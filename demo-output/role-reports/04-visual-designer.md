# 04 — Visual Designer: Aesthetic, Tokens, Components, Three Moves

Working from brief + CD anchor + UXR + IA, nothing else. Authored from scratch — not a tuning pass on a prior draft.

Prototype: `/Users/brittonstanfill/agent-team-experiments/northstar-20260514-0059-team/demo-output/prototype/index.html`

---

## 1. Aesthetic direction

- **Deep ink on warm bone, not white.** Pure white at 10:46 p.m. is hostile; warm bone (#F5F1E8) under #1A1715 reads as a paper briefing card, not a marketing surface. (recommendation; carries CD anchor)
- **One desaturated teal accent (#2E6E6B), reserved for the active decision only.** It appears on the selected path card and on the primary button. Nowhere else. The cancellation fact is not red — it is type. (recommendation; CD: "the cancellation is a fact, not an alarm")
- **Type is the hero. Two weights (400 / 600), three sizes per screen.** 28px display for the fact, 17px body, 14px metadata — no other sizes inside a single surface. The headline carries the page; no icon, no hero image, no illustration. (observed-from-brief: CD quality bar)
- **Tabular numerals on every time, flight code, dollar amount, confirmation code.** Numbers under stress must not jitter when they re-render. (recommendation)
- **Density: one decision per screen, fully framed.** Generous vertical rhythm on a 4pt grid. Cards are flat surfaces separated by tone (#FBF8F1 on #F5F1E8), not by shadow. The product never "fidgets." (observed-from-brief: CD motion stance)
- **States declare themselves visually, not chromatically.** Focus is a 2px ring in teal-ink against a 2px bone offset. Error is a warm rust (#9B2C2C) reserved for irreversible-only; an unavailable-seat error uses a danger border on a bone surface, not a red fill. (recommendation)

---

## 2. Design tokens

**Color** (semantic-first, then surface):

| Token | Hex | Role |
|---|---|---|
| `--ink` | #1A1715 | Primary type; near-black, warm undertone |
| `--ink-2` | #4A433D | Secondary type, state line |
| `--ink-3` | #7A716A | Metadata, captions, dt labels |
| `--rule` | #D9D0C2 | Hairlines, dividers, card borders |
| `--bone` | #F5F1E8 | Page background |
| `--bone-2` | #EAE3D3 | (reserved) deeper surface |
| `--bone-3` | #FBF8F1 | Card surface, receipt block |
| `--teal` | #2E6E6B | THE accent — active decision only |
| `--teal-ink` | #1F4F4D | Teal pressed / focus / hover |
| `--teal-wash` | #DCE8E6 | Selected-card tint |
| `--warn` | #8A4A1F | Advisory rust — "split party?" only |
| `--danger` | #9B2C2C | Irreversible / destructive only |

**Type scale** (three per screen, ceiling — never exceeded):

| Token | Size / line-height | Weight | Usage |
|---|---|---|---|
| `--t-display` | 28 / 34, -0.01em tracking | 600 | The fact headline (h1) |
| `--t-body` | 17 / 25 | 400 (600 for emphasis) | Body, state line, card labels, buttons |
| `--t-meta` | 14 / 20, 0.06em on caps | 400 / 600 | Metadata, section h2, receipt dt |

Family: system stack — `-apple-system, BlinkMacSystemFont, "SF Pro Text", "Segoe UI", "Helvetica Neue", Arial, sans-serif`. No web-font request — works offline, no FOUT. (recommendation; aligns with UXR's low-bandwidth user)

**Spacing** — 4pt grid: 4 / 8 / 12 / 16 / 20 / 24 / 32 / 40 / 56. Surface padding 24/20/20. Card internal padding 20. Gap between stacked cards 12.

**Radii** — 2 / 6 / 10. Buttons and cards 6. Sheet 10 on top corners only. Never pill, never circle on a tap target. (recommendation: pill radii read as marketing)

**Elevation** — none, except sheet (1px hairline above) and entitlements strip (1px hairline + inset shadow `0 -1px 0 var(--rule)`). Surfaces separate by tone, not depth. (recommendation; CD motion stance extends to elevation)

**Motion** — single token: 120ms ease-out cross-fade between screens. No skeleton, no shimmer, no spring. Loading is a static "Checking..." label on the primary button at `--ink-3`. (observed-from-brief: CD veto on shimmer)

---

## 3. Component specs (states implied; loading / error / offline shown in the prototype's states strip)

- **Operational header.** `meta` (14px, ink-3) — `h1.fact` (28/34, semibold, ink) — `state` (17/25, ink-2 with ink-emphasis on the standing-state fragment). No icon. Stack order is load-bearing: fact precedes state precedes path. (observed-from-brief: CD move #1)

- **Path card** (rebook / credit / standby). Vertical-stacked, full-width. Top row: label (17/25, 600) + a single decision-relevant data point right-aligned (e.g., "Earliest: 7:10 a.m."). Below: consequence line (17/25, regular, ink-2). Active state swaps to `--teal-wash` background, `--teal` border, `aria-pressed="true"`. Hover: border darkens to `--ink-3`. Focus: standard ring. (observed-from-brief: CD move #2; IA defense of stacked-over-horizontal)

- **Flight card** (rebook variant). Top row: arrival time at 28/34 semibold (the data point that matters) + `arrives LGA Wed` caption + fare ("No charge" or amount) + "Why?" link. Middle row: flight number + stops + duration in 14px metadata. **Bottom row, separated by hairline: party-size status with a colored dot.** Teal dot + "All 3 confirmed together"; warm-rust dot + "Only 2 seats together. Split party?" — this is my contribution to the UXR/IA group-of-four discussion: party status is structural to the card, not behind a filter. (recommendation, addressing UXR Risk section)

- **Entitlements strip.** Sticky to bottom of surface on screens 1–3. Bone-3 fill, 1px top rule, inset shadow. Tap target ≥44px. Two-line tap area: label (17/25, ink, with semibold on the offer) + status (14/20, ink-3). Right-side chevron. `role="region"` with `aria-labelledby`. Disappears on Screen 4 (Receipt) — its content is absorbed into the receipt block as status rows. (observed-from-brief: CD move #3; IA: "transforms into a status row inside the receipt")

- **Entitlements sheet.** Bottom-anchored, `role="dialog" aria-modal="true"`, 10px top radii, 36×4 handle, sheet-title h2 at 22/28 semibold (the one exception to the 3-sizes rule — sheet is a separate surface), then `sheet-sub` body, then entitlement rows separated by hairlines. Each row: name + description + "Claim" link (44px tap target, teal-ink). "Not eligible" rows go to `--ink-3` and lose underline. Bottom action: "Back to options" secondary button. (recommendation)

- **Receipt block.** Bone-3 fill with a 1px ink border (the only surface with a true ink stroke — a deliberate "official document" tell). Stamp caption ("Northstar Air - Trip updated") + 28px headline + a definition list with 100px metadata column and value column. Numbers tabular. Confirm code rendered prominent and copy-paste-safe. Support number is a `tel:` link, never just text. Bottom hairline divides flight info from support. (observed-from-brief: CD quality bar requires screenshotable receipt)

---

## 4. Three deliberate moves a CD can name on first scan

1. **Type-as-hero operational header.** 28px fact on warm bone, no icon, state line beneath in two-tone ink. The page does not greet the user; it briefs them.
2. **Side-by-side path cards with consequence-as-design.** Three vertically-stacked cards visible in one viewport, each with the *consequence* line at body weight equal to the label. Tabs would have buried two of three options under one tap and forced working-memory comparison; the stack makes the comparison the artifact. Active state is the only place teal appears on this screen.
3. **Persistent entitlements strip with status, never a screen.** Pinned bottom on screens 1–3, surfaces hotel/meal *availability and current status* — not just existence. Tap opens a sheet that preserves underlying state. On Screen 4 the strip dissolves into the receipt as a status row. The user never has to find help; help finds them.

---

## 5. Open questions

**For Accessibility Specialist (A11y):**
- Sheet trap behavior: I have `role="dialog" aria-modal="true"` and a labeled close button, but I have not implemented focus management JS in the static prototype. Confirm the open/close trap pattern you want, and whether the underlying screen should be inert / aria-hidden during sheet open.
- Persistent strip and screen-reader announcement frequency: the strip is a `role="region"` with `aria-labelledby`, but it appears on every screen — will VoiceOver / TalkBack re-announce it on each navigation in a way that becomes noise? Open to a `aria-live="off"` plus a visited-state model.
- Teal #2E6E6B on bone #F5F1E8 — I designed for ~7:1 against bone for type, ~4.6:1 for the teal fill against bone-3 surrounding. Please verify against AA non-text contrast for the active card border specifically.

**For Interaction Designer (IxD):**
- Screen 3 → Screen 4 transition: CD specified 120ms cross-fade. I have not specified what the *receipt block* itself does on first paint — a fade is correct but should the dl rows stagger by 30ms each, or arrive together? My instinct is together (no fidget), open to your call.
- "Plans changed? Start over" on Screen 4 returns to Screen 2 with prior choice marked. I have not designed the "visible-as-history not visible-as-current" state IA called for. Want to co-design it before I lock the path-card spec.
- Sort/filters row on Screen 3 — I have "Filters" as an inline link. Sheet, modal, or in-place expansion?

**For Content Designer (CW):**
- Consequence copy on the three path cards is placeholder-but-deliberate ("You arrive tomorrow morning." / "You decide later." / "You wait at the gate.") — refine voice but please preserve the *length* (one line at 17/25, no wrap to 3+ lines or layout breaks).
- "Why?" link next to fare — what does that copy reveal? I designed for a one-sentence factual disclosure, not a tooltip.
- Entitlements strip copy: "Hotel and meal support available" vs. "Not yet claimed" — I have the *what* and *status* in two lines. Confirm the register matches your read of the operational voice.

---

## 6. Handoffs

### To Creative Director — for sign-off

On first scan you should be able to name these three moves:
1. **Operational header** — type at 28px is the hero, fact before state, no icon, no apology.
2. **Stacked path cards with consequence copy as the design** — no tabs, one teal-active card per surface.
3. **Persistent entitlements strip with live status** — never a screen, never an FAQ, transforms into a receipt row on commit.

Quality-bar self-check against your sign-off list: one primary action per screen (yes), no red on cancellation (yes — cancellation is type, not color), no apology in headlines (yes — content-designer will refine within the register I've set), no illustration / lottie / hero (yes), no tabs (yes), receipt has flight + hotel + support number visible without a tap (yes). No Bootstrap tells. If you reject, I expect it to be on the choice of warm-bone over true white, or the warm-rust accent on the party-size advisory — I'd defend both with the same principle: the surface respects the user's state.

### To Accessibility Specialist — before you audit

Structure first, then what I'm uncertain about. Semantics: `lang="en"`, viewport meta, `<main>`, one h1 per screen on the fact, h2s for sections, `<button>` for actions (never divs), `<a>` only on real navigations and the support phone, `aria-labelledby` on every `role="region"`, `aria-pressed` on the path cards, `aria-modal` on the sheet, `aria-busy` on the loading button state. Tap targets ≥44px everywhere. Focus ring is 2px teal-ink + 2px bone offset — visible against every surface.

Please pressure-test, in this order:
1. **Focus order** on Screen 2: I expect fact → state → path card 1 → path card 2 → path card 3 → primary CTA → "Why these three?" → entitlements strip. Confirm the strip lands after the primary, not before it.
2. **Sheet trap behavior**: confirmed `role="dialog" aria-modal="true"` and labeled close, but the static prototype has no JS. Tell me the trap pattern you want — I'll spec it.
3. **Persistent strip announcement frequency**: this is the move I'm least sure of. The strip is identical on screens 1–3. Will it be re-announced on every screen transition? If yes, do we want an `aria-live="off"` plus a one-time intro on Screen 1?
4. **Color contrast spot-check**: teal-wash card background (#DCE8E6) against bone (#F5F1E8) for the active-card border, and warm-rust (#8A4A1F) on bone-3 for the party-status text.
5. **200% zoom and reflow**: the phone frame is 390px; verify the stacked cards do not require horizontal scroll at 200% zoom on a 320px viewport.

If any of these fail, the structure is more easily revised now than after CW finalizes copy. Tell me where to bend.

---

*Confidence: aesthetic direction and tokens — high (anchored directly on CD's brief). Component specs — high for the surfaces shown; the Credit and Standby Screen 3 variants share the frame but were not authored as separate mocks (noted on the prototype). Three-moves claim — high. Open questions — by design.*

---

## Addendum: Revision pass (A11y + BS fixes)

Scope: one consolidated revision pass after A11y and BS audits. Tuning, not re-authoring. Token system, three-moves claim, and aesthetic anchor unchanged. Two answers I previously flagged as open (persistent-strip announcement frequency; sheet focus-trap pattern) are now ratified-and-implemented per A11y §4 and §5.

### Must-fixes shipped

- [x] **B1 — Active path card non-color affordance.** Border thickened to 2px in `--teal`; added a 4px `--teal-ink` left-edge bar via `::before` pseudo-element. Padding compensated so layout does not shift between default and active states. Teal-wash fill kept as decorative affinity only. Selection now reads at 30% screen brightness and to switch-control users.
- [x] **B2 — Sheet focus trap.** Inline `<script>` block at end of `<body>`, dependency-free. Contract: opener button records itself, sets `aria-expanded="true"`, marks the containing `.surface` `inert` (plus `aria-hidden` for older AT belt-and-suspenders), focus moves to the sheet's `<h2>`. While open, Tab cycles within the sheet only, Esc closes, backdrop tap closes. On close, `inert` is removed, `aria-expanded` flips back, focus returns to the original opener button. No auto-close after claim. Strip buttons declare their target via `data-opens-sheet="entitlements-sheet"`; the script remembers which button opened the sheet across all three screens.
- [x] **B3 — Rule contrast.** New token `--rule-strong: #6E655E` (≈3.2:1 on bone). Applied to `.path-card`, `.flight-card`, `.btn-secondary`, `.sort-row` bottom border, `.entitlements-strip` top rule, and `.eligibility-gate` border. `--rule` retained only for decorative dividers inside a single card: receipt internal `<hr>`, sheet entitlement-row separators, sort-row sep dots.
- [x] **B5 — "Why?" link cut.** All three flight cards in the prototype show "No charge"; the disclosure had nothing to disclose. Markup, CSS, and tabindex=-1 trap removed. CSS comment block in the markup preserves the spec: on fare-difference cards, "Why?" must ship as a real `<button type="button" tabindex="0">` with a single factual sentence on tap (CW §5 disclosure copy — no tooltips, no marketing).
- [x] **B7 — Anchor-as-button conversions.** "Plans changed? Start over," "Why these three?," "Filters," and "Back to options" are now `<button type="button" class="text-link">`. Visual styling (teal-ink, underline, 3px offset) preserved via the `.text-link` class so they still read as tertiary text links. The two real anchors that remain are the SMS deep link (`#screen-1`, real page navigation) and the two `tel:` links (real protocol handlers).
- [x] **B7 + party-conflict structure.** `.flight-card` is now a `<div>` container. The interactive selection surface is a `<button class="flight-card-tap">` child. The party-status row is a sibling `<div class="status-row">` below the tap, NOT nested inside it. "Split party?" is its own `<button class="split-party-btn">` sibling of the card-tap. Switch-control users can land on it; nested-interactive parsing failures are gone.
- [x] **B8 — `tel:` aria-labels.** Screen 1 tertiary and Receipt support row both labeled `"Call Northstar support, 1-800-555-0142"`. (No `tel:` link exists on the Screen 1 variant or in error-state CTAs in this prototype.)
- [x] **B6 — Strip aria-label fix.** Every `.strip-tap` button carries `aria-label` directly per CW's status-variant table. The `id="entitlements-sheet"` exists on the sheet, but I removed `aria-controls` from the strip buttons because the sheet only renders in the open-state demo here — production engineering will portal it; until then, `aria-controls` pointing at a sometimes-present id risks "controls, no target." Replaced with `data-opens-sheet="entitlements-sheet"` so the JS knows the target; AT users get the action via the explicit aria-label ("Tap to see what's available").
- [x] **BS 2.1 — Screen 2 default state.** Rendered an explicit "Screen 2 - first paint (no selection, CTA disabled)" surface ABOVE the active-state demo. None of the three path cards is `aria-pressed="true"`; primary CTA shows "Pick a path to continue" with `aria-disabled="true"` and a `[aria-disabled="true"]` CSS variant (bone-2 fill, ink-3 type, not-allowed cursor). Section labels read "Screen 2 - first paint (no selection, CTA disabled)" vs. "Screen 2 - Rebook selected (demonstrates active state)". HTML comment placed next to the active demo: `<!-- Active state shown for demo. First paint per IxD §1 = no selection, CTA disabled. -->`
- [x] **A11y to VD #4 — Held-seat-expired non-color affordance.** New `.flight-card.is-expired` state: bone-2 fill, ink-3 border, 4px `--ink-3` left-edge stripe, strikethrough on the arrival time, "Seats no longer available" copy. Mirrors the history-card stripe pattern. Together with the selection-state teal-ink stripe (Screen 2 active card), there are now three distinct non-color affordances for three distinct states (selection / unavailability / history). Rendered as a state-variant surface below Screen 3 with an annotation explaining the IxD §3.5 announcement sequence.

### Should-fixes shipped

- [x] **#11 — `--ink-3` darkened** from #7A716A to #6E655E. All other inks and bones unchanged. Cheap insurance on the ~4.5:1 14px metadata pairings A11y flagged.
- [x] **#12 — Fifth status-line variant on flight cards (accommodation continuity).** New `.status-row.accom` modifier with an ink-2 dot and ink-2 type. Rendered on Card 3 of Screen 3 ("Bassinet row confirmed on this flight"). CSS hook is generic enough to also carry service-animal or wheelchair-assist copy. Card 3's `aria-describedby` references both the party row and the accommodation row, so the composed accessible name includes both ("All 3 seats together. Bassinet row confirmed on this flight.").
- [x] **#13 — Eligibility segmented control on the sheet.** New `.eligibility-gate` fieldset above the entitlement rows. Three `<button type="button">` segments with `aria-pressed` toggled via the inline script. "Already home" is shown as the active selection in the prototype to demonstrate the disabled-Hotel-row branch; tapping another segment in the live HTML re-enables Hotel via JS. Hint copy below names the rule. CW owns final strings; suggested strings are inline.
- [x] **#14 — History caption mixed case.** DOM reads "Your prior choice - 7:10 a.m., confirmed 9:54 p.m." in mixed case. No `text-transform: uppercase` applied to the caption.
- [x] **#15 — Path-card aria-labels.** Each path card carries an explicit `aria-label` per CW §9. The active card's aria-label ends with "Selected." so the consequence reads in full before the state token.

### What I deliberately did not ship and why

- **The full IxD §1 state catalog rendered as separate phones.** Out of scope per the punch list; the states-strip block at the bottom of the page already names default / focus / pressed / loading / error / offline, and the new Screen 3 state-variants block adds history + expired. The remaining states (logged-out, error-fatal, offline-mid-flow, link-stale, submit-failed) are spec'd in CSS and noted but not rendered as separate surfaces. If team-lead wants them visualized for the meeting, that is a separate pass.
- **Updating the Screen 4 Receipt to use `--rule-strong` on the ink-1 outer border.** The receipt block uses a 1px `--ink` border deliberately (the "official document" tell — the only surface in the system with a true ink stroke). That is well over 3:1; no fix needed.
- **Promoting "Plans changed? Start over" to secondary weight.** BS §2.4 explicitly says hold the tertiary placement; let H5 data decide. I did upgrade the element from `<a>` to `<button>` per B7, but I did not change its visual weight.
- **Auto-claim from the strip.** Tempting for the demo. A11y §4 and BS §2.5 both flag this as dangerous (focus-return contract; action-bias). The sheet requires explicit dismissal.
- **Replacing the SMS deep link with a button.** The SMS deep link IS a real URL navigation in production; it is correct as an `<a href>`. The `#screen-1` href in this prototype is a same-page jump that mirrors that navigation.
- **Animation on the sheet open/close.** CD's motion stance is 120ms cross-fade only; the script applies state changes synchronously. Engineering can wire a CSS transform-and-opacity transition without changing the script contract.
- **A separate Credit and Standby variant of Screen 3.** Same as the original prototype: the annotation under Screen 3 names what changes (terms + dollar value + "Accept credit" / next-flight + queue-position + "Add me to standby"). Not authored as separate mocks. This is a known and stated gap, not new.

### Verdict on Layer-0 floor

The prototype now passes the Layer-0 accessibility floor as I read A11y's blocker list: selection state has a non-color affordance, the sheet has a real focus trap with `inert`, rule contrast meets 3:1 between interactive surfaces, `tel:` links are labeled, the strip has direct accessible names, all action affordances are real `<button>`s, and the BS-flagged default-state dark-pattern risk is neutralized by rendering the spec'd first-paint surface explicitly. The remaining items in A11y's audit are handoffs to IxD (live-region sequencing on held-seat-expired, debounce on `aria-pressed`/CTA-label race) and to engineering (production focus-trap implementation matching this prototype's contract). Final A11y sign-off requires a manual VoiceOver + TalkBack pass — that is correctly downstream of this revision.

