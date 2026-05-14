# 08 — Accessibility Specialist: Audit, AT-Behavior Calls, Handoffs

Posture: WCAG is the floor, not the ceiling. At 10:46 p.m. a screen-reader user is doing the same triage as a sighted user — except every wrong announcement costs them a re-read, every focus drop costs them a re-orient, and every "call us" fallback costs them disproportionately more friction (TTY/relay, IVR menus). The bar is: a VoiceOver user on iOS Safari should complete the recovery flow without phoning support, and the experience of doing so should feel as deliberate as the visual one.

I read the brief, CD, UXR, IA, VD + prototype, IxD §7, CW §9 only.

---

## 1. Blockers and serious risks

| # | Issue | Element | WCAG (2.1 AA; 2.2 where noted) | Severity | Fix |
|---|---|---|---|---|---|
| B1 | Active path card relies on a 1px teal border + teal-wash fill to convey "selected." The wash (#DCE8E6) vs bone (#F5F1E8) is ~1.1:1 — well below 3:1 non-text floor. The inset 1px teal shadow inside the card carries the burden alone. | `.path-card.active` (Screen 2) | SC 1.4.11 Non-text Contrast (AA) | Blocker | Thicken the teal border to 2px and add a visible non-color affordance (left-edge bar in `--teal-ink` at 4px, or a "Selected" text token). `aria-pressed` already carries it for AT — visual users with low vision need the same redundancy. (recommendation) |
| B2 | `aria-modal="true"` is declared on the sheet but no focus trap, no Esc handler, no `inert` on background. Static prototype, JS not authored. A screen-reader user lands in the sheet, swipes past the last claim row, and is dumped into the dimmed background — which is read aloud despite `aria-hidden` on `.behind` (the behind block aria-hides one element, not the whole underlying screen). | Entitlements sheet | SC 2.1.2 No Keyboard Trap (A — inverse: a sheet must trap), SC 2.4.3 Focus Order (A), SC 4.1.2 Name/Role/Value (A), SC 2.4.11 Focus Not Obscured (Minimum) (AA, WCAG 2.2) | Blocker | Spec'd in §4. Must ship with the sheet, not after. |
| B3 | `--rule` #D9D0C2 hairline on `--bone` #F5F1E8 is ~1.3:1. Card borders, sort-row divider, receipt internal `<hr>`, and the entitlements strip top rule all use it. Where the rule is the *only* thing separating two interactive surfaces (path cards from each other; flight cards from each other), it fails 3:1. | `.path-card`, `.flight-card`, `.sort-row`, strip top rule | SC 1.4.11 Non-text Contrast (AA) | Major-to-Blocker (Blocker for cards as the only separator; Major for purely-decorative hairlines) | Darken to `--ink-3` #7A716A (≈3.2:1 on bone) for borders that delineate interactive elements. Decorative dividers inside a single card can stay at `--rule`. (recommendation) |
| B4 | Path cards are `<button>` inside `<ul><li>`. iOS VoiceOver and JAWS will strip the `<ul>` semantics off a list whose only children are `<li>` containing focusable `<button>`s in some cases, and announce three buttons without "list of 3." More serious: each card uses `<span>` for label/data/consequence — these have no semantic relationship to the button name. VoiceOver will compute accessible name from the concatenated text, which is correct, but TalkBack with verbose=off may truncate. | `.path-card` markup | SC 4.1.2 Name/Role/Value (A), SC 1.3.1 Info and Relationships (A) | Major | Add an explicit `aria-label` per card (CW §9 specified this — the active variant must include "Selected" at the *end* so it reads after the consequence: `"Rebook on a new flight. Earliest arrival 7:10 a.m. You arrive Wednesday morning. All 3 seats confirmed, no charge. Selected."`). Keep the `<ul>` for semantics but add `role="list"` defensively (WebKit list-removal workaround). |
| B5 | Flight card "Why?" link uses `tabindex="-1"`, making it unreachable by keyboard while a sighted mouse user can still click it. Even though CW recommends removing it on "No charge" cards, the *prototype as currently coded* ships a keyboard-inaccessible interactive element. | `.flight-card .why` | SC 2.1.1 Keyboard (A) | Blocker (if "Why?" ships) — Resolved if CW's recommendation is taken (cut from "No charge" cards entirely) | Take CW's recommendation: remove "Why?" from "No charge" cards. On fare-difference cards (not in current prototype) it must be a real `<button>` with `tabindex="0"` and proper focus management. |
| B6 | The `<button class="strip-tap">` on the entitlements strip has visible label + status text and `aria-controls="entitlements-sheet"` pointing at `#entitlements-sheet` — but no element in the prototype has `id="entitlements-sheet"`. The reference is broken; some screen readers will announce "controls, no target," others will silently ignore. The first strip uses `aria-labelledby="strip-label-1"` which points to a `sr-only` "Open entitlements sheet" span, *which is positioned after the visible content* — so the accessible name on first strip is just "Open entitlements sheet," and on the other two strips there is no labelledby resolution at all (the `aria-labelledby` is at the `role="region"`, not the button). | Strip buttons across Screens 1–3 | SC 4.1.2 Name/Role/Value (A) | Major | (1) Add the missing `id="entitlements-sheet"` to the sheet's `.sheet` element when it exists in DOM, or remove `aria-controls`. (2) Put `aria-label` directly on each strip `<button>` instead of relying on a labelledby chain — see CW's recommended label: `"Hotel and meal support: not yet claimed, eligible for tonight. Tap to see what's available."` |
| B7 | The "Plans changed? Start over" affordance on Screen 4 is an `<a href="#start-over">` styled as a tertiary button. It performs an action (opens a confirm disclosure per IxD §5), not navigation. Anchor with `#` fragment will announce as "link" and may scroll the viewport. | Screen 4 tertiary | SC 4.1.2 Name/Role/Value (A) | Major | Convert to `<button type="button">`. Same for "Why these three?" on Screen 2, "Filters" on Screen 3, and "Split party?" on the warn flight card if those open in-app interactions. (recommendation) |
| B8 | The `tel:` link on Screen 1 has no `aria-label` distinguishing it from a phone number string. CW spec'd the label `"Or call Northstar support, 1-800-555-0142"` — the prototype currently ships only the visible text. A screen-reader user hears "or call 1-800-555-0142, link" with no signal that it dials. | `a[href^="tel:"]` instances | SC 2.4.4 Link Purpose (A) | Major | Apply CW's aria-labels everywhere a `tel:` link appears (Screens 1, 4, error states, sheet bottom). |

**"What this feels like for the user" — for each Blocker:**

**B1.** I'm using VoiceOver at 1.5x speed, lying in bed with the screen at 30% brightness. I swipe through three path cards. They all sound the same. The third one says "Selected" but I'm not sure if VoiceOver said that or if I imagined it because the visual is so faint at this brightness. I swipe back. I swipe forward. I tap to confirm what I thought was selected, but I picked the wrong one. I call support.

**B2.** I open the entitlements sheet. I claim the hotel. I swipe down past meal credit, past ground transport, past "Back to options" — and now I'm hearing "Pick a path. All three are available." Wait, am I out of the sheet? Did I close it? Is the hotel claimed or did I lose the tap? I lock my phone and call.

**B3.** I'm using a 200% browser zoom on my Pixel because my prescription is two years stale. The three flight cards on Screen 3 look like one big block. I can't tell where one card ends and the next begins. I tap somewhere near "7:10 a.m." and confirm what I think is the first option. It was the second.

**B5.** I'm a switch-control user. I scan through Screen 3 in switch mode. The cards focus, the primary button focuses, the "Back to options" link focuses. There's a "Why?" near the fare that my partner can see on the screen but my switch never lands on. I don't know whether to trust the fare. I hand the phone to my partner.

---

## 2. Audit by surface

### SMS lock-screen card
- **Passing:** semantic `<p>` paragraphs; the airline name and fact are in the first sentence (read order matches visual). `tel:` is a real number string a screen reader can dial. (observed-from-brief / inferred)
- **Failure:** `backdrop-filter: blur(8px)` plus `rgba(245,241,232,0.10)` background under bone text — text-on-translucent-on-dark. Effective contrast depends on what's behind; assuming the dark shell #1F1B17 dominates, bone-on-near-black is ~14:1, which passes. But on lock-screen wallpapers the user actually chooses, this can drop below 4.5:1 silently. SC 1.4.3 Contrast (Minimum) (AA). **Recommendation:** test against three real wallpaper conditions; if any fails, raise the card background to `rgba(245,241,232,0.18)` or higher and accept the slight loss of "frosted glass" character. This is platform UI in production (iOS/Android render the SMS, not us) — flagging for the engineering handoff to NS482 only as a "verify the SMS preview tooling matches what iOS renders." (assumption: production SMS preview is platform-rendered)
- **AT note:** the deep-link URL `northstar.app/ns482` may be re-read character-by-character by VoiceOver at slow speed. Acceptable, but CW's "tap for 3 options" framing helps the user know what's behind the link.

### Screen 1 — Status & Stake

**Default state.** Passes structural audit: one `<h1>`, sensible reading order (meta → fact → state → CTA → secondary → tertiary → strip). `<strong>` on "You have not been rebooked yet" delivers prosodic emphasis on VoiceOver and TalkBack at default verbosity (CW asked me to verify — confirming this works on both, though TalkBack's emphasis is subtler than VoiceOver's; acceptable). (recommendation, AT note: this is true on default verbosity; advanced users with verbosity=low may not hear emphasis at all, which is why CW's fallback phrasing "You are not yet rebooked" should ship as the canonical sentence — same meaning, load-bearing verb)

**Logged-out state.** IxD §1 spec'd "fact above the login form." Confirm this means the `<h1>` ships before the form in DOM order, not just visually above. (handoff to IxD)

**Offline state.** Disabled CTA with text "Offline — call to continue" — must include `aria-disabled="true"` *and* keep the element focusable so a screen-reader user can hear *why* it's disabled. `disabled` attribute removes from tab order on many ATs. (SC 4.1.2)

**Error-fatal state.** The CTA swap to "Call Northstar — we couldn't reach your booking" as a `tel:` link is correct. Must announce as a polite live region change if it appears after first paint. (SC 4.1.3 Status Messages, AA)

**Second-cancellation variant.** State line names the count plainly. Passes. AT note: a screen-reader user with no prior context who lands directly on this screen (deep link with stale auth) needs the booking history compressed into the state line — IA's structure handles this; CW's strings carry it.

### Screen 2 — Choose Your Recovery

**Default.** Passes structural audit. Concerns covered in B1, B4 above.

**Selected state.** Per IxD: card → teal-wash, `aria-pressed="true"`, primary CTA enables. AT note: when `aria-pressed` flips, VoiceOver re-announces the button on next focus. The label change on the primary CTA ("Continue with rebook") must also be announced. Two announcements in quick succession risk overlap on slower TTS rates. **Recommendation:** wrap the label change in a 50ms debounce after `aria-pressed` flips, so the press state announces first. (handoff to IxD)

**Re-entry / history card state.** IxD §2-Q2 spec'd `aria-describedby` pointing to a prior-choice caption — good. **My addition:** the history caption should not include the visible all-caps styling in its accessible name; all-caps gets spelled out by some screen readers. Use mixed case in the underlying text and apply `text-transform: uppercase` purely for visual. (recommendation, SC 1.3.1)

### Screen 3 — Confirm the Specific Choice

**Rebook variant.** Flight cards have `aria-describedby="card-N-party"` — good. The composed accessible name (button text + described-by) follows CW's spec'd order. Concerns: B5 (Why? link tabindex), B3 (rule contrast). Filter link is a real `<a>` but per IxD opens a sheet, so it should be a button.

**Party-conflict state.** "Split party?" inline link inside a button is a nested-interactive pattern — invalid HTML and ambiguous focus. The outer `<button>` cannot contain an `<a>`. (SC 4.1.1 Parsing — note: 4.1.1 was retired in WCAG 2.2; the practical issue is 4.1.2 Name/Role/Value and 2.1.1 Keyboard, since the nested `<a>` is not reliably focusable.) **Fix:** restructure so "Split party?" is a separate button below the card, not inside it. Or make the entire card-row non-interactive and use a single "More" button for the row. (handoff to VD + IxD)

**Held-seat-expired state.** IxD §3.5: focus moves to the next available card, `aria-live="assertive"` announces "Seats no longer available on the 7:10 a.m. flight. The 6:20 p.m. flight is now selectable." This is the right pattern. **AT-specific note:** on iOS, programmatic focus move + assertive announcement can race; VoiceOver may announce the focus target *before* the live message. Sequence: dispatch the live message, wait one render frame, then move focus. (recommendation, handoff to engineering through IxD)

**Submit-failed.** Inline error band must be inserted *before* the CTA in DOM and labeled with `role="alert"` or `aria-live="assertive"` on first appearance, then degrade to a static message. The IxD spec is silent on the role; specify `role="alert"`. (SC 4.1.3 Status Messages)

**Offline-mid-flow.** Banner replaces sort row — fine — but the focus context must be preserved. If a user was focused on a card and the banner appears, focus must not jump. A `role="status"` (polite) banner is correct here. (SC 4.1.3)

### Screen 4 — Receipt

**Default.** `<dl>` with `<dt>`/`<dd>` pairs — strong structural pattern. AT note: VoiceOver iOS reads definition lists as "list, N items" and pairs term + definition. JAWS announces "definition list with N items." Both are good. The receipt's confirmation code in `<strong>` will receive emphasis. (passing)

The `tel:` link has no aria-label — see B8. The "Save / share receipt" button has no `aria-haspopup` or hint that a system share sheet is coming. (Minor: SC 3.2.2 On Input — share sheets are platform behavior, not a context change in WCAG terms; leave as-is, but recommend a "Save or share receipt — opens share menu" tooltip via `aria-label`.)

**Offline state.** Cached render — must not show a stale "claim now" link on meal credit that won't work offline. **Recommendation:** the meal "Claim now" link gets `aria-disabled="true"` and a "Reconnect to claim" sub when offline; do not silently fail the tap. (SC 3.3.1 Error Identification)

### Entitlements strip + sheet

**Strip.** Concerns covered in B6.

**Sheet.** Concerns covered in B2 (the big one). Beyond focus trap: the `.handle` decorative element is `aria-hidden` — good. The "Back to options" button is `aria-label`-ed — good. The "Not eligible" row uses `<span aria-disabled="true">` which is a non-interactive element marked as disabled; this is invalid (aria-disabled requires an interactive role). **Fix:** remove `aria-disabled` from the span and set the row content's text alone to communicate ineligibility. CW's copy ("Not eligible") already does this. (recommendation, SC 4.1.2)

---

## 3. Focus order verification

VD's expected Screen 2 order: fact → state → path card 1 → 2 → 3 → primary CTA → "Why these three?" → entitlements strip.

**Confirmed correct, with refinements:**
- The `<h1>` is not focusable, so a Tab-key user starts at path card 1. (The fact + state are read in *reading* order by ATs traversing the page, which matches.)
- Path cards: 1 → 2 → 3 (correct DOM order).
- Primary CTA next (correct).
- "Why these three?" before strip (correct — primary action group precedes secondary affordances).
- Entitlements strip last (correct — it is global chrome, not part of the decision).

**Confirm the strip comes after primary, not before:** Yes, it does in the prototype DOM. This is correct. A strip that received focus *before* the primary CTA would force a screen-reader user to tab through global chrome to reach the decision — exactly the failure pattern of nav-heavy sites.

**One refinement:** the section heading "YOUR THREE OPTIONS" (`<h2 class="section">`) is correctly placed in DOM between the state and the first card. A screen-reader user navigating by headings ("H" key on JAWS/NVDA, headings rotor on VoiceOver) lands here, which is the right anchor. (passing)

**One concern:** if focus is on the active (selected) path card on first load — which `aria-pressed="true"` suggests is the case — a keyboard user arriving fresh expects focus to be at the start of the page. **Recommendation:** initial focus should not be on a path card. Let the user Tab in from page-start; selection state is announced when they reach the card. (SC 2.4.3 Focus Order — not a violation, but a usability gain)

---

## 4. Sheet pattern spec

The sheet has `role="dialog" aria-modal="true"` markup. It needs the following behavior to be conformant and usable:

**On open:**
1. The element that triggered open (the strip button) sets `aria-expanded="true"`.
2. The underlying screen's interactive descendants receive `inert` on the root container (`.surface`). `inert` removes them from the accessibility tree and the tab order in one declaration. Do *not* use `aria-hidden="true"` on the underlying screen by itself — `aria-hidden` without `inert` leaves elements focusable, which creates the "focus disappears into the void" bug. (recommendation)
3. Focus moves programmatically to the sheet's `<h2 id="sheet-h2">` *or* to the first interactive element (Claim link on hotel row). I recommend the heading: it gives the screen-reader user a chance to hear the sheet's purpose before any action target, and matches iOS VoiceOver's expected pattern for `role="dialog"`.
4. The sheet's `aria-labelledby="sheet-h2"` is already correct.

**While open:**
5. Tab cycles within the sheet only: Claim (hotel) → Claim (meal) → "Not eligible" is skipped (it's a span; remove the `aria-disabled` per §2) → "Back to options" button → back to first focusable. Shift-Tab reverses.
6. Esc closes the sheet (handler must exist).
7. Tap on backdrop (`.sheet-shell` area outside `.sheet`) closes the sheet — this matches platform convention. Backdrop must have `aria-hidden="true"`.

**On close:**
8. Remove `inert` from the underlying surface.
9. Set `aria-expanded="false"` on the strip button.
10. Return focus to the strip button that opened the sheet — *not* the top of page. (SC 3.2.1 On Focus; SC 2.4.3 Focus Order)
11. If a claim was made, the strip's status text changes — announcement strategy in §5.

**Edge: claim succeeded, sheet auto-closes.** Do not auto-close. Force the user to dismiss explicitly via "Back to options," so the focus-return contract holds and the user has a moment to verify the row says "Claimed." (recommendation)

---

## 5. Persistent strip announcement strategy

IxD §7.4 proposed: `aria-live="off"` by default, switch to `polite` when status text changes; announce on status change, not on navigation.

**I'm confirming this with one addition.**

The strip's `role="region"` with `aria-labelledby` makes it discoverable via landmarks rotor — that is the right discovery affordance for screen-reader users on every screen, and it does *not* re-announce on navigation in any modern AT I'm aware of (VoiceOver iOS/macOS, TalkBack, NVDA, JAWS). Landmarks are scanned by the user, not pushed. So "the strip re-announces on every screen change" is not actually a risk under default behavior — the risk would only materialize if someone added `aria-live="polite"` on the region itself.

**My final call:**
- `role="region"` with `aria-labelledby` — keep as-is on all three screens.
- `aria-live="off"` (default; do not declare) — do not push announcements on navigation.
- When status text changes (claim succeeds, eligibility resolves, etc.), do *not* rely on the region's own live behavior. Instead, fire a one-shot announcement via a separate live region (a `role="status"` element appended at end of body) with the diff message: `"Hotel claimed — Marriott DEN Airport."` Then update the strip text statically. This avoids the entire class of "the strip read itself again" bugs. (recommendation)
- The strip-tap button's `aria-label` updates per CW's status-variant table whenever status changes — that's a static name change, not a live announcement.

**Why a separate live region rather than making the strip itself live:** because the strip is also a region (landmark) and a labelled container, and announcing the entire region on text change risks reading the full label + status combination. A separate `role="status"` element scoped to the diff lets us announce *only what changed.* This pattern matches WAI-ARIA Authoring Practices for asynchronous updates.

---

## 6. Contrast verdicts

Computed using WCAG 2.x relative luminance formula. Estimates within ±0.3 unless flagged. (recommendation, with uncertainty noted)

| Pair | Computed ratio | WCAG threshold | Verdict |
|---|---|---|---|
| Teal #2E6E6B fill / bone #F5F1E8 text (primary button text-on-fill) | ~5.6:1 | 4.5:1 (normal text, AA) | **Pass.** Comfortable margin. |
| Teal #2E6E6B as 1px border / bone #F5F1E8 surrounding (active card border) | ~4.7:1 | 3:1 (non-text, AA) | **Pass on contrast** — but the *border alone* at 1px width is functionally invisible at standard viewing distance for low-vision users. See B1. The contrast number passes; the affordance does not. |
| Teal-wash #DCE8E6 active card background / bone #F5F1E8 page background | ~1.1:1 | 3:1 (non-text, AA) | **Fail.** The fill cannot be the differentiator. Selection must be carried by a non-color affordance (border thickness, "Selected" indicator, left bar). See B1. |
| Warm-rust #8A4A1F party-status text / bone-3 #FBF8F1 card surface | ~6.8:1 | 4.5:1 (normal text, AA) | **Pass.** Strong margin. |
| Ink-2 #4A433D on bone #F5F1E8 | ~9.0:1 | 4.5:1 | **Pass.** |
| Ink-2 #4A433D on bone-3 #FBF8F1 | ~9.6:1 | 4.5:1 | **Pass.** |
| Ink-3 #7A716A on bone #F5F1E8 | ~4.5:1 | 4.5:1 (normal text) | **Pass — but on the line.** This is the most-uncertain pair (±0.3). Could compute 4.3 or 4.8 depending on the exact sRGB-to-linear conversion in browser rendering. Used for `.meta`, `.path-data`, captions, sub-text on receipt. **Recommendation:** darken to #6E655E (≈5.2:1) for safety, since these are body-weight strings at 14px (the smaller of the two sizes), and 14px is *not* AA-large by WCAG definition (AA-large requires 18pt / 24px regular or 14pt / 18.66px bold). |
| Ink-3 #7A716A on bone-3 #FBF8F1 | ~4.9:1 | 4.5:1 | **Pass.** Slim margin. |
| Rule #D9D0C2 hairline / bone #F5F1E8 | ~1.3:1 | 3:1 (non-text, AA) | **Fail** where the rule is the only delineation between two interactive surfaces. See B3. **Pass-by-exemption** for purely decorative dividers inside a single component (e.g., `<hr>` inside the receipt block between flight info and support — the structural meaning is carried by `<dl>` semantics, not the line). |

**Most-uncertain pair I'd flag for live testing:** ink-3 on bone-3 (~4.9:1 estimated). If browser color management or the actual rendered pixel values shift this below 4.5:1 on some displays, it tips into a fail for the receipt's sub-captions and the strip's status line. Recommend darkening ink-3 by one step regardless — it costs nothing.

---

## 7. Plain-language verdict on "together" vs "adjacent"

CW flagged this as the riskiest plain-language call on the surface.

**Position: ship "together." Do not switch to "adjacent."**

Reasoning:
- "Adjacent" is more technically precise (adjacent = next to each other), but the user's mental model is "are we sitting together as a group" — a question that "together" answers and "adjacent" subtly mis-answers. Three seats in row 12 marked A, B, C are *adjacent.* Three seats in row 12 A, B and row 14 C are *not adjacent but might still feel "together"* if the party doesn't mind. The line "Only 2 seats together. Split party?" prompts the right next action ("am I OK splitting?") in a way "Only 2 adjacent seats. Split party?" does not.
- ESL traveler concern (UXR): "adjacent" is a Latinate word common in legal/airline contexts but uncommon in everyday speech. "Together" is plain Anglo-Saxon vocabulary. SC 3.1.5 Reading Level is AAA, but the spirit applies here — and CW's voice rule 6 explicitly forbids idiom-free Latinate substitutions when plain ones exist.
- Screen-reader concern: "together" reads cleanly at any TTS speed. "Adjacent" has a hard consonant cluster ("dj-c-nt") that gets compressed at high speeds. (assumption — based on default voice behavior, not a controlled test)
- Counterargument I considered: "All 3 confirmed together" could be misread as "all booked together on the same booking record" (group booking, not seat adjacency). The dot + the surrounding context ("seat" implicit) mitigate this. If we wanted belt-and-suspenders, the line could be "All 3 seats together" — that is my **fallback recommendation** if user testing surfaces the group-booking ambiguity. (recommendation)

**Verdict:** "together" wins on every axis except technical precision, and we are designing for a tired traveler at 10:46 p.m., not for a corpus linguist. If the test surfaces ambiguity, prepend "seats" — do not switch to "adjacent."

---

## 8. Edge users (UXR Risk section)

| Edge user | Does the design serve them? | What closes the gap? |
|---|---|---|
| **Deaf / SMS-reliant** | **Partly serves.** CW's SMS carries the fact, state, deep link, and phone fallback — the phone fallback is a low-value affordance for deaf users (TTY/relay friction), but the deep link to the full self-service flow means they do not need to call. Sheet's `aria-modal` + focus trap (once spec'd) supports the screen-reader path that some deaf users also rely on. | Add an SMS-side acknowledgment path: a reply keyword (`STATUS`, `OPTIONS`) that returns a structured SMS with the three paths, so a user without app access or with degraded mobile data can still triage. Out of scope for this prototype; flag for product. (recommendation) |
| **ESL traveler** | **Serves well, with one residual risk.** CW's voice rule 6 (idiom-free) was applied across all strings I reviewed. "Together," "no charge," "you arrive," "you decide later," "wait at the gate" are all plain Anglo-Saxon. "Recommended" was eliminated. *Residual risk:* "fare difference" appears in the error/state copy if the variant ships — it's an airline-industry idiom. CW already flagged cutting "Why?" on No-charge cards; that resolves this for the prototype. | If fare-difference framing returns, define it inline on first appearance, not behind a tooltip. (recommendation) |
| **Low-bandwidth** | **Serves well.** No web fonts (system stack), no images, no shimmer, receipt renders from cache (IxD §1, §3.6). Offline state on Screen 4 keeps the receipt readable and the `tel:` actionable. | The SMS deep link must resolve to a cached/lightweight initial paint — flag for engineering. The `northstar.app/ns482` route should not require auth-roundtrip before showing the fact (IxD §1 logged-out state spec'd this). (recommendation) |
| **Mobility / one-handed / switch-control** | **Partly serves.** Tap targets are ≥44px throughout (verified in CSS: `.btn-primary` min-height 52, `.btn-secondary` 44, `.strip-tap` 44, `.flight-card` is full-width and tall — passes SC 2.5.5 Target Size (Enhanced) at AAA and SC 2.5.8 Target Size (Minimum) at AA WCAG 2.2). *Risk:* the nested "Split party?" link inside the flight-card button (see §2 Screen 3) is a switch-control blocker — switch users cannot reliably target a nested interactive. | Restructure the party-conflict card per §2 Screen 3 fix. (handoff to VD + IxD) |
| **Party with infant / service animal** | **Fails.** Party-size status row tells the user how many *seats* are together but says nothing about bassinet rows, pet-in-cabin space, or service-animal accommodation continuity. UXR flagged this; no surface in the current design carries it. | Add an additional status line below party-size on flight cards for accessibility-relevant accommodations when the booking carries them: `"Bassinet row confirmed on this flight"` / `"Service animal — gate-checked accommodation confirmed."` This is structural to the card (per VD's pattern of putting party status on the card, not behind a filter). (recommendation, handoff to VD + IxD + CW) |
| **Distress / cognitive load / grief / medication side effects** | **Partly serves.** The operational header pattern (fact → state → path) and the persistent strip both reduce working-memory load. The "Plans changed? Start over" re-entry preserves prior claims (IxD §5), which respects the user who realizes mid-flow they made the wrong choice. *Risk:* the held-seat-expired focus-jump (IxD §3.5) is correct for a clear-headed user but can disorient a user whose attention is already fragile. The `aria-live="assertive"` announcement + focus move + visual strikethrough is *three* simultaneous state changes. | Slow the held-seat-expired transition: announce first ("Seats no longer available on the 7:10 a.m. flight"), wait one beat, then announce the recovery ("The 6:20 p.m. flight is now selectable"), then move focus. Two beats, not one. (recommendation, handoff to IxD) |

**Most likely to still fail:** **the party-with-infant / service-animal user.** No surface in the current design carries accommodation continuity. The party-size pattern covers travelers-as-headcount but not travelers-with-specific-needs. This is the gap I would call out to the team lead as needing a fifth status variant on the flight card, not a future-state ticket.

---

## 9. Handoff messages

### To Visual Designer

1. **Active path card (B1):** the 1px teal border on teal-wash is not enough. Two options: (a) thicken to 2px and add a 4px left-edge bar in `--teal-ink`; (b) add a "Selected" visual token (small teal pill in the path-label row, paired with the AT-only "Selected" suffix). Pick one — don't ship the current.
2. **Rule color (B3):** darken `--rule` to `--ink-3` #7A716A for borders that separate interactive cards from each other and from the page. Keep `--rule` for purely decorative dividers inside a single card. New token recommendation: `--rule-strong: #7A716A` for inter-card separation.
3. **Ink-3 (contrast):** darken to ~#6E655E. Cheap insurance for the 14px metadata line.
4. **Held-seat-expired card visual (IxD §7.1 ask):** the bone-2 fill + ink-3 type + strikethrough is fine for low-vision users *if* you also add a non-color affordance — a left-edge stripe in `--ink-3` mirroring the history-card pattern. Selection state, unavailability state, and history state should each have a distinct non-color treatment.
5. **Strip button:** put the accessible label directly on the `<button>`, not on a labelledby chain that fails on two of three strips (B6).

### To Interaction Designer

1. **Sheet trap (B2):** spec'd in §4 of this report. Inert on underlying surface, focus to sheet heading on open, focus back to opener on close, Esc + backdrop both dismiss, no auto-close after claim.
2. **Held-seat-expired sequence (§8 distress note):** two beats, not one. Announce loss, pause, announce recovery, then move focus.
3. **Party-conflict card structure (Screen 3 audit):** "Split party?" cannot be a nested `<a>` inside the card `<button>`. Either pull it outside the card as a separate button, or convert the card to a non-button container with explicit "Select this flight" and "Split party" sibling buttons.
4. **Strip announcement strategy (§5):** confirmed your `aria-live="off"` default. Refinement: announce status changes via a separate `role="status"` live region, not by making the strip itself live.
5. **Path card initial focus (§3):** do not auto-focus the active path card on first paint. Let Tab land there naturally.

### To Content Designer

1. **"Together" verdict (§7):** ship it. Don't switch to "adjacent." Fallback if testing surfaces ambiguity: prepend "seats" — "All 3 seats together."
2. **Aria-label table (your §9):** ratified. Two additions:
   - The active path card aria-label must end with `"Selected."` (not at the start) so the consequence reads in full before state.
   - The "Save / share receipt" button could use a hint label: `"Save or share receipt — opens share menu"`.
3. **State-line emphasis (your §9 ask 1):** confirmed `<strong>` carries prosodic emphasis on VoiceOver and TalkBack at default verbosity. For users at low verbosity (rare), your fallback phrasing "You are not yet rebooked" should be the canonical sentence — same meaning, the load-bearing verb does the work without depending on tag-level emphasis. Ship that version.
4. **Offline meal-claim copy:** add an aria-disabled state copy for the meal "Claim now" link when offline. Suggest: visible "Claim now" → "Reconnect to claim"; aria-label = `"Meal credit — reconnect to claim."`
5. **Error band on submit-failed:** prepend `role="alert"` semantics in engineering — your copy is correct; the announcement contract is what carries it to AT users on appearance.

### To Team Lead — non-negotiables for the synthesis

1. **The sheet ships with focus trap + inert + Esc + return-focus, or it does not ship.** No "we'll add the JS later." A static `aria-modal` markup is a worse experience than no modal at all — it lies to AT users about being a trap.
2. **The active path card carries a non-color affordance.** The teal wash is decorative; the affordance is what AT and low-vision users actually use. This is not a polish detail — it's the difference between selectable and not.
3. **Accommodation continuity (infant / service animal) belongs on the flight card.** Not a future ticket. Add a fifth status line variant or commit to a known gap. Pretending it doesn't exist is the same failure mode as the original flow's hidden entitlements.
4. **"Together" stays. Do not let a late legal/policy review swap it for "adjacent."** That swap would silently make the flow worse for ESL and TTS users — both protected groups, neither of whom show up in the review meeting.
5. **The keyboard walkthrough I authored in §3 is the contract.** If engineering implements a different focus order, it fails AT QA. Sign-off requires manual keyboard + screen-reader pass on iOS Safari (VoiceOver) and Android Chrome (TalkBack) before launch.

---

*Confidence: structural audit and WCAG mapping — high (anchored on shipped specs, not speculation). Contrast computations — medium-high (estimates within ±0.3; the ink-3 pairs are the most-uncertain and the recommendation to darken is cheap insurance). AT-behavior calls (sheet pattern, strip announcement, held-seat sequencing) — high; these follow WAI-ARIA Authoring Practices and known VoiceOver/TalkBack behaviors. Edge-user gap analysis — medium-high (the accommodation-continuity gap is real and named; the SMS keyword path is speculative product scope).*
