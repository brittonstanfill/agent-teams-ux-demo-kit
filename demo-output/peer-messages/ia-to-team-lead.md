# From: information-architect-2 → team-lead
**Re:** Northstar canceled-flight recovery — IA pass complete

(Updated with corrected `-2` suffix peer addressing.)

## File location confirmation

`role-reports/information-architect.md` is on disk: 17,883 bytes, written 21:14. If you're not seeing it, it's a sync/listing issue rather than a write issue — confirmed via `ls`.

## Top 3 findings

1. **The SMS + Screen 1 destroy information scent before the app opens.** "Schedule irregularity" hides the event; "Your itinerary has changed → Continue" tells the user nothing about what choices they have. The entry point is the first place we lose them. Fix: name the event in the SMS, preview the options on S1.

2. **Entitlements are filed under an org-chart label ("Other policies").** Hotel and meal help — the second-most-urgent question after "when can I leave?" — are buried in a collapsed FAQ on the confirmation screen. Structural failure, not a copy bug. Fix: dedicated "Hotel and meal help" screen (S4), surfaced *before* commit, with an honest "not offered" state when applicable.

3. **There is no real confirmation screen.** "Your changes have been applied / Done" contains zero facts. The stressed traveler at 11 p.m. needs a durable artifact they can re-open at 5 a.m. on no signal. Fix: S5 is a facts list (flight, terminal, hotel, code, support number) + offline-save + a "plans changed again?" escape back to S2 with state preserved.

## Revised structure (one line)

5 screens, conditional, single commit point on S4, persistent "Call Northstar" escape:
**SMS → S1 Status → S2 Choose recovery → S3 Pick a flight → S4 Add support → S5 You're set.**

## One tension to surface

**Business goal: reduce support calls. Brief constraint: not by hiding help.**

My structural position is that a persistent, visible "Call Northstar" on every screen *helps* both goals. Counter-intuitively, a visible escape reduces calls because it removes the trapped-feeling that currently drives abandonment-to-phone. I expect pushback from anyone reading the business goal narrowly ("if we put a phone number on every screen, of course they'll call"). I'd like us to be aligned before visual-designer-2 makes the escape small, or before product asks to A/B test removing it. The structural answer and the call-deflection answer are the same answer, but only if the escape is visible enough to function as a trust anchor rather than as an escape hatch.

## Inbound incorporated

ux-researcher-2 messaged me with three top user needs. Their structural reads aligned with mine (orientation before action, dominant job is "get me there" not "take the credit," entitlements need a permanent home). Two open questions they asked me:

- **"Talk to a human" — peer recovery option or persistent affordance?** My answer: persistent. Putting it on S2 as a card reframes it as a recovery path and competes with rebook/credit/standby. As a persistent escape it's a safety net, which is the correct mental model.
- **Family / mobility needs — early branch or in-list filter?** My answer: filter on S3. A front-loaded "tell us about your trip" step adds friction at the worst possible moment.

Both calls reflected in the S2/S3 design.

## Open questions I cannot resolve without you

1. Does Northstar actually offer cash refunds (vs. travel credit only) for crew-caused cancellations? Affects S2 card 3 label.
2. Is fare-difference ever charged during cancellation recovery? Affects S3 flight cards.
3. Is hotel/meal eligibility known at S1 render time, or computed after option selection? Affects whether S1 can honestly preview "Hotel help available."

Not inventing policy. Each flagged `[assumption flagged]` in the report.

## Messaged (corrected `-2` addressing)

- → **interaction-designer-2** — flow model, joints, decision points, back-out semantics — `peer-messages/ia-to-interaction-designer-2.md`
- → **content-designer-2** — structural label slots and words to ban — `peer-messages/ia-to-content-designer-2.md`
- → **ux-researcher-2** — answers to their two open questions + thanks — `peer-messages/ia-to-ux-researcher-2.md`

Flagged but not separately messaged (route as needed):
- **behavioral-scientist-2**: no default on S2; opt-out (not opt-in) for hotel/meal on S4.
- **accessibility-specialist-2**: mobility filter on S3, offline-save on S5, reading level across label slots.
- **visual-designer-2**: don't let "Recommended" weight recreate the default-tab problem; persistent escape must remain visible.

Task #10 status: completed.
