# Accessibility Specialist — Northstar Canceled-Flight Recovery

## Audit summary

The prototype clears most of the easy floor: `lang="en"` is set, focus-visible is implemented with a high-contrast ring, `prefers-reduced-motion` is respected, primary CTAs are 48px tall, color is reinforced with text and shape on every state badge, and Standby's non-equivalence is encoded structurally (dashed container, warning chip, "non-confirmed" divider) rather than by color alone. What it does not yet clear is custom-control semantics. The path radiogroup, flight listbox, and filter chip group all use `<button>` elements with overloaded ARIA (`role="radio"` *and* `aria-pressed`, `role="option"` inside `<li>` inside a `role="listbox"` `<ul>`), no roving tabindex, and no arrow-key handling. To a screen-reader user that is the difference between "I am picking a recovery path" and "I am pressing four unrelated buttons." There are also low-contrast secondary text tokens and a missing `<main>` landmark. Two blockers, six should-fix.

## Blockers

### B1. Custom radiogroup on Screen 2 has broken/contradictory ARIA and no keyboard model

- **WCAG:** 4.1.2 Name, Role, Value (A); 2.1.1 Keyboard (A); WAI-ARIA Authoring Practices "radio group" pattern.
- **Where:** `#screen-2 .paths[role="radiogroup"]` and its three `<button role="radio">` children. JS sets *both* `aria-checked` and `aria-pressed` on the same element.
- **Failure:** `role="radio"` requires `aria-checked` and a roving-tabindex / arrow-key model. `aria-pressed` is for toggle buttons; combining them gives screen readers contradictory state ("toggle button, not pressed" vs. "radio button, not checked"), and announcement varies by AT. No arrow-key handler exists, so a NVDA/VoiceOver user in radiogroup mode cannot move between options the way the role contract promises.
- **User impact:** A blind user lands on "Rebook," hears an inconsistent role, presses arrow-down expecting the next path, nothing happens, and ends up Tab-cycling out of the group entirely. Under fatigue at 11 p.m., this is where they call support.
- **Minimum fix:** Pick one pattern. Easiest: keep `<button>` + `aria-pressed` and drop `role="radio"`/`role="radiogroup"` — treat them as a single-select toggle set with a `<fieldset><legend>` wrapper, JS enforcing one-pressed. If keeping `role="radio"`: remove `aria-pressed`, use `aria-checked` only, implement roving `tabindex` (selected = 0, others = -1), and bind ArrowUp/ArrowDown/ArrowLeft/ArrowRight to move selection. Either way, do the same on the refund pair (also using `aria-pressed` without a group role — pick one model).

### B2. Flight cards declared as `listbox`/`option` but nested under `<li>`

- **WCAG:** 4.1.2 Name, Role, Value (A); 1.3.1 Info and Relationships (A).
- **Where:** `#screen-3 ul.flights[role="listbox"]` containing `<li>` containing `<button role="option" aria-pressed="false">`.
- **Failure:** The `listbox` → `option` parent-child relationship is broken by the `<li>` wrapper; some screen readers will not recognize the options as belonging to the listbox at all, and `aria-pressed` is not a valid state for `option` (it uses `aria-selected`). The list is also not navigable with arrow keys, and "Confirm flight choice" lives in a separate CTA below — there is no model by which a screen-reader user knows they need to activate one of these cards *first*.
- **User impact:** A screen-reader user hears three pressable buttons that "look like" flights, presses the first one, hears no confirmation that a selection happened (the visual border change has no SR equivalent), then hits "Confirm" — and cannot tell whether they confirmed anything.
- **Minimum fix:** Drop `role="listbox"` and `role="option"`. These are cards that act like radio buttons. Wrap the three flight `<button>`s in a `<fieldset>` with a `<legend>` ("Available flights to LGA") or a `role="radiogroup"` with `aria-label`, use `aria-checked` on each `<button role="radio">` with the same roving-tabindex model as B1, and announce the selection via the button's accessible name (e.g., "Flight at 7:10 AM, arrives 3:48 PM, one stop, earliest arrival, no fare difference"). Keep the `<ul>`/`<li>` if you want list semantics, but remove `role="listbox"` — they conflict.

## Should-fix

### S1. Missing `<main>` landmark and no semantic header/footer

- **WCAG:** 1.3.1 Info and Relationships (A); 2.4.1 Bypass Blocks (A) is satisfied by the `<nav>`, but landmark navigation in a screen reader currently surfaces only "Screen anchors" and five "complementary" regions, with no main content region.
- **Fix:** Wrap the five `<section class="screen">` elements in `<main>`. Optional: move the audit nav out of the `<main>` and add a skip link.

### S2. `--ink-3` (#6b766f) on `--bg` (#f6f5f1) used for functional body text

- **WCAG:** 1.4.3 Contrast (Minimum) (AA) — needs 4.5:1 for normal text.
- **Where:** `.context__meta`, `.meta`, `.support-row__placeholder`, `.step__when`, `.flight__route`, `.refund-card__sub`, `.agent__label span`, `.path--standby .path__sub`.
- **Measured:** ~3.9:1 — fails for text under 18px / non-bold. Some of this is genuinely meta (the dotted screen tag at 12px is decoration), but `.flight__route` "DEN → ORD → LGA" is functional information at 12px, and `.path--standby .path__sub` carries the consequence copy "No confirmed seat. You wait at the airport…" — that copy must not be the lowest-contrast text on the page.
- **Fix:** Either darken `--ink-3` to ~#5a655e (≈4.7:1) for any text use, or split tokens: keep `--ink-3` for decorative meta and introduce `--ink-2b` (~#52605a) for functional small text. Pay particular attention to Standby — its non-equivalence cannot be coded as "harder to read."

### S3. Stepper announcement does not include the label

- **WCAG:** 4.1.3 Status Messages (AA); 1.3.1 (A).
- **Where:** `#screen-2 .stepper .stepper__value[aria-live="polite"]`. The value-only update announces "3" with no context.
- **Fix:** Either change `aria-live` target to include a label ("Party size: 3 travelers") or set `aria-label`/`aria-valuetext` on the stepper container and use a proper `role="spinbutton"` with `aria-valuemin`, `aria-valuemax`, `aria-valuenow`. Also: the +/− buttons are 36×36, which passes WCAG 2.5.8 (24×24 AA) but not 2.5.5 (44×44 AAA) — at 11 p.m. on a phone, raise them to 44×44.

### S4. Broken in-page anchors break focus and orientation

- **WCAG:** 2.4.3 Focus Order (A); 3.2.3 Consistent Navigation (AA).
- **Where:** `href="#flight-detail"`, `href="#agent"`, `href="#explain"` — none of those IDs exist.
- **Fix:** For a prototype this is acceptable as a scaffolding placeholder, but the `<a>` should either be a real anchor or become a `<button type="button">` so the role matches behavior (link implies navigation; these go nowhere). Pick one and be consistent.

### S5. Chip toggles announce as buttons, not as selected filters

- **WCAG:** 4.1.2 (A).
- **Where:** `#screen-3 .chips[role="group"]` filter chips with `aria-pressed`. This is technically correct for toggle buttons, but the group lacks a programmatic relationship between the filter name and the state — a screen reader hears "Earliest arrival, toggle button, pressed" which is correct but not great. A `role="group"` is fine; consider `aria-describedby` on the group explaining "Filters apply to the flight list below" so a SR user understands the relationship.
- **Fix:** Add an instruction line associated with the group, or label it more specifically: `aria-label="Flight filters, multiple allowed"`.

### S6. Confirmation summary `<dl>` mixes status badges and values inside a single `<dd>`

- **WCAG:** 1.3.1 (A).
- **Where:** `#screen-5 .summary__section` "Support secured" rows. The `<dd>` for Meals contains only a "Pending agent" badge with no readable label of what's pending beyond the `<dt>`. A screen reader will announce "Meals — Pending agent" which is fine; but for Bags the badge is also "Pending agent" with no detail. The user gets less information than the sighted user (who at least sees the badge color and shape).
- **Fix:** Add a hidden or visible short clarification: "Pending agent confirmation" with one-sentence context per row. Don't let the badge be the only signal in the summary view.

## Considered but acceptable

- **Multiple `<h1>` elements (one per `<section>`).** Each section is labelled by `aria-labelledby` pointing at its h1; this is the HTML5 sectioning-with-aria-labelledby pattern and is acceptable. I'd prefer one page-level h1 with h2 per screen, but the prototype is presenting all five screens stacked for audit, so each is effectively its own document region. Not a blocker.
- **Status pip color (amber, not red).** The visual designer's reasoning holds. "Flight canceled" is conveyed by the text "Flight canceled" next to the pip, not by the pip alone, so 1.4.1 Use of Color is satisfied.
- **`--warn` (#8a5a1a) on `--warn-soft` (#f4ead5)** for "Check with agent" badge: ~4.8:1, passes 1.4.3 for normal text. `--ok` (#2f6a4a) on `--ok-soft` (#e3ede5): ~4.6:1, passes.
- **Focus ring `--focus` (#2563eb) on `--bg` (#f6f5f1):** ~4.3:1 against background, well over the 3:1 non-text floor (1.4.11). Visible against every surface in the prototype.
- **Audit nav with `<nav aria-label="Screen anchors">`** — labeled landmark, fine. The horizontal scroll is hidden visually but keyboard tab-reaches every anchor.
- **`prefers-reduced-motion`** disables all CSS transitions globally. No autoplay, no animation triggers. Passes 2.3.3 / 2.2.2.
- **Persistent agent affordance** is a real link in document order on every screen, present in tab order, with min-height 44px on the CTA. Good pattern; no notes.
- **Standby's reduced visual weight** is a design-honesty choice, not a contrast failure — the *type* on standby (`--ink-2` then `--ink-3`) needs the S2 fix, but the structural subordination is correct.

## Handoff to Visual Designer

Blocker fixes only, ready for the revision pass:

- **B1 (path radiogroup):** Either drop `role="radio"`/`role="radiogroup"` and present the three paths as `aria-pressed` toggle buttons inside a `<fieldset><legend>How do you want to recover?</legend>` — or commit to the radio pattern: remove `aria-pressed`, keep `aria-checked` only, add roving `tabindex` and arrow-key handling. Coordinate with interaction-designer for the keyboard model; my recommendation is the fieldset+toggle path since the three paths already render as cards, not as a tight radio cluster.
- **B2 (flight listbox):** Remove `role="listbox"` from the `<ul>` and `role="option"` / `aria-pressed` from the three flight `<button>`s. Wrap the flights in a `<fieldset>` with `<legend>` "Choose a flight to LGA" (visually hidden if needed) and treat each `<button>` as a `role="radio"` with `aria-checked`, same roving-tabindex model as B1. The visual treatment doesn't need to change; only the semantics and keyboard handler do.
