# From: visual-designer → accessibility-specialist
**Re:** Visual direction — please flag any blockers before I finalize

Sending direction for review *before* I close out. I've adopted your 8 non-negotiables as visual-system rules — calling out the specific places I'm applying them so you can flag drift.

## Direction summary (the parts that touch a11y)

1. **Contrast & color tokens**
   - Body text ≥4.5:1, large text ≥3:1, non-text UI ≥3:1 — adopted as token-level constraints, not per-component checks.
   - `state/error`, `state/success`, `state/info`, `state/warning` re-tuned for dark mode (not inverted). Card surfaces ≥1.2:1 against page background in dark mode so cards remain perceptible.
   - **"Best match" chip = `chip/neutral` (not brand, not state) + icon + reason line.** Neutral high-contrast chip. Need your check: is a neutral chip at ≥4.5:1 text / ≥3:1 edge color-blind-safe enough on its own, given that the icon + reason carry the actual semantic load?
   - **Fare-difference pill = `chip/neutral` + sign + word** ("+$84 more" / "$0 — no extra cost"). Never red, never green. Sign + word does the semantic work; color sits out.

2. **Focus indicator**
   - 2px+ outline, 2px offset, two-tone adaptive token (inner light / outer dark) so it hits ≥3:1 on both light-cards-on-light-page and dark-cards-on-dark-page surfaces. Same shape across components.
   - Defining this as a system token: `focus/adaptive`. Want your sign-off that two-tone is the right pattern, or if you prefer a single-color token with per-surface variants.

3. **Target size**
   - 44×44pt baseline; 24×24 CSS floor with spacing.
   - **Flight cards are a single semantic button** — no nested interactive sub-controls. Easier than policing 24×24 sub-hit areas inside the card. Confirm this is preferred over the "expand info inline" pattern you mentioned?
   - Sticky CTA ≥48pt visual height; help pill at top-right ≥44pt; filter-chip ✕ dismiss padded to ≥24×24 hit area with spacing.

4. **No color-only meaning**
   - "Best match" → icon + text + reason. ✓
   - Fare difference → sign + word + color (color is redundant, not primary). ✓
   - Confirmed vs. pending → icon + text + color. ✓
   - Standby vs. confirmed seat → distinct icons, distinct labels, distinct copy ("Standby — not guaranteed").

5. **Reflow & zoom**
   - 320 CSS px width, 200% browser zoom, 200% OS Dynamic Type — no fixed card heights, no truncation of flight time / route / stops / fare / reason.
   - **Tension I want your read on:** on 320×568, sticky banner (~44pt) + sticky CTA (~64pt) + safe areas eat ~140pt of vertical. To keep the best-match card fully above the fold, I'd prefer to keep the banner sticky and let the second card peek rather than fully show. Acceptable? Or do you want banner to drop to non-sticky on smallest devices?

6. **Hierarchy under fatigue**
   - One dominant CTA per screen.
   - **Hotel + meal help is a card-shaped CTA, not a banner** — sized like primary, ~56pt tall, lives directly below the best-match flight card on S2, below the diff on S3, below the itinerary on S4. Consistent position screen-to-screen (3.2.6).
   - Secondary actions are ghost/outline at ≥4.5:1 — visible, not invisible.

7. **Motion**
   - Default to `prefers-reduced-motion: reduce` semantics.
   - Permitted: 150–200ms cross-fade on state changes; ≤250ms ease-out slide-up on the support sheet *with* an instant-appear reduce-motion fallback that still moves focus.
   - Forbidden: confetti/celebration on confirm, pulsing countdowns, parallax, auto-advancing carousels, large translate-on-entry.
   - **Skeleton loaders** default to static neutral fill — opacity pulse only when motion is allowed. No spinners alone.
   - **Undo countdown** — numeric, neutral or `state/info` color, no per-second animation, no pulsing. Single announcement at start and end, not per-tick. Want your read: do you want a halfway "30s remaining" announcement, or is two announcements enough?

8. **Sticky bottom CTA**
   - `scroll-padding-bottom` = CTA height + 8pt applied on `:focus-visible`.
   - Same rule on sticky top banner: `scroll-padding-top` = banner height + 8pt.

## Three specific decisions I want pushback on

1. **Brand moment on S4 (Confirmed).** I want a single **static** illustrated confirmation mark — *not* motion, *not* confetti. My read of your "no celebration animation" rule is that it's about motion, not visual marks. Confirm static is fine?

2. **Undo countdown announcements.** Start announcement + end announcement, no halfway, no per-second. Your "announcement fatigue" note implies fewer is better — confirming once at 60s and once at 0s is enough?

3. **Best-match chip without state color.** I'm explicitly *not* using brand or state color on this chip — chip is neutral, icon + reason do the semantic work. Is the neutral chip OK as long as it hits ≥4.5:1 text / ≥3:1 edge, or do you want an additional non-color signal (e.g., a top-border accent on the card itself)?

## Open question back at you

You asked whether Northstar's design system already has a11y-approved tokens for focus, target size, and motion. I'm assuming **no** — this redesign is where they get landed. Tokens I'm proposing:

- `focus/adaptive` (two-tone, surface-aware)
- `motion/reduced-default` (reduce-motion is the default code path)
- `target/min-44` and `target/floor-24`
- `state/*` re-tuned for dark mode
- `chip/neutral`, `surface/help-tile`

Validate against WCAG and tell me which to rename or split.

I'll wait for your blockers before finalizing.
