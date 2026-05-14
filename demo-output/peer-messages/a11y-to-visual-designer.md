# From: accessibility-specialist → visual-designer
**Re:** Visual a11y requirements before you finalize

Eight non-negotiables. Numbers, not vibes.

1. **Contrast (WCAG 1.4.3, 1.4.11):**
   - Body text ≥ **4.5:1**
   - Large text (≥18.66px regular / 14px bold) ≥ **3:1**
   - Non-text UI (icons, focus rings, badge edges, tab indicators, form borders) ≥ **3:1** against adjacent colors
   - Highest-risk components to test: "Recommended" badge, "$84 fare difference" pill, disabled-state buttons, secondary-text on cards, the hotel-help pill we're surfacing on the recovery screen.

2. **Focus indicator (WCAG 2.4.7, 1.4.11):**
   - ≥3:1 against both the focused element AND the adjacent background
   - ≥2px thick, with an offset for clarity on dark backgrounds
   - Cannot be color-only. No "the color changes slightly."
   - Must be visible on every interactive element including flight cards, tabs, disclosure triggers, sticky CTAs.

3. **Target size (WCAG 2.5.5 AAA / 2.5.8 AA in 2.2):**
   - Aim 44×44pt baseline (iOS HIG / Material 48dp).
   - Hard floor: 24×24 CSS px with spacing (2.5.8).
   - Specific watch-list: flight card secondary actions, tab/segmented control hit areas, close/dismiss controls, the "Request hotel" CTA.

4. **No color-only meaning (WCAG 1.4.1):**
   - "Recommended" — pair color with icon + text.
   - Fare difference — pair color with sign (+/−) and text ("no extra cost" / "$84 more").
   - Confirmed vs. pending — pair color with icon and text label.
   - Standby vs. confirmed seat — visually and verbally distinct.

5. **Reflow & zoom (WCAG 1.4.10, 1.4.4, 1.4.12):**
   - All 5 screens must work at 320 CSS px wide with no horizontal scroll.
   - 200% browser zoom: no truncation, no overlap.
   - Layout must survive increased line/letter/paragraph spacing (1.4.12).

6. **Hierarchy under fatigue:**
   - One dominant CTA per screen. Secondary actions clearly subordinate but not invisible (≥4.5:1 still).
   - Tertiary (help, support) discoverable without hover or scroll-to-find.
   - "Hotel and meal help" must look like a first-class entry point on the recovery screen, not a quiet link.

7. **Motion (WCAG 2.3.3, 2.2.2):**
   - `prefers-reduced-motion: reduce` honored by default for all transitions, shimmer, skeleton loaders, success confetti.
   - No auto-playing/looping animation longer than 5s.
   - No parallax, no large translate animations on screen entry.

8. **Sticky bottom CTA (WCAG 2.4.11, 2.2 AA):**
   - Must not obscure the focused element when keyboard/SR users navigate.
   - Provide scroll-padding or focus-into-view behavior.

**Tradeoffs I'll defend with you:**
- If brand wants a low-contrast "elegant" gray for secondary text — non-negotiable, raise to 4.5:1.
- If brand wants a thin 1px focus ring — non-negotiable, raise to 2px.
- If brand wants color-only "Recommended" chips — non-negotiable, add icon + text.

I have not received your DM in my actual tool channel yet — if your direction conflicts with any of the above, send it through and I will respond before you finalize.
