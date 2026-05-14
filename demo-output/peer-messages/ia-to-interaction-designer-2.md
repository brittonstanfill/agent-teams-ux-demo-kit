# From: information-architect-2 → interaction-designer-2
**Re:** Proposed flow model + decision points for the canceled-flight recovery

(Re-routed with corrected `-2` suffix addressing per team-lead.)

Here is the structural skeleton I'm proposing. You own the *how it moves*; I'm handing over the *where the joints are* so we can align before either of us hardens anything.

## Flow model (5 screens, conditional)

```
SMS  →  S1 Status  →  S2 Choose recovery  ┬─→ S3 Pick a flight ─→ S4 Add support ─→ S5 You're set
                                          ├─→ (credit/refund) ────────────────────→ S5
                                          └─→ (standby) ──→ S3 (standby framing) ─→ S4 ─→ S5
```

## Joints I care about (decision points)

1. **S1 → S2 pre-selection.** When a user taps a specific option card on S1 (e.g. "Rebook"), S2 should open with that option *highlighted but not committed*. They can still change their mind. Soft commit, not a router decision.

2. **S2 has no default.** Active choice required. The current Travel-credit-default is doing harm. If you want a *recommended* visual treatment, fine — but it must be a recommendation, not a pre-selection. Behavioral-scientist-2 should weigh in.

3. **S2 → S3 vs. S2 → S5 branch.** Credit/refund path skips S3 and S4 *unless* entitlements still apply (e.g. hotel for an overnight gap). My instinct: include S4 if entitled, skip if not. Your state-machine call.

4. **S3 selection is held, not committed.** Back from S3 to S2 must not lose filter state or the highlighted flight. Tired users back up to verify; punishing them is the original sin of this flow.

5. **S4 Confirm is the one-way door.** The only commit point. Everything before is reversible. Design the Confirm interaction with this in mind — a brief, non-blocking summary of what's about to commit, in the button area or just above it. No modals.

6. **S5 has two onward actions that matter equally.** "Save offline" and "Change my recovery." Don't let one win visually. "Change my recovery" returns to S2 with current state preserved — important for the "plans changed again at 4 a.m." case.

7. **Persistent escape: "Call Northstar."** Same place on every screen, including S5. Structural, not decorative. Trust anchor.

## Inbound from ux-researcher-2 that affects this handoff

ux-researcher-2 sent me their top user needs. Two structural points they raised that you should know about:

- **"Talk to a human" as a peer-level option vs. a persistent affordance.** They lean persistent; I agree. The structural answer: persistent escape on every screen, *not* a recovery card on S2. Putting it on S2 would compete with rebook/credit/standby for cognitive bandwidth and reframe it as a recovery path rather than a safety net.
- **Family / mobility needs: early branch vs. in-list filter.** They lean filter. I agree. A front-loaded "tell us about your trip" step adds friction at the worst possible moment. Mobility/party-size live as filters on S3.

## Back-out paths

- Back from any screen returns to the previous screen with state preserved, *until* Confirm on S4.
- Browser/system back honored everywhere. Don't trap.
- After S4 commit, back from S5 should not "un-commit" — it returns to S5 or to the trip page. Only place where back semantics change. "Change my recovery" is the affordance, not the back gesture.

## Things I'm explicitly leaving to you

- Filter-row open/close behavior on S3 (sheet vs. inline expand vs. drawer — please don't make it a separate route).
- The "Recommended" badge interaction — tap to expand reason? Always-visible reason? I lean always-visible; align with content-designer-2.
- Loading and error states between screens. Structural rule: errors do not navigate the user backward or forward without their input.
- Whether S1's "options preview" cards are tappable as routes or only a primary button. I lean tappable cards (every option is a peer); flagging.

## What I'd like back from you

- A flow diagram I can sanity-check against this skeleton.
- Your call on the S2 → S5 (credit/refund) branch when entitlements apply.
- Any joints I've missed or where you think the structure should bend differently.

Full report: `role-reports/information-architect.md`.
