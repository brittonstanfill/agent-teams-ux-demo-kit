# From: visual-designer → team-lead
**Re:** Task #14 — status update

## Top 3 findings

1. **Design for fatigue, not delight.** Exaggerated hierarchy — one dominant element per screen, generous spacing, semantic color discipline, reduced motion as the default. The current flow spends visual budget on brand; the redesign spends it on the next decision.

2. **The "Recommended" badge is the load-bearing element and the worst-designed thing in the current flow.** Replace with **"Best match" = neutral chip + icon + reason line**, never brand color, never state color. This single change is the highest visual-impact-per-unit-of-effort fix in the surface.

3. **Status + decision + help must coexist on every screen with non-competing z-order.** Sticky status banner (top), decision block (middle), help anchor as a card-shaped CTA (consistent position), persistent "Get help" pill (top-right anchor). The hotel/meal entitlement gets promoted from buried FAQ to a first-class CTA-weight card.

## One tension

**Brand moment on the success screen vs. a11y's "no celebration animation" rule.** I want a single static illustrated mark on S4 to make the success feel earned. My read is that the a11y rule is about motion, not visual marks — but I've kicked it to accessibility-specialist for explicit confirmation. If they say no, I'll drop it and rely on type + spacing to do the emotional work. Either way, no confetti, no pulse, no celebration animation.

**Secondary tension worth flagging:** interaction-designer's S3 visual treatment assumes seat-holds are technically possible. If holds aren't supported, S3 needs a `state/warning` chip on the diff ("may sell out — confirm quickly"). Easy fix; depends on engineering confirmation.

## Who I messaged

- **accessibility-specialist** — full direction summary for review *before* I finalize. Specific decisions I asked for pushback on: brand moment on confirm, undo announcement model, neutral-chip pattern for "Best match", focus token shape, sticky-element tension on 320px devices.

## Report

Filed at `demo-output/role-reports/visual-designer.md`. Includes layout direction, hierarchy strategy, type/color/spacing systems, component specs, per-state visual treatment table mapped 1:1 to interaction-designer's state matrix, mood/tone note, and reference points (Linear, Stripe, Apple Wallet).

## Status

Task #14 → in_progress → completed. Reduce-motion is the default; dark mode is first-class; "Best match" is rebuilt around icon + text + reason. Holding pending only on accessibility-specialist's pushback on the three specific decisions above.
