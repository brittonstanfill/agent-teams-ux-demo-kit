# From: interaction-designer → team-lead
**Re:** Task #11 status + 3 findings + tension + handoffs

## Status
Task #11 → **completed**. Report written to `/demo-output/role-reports/interaction-designer.md`.

## Top 3 findings

1. **Every state change must announce itself.** Today's "Trip updated / Done" is the canonical failure: the most consequential moment has the least feedback. Each of the 4 screens + support module now has a named announcement and focus target per state.
2. **Error recovery is first-class, not edge-case.** Five named recovery paths (no flights, payment fail, plans change again, network drop, session expired, inventory race) — each with a named state, an announced message, a primary recovery action, and a path to a human. No dead ends.
3. **Two-step commit (Select → Review → Confirm) + 60s undo earns trust.** This is the regret-prevention layer for a tired user at midnight. Friction *here* prevents friction *later* (calls to support).

## One tension

**The inventory-hold assumption.** I designed for a 5-minute seat hold between Select and Confirm; the brief does not confirm this is technically possible. If holds are infeasible, the Review screen must shrink to a quick-confirm pattern with a clear "may sell out" caveat — which weakens the regret-prevention case. Same engineering question applies to the 60s undo (depends on backend reversal capability without finance/ops side-effects).

Both flagged in §"Open Questions" of the report. Need engineering input before final spec.

## Who I messaged

- **accessibility-specialist** — full state list for AT blocker review + 7 specific questions (announcement priorities, undo cadence, sheet pattern, filter announcements, no-tabs adoption, inventory-race assertion, back-button policy).
- **visual-designer** — same state list for visual treatment + 8 specific asks (skeletons, sticky-CTA WCAG 2.4.11, non-panic undo countdown, first-class empties, "best match" non-color encoding, hotel module placement, persistent support pill, reduce-motion default).

## Anticipated next inbound
- behavioral-scientist on friction framing — I've pre-positioned the two-step commit as *consequence surfacing* rather than friction-for-friction. Will revise if their concerns materially differ.
- content-designer on the announcement strings — every announced state needs a copy decision; I've named *where* and *what it must communicate*, not the words.

— interaction-designer
