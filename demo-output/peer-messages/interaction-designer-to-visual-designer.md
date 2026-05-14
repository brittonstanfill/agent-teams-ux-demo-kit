# From: interaction-designer → visual-designer
**Re:** State list for visual treatment

Full state tables are in `/demo-output/role-reports/interaction-designer.md` §"States Per Screen". Summary and what I need from you:

## What you'll need to treat

Four screens + a persistent support module. Every screen has at least: default, loading, partial, empty, error, success, undo. **Empty / error / loading are not edge cases — they are first-class.** A screen without an empty/error treatment is not done.

| Surface | Distinct visual states needed |
|---|---|
| Screen 1 — Status & Path | default, loading (passive auth), partial, error (auth fail) |
| Screen 2 — Choose a Flight | default, loading, partial, empty (no flights), filter applied, error (inventory failed), success (transition) |
| Screen 3 — Review & Confirm | default, loading (holding seat), partial (hotel pending), error × 3 (hold lost / payment declined / network), success (transition) |
| Screen 4 — Confirmed | default, loading (finalizing), partial (hotel pending), undo active, undo fired, undo expired, success (delivery), error (outbound fail) |
| Support module (sheet) | closed, opening, loading, partial, empty (no entitlement), submitting, success, error, closed (return), undo |

## Specific asks

1. **Skeleton loaders, not spinners alone.** Reduces perceived latency at midnight on cellular. Skeleton shape should hint at content shape (flight card vs review block).
2. **Sticky banner on Screen 2 must not obscure the focused element.** WCAG 2.4.11 — focused control cannot be hidden by sticky elements. I need a treatment that survives scroll without trapping focus underneath.
3. **Undo countdown styling — non-panic.** No red, no pulsing, no large flashing numerals. The undo window is a **safety net**, not an emergency. Reduce-motion users should see a static "60s remaining" indicator that updates without animation.
4. **Empty and error states need first-class visual treatment.** No generic "Oops!" art. Each empty/error has a named recovery action; the visual should support reading the recovery, not the loss.
5. **"Best match" badge: text + icon + adjacent reason.** Never color-only. The reason ("nonstop, similar arrival time") sits next to the badge so a colorblind or low-vision user gets the same information.
6. **Hotel module placement.** Your call between mid-list and sticky on Screen 2, but it must be (a) visible in the first scroll, (b) at a *consistent position* on every screen it appears on, (c) reachable via tab in a sensible order.
7. **Persistent support pill.** Same position on every screen, every state. (WCAG 3.2.6 Consistent Help — flagged by accessibility-specialist.)
8. **Reduce-motion default for the slide-up sheet** and any transitional animation. Sheet still works without motion; just no slide.

## What I haven't decided (your call)

- Card density / typography hierarchy on the flight list.
- Color tokens for the four error severities (info / warning / blocker / fatal).
- Whether the undo countdown is a ring, a bar, or a numeral.
- Visual treatment of the "Sent to your phone and email" delivery confirmation.

## Tension to flag with you

The most common visual-driven mistake is "we'll style empties later." I'm naming five empty/error states above and asking that they be designed with the same care as the default. If we ship default-only, we ship the same flow we're trying to fix — the original "Trip updated / Done" screen is a default-only shipping decision.

— interaction-designer
