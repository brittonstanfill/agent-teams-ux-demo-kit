# Visual / UI Designer — Northstar Canceled-Flight Recovery

**Role:** Visual / UI Designer
**Scope:** Layout direction, hierarchy, components, visual system — mobile-first, ≤5 screens.
**Inputs used:** Brief; inbound from interaction-designer (state matrix); accessibility-specialist (contrast, target, motion, focus). No invented brand assets.

---

## Top 3 Findings

1. **The screen is a stress instrument — design for fatigue, not delight.** [recommendation] Hierarchy must be exaggerated, not subtle: one dominant element per screen, generous spacing, large hit targets, no decorative motion. The "Recommended" badge in the current flow is a microscopic visual cue carrying a huge decision weight — that inversion needs to flip.
2. **Status, action, and help must coexist on the same screen without competing.** [recommendation, integrating IA + accessibility] The current flow's separation (status, then options, then a hidden FAQ) is the failure. The redesign needs a layout language that puts *status banner + decision area + persistent help* on every screen with clear z-order.
3. **Visual treatment of "Recommended" / "Best match" is load-bearing.** [observed from brief + accessibility] It is currently the most consequential visual element in the flow and the worst designed. It must be: pair of text + icon + adjacent reason, contrast ≥3:1 non-text and ≥4.5:1 text, never color-only (WCAG 1.4.1 / 1.4.11).

---

## Evidence Labels

- **[Observed from brief]:** 5 screens, "Recommended" badge, tabs, fare-difference pill, "$84" displayed during disruption.
- **[Inferred]:** Current visual system likely uses brand blue for both navigation and a "Recommended" tag — collisions; flight cards likely under 44pt; sticky CTAs likely cover focused elements.
- **[Assumption]:** Northstar has an existing design system; I am not redesigning the system, I am redesigning a high-stakes flow inside it.
- **[Recommendation]:** Big type, exaggerated hierarchy, status color used sparingly, motion off by default, persistent help module visually anchored.

---

## Layout Direction (mobile-first)

### Vertical structure (every screen)

```
┌──────────────────────────────┐
│  System / safe-area          │  always present
├──────────────────────────────┤
│  STATUS BANNER (sticky)      │  S2–S4 only; 1 line
├──────────────────────────────┤
│                              │
│  HEADLINE  ↓                 │  H1; large; high contrast
│                              │
│  PRIMARY CONTENT  ↓          │  one dominant block
│                              │
│  SECONDARY CONTENT  ↓        │  visually subordinate
│                              │
│  PERSISTENT SUPPORT MODULE   │  pinned but not sticky-blocking
│                              │
└──────────────────────────────┘
│  PRIMARY CTA (sticky bottom) │  only on S2, S3
└──────────────────────────────┘
```

### Above the fold (375pt-wide reference device)

- **S1:** headline ("Your 6:15 a.m. flight tomorrow is canceled.") + reason + party scope + primary CTA. The user knows the event without scrolling.
- **S2:** sticky banner + first 2 flight cards. The "best match" card is the first card. Hotel module visible after the first card or sticky in lower third.
- **S3:** "what changes" diff visible without scroll.
- **S4:** success header + first 4 lines of itinerary (flight #, day/time, route, terminal).

### Thumb reach

- Primary CTAs sit in the bottom 1/3, within thumb arc. Secondary actions reachable but not adjacent (avoid mis-taps).
- Persistent "Get help" sits at a known anchor — recommendation: top-right corner *and* a bottom-inline duplicate on long screens (S2). Consistent across screens (WCAG 3.2.6).

---

## Hierarchy Strategy

### Z-order priority (top = most prominent)

1. **Headline** — the event. Largest type.
2. **Primary CTA** — the next action.
3. **Status banner** — present on S2–S4, persistent reminder, small but readable.
4. **Primary content** — flight cards / review diff / itinerary.
5. **Secondary actions** — credit, standby, call.
6. **Persistent help module** — anchored, present, never the focal point.

### Type scale (suggested; adjust to existing system)

| Use | Size (mobile) | Weight | Notes |
|---|---|---|---|
| H1 / event headline | 28–32pt | Semi-bold | ≤2 lines on first-fold |
| H2 / section | 20–22pt | Semi-bold | High contrast |
| Body | 16–17pt | Regular | ≥4.5:1 contrast (1.4.3) |
| Microcopy | 14pt | Regular | Used sparingly; never for critical info |
| Primary CTA label | 17pt | Semi-bold | 44pt min target |
| Badge / tag | 13–14pt | Semi-bold | Always paired with icon + text reason |

> All sizes assume the user can scale up via OS dynamic type without breaking layout (WCAG 1.4.4 / 1.4.10).

### Color strategy

- **Status color used only for state, never for decoration.**
  - Canceled / error: high-contrast red-orange family (≥4.5:1 for text, ≥3:1 for badge against card)
  - Success / confirmed: high-contrast green family
  - Neutral / informational: brand neutral
- **Brand primary** reserved for primary CTAs and links. Not for "Recommended" tag.
- **"Best match" badge** — neutral high-contrast chip (not brand color, not red, not green). Carries text "Best match" + an icon + an adjacent reason line. Never color-only (WCAG 1.4.1).
- **Fare difference** — neutral chip with a "+$84" or "$0" label. Never red (that reads as error). Never green (that reads as success).
- **Hotel module accent** — distinct but quiet; doesn't compete with primary CTA. Treat as a service-tile color, not a state color.

---

## Component Suggestions

### Status banner (S2–S4)

- Sticky to top under safe-area
- Height: 1 line at body size, ~44pt
- Background: state color at low opacity, OR neutral with a state-colored icon
- Text: "Canceled: 6:15 a.m. NS482 tomorrow"
- Tappable to expand for details (optional, low priority)
- Must not cover focused content on scroll (WCAG 2.4.11 — accessibility ask)

### Flight card

- Full-width, ≥88pt tall (room for time, route, stops, cost, reason, all readable)
- Tappable area = entire card; single semantic button (per accessibility 4.1.2)
- Hierarchy within card:
  1. Time (largest)
  2. Stops + route
  3. Arrival + cost
  4. Reason text (especially for "Best match")
- "Best match" indicator: icon + text + reason, not a colored pill alone
- Spacing between cards ≥16pt to avoid mis-taps

### Hotel module

- A card, not an FAQ disclosure
- Visually anchored: position consistent across S2/S3/S4
- Style: service-tile (distinct from flight cards), with a clear "Get hotel help" action
- Never inside a collapsed accordion (per accessibility / IA)

### Persistent support module (cross-cutting)

- **Closed:** a pill or icon-button at a top-right anchor with text label visible ("Get help")
- **Open (slide-up sheet):** focus-trapped, escape closes, returns focus to opener (accessibility pattern)
- **Inside:** form components match the rest of the design system (no bespoke styling)

### Primary CTA

- Full-width sticky bottom on S2 and S3
- ≥48pt tall
- Single dominant element — only one primary CTA per screen
- Must not obscure focused content (WCAG 2.4.11)

### Secondary actions

- Inline links or low-emphasis buttons (e.g., ghost / outline)
- Stacked, ≥44pt tall each
- Spaced from primary CTA (avoid accidental tap)

### Empty / error states

- First-class design treatment, not generic "Oops!" art
- Layout: icon (medium, neutral) + short headline + one short body + one or two recovery actions
- Same structure across all error types — predictability under stress

### Undo countdown

- Visible numeric countdown OR progress bar (not both)
- Calm color (neutral or brand primary), not red
- No animation that pulses or flashes — respect `prefers-reduced-motion`
- Pairs with text: "60s to undo" → "0s" → fades to "Undo window closed"

### Skeleton loaders (loading states)

- Used instead of spinners alone (per interaction-designer ask)
- Match the shape of the content that will arrive
- No motion shimmer when `prefers-reduced-motion` is on — fade-in only

---

## Visual System Notes

### Spacing

- Base unit: 4pt. Common multiples: 8, 12, 16, 24, 32.
- **Generous vertical rhythm.** At 10:46 p.m., dense layout fails. Aim for 24pt between major blocks.
- Card padding ≥16pt. Touch padding ≥12pt around tappable text.

### Iconography

- One icon family across the flow (lineweight + corner radius consistent).
- Icons paired with text labels for all critical actions (per WCAG 1.4.1 — accessibility ask).
- Status icons (canceled / confirmed / pending) recognizable at small sizes; rely on shape, not just color.

### Motion

- **Default to reduced motion.** Respect `prefers-reduced-motion: reduce`.
- Allowed motion: fade-in for skeleton loaders; slide-up for the support sheet (can be disabled).
- Forbidden: confetti or celebration animation on confirm; pulsing countdowns; auto-advancing carousels of any kind.
- (Accessibility specifically called this out: distress + vestibular triggers do not mix.)

### Focus indicators

- 2px+ outline, ≥3:1 contrast against both the focused element and adjacent background (WCAG 1.4.11 / 2.4.7)
- Visible on keyboard + voice-control focus, not just hover
- Same shape across components for predictability

### Reflow + zoom

- All layouts function at 320 CSS px wide (WCAG 1.4.10) and 200% zoom without 2-D scroll (WCAG 1.4.4)
- Flight cards reflow vertically; no fixed heights on text containers (per accessibility — large-text scenario)

### Dark mode

- Treat as first-class. Status colors retuned for dark backgrounds (red-orange on dark needs different tone to maintain contrast).

---

## Visual Treatment per State (working table)

| Screen | State | Visual notes |
|---|---|---|
| 1 | Default | Big H1, generous spacing, primary CTA in brand color |
| 1 | Loading | Skeleton lines for headline / body |
| 1 | Auth error | Inline banner above CTAs; banner color = error |
| 2 | Default | Sticky banner, first card = best match (visually highlighted with neutral chip + reason text), hotel module after first card |
| 2 | Loading | Banner present, 3 skeleton flight cards |
| 2 | Empty | Centered empty state, two recovery CTAs |
| 2 | Partial | Real cards on top, skeleton at bottom |
| 2 | Filter applied | Filter chip visible (e.g., "Nonstop only ✕") above list |
| 2 | Error (inventory call) | Inline banner above list with retry |
| 3 | Default | Diff layout (Old → New), strong rule between old and new |
| 3 | Hold loading | Inline "Holding seat" with skeleton; calm tone |
| 3 | Hold lost | Error state with one-tap "See similar flights" |
| 3 | Payment error | Inline above CTAs, focus moves to error |
| 4 | Default | Success header, itinerary block, hotel block, undo countdown anchored near save-actions |
| 4 | Undo fired | Restored-state header, "Try again" CTA, calm color |
| 4 | Undo expired | Countdown disappears; "Undo window closed" text remains for a beat then fades |
| 4 | SMS/email confirmed | Inline checkmark next to "Text me this info" |
| support | Closed | Pill at known anchor |
| support | Open | Slide-up sheet, focus trapped, opaque scrim |
| support | Submitting | CTA disabled; inline progress; no spinner alone |
| support | Submitted | Inline success in sheet; close returns focus |

---

## Hierarchy Stress-Test (the "tired user" test)

For each screen I ask: *if a tired user reads only the largest element, do they know what to do?*

- **S1:** "Your 6:15 a.m. flight tomorrow is canceled." → Yes.
- **S2:** "Available flights tomorrow — pick one." → Yes.
- **S3:** "Review your changes." → Yes.
- **S4:** "You're rebooked." → Yes.

For each screen I ask: *if they don't scroll, do they have a path forward?* — Yes on all four.

---

## Handoffs Sent

### → accessibility-specialist (before finalizing)

**Subject: Visual direction — please flag any blockers**

Three specific checks:

1. **"Best match" chip:** neutral high-contrast chip + icon + adjacent reason line. Color-blind safe? Contrast ≥3:1 non-text and ≥4.5:1 text against background? Will I confuse anyone by *not* using brand color here?
2. **Status colors:** error red-orange family on light + dark backgrounds. Need your sign-off that these will hit ≥4.5:1 for text and ≥3:1 for non-text in both modes.
3. **Undo countdown:** numeric, calm color (not red), no pulsing. Is once-on / once-off announcement enough, or do I need a halfway marker? My instinct is no, per your "announcement fatigue" note.

Also: any visual treatment I've not thought of that the screen-reader / switch-control / voice-control flows need? I tried to design around your requirements but you'll see things I won't.

---

## Handoffs Received

| Sender | Message | What changed |
|---|---|---|
| interaction-designer | State matrix per screen; persistent support as a sheet pattern; skeleton loaders, not spinners; status banner survives scroll without obscuring focus; "Best match" must be text+icon+reason. | Built the visual-treatment table around their state matrix. Replaced spinner concept with skeletons. Anchored the status banner with the 2.4.11 rule. Designed "Best match" as the explicit neutral-chip + reason pattern. |
| accessibility-specialist | Contrast minimums, focus indicators, 44pt targets, never color-only, reduce-motion default, reflow at 320px / 200% zoom, sticky-bottom CTA cannot obscure focused content. | Adopted directly as the visual-system rules (above). Re-tuned "Best match" away from color-only. Made motion opt-in via system preference. |

---

## To Team Lead (status)

**Top 3 findings:** exaggerated hierarchy for fatigue; status + decision + help on every screen; "Best match" needs text+icon+reason treatment.

**One tension:** I'd like to use a small brand moment on the confirmation screen (a subtle visual flourish on success), and accessibility-specialist's "no celebration animation" rule reads as a no. I think there's a static visual moment that's *not* motion that we can use; will negotiate. Otherwise direction is clean.

**Messaged:** accessibility-specialist.
