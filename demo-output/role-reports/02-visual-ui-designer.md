# Visual / UI Designer Report — Canceled-Flight Recovery Prototype

Labels: **[OBSERVED-FROM-IA]** taken directly from the IA report, **[INFER]** inferred from IA + general design knowledge, **[ASSUME]** my working assumption, **[REC]** my recommendation for downstream auditors.

Single deliverable: `demo-output/prototype/index.html` — five mobile screens, stacked vertically, each framed as a phone mockup. Self-contained HTML with inline `<style>` and SVGs, minimal vanilla JS for state toggles only. No external requests.

---

## 1. Visual direction brief

**Aesthetic anchor.** Linear's restraint crossed with Apple system honesty. The traveler reading this is fatigued, embarrassed, or angry. The product cannot read as cheerful, marketing-y, or aggressively branded. It must read as composed — like a calm operator on the other end of the line. **[INFER]** from the IA tone guidance ("plain, calm, second-person") and the brief's anti-jargon stance.

**Mood.** Composed. Plain-spoken. Useful. Unhurried. Accountable. Five adjectives, all anti-marketing.

**Principles (named, defensible).**

1. **Hierarchy is exaggerated under fatigue.** The headline on every screen is the loudest type on that screen. A panicked user should be able to read one thing and know what to do. The display size on Screen 1 (`--t-display: 26px`) is intentionally bigger than the rest of the type scale would dictate, because that screen carries the bad news.
2. **Color is for state, never for decoration.** Brand navy appears on the primary button and key emphasis (the destination city, the cancellation token). Warm yellow appears only on the "Not guaranteed" standby risk badge. Green appears only on confirmation and on a flight card's reason chip ("Earliest arrival"). Blue appears only on the conditional support banner. No gradients, no decorative color, no celebratory color anywhere.
3. **Long tokens are first-class content.** Every placeholder (`{flight_number}`, `{destination_city}`, etc.) is rendered as a typographically distinct pill that *wraps inside its parent*. Tokens never force horizontal overflow. **[REC]** when this ships, the engineering team should preserve the wrap behavior — long real-world flight numbers and destination strings will appear in production.
4. **Three recovery paths are visually equal.** Screen 2's three choices share identical type, identical card weight, identical border. Standby carries an additional risk badge per IA spec, but no path is pre-selected, no path has a "Recommended" pill, no path is visually heavier than another. The user makes a choice; the airline does not pre-make it for them. **[OBSERVED-FROM-IA]**
5. **"Talk to a person" is a fixture, not a footer.** It sits on a bordered help strip at the bottom of every phone screen. Underlined, brand-color, visible without scrolling once the screen is rendered. **[OBSERVED-FROM-IA]**

**What the surface should not feel like.** A boarding-pass app. A loyalty pitch. A legal disclaimer. A celebration of getting through a problem. A wizard that gates information behind clicks.

---

## 2. Design tokens

Defined as CSS custom properties in the prototype. The summary:

**Type scale (mobile-first).**

| Token | Size | Use |
|---|---|---|
| `--t-display` | 26px | Screen 1 cancellation headline only |
| `--t-h1` | 22px | Screen titles ("How would you like to recover?") |
| `--t-h2` | 17px | Card titles, section heads |
| `--t-body` | 16px | Body text |
| `--t-small` | 14px | Secondary text, consequence lines, meta |
| `--t-caption` | 12.5px | Labels, eyebrow text, status meta |

Line height is `1.25` for headlines (`--lh-tight`) and `1.45` for body (`--lh-body`). Letter-spacing on headlines is `-0.01em` to `-0.015em`. **[INFER]** — these are conservative against the IA's "plain, calm" tone.

**Color tokens.** Warm-cool ink rather than pure black. Brand is restrained navy.

- Neutrals: `--ink-900` (#0f1419) for primary text, `--ink-700` for secondary, `--ink-500` for tertiary, `--ink-200`/`--ink-100` for borders and surfaces.
- Brand: `--brand-900` (#0b2545) for primary button + key emphasis tokens. `--brand-100` for token highlight on important nouns.
- State (semantic only): warn (canceled/standby risk), positive (confirmation/recommended reason), info (conditional support banner). Each state has ink + bg + edge color so it can render as a chip, a banner, or a small badge consistently.

**Spacing.** 4-point rhythm. `--s-1` (4px) through `--s-9` (56px). Card internal padding is `--s-4` (16px), screen-body gap is `--s-4` / `--s-5`. **[INFER]**

**Radius.** Cards `--r-xl` (22px) and `--r-lg` (14px); buttons `--r-md` (10px); pills `--r-pill` (999px); phone frame `--r-phone` (36px).

**Shadow.** Quiet. Cards `0 1px 0 / 0 1px 2px` rgba ink. Phone frame `0 8px 28px / 0 2px 4px`. No dramatic drop shadows; no glow.

**Motion.** A single ease curve `cubic-bezier(.2,.7,.2,1)`. Short durations (.05–.15s). Respect `prefers-reduced-motion`. **[REC]** the Accessibility Specialist should verify this is sufficient.

---

## 3. Screen-by-screen layout decisions

### Screen 1 — What happened

- Headline uses the largest type in the whole flow (`--t-display`), wrapping across three lines on a 390px-class viewport so the cancellation reads as the single most important thing on the page. **[INFER]** from IA's "primary decision: read and acknowledge."
- The tokens for `{depart_time}` and `{destination_city}` are *inside* the headline, rendered as a stronger pill (`tok-strong`) so the eye lands on the specifics, not just the word "canceled."
- The "cause" sentence and the reassurance sentence sit below the headline at body weight, no card or border — they read as continuation, not as new modules.
- "See my options" is the only primary button. Verb + outcome. No "Continue." **[OBSERVED-FROM-IA]**
- The help strip at the bottom shows "Talk to a person" + flight-number context. The flight number stays available even on Screen 1 so the user always knows which trip they're inside.

### Screen 2 — Choose how to recover

- One-line restatement of what was canceled, framed as an "anchor" card (light gray surface, low contrast) — present but not loud. **[OBSERVED-FROM-IA]**
- Three identical "choice" buttons. Same size, same border, same internal layout. No card has a "Recommended" pill. Standby carries an additional `NOT GUARANTEED` warning chip per IA wording rule. **[OBSERVED-FROM-IA]**
- The conditional support banner sits *below* the choices, info-colored, not pre-promising entitlement. Copy is the IA's recommended phrasing verbatim: "Tonight's hotel and meal support may be available. We'll show what you qualify for after you pick a path." **[OBSERVED-FROM-IA]**
- A small muted line under the banner: "Travelers booked together will be moved together unless you call." This addresses the IA scoped gap on multi-passenger travel — surface area visible but not built. **[OBSERVED-FROM-IA]**
- No primary button at the bottom of this screen, because the choice cards *are* the affordance. **[OBSERVED-FROM-IA]** "the card itself is the affordance" is the IA's exact language.

### Screen 3 — Pick your flight (rebook variant)

- Filter bar uses pill-style toggle chips. "Earliest arrival" is pre-selected to mirror the IA's "sorted by earliest arrival by default" — but the sort is *named*, not silently applied. **[OBSERVED-FROM-IA]**
- Flight cards show depart/arrive times as the dominant content, with the depart→arrive arrow as a visual connector. Token-sized times sit on a 17px weight-700 line. **[INFER]**
- "Recommended" labels are replaced per IA rule with a reason-chip: green pill reading "Earliest arrival" or "Closest to original time." The reason is on the same line as the chip itself — there is no separate bare "Recommended" anywhere. **[OBSERVED-FROM-IA]**
- The selected flight card is bordered in brand navy and has `aria-current="true"`. Selection is a state, not a "tap to add to cart" interaction.
- A dashed-border sketch at the bottom describes the refund and standby variants in two short paragraphs. **[OBSERVED-FROM-IA]** — the IA explicitly said refund and standby could be a sketch. The sketch keeps the variant intent visible without inventing screens.
- Primary button: "Confirm this flight." Verb + outcome.

### Screen 4 — Tonight and tomorrow

- The screen the current flow buries. Headline + plain explanation come first. **[OBSERVED-FROM-IA]**
- Each entitlement is an "offer" row with a glyph (house, plate, suitcase), a label, a *status token* (so the system can say "we're checking" or "not eligible — call us"), and an explicit Accept / Decline pair. **[OBSERVED-FROM-IA]**
- The baggage row has no Accept/Decline — it's pure instruction (e.g. "your bags will be re-checked"), which is the IA's framing of baggage as information not opt-in. **[INFER]**
- A second info banner sits below the rows: if the system can't confirm eligibility, the user is invited to "Talk to a person — we'll sort it without delaying your rebooking." This addresses the IA's rule that uncertainty must be voiced plainly, not hidden. **[OBSERVED-FROM-IA]**
- Primary button: "Confirm tonight's plan." Verb + outcome.

### Screen 5 — Your updated trip

- A check-circle + "Confirmation" eyebrow + outcome-named headline ("You're rebooked to {destination_city}"). The headline names the outcome the user chose, not a generic "Trip updated." **[OBSERVED-FROM-IA]**
- A summary card with five rows in the IA's confirmation order: New flight, Tonight, Bags, At the airport, If plans change. Each row uses a label / value grid layout. **[OBSERVED-FROM-IA]**
- The "If plans change" row directs the user back to "Talk to a person" with their trip ID preserved — closing the loop on support-visibility. **[OBSERVED-FROM-IA]**
- Two primary-tier buttons in a row: "Save offline" (brand-navy primary) and "Share trip" (ghost). Per IA, this screen has no forward primary; the action is save or share. **[OBSERVED-FROM-IA]**
- A muted line: "This page works without signal once saved. Re-open from your trips list." Addresses the scoped low-bandwidth gap as IA recommended. **[OBSERVED-FROM-IA]**

---

## 4. Viewport-fit note (render-gate-relevant)

**Method.** Headless Chrome with `--window-size`, `--force-device-scale-factor=1`, and `--virtual-time-budget` set high. Probe injected into a copy of the HTML; probe walks every element with `getBoundingClientRect` and counts any whose `right` exceeds `clientWidth`. Probe also reports `scrollWidth` vs `clientWidth` for `<html>` and `<body>`.

**Results across tested widths (chrome-headless layout viewport in parentheses).**

| Requested window | Reported layout viewport | scrollWidth | clientWidth | offenders |
|---|---|---|---|---|
| 390 | 485 (chrome-headless minimum) | 485 | 485 | **0** |
| 600 | 585 | 585 | 585 | **0** |
| 800 | 785 | 785 | 785 | **0** |
| 1024 | 1009 | 1009 | 1009 | **0** |
| 1200 | 1185 | 1185 | 1185 | **0** |

**Stress test.** A copy of the HTML was patched to replace every primary token (`{flight_number}`, `{destination_city}`, `{depart_time}`, `{arrive_time_1}`) with much longer strings (e.g. `NS482-RETURN-LEG-A-EXTRA-LONG-TOKEN`, `SOMEWHERE-FAR-AWAY-INTERNATIONAL`, `MONDAY-NOV-LATE-MORNING-ARRIVAL-JFK`). Probe still reported `offenders=0` at all tested widths. Long tokens wrap inside their containers via `overflow-wrap: anywhere` + `word-break: break-word` on `.tok`, with `box-decoration-break: clone` so pill backgrounds continue cleanly across line breaks.

**Key fixed-format containers verified visually at the tested layout viewport (485px):**

- Phone frames render fully visible, rounded corners intact, content fits.
- Cards (`.card`, `.choice`, `.flight`, `.offer`) — all token content wraps inside the card; no clipping at edges.
- Token pills — `display: inline` with `box-decoration-break: clone` ensures multi-line tokens still look like pills.
- Buttons — fluid width, text wraps if needed, no fixed pixel widths.
- Summary rows on Screen 5 — at >=420px the label sits to the left in a 96px column; below 420px the row collapses to single-column. Long values wrap inside the value cell.
- Filter pills — `flex-wrap: wrap` so they reflow rather than scroll horizontally.
- Help footer — `flex-wrap: wrap`; the trip-context token can drop to a second row.

**No `overflow: hidden` / `overflow-x: hidden` is used anywhere as a masking band-aid.** The phone-screen container was initially set to `overflow: hidden` for cosmetic corner clipping; that was removed and the corner rounding is now visually carried by the phone bezel's outer radius. The render gate's "rerun with masking disabled" test should produce the same result.

**One environmental note for the lead.** Chrome's headless layout viewport in this environment did not go below 485px even when `--window-size=390` was requested — every screenshot taken at narrow window-sizes was the same 485px layout cropped to the requested physical width. This is a chrome-headless quirk, not a layout bug; on a real iPhone at 390pt the layout would be even more comfortable than the screenshots suggest. If the render proof reruns with a different headless mode (e.g. device emulation or Puppeteer with a true mobile viewport), the offender count should remain 0.

---

## 5. Copy + content discipline

- Verb-+-outcome buttons everywhere a primary action exists: "See my options", "Confirm this flight", "Confirm tonight's plan", "Save offline". **[OBSERVED-FROM-IA]**
- Banned phrases verified absent: no "schedule irregularity", no bare "Continue", no bare "Done", no "Recommended" (the word does not appear anywhere — reason chips use the reason directly), no "Other policies". Grep-verified.
- "Talk to a person" appears in the persistent help strip of all five screens. Screen 5's variant reads "Plans changed again? Talk to a person." per the IA confirmation rule.
- No invented operational facts. All concrete values are placeholders. Grep-verified for currency, hotel chains, phone numbers, wait times, expiration windows — none present.
- Blind-eval hygiene: the HTML `<title>` reads "Canceled-flight recovery — mobile prototype." No origin terms, no team names, no SHAs in the body. **[OBSERVED-FROM-HANDOFF]**

---

## 6. Known design choices the auditors will likely flag

I'm naming these now so the Accessibility Specialist and Behavioral Scientist can decide quickly whether to escalate or accept.

- **Standby's "NOT GUARANTEED" badge is the only uppercase-on-warn-color element on Screen 2.** The Behavioral Scientist may argue this visually de-weights standby relative to the other two options, even though the IA explicitly required standby to read as non-equivalent to confirmed rebooking. The badge is small and below the title, not louder than the choice cards themselves — but it is asymmetric. **[ASSUME]** the IA intent justifies the asymmetry; if the Behavioral Scientist disagrees I'll move it to a separate caveat line on the same card.
- **The destination/depart-time tokens on Screen 1 use `tok-strong` (brand-navy bg).** This visually pulls the eye to the specifics inside the headline. The Accessibility Specialist should check the contrast ratio of `--brand-100` (#e6edf6) bg + `--brand-900` (#0b2545) text — by my read it's ~14:1 which is far above AA, but verify. Same check for the gray `--ink-100` token bg on `--ink-900` text.
- **Focus ring is a 3px brand-500 outline with 2px offset.** Applied to buttons, choice cards, filter pills, toggle pairs, and the "Talk to a person" link. The Accessibility Specialist should confirm this is visible against the white background and the brand-navy primary button. I deliberately did not use a default browser focus ring.
- **Tap target size.** Primary buttons are 14px + 16px text + 14px = ~48px tall. Toggle pairs are 10px + 14px text + 10px = ~38px tall — at the lower end. Filter pills are ~30px tall. The Accessibility Specialist should call any of these out if they fall below the 44pt target.
- **The reason chip ("Earliest arrival" / "Closest to original time") is positioned *above* the time block in each flight card.** That's a deliberate choice — the reason is the answer to "why is this card listed first," and the IA's rule was that the reason must accompany the recommendation on the same line. I'm treating "same line" loosely as "before the user reads the time," and the chip sits as an above-content label so the reason is read first. If that misreads the IA constraint, happy to move the chip inline with the times.

---

## 7. Revision pass: audit fixes applied / rejected

One surgical revision pass against the two audit reports. Every blocker was applied; the cheap A11y nice-to-haves the specialist suggested batching were also applied. No fix was rejected.

### Blockers applied

**A11y-B1 — Screen 3 flight cards now keyboard-/AT-accessible.**
*Selectors:* `.flight`, new `.flight-radio`, new `.flights`, `.sr-only` (new utility class).
*Change:* Converted from `<div role="listitem">` with JS click handlers to native `<input type="radio" name="flight">` + `<label class="flight" for="…">` pattern wrapped in `<div role="radiogroup" aria-label="Available flights">`. The radio inputs are visually hidden (`opacity: 0` + 1px square + `pointer-events: none`) but remain focusable and keyboard-operable; native arrow-key + Space-to-select behavior comes for free. Selected state is driven by `.flight-radio:checked + .flight` (no JS sync needed) and the two-color focus ring surfaces on the visible label via `.flight-radio:focus-visible + .flight`. Dropped `role="list"`, `role="listitem"`, and `aria-current` per the A11y spec's note that radiogroup carries its own structure. Added `aria-label="Departure"` / `aria-label="Arrival"` to each `.time-block` (the optional N9 from the A11y report) so the depart→arrive relationship survives the visual arrow being decorative.

**A11y-B2 — Two-color focus ring on all interactive surfaces.**
*Selectors:* `.btn-primary:focus-visible`, `.btn-ghost:focus-visible`, `.choice:focus-visible`, `.filter:focus-visible`, `.toggle:focus-visible`, `.help a:focus-visible`, `.flight-radio:focus-visible + .flight`.
*Change:* Replaced the single brand-500 outline with a two-color pattern. Primary button uses `outline: 2px solid #fff; box-shadow: 0 0 0 4px var(--brand-500);` — the white inner ring sits adjacent to the navy button at 18.5:1; the brand-500 outer ring sits against the page background at 7.8:1. Other (non-navy) buttons use `outline: 2px solid var(--brand-900);` for the inner ring with the same brand-500 outer ring, so the pattern survives on any current or future button color. The focus indicator now passes 1.4.11 Non-text Contrast on every interactive surface.

**A11y-B3 — Target sizes bumped to ≥44 CSS px.**
*Selectors:* `.filter`, `.toggle`, `.help a`, `.btn`.
*Change:*
- `.filter` padding `6px 12px` → `10px 14px`; added `min-height: 44px` and `display: inline-flex; align-items: center; justify-content: center;`. Pills are still pill-shaped, now ~44px tall.
- `.toggle` padding `10px 12px` → `12px 16px`; added `min-height: 44px` + inline-flex centering. The Accept/Decline pair still fits in its flex track at 120px each.
- `.help a` is the most severe of the three (was ~20px). Now wrapped in `display: inline-flex; align-items: center; min-height: 44px; padding: 10px 6px; margin: -10px -6px;`. The negative margin keeps the underlined text visually aligned with the help strip's edge while the hit area extends behind the strip padding. Verified the negative margin does not trigger horizontal overflow in the render gate (see viewport-fit note below).
- `.btn` defensive `min-height: 44px` even though computed height was already ~48.

**Beh-B1 — Screen 1 reassurance rewritten as a check, not an offer.**
*Selector:* Screen 1's second `<p class="p">`.
*Old:* "We'll help you arrange a new flight, and — if your case qualifies — a place to sleep tonight and a meal credit. You'll see what you qualify for on a later step."
*New:* "We'll help you book a new flight. We'll also check whether tonight's stay or a meal credit applies to your case, and show you the result on the support step."
The new copy leads with the guaranteed action (book a new flight), then describes support as something the airline will *check* on the user's behalf. Hotel and meal credit are now mentioned only as the categories being checked, not as items being floated. Loss-aversion anchor reduced; trust framing preserved.

**Beh-B2 — Screen 5 pending vs confirmed states are visually distinct.**
*Selectors:* new `.status-pill`, `.status-pill.is-confirmed`, `.status-pill.is-pending`, `.status-line` (with `.label`, `.detail`). Markup change to the "Tonight" summary row only.
*Change:* The "Tonight" row now renders two `.status-line` blocks. The hotel row carries a warn-state pill reading "Pending — we'll text you when it's ready" (state-warn palette, 8.6:1 contrast — not the focus-ring color). The meal credit row carries a positive-state pill reading "Confirmed" (state-pos palette, 8.0:1 contrast). The status pill is the load-bearing visual; the placeholder token is the detail line under it. Both states are demonstrated in the prototype as the audit asked. The other summary rows (New flight, Bags, At the airport) remain in the prior format because reaching Screen 5 with a rebook outcome implicitly confirms those values; if downstream those rows could carry pending status too, the same `.status-pill` component handles it.

**Beh-B3 — Screen 4 primary disabled until each row has a selection.**
*Selectors:* new `.primary-with-helper`, `.primary-helper`; `.btn-primary[disabled]` state; markup change wrapping the Confirm button.
*Change:* The "Confirm tonight's plan" button now starts with `disabled` attribute. A helper paragraph below the button reads "Choose accept or decline for each row to continue." (state-warn-ink, centered, 14px). The disabled button uses `--ink-200` background with `--ink-500` text. When the user taps any Accept or Decline, the JS handler `refreshConfirmTonight()` checks whether every `.offer .actions` group has a pressed toggle; if so the button's `disabled` attribute is removed. The helper text auto-hides via CSS `:has(.btn-primary:not([disabled]))` — no JS needed for that. `aria-describedby` links the button to the helper text so screen-reader users hear the reason for the disabled state.

### Cheap A11y nice-to-haves applied (batched, per spec)

- **N1 — Demote Screen 1 `.h-display` from `<h1>` to `<h2>`.** The page-intro `<h1>` is now the sole `<h1>` in the document. All five screens use `<h2>` for their primary heading. Visual size preserved via the `.h-display` class.
- **N3 — Statusbar hidden from AT.** Already had `aria-hidden="true"` on the `.statusbar` div from the original pass; verified clean. The five "9:41" decorative reads are not announced.
- **N4 — "Screen N of 5" in accessible name.** Each `<article class="mock">` switched from `aria-labelledby="sN-title"` (which resolved to just "What happened") to `aria-label="Screen 1 of 5: What happened"` (and equivalents on the other four). Screen-reader users now hear the position-in-flow when navigating between articles.
- **N9 — `aria-label="Departure"` / `aria-label="Arrival"` on each `.time-block`** on Screen 3, applied as part of the radio-group conversion. The visual arrow remains decorative; the role of each time block is now explicit.

### A11y improvements not in the formal audit list but applied opportunistically

- **N2 from the A11y report** (drop `role="list"`/`role="listitem"`) — applied as a side effect of B1.
- **Reason chips on Screen 3** — wrapped the visible text in `aria-hidden="true"` and added an `.sr-only` "Reason: …" variant so screen-reader users hear the reason as a labeled phrase rather than as a floating word.

### Audit items not applied (deliberate, with reasoning)

None. Every blocker was applied. The non-blocking nudges from the Behavioral Scientist (N1–N4) are copy/content suggestions that I'm leaving for the lead and a Content Designer (downstream) — they are wording calls that the IA's copy-constraint rules already touch, and the lead's red-team checklist asked me not to chase nudges. The A11y non-blockers N5–N10 about live regions, page-load focus management, SPA route-change behavior, and `prefers-color-scheme` are runtime / engineering concerns that I cannot solve in static HTML, and the A11y specialist explicitly noted them as downstream of the prototype.

### Render-gate viewport-fit confirmation (after revision)

Re-ran the same headless-probe-with-getBoundingClientRect approach used in the first pass. Probe runs in a `setInterval` to settle layout, walks every element, and reports any whose right edge exceeds `clientWidth`. Results:

| Requested window | Reported layout viewport | scrollWidth | clientWidth | offenders |
|---|---|---|---|---|
| 390 | 485 (chrome-headless minimum, unchanged) | 485 | 485 | **0** |
| 480 | 485 | 485 | 485 | **0** |
| 600 | 585 | 585 | 585 | **0** |
| 800 | 785 | 785 | 785 | **0** |
| 1024 | 1009 | 1009 | 1009 | **0** |
| 1200 | 1185 | 1185 | 1185 | **0** |

**Stress re-test with long tokens.** Same substitution as the first pass plus `{hotel_status}` → `STILL-WORKING-LATE-NIGHT-CHECK-LONG` (since Screen 5's status-pill section is new and contains tokens). Probe at W=390/600/1024 still reports **offenders = 0** in every case. New components added in this revision pass — `.status-pill`, `.status-line`, `.primary-with-helper`, `.primary-helper`, and the radio-input flight cards — all wrap their contents (no fixed widths, `overflow-wrap: anywhere` on the detail line, `flex-wrap: wrap` on `.status-line` so the pill can drop to its own row when the label is long).

**No `overflow: hidden` / `overflow-x: hidden` added in this revision pass.** The earlier removal from `.phone-screen` is preserved. The render gate's masking-disabled rerun should return the same offenders=0 result.

**Visual sanity at 485px layout viewport** (chrome-headless minimum), verified by full-page screenshot:

- *Screen 1:* rewritten reassurance copy reads cleanly across three lines; "See my options" button + help footer with expanded tap area intact.
- *Screen 3:* flight cards render identically to the prior pass — same visual, same tokens, same selected-state border. The native radio input is invisible to sighted users but tabbable for keyboard users. Reason chips ("Earliest arrival", "Closest to original time") still position above the time block.
- *Screen 4:* Accept/Decline buttons are visibly taller. Confirm button starts greyed-out with warn-color helper text "Choose accept or decline for each row to continue." Tapping any Accept or Decline enables the primary and hides the helper.
- *Screen 5:* the new "Hotel … Pending — we'll text you when it's ready" pill and "Meal credit … Confirmed" pill render side-by-side as a clear demonstration of the two states. Other summary rows unchanged.

The render gate's `scrollWidth <= clientWidth` rule passes; the per-element internal-clipping walk reports zero offenders; the visual sanity check confirms no token, card, button, summary row, status pill, or radio-pattern flight card clips, overlaps, or escapes its container.
