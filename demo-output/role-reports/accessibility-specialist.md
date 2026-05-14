# Accessibility Specialist — Audit Report

## 1. Audit summary

Conditional pass. The prototype's structural bones are strong — semantic landmarks, real `<button>` elements for the Accept/Decline pair, visible underlines on links, 44px row-action targets, `prefers-reduced-motion` respected, no icon-only meaning. Six blockers must change before ship, all surgical. Five recommended improvements are cheap to roll into the same pass.

## 2. Blockers (must change before ship)

1. **Focus ring fails 3:1 against the primary button surface.**
   Location: `.btn-primary:focus-visible` on Screens 1 ("Find me another flight") and 3 ("Confirm rebooking and support"). Focus token `#7FB3FF` against accent `#E8ECEF` measures ~1.7:1.
   WCAG: 1.4.11 Non-text Contrast (AA), 2.4.11 Focus Not Obscured / 2.4.13 Focus Appearance (2.2).
   Fix: add a 2px dark inner ring on `.btn-primary:focus-visible` (e.g., `outline-offset: 2px; box-shadow: 0 0 0 2px var(--ink-inverse) inset, 0 0 0 4px var(--focus);`) so the ring has 3:1 against both the near-white fill and the dark canvas.

2. **Two `<h1>` elements per viewport; no document-level heading order.**
   Location: every viewport (`h1.event` inside each `main`) plus the stage `<h1>Trip recovery — mobile prototype</h1>`. Screen 0 also nests a `.vh` `<h1>` inside the bubble.
   WCAG: 1.3.1 Info and Relationships (A), 2.4.6 Headings and Labels (AA).
   Fix: demote stage and SMS-bubble headings to `<h2>`, or demote each screen's `h1.event` to `<h2>` and keep the stage `<h1>` as the page title. One `<h1>` per page; AT users currently hear five competing "Heading level 1".

3. **Primary action buttons are anchors, not buttons.**
   Location: `.btn`/`.btn-primary` used as `<a href="#…">` on Screens 1 and 3 ("Find me another flight", "I'm not traveling — refund or credit", "Confirm rebooking and support", "Back to flight list").
   WCAG: 4.1.2 Name, Role, Value (A); 2.1.1 Keyboard (A) — Space does not activate links.
   Fix: change to `<button type="button">` (or keep the anchor and add `role="button"` plus a Space keydown handler — but the element swap is shorter).

4. **`role="group"` wrapping Accept/Decline is not a state-machine; toggles default to true and have no live announcement.**
   Location: Screen 3 each `.support-item .controls` (Hotel, Meal credit, Ride). Both buttons default `aria-pressed="true"`, which announces "Accept, pressed. Decline, pressed."
   WCAG: 4.1.2 Name, Role, Value (A); 3.2.4 Consistent Identification (AA).
   Fix: convert to `role="radiogroup"` with two `role="radio"` buttons (or native `<input type="radio">` with a fieldset/legend naming the item), exactly one selected. Add `aria-describedby` on the group pointing to a one-line status (e.g., "Accepted — included in your receipt"). This resolves the SR narration gap the Visual Designer flagged.

5. **Standby flag is color-only differentiation from the held-seat flag.**
   Location: Screen 2 `.flight .flag` (`#F4` "Standby — not a confirmed seat") vs `.flag.held-flag` (`#F1` "Your seat is held here"). Both are pill-bordered text; the only differences are border/ink hue (warm-ink vs ink-1).
   WCAG: 1.4.1 Use of Color (A).
   Fix: prefix the standby flag text with the word "Standby" already present — good — but also give it a distinct shape (e.g., dashed border, or a leading "!" textual prefix), so colorblind/low-vision users see a non-color difference at a glance.

6. **Filter `<fieldset>` has no programmatic group name; `<legend>` "Filter" is generic and label-for/id pairs are split.**
   Location: Screen 2 `.filters` — legend says "Filter", but the fieldset wraps three unrelated controls with mixed inline labels. The number input `#party-size` has no `aria-describedby` for min/max constraints.
   WCAG: 1.3.1 Info and Relationships (A), 3.3.2 Labels or Instructions (A).
   Fix: rename legend to "Filter flights"; add `aria-describedby="party-size-hint"` on the number input with a visible hint "1–9 travelers".

## 3. Recommended improvements

- Add a visually hidden skip-link `<a href="#screen-1">Skip to trip status</a>` as the first focusable element; the stage `<nav>` helps but a top skip link is faster for SR users (2.4.1 Bypass Blocks).
- The "i" inside `.support-link .icon` is a literal character with `aria-hidden`; fine, but the circle border at `#C8CCD1` on `#0C0E10` is a decorative non-text element — leave aria-hidden as is, just confirm it never carries meaning on its own.
- Status bar mock times/percentages: already `aria-hidden="true"`. Good — keep.
- Screen 0 hidden `<h1>` "Text message from Northstar Air" is fine for labeling the bubble, but consider `aria-label` on the `<main>` instead so heading count drops.
- Native iOS `<select>` in dark mode renders the picker against system chrome — visually acceptable but the `option` text inherits OS colors. No CSS fix; document as known OS-controlled behavior. (No blocker.)
- Tap-target spacing between `.row-action` Accept and Decline is `var(--s-2)` = 8px — meets 2.5.8 (AA target spacing) at exactly the floor; bump to `var(--s-3)` = 12px for safer thumb separation.

## 4. What I verified passes

- ink-1 `#F4F5F6` on bg-1 `#0C0E10`: ~16.5:1 (1.4.3 AAA).
- ink-2 `#C8CCD1` on bg-1: ~9.8:1 (AAA).
- ink-3 `#8B9197` on bg-1: ~5.9:1 — passes 1.4.3 AA for normal text and meta use.
- warn-ink `#F1D8A8` on bg-1: ~12:1 — passes AAA.
- All form fields have `<label for=…>` bindings, not placeholder-only (3.3.2).
- Real `<button type="button">` for flight rows and Accept/Decline (4.1.2).
- `prefers-reduced-motion: reduce` zeroes transitions and animations (2.3.3).
- `inputmode="numeric"` on party-size input — appropriate mobile keyboard.
- Underlined links with `text-underline-offset` — link affordance is not color-only (1.4.1).
- No keyboard traps; tab order follows DOM order top-to-bottom across screens.
- 44×44 minimum on `.row-action`, `.support-link`, form fields; primary `.btn` is 56px min — exceeds 2.5.5 (AAA) and 2.5.8 (AA).
- Status block on Screen 1 communicates eligibility in plain text only — no iconography conveying meaning.

## 5. Handoff to Visual Designer

- **HTML changes required**: blockers 2 (heading demotion), 3 (anchor → button on `.btn`/`.btn-primary`), 4 (radiogroup on Accept/Decline), 6 (legend rename + describedby). Blocker 5 needs the standby flag class to add a dashed-border style.
- **Token-level fix only**: blocker 1 — extend `.btn-primary:focus-visible` to layer a dark inner ring; no structural change. Recommended spacing bump (Accept/Decline gap from `--s-2` to `--s-3`) is a single CSS edit.
- **SR narration of Accept/Decline**: convert to a radiogroup with two radios per support item. Group label = the item name ("Hotel for tonight"). Selected radio announces as "Accept, selected, 1 of 2". On selection change, an `aria-live="polite"` status node under the group reads "Hotel accepted" or "Hotel declined". This replaces the current dual-pressed `aria-pressed="true"` state, which currently narrates as both options being on simultaneously.
