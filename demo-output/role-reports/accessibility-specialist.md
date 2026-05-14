# Accessibility Specialist Report: Canceled-Flight Recovery Prototype

Audit target: `demo-output/prototype/index.html`. WCAG 2.2 AA, mobile-first, screen-reader-aware.

## Blockers (must change HTML)

1. **Multiple `<main>` elements per document.** The page uses one outer `<main class="page">` wrapping five inner `<main class="screen">` elements. Only one `<main>` is permitted per page (HTML spec, supports WCAG 1.3.1 Info and Relationships). Screen readers in landmark-navigation mode (VoiceOver rotor, NVDA D-key) will either announce duplicates or skip them inconsistently. **Fix:** Change the outer wrapper to a plain `<div>` (or `<body>`-level layout). Change each inner `<main class="screen">` to `<section aria-labelledby="screen-N-title">` and give each `h1.screen-title` an `id`.

2. **Five `<h1>` elements on a single document.** Each screen has its own `h1.screen-title`; the page itself also has an `h1` ("Canceled flight — recovery flow") in `.page-head`. WCAG 1.3.1 / 2.4.6: heading levels must convey structure, not visual size. As a storyboard rendering five screens stacked in one document, only the page-level title is an `h1`. **Fix:** Demote per-screen `h1.screen-title` to `h2`, demote in-screen `h2`/`h3` correspondingly (status banner `h2` → `h3`, etc.). If the intent is "each `<section>` is a separate document outline," that outline algorithm was never implemented by browsers/AT — do not rely on it.

3. **Screen labels ("Screen 1 — Status & Cause") are `aria-hidden="true"`.** Sighted users see the numbered chip; screen-reader users get no announcement that the next region is "Screen 1 of 5." For a stacked storyboard this is disorienting. WCAG 1.3.1. **Fix:** Either remove `aria-hidden` and let the label announce as a normal heading (preferred — make it the section's `<h2>`), or wire it as the `aria-labelledby` target for the `<section>` so the section is announced "Screen 1 Status and Cause, region."

4. **`role="list"` + `role="listitem"` applied to `<button>` elements (Screen 2 paths) and `<article>` (Screen 3 flights).** Putting `role="listitem"` on a `<button>` overrides the button role in some AT (or is ignored, leaving an ambiguous accessible name). WCAG 4.1.2 Name, Role, Value. The "Recommended for getting there" badge is a sibling `<span>`, so it is part of the accessible name — the path button currently announces as "Rebook on a Northstar flight Recommended for getting there Pick a replacement flight…" — a wall of text with no role separation. **Fix:** Use `<ul role="list">` with `<li>` wrappers each containing the `<button>`. Move the badge text into the button's `aria-describedby` or visually-hidden context, not into the title row. For the default option, add `aria-current="true"` or explicit text "currently recommended."

5. **Token pills (`{confirmation_code}`, `{depart_time}`, `{support_number}`, etc.) are read literally by screen readers.** The H1 on Screen 1 reads as "Your open-brace depart underscore time close-brace flight tomorrow is canceled." The `aria-label="6:15 a.m."` on that one span is a good intent but is overridden in some AT by visible text; nowhere else is it applied. WCAG 1.3.1, 2.4.6, 3.3.2. **Fix:** This is a prototype, so add a visible note at the top of the document — "Tokens render server-side; the live build substitutes values before paint." If shipping any version of this for user testing, swap tokens for plausible literal values. Do not leave `{...}` braces in the accessible name tree.

6. **`role="status"` on the cancellation banner is wrong for the moment.** `role="status"` is a polite live region — fine for "saved" toasts, wrong for the primary headline of a screen the user just arrived on. It risks being announced twice (once as the live region, once when the heading is read) or being announced out of reading order. WCAG 4.1.3. **Fix:** Remove `role="status"`. The banner is static page content; let it announce via its heading.

7. **Filter chips' visible label and accessible name diverge.** Each `<label class="chip">` wraps an `<input type="checkbox">` plus visible text "Nonstop only," but the `<fieldset>` legend is visually hidden and the inputs have no `aria-label`. Most AT will compose the name from the label text — usually OK — but the `:has(input:checked)` styling is the only signal of selected state, and `<input type="checkbox">` inside an unstyled `<label>` may announce as "checkbox, checked, Nonstop only" with no pill-group context. The "Morning" chip is pre-checked but visually identical to others until inspection. WCAG 1.4.1 (use of color), 4.1.2. **Fix:** Keep the `<fieldset>`/`<legend>`. Confirm each input has an explicit `id` and the label `for` it (currently relies on wrap-association — works, but be explicit). Add a visible non-color affordance (e.g., a checkmark glyph that's actually visible on the chip, not just on the dark fill). Today the "check" SVG appears only inside the chip after checked — and on a dark background — fine, but ensure contrast (see below).

8. **"Change sort" is an `<a href="#">` styled as a button with no destination.** A screen-reader user activates it and is sent to the top of the document. WCAG 2.1.1, 4.1.2. **Fix:** Make it a `<button type="button">`. Same issue: "Back to status" on Screen 2 uses `href="#screen-1"` but no element has `id="screen-1"`.

9. **Insufficient contrast on secondary text.** Measured against `#ffffff`:
   - `--ink-500` (`#6b7591`) — used for `.stub-line .label`, `.chip` muted state, `.sort-row` — ratio ~4.0:1. Fails 1.4.3 for body text under 18pt.
   - `--ink-400` (`#9aa3bd`) on white — used for arrow glyphs and `.path-chev` — ratio ~2.6:1. Fails 1.4.11 Non-text contrast (AA 3:1) for the arrow that conveys "to" between airport codes.
   - `--ink-600` (`#4a5470`) on white — ~6.4:1, passes. `--ink-700` (`#2b3447`) on white — ~10.5:1, passes.
   - Confirm hero: `#9aa3bd` on the near-black gradient (`#0b1220` → `#1a2233`) — ratio ~6.2:1, passes for the `<dt>` labels.
   - Status banner: `--signal-600` (`#b42318`) on `--signal-50` (`#fef3f2`) — ~5.4:1, passes for the "FLIGHT CANCELED" eyebrow.
   - `.brand-name` `--ink-800` on white — passes.
   - **Fix:** Replace `--ink-500` body uses with `--ink-600`. Strengthen the arrow color to at least `--ink-600` or pair it with a visually-hidden "to."

10. **Focus ring color is the same blue as the primary button (`#1d4ed8`) and renders directly against that button.** On `.btn-primary:focus-visible`, the focus ring is `2px solid #1d4ed8` with `outline-offset: 2px` — on a `#1d4ed8` button. The 2px offset gives a white halo that helps, but on a small mobile screen with antialiasing the ring effectively disappears against the button color. WCAG 2.4.7, 2.4.11 Focus Not Obscured, 1.4.11 Non-text contrast. **Fix:** Use a focus ring that's not the button color (e.g., `--ink-900` or `2px solid #fff` with a `4px` outer `box-shadow` in `--ink-900` to guarantee 3:1 against any background).

11. **Filter chip target size below 44×44 CSS pixels.** `.chip` declares `min-height: 36px` with `padding: 6px 12px`. WCAG 2.5.8 (Target Size Minimum, 24×24, AA) passes, but the 2.2 AAA recommendation and Apple HIG 44pt baseline both fail — and these chips will be tapped by a tired traveler. **Fix:** Raise to `min-height: 44px` and increase horizontal padding to keep proportions. This is a Blocker for me because the task is mobile-first and the user is stressed.

12. **No skip link, and the document order forces a screen-reader user to traverse all five screens linearly.** WCAG 2.4.1 Bypass Blocks. Even with section landmarks, there's no in-page nav. **Fix:** Add a "Skip to screen…" nav at the top (visually-hidden until focused) with anchors to each `<section>`'s `id`. Even better for a storyboard: a real `<nav aria-label="Storyboard screens">` with links to each screen.

13. **`tel:` link with `aria-label="Call support"` plus visible "Call support" text — accessible name is fine, but the visible token-pill phone number is unread.** `Call <span class="token">{support_number}</span>` in the dock and footer reads "Call open-brace support underscore number close-brace." Same root cause as #5; mentioned here because phone numbers are the highest-stakes content on these screens for a stressed user. **Fix:** Treat the rendered number as plain text, not as a token pill, and verify it announces as digits ("1 800 …").

## Important (should change, lead may waive)

1. **No `aria-current` on the default path card** ("Rebook on a Northstar flight"). Sighted users see the blue border; screen-reader users hear nothing. Add `aria-current="true"` or include "Currently selected default" in the accessible name.

2. **`role="list"` on `.paths` and `.flights` is fine in principle, but with `<button>` children for paths the wrapper should be `<ul>`.** Same fix as Blocker 4.

3. **Phone-frame `<section class="phone" aria-label="Screen N">` produces five "region" landmarks** — useful for navigation, but the labels are duplicative ("Screen 1: Status and Cause" is already the heading). Consider whether the section needs an `aria-label` at all once the H2 inside it is correctly associated.

4. **Reduced-motion handling is universal (`* { transition: none !important }`).** Good practice. But the `box-shadow` pulse on the success dot (`box-shadow: 0 0 0 3px rgba(34,197,94,.18)`) is static — not a motion issue. No vestibular triggers detected. **Preserve this.**

5. **`.path` buttons have no programmatic indication that activating them changes which "primary CTA" appears below.** Currently the CTA "Find a flight" is shown unconditionally — but per IA, "label matches choice." If the CTA changes on selection, that change must be announced (`aria-live="polite"` on the actions region) or the selection must navigate forward immediately.

6. **`<dl>` in confirm hero is correctly used** (term/description pairs) — preserve. But `<dt>Gate</dt><dd>To be assigned</dd>` reads as "Gate to be assigned" with no semantic flag that the value is pending. Consider `<dd>Gate to be assigned <span class="sr-only">(value pending)</span></dd>` or similar.

7. **`<fieldset class="filters">` has both a visible group context (visually it reads as filter chips above a sort row) and a `sr-only` legend.** Adequate. But "Seats for {passenger_count}" chip mixes a filter with a passenger count — confusing under cognitive load. Split into a passenger-count display (not a filter) and an actual filter ("Show only flights with seats for my party").

8. **"Continue without support" button on Screen 4** — under stress, a tired user may tap this thinking it means "continue to the next screen" rather than "decline support I might be entitled to." Cognitive accessibility (WCAG 2.2 has no direct criterion, but related to 3.3.2 Labels or Instructions). Recommend a confirm step or rewording: "Skip — I don't need hotel or meal help."

9. **`.save-row` uses `role="group" aria-label="Save your record"`** — good. But three buttons in a `display: grid` may wrap on 360px viewport; the CSS already accounts for two columns at that breakpoint — confirm focus order remains visual order.

10. **Family / multi-passenger path** is acknowledged via the "Seats for {N}" chip and `{passenger_count}` token. Adequate at the IA level. No per-passenger UI exists — for a screen-reader user traveling with a companion who also uses AT, there's no indication of group split, name list, or "Are these flights for everyone?" confirmation. Note for the next iteration.

11. **No `lang` attribute on token spans that may render in another locale** (e.g., destination city names). Minor; flag for the live build.

## Observations / good practice noticed

- One persistent `Call support` link in the header on every screen, with `min-height: 44px` and a real `tel:` href — preserve.
- `:focus-visible` is used consistently on buttons and links — preserve.
- `prefers-reduced-motion` honored globally — preserve.
- Token pills are styled as visible content (`white-space: normal; word-break: break-word`), not abbreviated or hidden — IA constraint #5 respected.
- Primary buttons are `min-height: 48px` — meets target size for primaries.
- Plain language: "Flight canceled," not "schedule irregularity" — preserve.
- `<dl>` for confirmation key/value pairs is semantically correct — preserve.
- Buttons name the outcome ("See your options," "Find a flight," "Hold this flight," "Done — save a copy") — preserve.
- Refund is a peer of rebook on Screen 2, visually equal weight — preserve.
- Support disclosure is conditional ("You may be eligible"), no invented numbers or brands — preserve.
- Mobile media query down to 360px exists — preserve.

## Confidence note

What I verified by reading the HTML and CSS: landmark structure, heading levels, ARIA role/property usage, `tel:` link semantics, target-size declarations in CSS, focus-ring CSS, `prefers-reduced-motion` rule, color tokens, contrast ratios computed against declared CSS variables, token-pill rendering as visible content.

What I could not verify without a live AT run on real devices: actual announcement order in VoiceOver (iOS) vs. TalkBack vs. NVDA — particularly whether `role="status"` double-announces the banner, whether `role="listitem"` on `<button>` is honored or dropped, whether the `aria-label="6:15 a.m."` override on the H1 token is actually spoken in place of the literal `{depart_time}` brace text, and whether the `<fieldset>` legend (visually hidden, position:absolute clip rect) is grouped consistently across AT. Live testing on at least iOS VoiceOver and TalkBack is required before ship. Contrast ratios were computed analytically from CSS hex values; a real-device test under outdoor lighting and at 200% zoom (WCAG 1.4.4, 1.4.10) is still required.
