# Visual / UI Designer — Northstar Canceled-Flight Recovery

**Role:** Visual / UI Designer
**Scope:** Surface — layout, hierarchy, type, color, spacing, components, motion. Mobile-first. ≤5 screens.
**Inputs integrated:** Brief; interaction-designer state matrix; accessibility-specialist contrast/target/motion/focus requirements.
**Stance:** Polish is structural, not a final pass. Every visual call below names a principle.

---

## Top 3 Findings

1. **This is a stress instrument, not a marketing surface — exaggerate hierarchy, kill decoration.**
   At 10:46 p.m. a tired user has roughly one fixation per screen before they give up and call. The design must spend its visual budget on *the next decision*, not the brand. Principle: **hierarchy under fatigue** — one dominant element per screen, second-most clearly subordinate, everything else quiet. The current "Continue" / "Done" surface inverts this: the most important things (what happened, what you can do, what you're entitled to) are the smallest or hidden.

2. **The current visual system fails on the load-bearing element: the "Recommended" badge.**
   The single most consequential visual signal in the flow is also the worst-designed: a colored chip, likely brand-toned, with no reason text, no icon, and almost certainly failing WCAG 1.4.1 (color-only meaning) and 1.4.11 (non-text contrast). Replace with **"Best match" = text + icon + reason line**, on a neutral high-contrast chip — *never* brand color, *never* red/green (which read as state). Principle: **never color-only**; **semantic color reserved for state**.

3. **Status, decision, and help have to coexist on every screen — and the visual system has to give them non-competing z-order.**
   The current flow separates them (status screen → options → buried FAQ). That separation *is* the failure. The redesign needs a layout language with three persistent zones — **status banner (top), decision area (middle), help anchor (always reachable)** — each at a deliberately different visual weight. Principle: **gestalt grouping + consistent identification (WCAG 3.2.6)**.

---

## Evidence Labels

- **[Observed from brief]:** 5 screens, "Recommended" badge, tab UI defaulting to Travel Credit, "$84 fare difference" pill during disruption, hotel/meal inside a collapsed FAQ, "Trip updated" outcome with no facts.
- **[Inferred]:** Brand primary likely overloaded (nav + CTA + "Recommended" all in the same hue → collision); flight cards likely under 44pt tall; sticky CTAs likely obscure focused content; no dedicated dark-mode tuning of status colors.
- **[Assumption]:** Northstar has a usable design system; I am scoping a high-stakes flow inside it, not redrawing the system. Where the system is silent (e.g., disruption-state colors, undo countdown), I'm proposing tokens it should adopt.
- **[Recommendation]:** Exaggerated type scale, semantic color discipline, persistent help module, reduce-motion default, first-class empty/error visuals, dark mode treated as a primary surface.

---

## Layout Direction (mobile-first, 375pt reference, thumb-friendly)

### Vertical structure — applies to S2–S4

```
┌────────────────────────────────────┐
│  Safe area / status bar             │   system
├────────────────────────────────────┤
│  STATUS BANNER  (sticky top)        │   1 line, ~44pt, state-tinted
├────────────────────────────────────┤
│                                     │
│  H1 — the question this screen      │   28–32pt, semi-bold
│  answers, in 1–2 lines              │
│                                     │
│  PRIMARY CONTENT BLOCK              │   one dominant block
│  (flight cards / diff / itinerary)  │
│                                     │
│  HELP ANCHOR (in-flow card)         │   visually distinct,
│  "Hotel + meal help"                │   sized like a real CTA
│                                     │
│  SECONDARY ACTIONS                  │   ghost/outline, stacked
│                                     │
├────────────────────────────────────┤
│  PRIMARY CTA  (sticky bottom)       │   ≥48pt, full-width
└────────────────────────────────────┘
```

S1 (status) has no sticky banner — the screen *is* the banner. S4 (confirmed) drops the sticky CTA and uses inline save-actions.

### Above the fold — what must be visible without scrolling

| Screen | Above-fold reads |
|---|---|
| **S1 Status** | H1 event ("Your 6:15 a.m. flight tomorrow is canceled."), reason in plain language, party scope, primary CTA, help anchor |
| **S2 Choose** | Sticky banner, H1, **Best-match flight card in full**, beginning of second card, help anchor pinned to lower third |
| **S3 Review** | Sticky banner, H1 "Review your changes", old→new diff with strong rule, cost line, sticky Confirm CTA |
| **S4 Confirmed** | H1 "You're rebooked", flight, hotel, confirmation code — *before* any accordion |

### Thumb reach

- Primary CTAs anchored to the bottom 1/3 (Fitts + thumb-arc). Single sticky CTA on S2, S3.
- Secondary actions stacked *above* the primary CTA, separated by ≥24pt vertical gap (anti-mistap).
- Help anchor lives in two places by design: an **in-flow card** mid-screen (so it can't be missed under stress) and a **persistent "Get help" pill top-right** (so it survives scroll without taking sticky-CTA real estate). Same position screen-to-screen — WCAG 3.2.6 consistent identification.

---

## Hierarchy Strategy

### Eye-path I'm designing for (S2, the load-bearing screen)

1. **Sticky banner** — "Canceled: 6:15 a.m. NS482 tomorrow." Read first not because it's loudest but because it's the top-most persistent element. Tinted, not screaming.
2. **H1** — "Pick a new flight." Largest type on the screen. Tells the user what this screen is *for*.
3. **Best-match flight card** — visually heaviest card in the list. Heavier weight via elevation + a "Best match" chip + a reason line, not via color alone.
4. **Other flight cards** — same width, same internal grid, lower elevation, no chip.
5. **Help anchor card** — visually distinct (service-tile color, not flight-card chrome) so it doesn't compete with flight selection but reads as first-class.
6. **Secondary actions** ("See standby", "Use travel credit") — ghost buttons, low emphasis, never invisible (≥4.5:1).
7. **Sticky Confirm CTA** at bottom — dominant by position, not by size relative to H1.

### Hierarchy stress-test ("the tired-user test")

For each screen: *if a fatigued user reads only the largest element, do they know what to do?*

- **S1** → "Your 6:15 a.m. flight tomorrow is canceled." → yes.
- **S2** → "Pick a new flight." → yes.
- **S3** → "Review your changes." → yes.
- **S4** → "You're rebooked." → yes.

*If they don't scroll, do they have a path forward?* — yes on all four. This is the bar.

---

## Type Scale (mobile; calibrated to OS Dynamic Type)

| Use | Size | Weight | Line height | Notes |
|---|---|---|---|---|
| H1 / event | 28–32pt | Semi-bold (600) | 1.15 | ≤2 lines on first fold; never truncated |
| H2 / section | 20–22pt | Semi-bold | 1.2 | Confirmation block headings |
| Body | 16–17pt | Regular (400) | 1.4 | ≥4.5:1 contrast (WCAG 1.4.3) |
| Body bold | 16–17pt | Semi-bold | 1.4 | Reserved for in-card emphasis, not decoration |
| Microcopy | 14pt | Regular | 1.4 | Never for critical info; ≥4.5:1 |
| CTA label | 17pt | Semi-bold | 1.0 | Sentence case ("Confirm rebooking", not "CONTINUE") |
| Badge / chip | 13–14pt | Semi-bold | 1.0 | Always paired with icon + adjacent reason |

**Optical sizing:** for H1 at 28–32pt, tighten tracking by –1% to –2% to fix the looseness display sizes get in mobile system fonts. For body at 16–17pt, default tracking — do not tighten. Principle: **optical correction**.

**Dynamic Type contract:** all layouts must reflow vertically at 200% OS text scale. No fixed card heights. No truncation of flight time, route, stops, fare, or reason. (Accessibility ask, adopted as a system rule.)

---

## Color System (semantic, not decorative)

### Token roles

| Role | Use | Constraint |
|---|---|---|
| `brand/primary` | Primary CTAs, links | Never used for state, never for "Recommended" |
| `state/error` | Cancellation banner, error toasts | Red-orange family. Text ≥4.5:1, badge ≥3:1 |
| `state/success` | Confirmation banner, success inline | Green family. Text ≥4.5:1, badge ≥3:1 |
| `state/info` | Neutral status, in-progress | Blue-gray family, distinct from brand primary |
| `state/warning` | Hold-may-be-lost, time-pressure | Amber. Used sparingly; never on the undo countdown |
| `surface/card` | Flight cards, review block | High-contrast text on top; elevation via shadow, not color |
| `surface/help-tile` | Hotel + meal help card | Distinct from flight cards — different chroma, not different intensity |
| `chip/neutral` | "Best match", fare-difference pill | Neutral high-contrast; never brand, never state |

### Specific calls

- **"Best match" chip** — `chip/neutral` background, dark text, paired with a check-shield icon and a reason line ("Best match — fewest stops, arrives by 6 p.m."). Never brand color (collides with CTA), never green (reads as confirmed/success), never red (reads as error). Principle: **semantic color discipline**.
- **Fare difference** — `chip/neutral` with a sign and a word: "+$84 more" / "$0 — no extra cost". Never red, never green. The sign + word does the semantic work; color stays out of it. (Removes the loaded-money signal during disruption recovery — behavioral-adjacent concern, but I own the visual call.)
- **Status banner colors** — light-mode tint at ≥1.5:1 against page background for the *fill*, with text + icon meeting 4.5:1 / 3:1 against the tint. Dark-mode re-tuned (not inverted): error red-orange shifts warmer/brighter to stay ≥4.5:1 on a dark surface.
- **Undo countdown** — uses `state/info` or neutral, never `state/error`. Red on a countdown reads as "you're losing something dangerous"; the actual semantic is "you have a safety net". Principle: **color matches meaning**.

### Dark mode

First-class, not inverted. Status colors are re-tuned tokens (not the same hue at lower lightness). Card surfaces sit slightly elevated from page (≥1.2:1 against background) so cards remain perceptible without relying on heavy shadow. Focus rings switch to a two-tone token (inner light, outer dark) to maintain ≥3:1 against any surface. Per accessibility-specialist's note on surface-adaptive focus tokens.

---

## Spacing & Grid

- **Base unit:** 4pt. Step: 4, 8, 12, 16, 24, 32, 48.
- **Vertical rhythm between major blocks:** 24pt. Tighter (16pt) only inside a card. Looser (32pt) only above a screen-level CTA.
- **Card padding:** 16pt minimum; 20pt on flight cards (the most-read element).
- **Touch padding:** ≥12pt around any tappable text-only target so the hit area clears 44×44pt without the visible target needing to.
- **Grid:** single-column on mobile. No two-column flight cards (breaks at 320px / Dynamic Type).
- Principle: **rhythm**. Ad-hoc spacing values are how systems die — every gap above must resolve to a token.

---

## Component Suggestions

### Status banner (S2–S4, sticky top)

- One line at body size, ~44pt tall including padding.
- State-tinted fill OR neutral fill with a state-colored icon (designer's choice per screen; pick one and stay consistent).
- Content: state icon + state word + facts ("Canceled: 6:15 a.m. NS482 tomorrow").
- Tappable to reveal full disruption details in a bottom sheet (low priority; can ship without).
- Sticky behavior must not obscure focused content — apply `scroll-padding-top` equal to banner height + 8pt. WCAG 2.4.11.

### Flight card

- Full-width, ≥96pt tall to comfortably contain: time / route / stops / arrival / cost / reason.
- **Single tappable surface** — the entire card is one semantic button. No nested interactive controls inside the card (per a11y target-size guidance: easier to make the whole card primary than to police 24×24 sub-hit areas).
- Internal hierarchy:
  1. Departure time + arrival time (largest in-card type, ~20pt)
  2. Stops + route summary
  3. Fare label ("+$84 more" / "$0 — no extra cost")
  4. Reason line (only on "Best match" card)
- Elevation: best match = elevation-2 (deeper shadow), others = elevation-1. Not color difference.
- Spacing: ≥16pt between cards.

### Help anchor card ("Hotel + meal help")

- **A card, not a banner, not an accordion, not a footer link.** This is the entitlement-disclosure fix.
- Sized like a real CTA — primary affordance, ≥56pt tall, with a clear action label.
- Lives in a consistent position across S2/S3/S4 (recommendation: directly below the first/best-match flight card on S2; below the diff on S3; below the itinerary on S4).
- `surface/help-tile` color — distinguishable from flight cards by chroma, not by intensity.
- States: default, focus, pressed, disabled, post-request (shows "Hotel requested — confirmation pending").

### Persistent support pill (cross-cutting)

- Top-right anchor, present on every screen. Text label always visible ("Get help") — icon-only fails recognition under fatigue.
- Opens a **slide-up sheet** (per interaction-designer). Focus-trapped, ESC closes, focus returns to opener.
- Sheet uses the same surface tokens as the rest of the system — no bespoke "support styling" that visually othering the help path.

### Sticky bottom CTA

- Full-width, ≥48pt tall, 16pt horizontal margin from screen edges. (≥44pt hit; visual height ≥48pt for comfort.)
- One per screen. If a "secondary" looks equally weighted, the screen has two primary CTAs — that's a hierarchy bug, not a feature.
- Apply `scroll-padding-bottom` equal to CTA height + 8pt so focused inputs/cards never land underneath. WCAG 2.4.11.

### Diff block (S3 — old → new)

- Two stacked blocks with a strong horizontal rule between (1px on light, 1px lighter-than-text on dark, ≥3:1 against page).
- Old block: muted card surface, strike-through on changed lines.
- New block: standard card surface, semi-bold on changed values.
- Cost line below, neutral chip.
- Principle: **gestalt grouping** — the diff has to read as one comparison, not two unrelated lists.

### Undo countdown (S4)

- Numeric countdown ("Undo · 58s") next to the Undo button.
- Neutral or `state/info` token. Not red. Not pulsing.
- No per-second animation; the digit re-renders. Reduce-motion respected — no shimmer, no progress-arc easing on cubic curves.
- After expiry: countdown disappears; line collapses to "Undo window closed" for ~3s then fades. Single announcement, not per-tick. (Per interaction-designer's announcement model.)

### Skeleton loaders

- Used wherever there's perceivable wait — auth on S1, list load on S2, hold check on S3.
- Shape matches the content that will arrive (card-shaped skeletons for flight cards, two-block skeleton for the diff).
- Default: static neutral fill (no shimmer) when `prefers-reduced-motion: reduce` is set or unknown. Optional very-low-amplitude opacity pulse only when motion is allowed.
- No spinners alone. Spinners give no information about *what* is loading.

### Empty / error states

- First-class. No "Oops!" art, no stock illustrations.
- Layout: neutral icon (medium) + short H2 + one body sentence + one or two named recovery CTAs.
- Same structure across all empty/error variants — predictability under stress.

### Filter chips (S2)

- Collapsed by default. Expanded state shows applied filters as chips ("Nonstop only ✕") above the list.
- Chip dismiss control: ≥24×24pt hit area with spacing; pair the ✕ with screen-reader text.

---

## Visual System Notes

### Iconography

- **One family across the flow.** Same stroke weight (1.5–2px), same corner-radius language, same optical size.
- Critical-action icons always paired with text (WCAG 1.4.1).
- Status icons (canceled / confirmed / pending / warning) distinguishable by **shape**, not just color: ⊘ canceled, ✓ confirmed, ⟳ in-progress, ⚠ warning. Verified color-blind-safe.

### Motion

- **Default to reduced motion.** `prefers-reduced-motion: reduce` is respected and is the *expected* user setting for a stressed midnight flow.
- Permitted: 150–200ms cross-fade on state changes; slide-up (≤250ms, ease-out) on the support sheet *with* a reduce-motion fallback that is an instant appear with focus.
- Forbidden: confetti / celebration on confirm, pulsing countdowns, parallax, auto-advancing carousels, large translate animations on screen entry.
- Principle: **restraint**. Motion is information; if it doesn't carry information, it doesn't belong here.

### Focus indicators

- ≥2px outline, offset 2px from the focused edge, ≥3:1 against both the element and the adjacent background (WCAG 1.4.11, 2.4.7).
- Two-tone token for surface adaptivity (inner light, outer dark) per accessibility-specialist.
- Same shape across components — predictability.
- Never color-only — a slight tint change is not a focus indicator.

### Reflow & zoom

- 320 CSS px width: no horizontal scroll on any screen. (WCAG 1.4.10)
- 200% browser zoom: no truncation, no overlap. (WCAG 1.4.4)
- 200% OS Dynamic Type: cards reflow vertically; no fixed text-container heights.
- Increased letter/line/paragraph spacing (WCAG 1.4.12): layouts hold.

### Dark mode parity

- Re-tuned tokens, not inverted.
- Verified contrast for all state colors in both modes.
- Surface elevation visible without leaning on heavy shadow.
- Focus ring uses adaptive token (light inner / dark outer) so it works on both light cards on light page and dark cards on dark page.

---

## Visual Treatment per State (paired with interaction-designer's state matrix)

| Screen | State | Visual treatment |
|---|---|---|
| S1 | Default | Large H1, generous spacing, primary CTA in brand color, help anchor in-flow |
| S1 | Loading (passive auth) | Skeleton H1 + skeleton body lines; primary CTA disabled with label "Loading…" |
| S1 | Auth error | Inline error banner above CTAs (state/error fill, ≥4.5:1 text), focus moves to banner |
| S2 | Default | Sticky banner, H1, best-match card with chip+reason, other cards, help anchor card mid-list |
| S2 | Loading | Banner present, 3 skeleton flight cards, help anchor visible |
| S2 | Empty | Centered empty layout: icon + H2 + body + two CTAs ("Try next-day flights", "Call support") |
| S2 | Partial | Loaded cards on top, skeleton cards at bottom, label "Checking for more" |
| S2 | Filter applied | Filter chip row above list, list updates, count microcopy |
| S2 | Inventory call error | Inline banner above list with Retry + Call support |
| S3 | Default | Sticky banner, H1, old→new diff with rule, cost line, hotel-bundle row if any, sticky Confirm CTA |
| S3 | Hold loading | Inline "Holding seat" with skeleton diff; calm color, not warning |
| S3 | Hold lost | Error banner top-of-screen, "See similar flights" CTA pre-focused |
| S3 | Payment declined | Inline error in payment area, focus moves to error field, primary CTA disabled until resolved |
| S3 | Network drop | Toast + offline banner; selection preserved indicator |
| S4 | Default | Success H1, itinerary block, hotel block, confirmation code prominent, save-actions inline, undo countdown beside Undo button, help anchor below |
| S4 | Undo fired | Restored-state H1, "Try again" CTA, calm `state/info` color (not error) |
| S4 | Undo expired | Countdown collapses to "Undo window closed" microcopy for ~3s then fades |
| S4 | SMS/email confirmed | Inline ✓ + label next to save action |
| S4 | SMS/email failed | Inline retry CTA + Call support fallback |
| Support | Closed | Pill at top-right, label visible |
| Support | Opening | Slide-up sheet (≤250ms ease-out; instant under reduce-motion) |
| Support | Inside | Form components match system; inline field errors |
| Support | Submitting | CTA disabled with progress label; no spinner alone |
| Support | Submitted | Inline success in sheet, close returns focus to opener |
| Support | Failed | Inline retry + Call support |

---

## Label Claims (what I'm asserting and why)

- **[Recommendation]** Use neutral-chip + icon + reason for "Best match", *not* brand or state color — because brand color collides with the CTA and state color miscommunicates urgency. Principle: semantic color discipline.
- **[Recommendation]** Hotel + meal help is a card-shaped CTA at a consistent position on S2/S3/S4 — because banners are ignored under fatigue and accordions hide entitlements. Principle: hierarchy under fatigue + consistent identification.
- **[Recommendation]** Status banner is sticky on S2–S4 with `scroll-padding` rules so focus is never obscured — because the user needs the event present at every step. Principle: persistent context + WCAG 2.4.11.
- **[Recommendation]** Undo countdown is neutral, numeric, non-animated — because red+pulsing makes a safety net feel like a threat. Principle: color matches meaning.
- **[Recommendation]** All motion respects `prefers-reduced-motion` by default — because this flow's users skew toward stress and vestibular sensitivity is amplified at night. Principle: restraint.
- **[Inferred]** The current "Recommended" badge likely fails WCAG 1.4.1 and 1.4.11; needs the chip+icon+reason replacement regardless.
- **[Assumption]** Northstar's existing design system provides primitive tokens; this flow introduces or formalizes: `state/*`, `chip/neutral`, `surface/help-tile`, `focus/adaptive`, `motion/reduced-default`.
- **[Observed from brief]** "Recommended", "$84 fare difference", and "Done" are the three visual choices most directly responsible for support-call volume. They are the three I'm spending the most words on.

---

## Tensions Flagged

1. **Brand moment on success vs. accessibility "no celebration animation".** I want a static visual moment on S4 — a single high-quality illustrated confirmation mark, not motion — to make the success feel earned. Accessibility-specialist's rule reads as a no-motion rule, not a no-visual rule; I read it as compatible with a still mark. Will confirm in my message to a11y. *Resolution: a static visual is fine; pulsing/confetti is not.*
2. **Inventory hold assumption (from interaction-designer).** My S3 visual treatment assumes seat-hold is possible. If holds aren't supported by the platform, the diff block on S3 needs a "may sell out — confirm quickly" warning chip in `state/warning` color. Easy to add; flagging now so I'm not re-designing later.
3. **Sticky banner + sticky bottom CTA can squeeze the visible content area on small devices.** On 320×568 (iPhone SE-class), banner ~44pt + CTA ~64pt + safe areas eats ~140pt of vertical. The H1 has to share what's left with at least one flight card. I'm willing to drop the sticky banner to a non-sticky position on the smallest devices if it preserves the first card above the fold — preference: keep banner sticky and accept that the second card peeks rather than fully shows. Will validate at design-review.

---

## Handoffs Sent

- **→ accessibility-specialist** — direction summary for review *before* finalizing (contrast tokens, target sizes, motion defaults, focus pattern, "Best match" chip approach, undo countdown color, dark-mode strategy, brand moment on confirm).
- **→ team-lead** — 3 findings + 1 tension + status.

## Handoffs Received

| Sender | Message | What it changed |
|---|---|---|
| interaction-designer | Per-screen state matrix, persistent help as a slide-up sheet, skeletons over spinners, sticky banner must survive scroll without obscuring focus, "Best match" = text+icon+reason, hotel module visually anchored | Built the visual-treatment table 1:1 against the state matrix. Spinners removed in favor of skeletons. `scroll-padding` rules added to banner and bottom CTA. Hotel module promoted from "module" to first-class card at a consistent position. |
| accessibility-specialist | Contrast minima (4.5:1 text, 3:1 non-text), 2px+ focus ring with surface-adaptive token, 44×44 target baseline (24×24 floor), never color-only, reduce-motion default, reflow at 320px / 200% zoom, sticky CTAs cannot obscure focused content, hotel+meal entry point must be a real CTA | Adopted directly as visual-system rules. "Best match" rebuilt away from color-only. Motion gated on `prefers-reduced-motion`. Focus token specified as two-tone adaptive. Hotel anchor reclassified from "module" to CTA-weight card. |

---

## Mood / tone note

The intended feel is **calm, clinical, in-control** — not warm, not playful, not apologetic. The user does not need to be comforted by visual softness; they need to be confidently led. Closer to **Linear's restraint** and **Stripe's clarity** than to a consumer-travel app's vibrancy. Type does the emotional work (size + weight signaling certainty); color stays out of the way except where it carries meaning. If the surface feels a little austere on a calm afternoon, it's calibrated correctly — the test condition is 10:46 p.m.

## Reference points

- **Linear — empty/error states.** First-class layouts, never generic. The "what happened + what to do" pattern with restraint is the model.
- **Stripe Checkout — hierarchy under fatigue.** One dominant action per screen, semantic color used only for state, no decorative motion. The pattern transfers cleanly to recovery.
- **Apple Wallet boarding-pass detail.** Information density done with type weight + spacing, almost no color. The S4 confirmation block should aim here.
