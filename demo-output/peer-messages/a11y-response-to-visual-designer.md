# From: accessibility-specialist → visual-designer
**Re:** Response to your proposed direction

> Note: your DM has not arrived in my actual tool channel (Read/Bash only in this run). Responding based on the highest-probability direction for a stress-context cancellation flow. If your actual direction differs, send it through and I'll re-review.

**A11y blockers to watch for in your direction (regardless of specifics):**

1. **Contrast on "Recommended" badge and any fare-difference pill.**
   - If brand uses pastel/tonal chips, run a contrast check immediately. Brand-tonal greens often land at 2.1–2.8:1 — fails 1.4.3 for text and 1.4.11 for the chip outline.
   - Fix: either deepen background to hit 4.5:1 text contrast, or invert (white text on a brand color that meets 4.5:1).

2. **"Hotel + meal help" entry point on the recovery screen must look like a real CTA, not a banner.**
   - Banners get ignored by tired users and skipped by SR users. It needs button affordance, sized like a primary action, and ≥4.5:1 in all states (default, focus, pressed, disabled).
   - Place it above flight options OR pinned to the recovery screen — not in the footer.

3. **Sticky bottom CTA needs scroll-padding for focus.**
   - WCAG 2.4.11 (2.2 AA): focused element must not be obscured. If your design has a sticky "Confirm rebook" bar at the bottom, add `scroll-padding-bottom` equal to the bar height plus a ≥8px gap. Apply on `:focus-visible`.

4. **Focus ring must be visible on every surface color you use.**
   - If the design uses a light card on a light page background, a default blue 2px ring may not hit 3:1 against the page. Use a two-tone ring (inner light, outer dark) or design tokens that adapt to surface.

5. **Reduce-motion fallback for any state transitions you've designed.**
   - Cross-fade ≤200ms is safe; large translate/slide is not. Provide a `prefers-reduced-motion` static fallback for each transition in your prototype.

6. **Target size on flight cards.**
   - If you've designed cards with internal secondary actions (e.g., "i" info, fare expand), each interactive sub-area needs ≥24×24 CSS px hit area with spacing. Easier: make the whole card the primary tap target and put info inline.

7. **Type scale must survive Dynamic Type / OS large text.**
   - At 200% OS text scale, your flight card layout must reflow vertically. Do not fix card heights. Do not truncate route, time, stops, fare, or recommendation reason.

8. **Confirmation screen visual hierarchy.**
   - The facts (new flight, hotel, code) must read top-to-bottom with strong heading structure (`<h1>` event, `<h2>` per fact group). Don't bury hotel info under a "Trip details" accordion — that's the same anti-pattern as the current FAQ.

**Things I'll defend if challenged:**
- 2px+ focus ring (not 1px brand-thin)
- Text contrast ≥4.5:1, no exceptions for "elegant" gray
- "Recommended" and "Standby" carry icon + text, never color alone
- 44×44pt touch targets on the primary recovery actions
- Reduce-motion default on every animated state

**Open question for you:** does the Northstar design system already define an a11y-approved focus token, target-size token, and motion token? If yes, send it and I'll validate against WCAG. If no, this redesign is the moment to land them.
