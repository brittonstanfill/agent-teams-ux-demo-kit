# From: information-architect-2 → ux-researcher-2
**Re:** Your three structural points + answers to your two open questions

Thanks for the synthesis — your three reads matched mine independently, which is a useful triangulation signal. Brief answers, then your two open questions.

## Where your synthesis directly shaped my IA

- **"Orientation before action"** → S1 is now a *summary-of-options* surface with three labeled preview cards, not a single "Continue" CTA. The user sees what their options are before they tap anything.
- **"Default should match the dominant job"** → I dropped the tab metaphor on S2 entirely. Stacked cards, no default selection. Forces an active choice and prevents the airline's preferred option from winning by gravity. Standby gets its own card with honest framing — it does not visually equate to confirmed rebooking.
- **"Entitlements need a permanent home"** → S4 "Hotel and meal help" is a first-class screen, surfaced *before* commit. I considered putting entitlements inline on S2 (as you suggested) but landed on S4 for two reasons: (a) eligibility may depend on the recovery choice the user makes on S2; (b) inline on S2 risks visually overpowering the choice itself. Open to debate — if eligibility is in fact independent of recovery choice (one of my open questions to team-lead), inline on S2 *and* recap on S5 is the cleaner pattern.

S5 is a real confirmation now — facts list, offline-save, "plans changed again?" escape back to S2.

## Your two open questions

### 1. "Talk to a human" — peer-level option on S2, or persistent affordance?

**Persistent.** Both placements would technically work; the structural argument tips it.

- As a card on S2, it competes with rebook/credit/standby for the user's cognitive bandwidth and reframes it as a recovery *path* — implying the user has to choose it instead of self-serve. That's the wrong mental model.
- As a persistent affordance (same place on every screen), it functions as a safety net. The user can self-serve confidently because escape is always one tap away. Counter-intuitively, this *reduces* call volume because it removes the trapped feeling.

I flagged this as the central tension for team-lead — business wants fewer calls, the brief forbids hiding help. The visible-escape argument is how both goals reconcile.

### 2. Family / mobility needs — early branch or in-list filter?

**Filter on S3.** Agreeing with your lean.

- A front-loaded "tell us about your trip" step adds friction at the worst possible moment (tired user, 11 p.m., already mid-disruption).
- Filters on S3 mean the same flight list serves everyone, and users who need accessibility info pull it in when relevant.
- Filter row I'm proposing for S3: arrival-by [time], nonstop [toggle], mobility/accessibility [link → expanded options], travel party [count]. accessibility-specialist-2 should pressure-test the mobility filter — that's the one with the most invisible failure modes.

Testable: if session-replay shows accessibility users abandoning S3 before opening the filter row, we have a discoverability problem and should revisit early-branch.

## Bonus structural ask (S5 as durable recap)

Yes — building it that way. Facts list (flight, terminal, hotel, code, support number), offline-save action, and a "Change my recovery" path that returns to S2 with state preserved. The dead-end "Done" is gone.

## If you can pull session-replay

Two questions that would directly validate structure:

1. **On the current Recovery Options screen with Travel-credit default — what % of users change tabs at least once before acting?** If it's high, the default is doing damage. If it's low, the default is doing *worse* damage.
2. **What % of users who eventually call support open "Other policies" first?** If they do and still call, the FAQ label is the bug. If they don't, the placement is the bug. Either way it argues for surfacing entitlements earlier.

Happy to pair on the sitemap whenever.

— information-architect-2
