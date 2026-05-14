# Accessibility Specialist — Canceled-Flight Recovery

## Header

- **Role:** Accessibility Specialist.
- **Scope of authority (blocking):** keyboard order, focus visibility, screen-reader semantics (landmarks, headings, accessible names, ARIA correctness), color/non-text contrast, target size, motion, content reflow.
- **Scope of audit:** the prototype HTML at `demo-output/prototype/index.html`. Five stacked mobile-width screens (SMS entry → Status & Plan → Choose your path → Pick a flight → Confirm & save) plus the page-level intro shell.
- **Method (what I checked, how):**
  - Read every interactive control and its accessible name path (`aria-label`, `aria-labelledby`, label-as-text, SVG `aria-hidden`).
  - Walked landmark and heading structure as a screen reader would surface it (flat heading list, region list).
  - Computed actual contrast ratios in code (WCAG relative-luminance formula) for every body / secondary / chip / alert / confirm / link / focus-ring pairing on its real background — including alpha-blended focus rings.
  - Math-checked content reflow at 320px and 390px against the grid track minimums declared in CSS.
  - Verified `prefers-reduced-motion` coverage and target-size compliance on every tap target.
  - Listened (mentally) for the required narration order: cause → options exist → hotel/meal exists → refund honest dead-end → persistent talk-to-someone.
- **Claim labels used below:** *observed in HTML*, *inferred*, *recommendation*.
- **What I could not assess without live testing:** real VoiceOver / TalkBack / NVDA announcement timing on `role="status"` mid-page, screen-reader heading-list rendering across versions, voice-control label matching for the "Choose this flight" buttons (where the visible label and the augmented `aria-label` differ — see Blocker 5), and rotor / forms-mode behavior on the path-card buttons.

---

## Findings summary

- **Blockers (must be fixed before seal):** 6
- **Polish (lower priority but should land if cheap):** 7
- **Passes worth naming (so they don't regress):** see end of doc

The biggest blocker is heading hierarchy — six `<h1>` elements on one page is the single thing that most degrades the screen-reader experience of this flow. The most insidious is the focus ring contrast, because it *looks* fine to a sighted designer but measures as a 2.4.11 fail on white. Both must be fixed.

---

## Blockers

### Blocker 1 — Heading hierarchy: six `<h1>` elements on one page

- **Selector / screen:** `header.page-intro > h1` ("Canceled-Flight Recovery") *plus* `section.screen h1.event#s2-title`, `#s3-title`, `#s4-title`, `#s5-title`, and the SMS bubble div carrying `id="s1-title"` as the section label (5 screens × 1 H1 each + 1 page H1 = 6 H1s). *(observed in HTML)*
- **WCAG:** 1.3.1 Info and Relationships (A); 2.4.6 Headings and Labels (AA); 2.4.10 Section Headings (AAA — heads-up).
- **Why this is a blocker:** Screen readers do not implement the HTML5 sectioning outline algorithm. They render a flat heading list. A user pulling up the rotor / headings list sees six H1s and no structural hint that some of those H1s are nested inside the page H1. There is no way to skim "what are the major sections" because every section is announced as a peer of the page title.
- **What this feels like for the user:** A blind traveler trying to skim this flow at 10:46 p.m. opens the headings rotor expecting an outline — "Canceled-Flight Recovery / Status / Choose path / Pick flight / Confirm." Instead they get six items at the same level, with no parent-child shape. They cannot tell whether "What works best for you?" is *the* heading or *a* heading. Under stress, they over-scroll, lose context, and reach for the phone — which is exactly the abandonment the brief flags.
- **Required fix (Visual Designer must change HTML):**
  - Keep `header.page-intro > h1` as the single page H1.
  - Demote every `h1.event` inside `<section class="screen">` to `<h2 class="event">`.
  - Demote `.support-block > h3` to `<h4>` on Screen 5 (so it nests correctly under the now-H2 screen heading).
  - Update CSS selector `h1.event` to `.event` (or add `h2.event`) so visual size is preserved. Visual rank stays, semantic rank corrects.
  - On Screen 1 (SMS entry), the section currently uses `aria-labelledby="s1-title"` pointing at the entire SMS bubble paragraph. Replace with a `<h2 class="visually-hidden" id="s1-title">Text message from Northstar Air</h2>` and remove `id="s1-title"` from the bubble div. (See Blocker 2 for why.)

---

### Blocker 2 — Screen 1 section's accessible name is the entire SMS body

- **Selector / screen:** `section[aria-labelledby="s1-title"]` where `#s1-title` is the `<div class="sms-bubble">` containing the whole message including the embedded link and a `<br><br>` break. *(observed in HTML)*
- **WCAG:** 4.1.2 Name, Role, Value (A); 2.4.6 Headings and Labels (AA).
- **Why this is a blocker:** When a screen reader user navigates into the Screen 1 region, the region's accessible name (computed from `aria-labelledby`) is the *entire* message body, including the link href. Region landmarks should be labeled with a short, scannable name, not the content. Worse, the bubble is *also* the visible content — so the same string is announced twice: once as the region name on entry, once as the content as the user reads through it.
- **Required fix:** Create a visually-hidden H2 ("Text message from Northstar Air") and use *that* as `aria-labelledby`. Remove `id="s1-title"` from the bubble div.

---

### Blocker 3 — Focus indicator fails non-text contrast against white

- **Selector / screen:** `--focus: 0 0 0 3px rgba(14, 90, 133, 0.35)` applied to `.btn-primary:focus-visible`, `.btn-secondary:focus-visible`, `.path-card:focus-visible`, `.talk-link:focus-visible`, and `a/button:focus-visible` globally. *(observed in HTML)*
- **WCAG:** 1.4.11 Non-Text Contrast (AA); 2.4.11 Focus Not Obscured (Minimum, 2.2 AA); 2.4.7 Focus Visible (AA — the ring exists, but at this contrast it functionally fails for low-vision users).
- **Measured:** The 35%-alpha brand-600 ring, rendered over the white `.screen` surface, computes to `#ABC5D4`, which is **1.80:1 against white**. WCAG 1.4.11 requires **3:1** for focus indicators against their adjacent background.
- **Why this is a blocker:** A low-vision keyboard user tabbing through the flow sees no usable focus indicator on the white-surfaced controls — secondary buttons, path cards, talk links. The primary button passes because the ring sits adjacent to the dark brand-600 fill (4.14:1 against the fill), but it still fails against the white *around* the button — and most controls on this flow sit on white.
- **Required fix:** Either
  - **A (preferred):** Replace the rgba ring with a solid ring at full brand-600: `--focus: 0 0 0 3px var(--brand-600);` — measured 7.45:1 against white. Add a 1px inner white halo (`0 0 0 1px #fff, 0 0 0 4px var(--brand-600)`) so the ring stays visible when the focus target sits directly against the brand-600 primary-button fill.
  - **B:** Keep the soft ring but raise alpha to ≥0.75 *and* add a 2px solid inner stroke at full brand-600. Verify the result against white measures ≥3:1.
  - Re-measure after change; do not ship until the ring against the lightest surface in the flow (white) is ≥3:1.

---

### Blocker 4 — Horizontal scroll at 320px and ~390px viewports

- **Selector / screen:** `.stack { grid-template-columns: repeat(auto-fit, minmax(360px, 1fr)); }` with `.page { padding: 32px 16px 40px; }`. *(observed in HTML, math-verified)*
- **WCAG:** 1.4.10 Reflow (AA) — content must be presentable without horizontal scrolling at 320 CSS px (equivalent to 1280 CSS px zoomed to 400%).
- **Measured:**
  - 320px viewport: inner content area 288px, grid track minimum 360px → **overflow by 72px** (horizontal scroll required).
  - 360px viewport: overflow by 32px.
  - 390px viewport (the brief's mobile target): overflow by ~2px.
- **Why this is a blocker:** A user at iPhone SE (320pt) or with browser zoom on a small device gets a horizontal scrollbar on the whole flow. The brief explicitly names "mobile-first" and "low bandwidth." Reflow is non-negotiable at 320.
- **Required fix:** Change `.stack` to `grid-template-columns: repeat(auto-fit, minmax(min(100%, 360px), 1fr));` (the `min()` lets the track collapse to the available width below 360). Verify with the lead's render-proof at 320, 360, 390 that `scrollWidth <= clientWidth`. Do not mask with `overflow-x: hidden` — that hides the bug, doesn't fix it.

---

### Blocker 5 — Back arrows have a label but no role and no keyboard reachability

- **Selector / screen:** `<span class="back" aria-label="Back">` inside `.app-bar` on Screens 2, 3, 4, 5. *(observed in HTML)*
- **WCAG:** 4.1.2 Name, Role, Value (A); 2.1.1 Keyboard (A).
- **Why this is a blocker:** A `<span>` with `aria-label="Back"` announces as "Back" to a screen reader (no role) and is unreachable by keyboard (no tabindex, no element role that takes focus by default). To an SR user the announcement implies an action exists; to a keyboard user it doesn't. To a sighted mouse user it appears clickable but has no handler. This is the WCAG 4.1.2 anti-pattern: a control with a name that has no role and no behavior. (Voice-control users saying "click Back" will get nothing.)
- **Required fix:** Pick one:
  - **A (if the back arrow is decorative chrome only — i.e., this is a stacked storyboard, not an interactive flow):** Remove `aria-label="Back"` from the span and add `aria-hidden="true"` to the entire `.app-bar` (it's already chrome-equivalent, matching how `.chrome` is treated). The visible arrow stays, but SRs and keyboard skip it.
  - **B (if back is meant to be functional):** Change the `<span>` to `<button type="button" class="back" aria-label="Back">…</button>` with min 44×44 hit area. Ensure focus-visible style. Wire to history.back() or the previous screen anchor.
  - Audit consistency across all four occurrences.

---

### Blocker 6 — Flight-choice button accessible name contradicts visible label

- **Selector / screen:** Screen 4, `.flight-card .cta` — three anchors styled as buttons:
  - Visible text: "Choose this flight" (×3, identical)
  - `aria-label`: "Choose 7:10 AM, one stop, same fare" / "Choose 2:40 PM, nonstop, $84 more" / "Choose 6:30 PM, one stop, same fare" *(observed in HTML)*
- **WCAG:** 2.5.3 Label in Name (A) — the visible label text must be part of the accessible name. "Choose this flight" is not contained verbatim in any of the three aria-labels.
- **Why this is a blocker:** Voice-control users (Dragon, Voice Control on iOS/macOS, Voice Access on Android) say "click Choose this flight." When the accessible name omits that phrase, the click target cannot be resolved by voice — the user is locked out of the primary action on the flight-pick screen. This is a textbook 2.5.3 violation.
- **Required fix:** Rephrase aria-labels so the visible string is preserved as a prefix:
  - `aria-label="Choose this flight — 7:10 AM, one stop, same fare"`
  - `aria-label="Choose this flight — 2:40 PM, nonstop, $84 more"`
  - `aria-label="Choose this flight — 6:30 PM, one stop, same fare"`
  - Better still, drop the aria-label and put the augmenting context into the visible text or a visually-hidden span inside the button, so visible and accessible names match exactly. Example: `<a class="btn …"><span>Choose this flight</span><span class="visually-hidden"> — 7:10 AM, one stop, same fare</span></a>`.

---

## Polish (lower priority — recommend, don't block)

### P1 — Missing skip link
The CSS defines `.visually-hidden` but no `<a class="visually-hidden" href="#screen-2">Skip to flow</a>` is rendered. With the page-intro at the top, an SR/keyboard user must tab through the header before reaching the flow. *(WCAG 2.4.1 Bypass Blocks — A.)* Add a skip link targeting `#screen-2` (or wherever the action begins).

### P2 — "Send me a copy" is `<a href="#">` but is an action, not a navigation
On Screen 5, the primary button "Send me a copy by email and text" is an `<a>` with `href="#"`. Semantically it's an action; should be `<button type="button">`. *(WCAG 4.1.2; usability — anchors announce as "link," buttons as "button"; users expect linked elements to navigate.)*

### P3 — Persistent "Talk to someone" links resolve to themselves
Every `talk-link` uses `href="#talk"`, and `id="talk"` is on the last talk-link on Screen 5. Activating "Talk to someone" from any earlier screen scrolls to a target that *is* the link itself, not a support surface. Document as a prototype scoping gap or wire to a placeholder support panel. Not a WCAG failure, but a UX dead-end that disproportionately hurts users who tap support out of confusion (cognitive load).

### P4 — `role="status"` on the cause stripe may double-announce
The `.event-block` on Screen 2 has `role="status"` *and* is read again as content when the user navigates into it. On a stacked-storyboard page, every screen would announce its cause on page-load, in order — that's noisy. Recommend removing `role="status"` since the H2 heading and the visible content are sufficient for a non-stacked production rendering. *(WCAG 4.1.3 Status Messages, AA — the status role is meant for state changes, not static content; misuse is not a blocker but creates noise.)*

### P5 — Body text at 15px is under conventional mobile baseline
No WCAG minimum, but 15px on a 390pt phone is small. Consider 16px body (`--t-body: 16px`) for cognitive load / low-vision users who rely on default size rather than zoom.

### P6 — `screen-label` (the "01 / SMS entry | …" tag) is `aria-hidden`
Correct choice — this is editorial chrome for the storyboard, not user content. Just confirm with the lead that none of these labels are expected to surface to AT users in the production flow. *(Observed; no action unless the answer is "yes, they should be exposed.")*

### P7 — Inline anchor `href="#"` on dummy targets will fight focus management
The primary CTA on Screen 5 ("Send me a copy") uses `href="#"`, which scrolls to top on activation. In a stacked prototype this is jarring for keyboard users — they get bounced to the page top and lose place. Replace with `href="#screen-5"` (self-anchor) or, better, with `<button type="button">` per P2.

---

## Passes worth naming (so they don't regress in a revision pass)

- *(observed)* Body / lede / secondary / brand / good / alert text all clear AA contrast on their respective backgrounds — measured 5.27:1 (worst case: ink-500 on token-bg) through 17.96:1 (ink-900 on white). No text-contrast blockers.
- *(observed)* `prefers-reduced-motion: reduce` is honored and disables all transitions and animations globally. Good.
- *(observed)* Target sizes: `.btn` min-height 48px, `.path-card` min-height 44px, `.talk-link` min-height 44px. All meet WCAG 2.5.8 Target Size (Minimum, 2.2 AA).
- *(observed)* Decorative SVGs (back arrow, alert triangle, path-card icons, caret, confirm checkmark, phone glyph) are correctly marked `aria-hidden="true"`.
- *(observed)* Color is not the sole carrier of meaning: "Same fare" / "+ $84" use color *and* text; the cause stripe uses an icon, a stripe, and a text label. *(WCAG 1.4.1 passes.)*
- *(observed)* Cause of disruption, that options exist, hotel/meal callout, refund honest dead-end, and persistent talk-to-someone all appear in the expected narration order for an SR user reading top-to-bottom of Screen 2 then Screen 3. The required behavioral surfaces are *present*; my blockers are about how AT users *reach* them, not whether they're there.

---

## Notes for the lead / final memo (accessibility guardrails worth lifting)

These are the few guardrails I want explicit in the final recommendation so they don't get value-engineered out in implementation:

1. **No "Recommended" badge without a stated, audible reason.** "Recommended" without justification is marketing copy that disproportionately steers users with cognitive disabilities or under stress. The current prototype correctly omits this; keep it omitted. *(recommendation)*
2. **Focus indicator standard: solid 3px ring at full brand-600 with a 1px white inner halo.** Lock this as the design system token; do not allow alpha-tinted rings in this flow. *(recommendation, post-fix)*
3. **Single H1 per page; semantic heading levels mirror screen hierarchy.** Even if the production app renders one screen at a time, the same rule should hold per route so AT heading navigation works the same in prototype and production. *(recommendation)*
4. **Label-in-name discipline on all cards and buttons.** When augmenting an accessible name with context, the visible label must remain a substring — voice-control users depend on this. *(recommendation, per 2.5.3.)*
5. **Persistent "Talk to someone" is an accessibility feature, not just a trust feature.** A user whose cognitive load spikes (grief, panic, fatigue, medication side effects, a recent diagnosis surfacing during travel) may not be able to parse the four-path choice and needs a low-cost escape hatch on every screen. Do not let this be cut "to reduce duplication." *(recommendation; this is the strongest under-used lens — distress-state walkthrough — and it argues for keeping the persistent link even at the cost of visual weight.)*
6. **Reflow gate: 320px is the floor, not 390px.** Verify in the render-proof at 320, 360, and 390 that `scrollWidth <= clientWidth`. Do not paper over with `overflow-x: hidden`. *(recommendation, per 1.4.10.)*
7. **Scoped gap to name in the memo: arrival times shown as tokens.** This is an honest gap, and SR users will hear "open brace new underscore arrival underscore time close brace" if the token text is read literally. The token CSS chip styling is visual; SRs read the text. If the production system can't fill the token, the copy must degrade to natural language ("Arrival time confirmed at booking"), not leave a literal `{new_arrival_time}` to be spoken aloud. *(observed in HTML; recommendation to flag in memo.)*

---

## Ship eligibility

After the 6 blockers are fixed in one surgical revision pass — and re-verified by the lead's render-proof at 320 / 360 / 390 — the prototype is ship-eligible against WCAG 2.1 AA and the 2.2 AA additions in scope (2.4.11, 2.5.8). The polish list is genuinely polish; none of it should hold the seal.
