# From: information-architect → interaction-designer
**Re:** Proposed flow model + decision points for the canceled-flight recovery

Here is the structural skeleton I'm proposing. You own the *how it moves*; I'm handing over the *where the joints are* so we can align before either of us hardens anything.

## Flow model (5 screens, conditional)

```
SMS  →  S1 Status  →  S2 Choose recovery  ┬─→ S3 Pick a flight ─→ S4 Add support ─→ S5 You're set
                                          ├─→ (credit/refund) ────────────────────→ S5
                                          └─→ (standby) ──→ S3 (standby framing) ─→ S4 ─→ S5
```

## Joints I care about (decision points)

1. **S1 → S2 pre-selection.** When a user taps a specific option card on S1 (e.g. "Rebook"), S2 should open with that option *highlighted but not committed*. They can still change their mind. This is a soft commit, not a router decision.

2. **S2 has no default.** Active choice required. The current Travel-credit-default is doing harm. If you want a *recommended* visual treatment, fine — but it must be a recommendation, not a pre-selection. Behavioral-scientist should weigh in.

3. **S2 → S3 vs. S2 → S5 branch.** Credit/refund path skips S3 and S4 *unless* entitlements still apply (e.g. hotel for an overnight gap). I don't yet know whether your state machine wants S4 in the credit/refund path. My instinct: include S4 if entitled, skip if not.

4. **S3 selection is held, not committed.** Back from S3 to S2 must not lose the user's filter state or their highlighted flight. Tired users back up to verify; punishing them is the original sin of this flow.

5. **S4 Confirm is the one-way door.** This is the only commit point. Everything before is reversible. Please design the Confirm interaction with this in mind — a brief, non-blocking summary of what's about to commit, in the button area or just above it. Don't use a modal; modals on mobile under stress are friction.

6. **S5 has two onward actions that matter equally.** "Save offline" and "Change my recovery." Don't let one win visually. "Change my recovery" returns to S2 with current state preserved — important for the "plans changed again at 4 a.m." case.

7. **Persistent escape: "Call Northstar."** Same place on every screen, including S5. This is structural, not decorative. It's the trust anchor. We can talk about whether it's a sticky footer, a header item, or both, but it must be visible without scroll on every screen.

## Back-out paths

- Back from any screen returns to the previous screen with state preserved, *until* Confirm on S4.
- Browser/system back is honored everywhere. Don't trap.
- After S4 commit, back from S5 should not "un-commit" — it returns to S5 or to the trip page. This is the only place where back semantics change, and we should make that change obvious (e.g. "Change my recovery" is the affordance, not the back gesture).

## Things I'm explicitly leaving to you

- Filter-row open/close behavior on S3 (sheet vs. inline expand vs. drawer — your call, but please don't make it a separate route).
- The "Recommended" badge interaction — tap to expand reason? Always-visible reason? I lean always-visible; align with content-designer.
- Loading and error states between screens. I haven't designed them, but the structural rule is: errors do not navigate the user backward or forward without their input.
- Whether S1's "options preview" cards are tappable as routes or only the primary button is. I lean tappable cards (every option is a peer); flagging.

## What I'd like back from you

- A flow diagram I can sanity-check against this skeleton.
- Your call on the S2 → S5 (credit/refund) branch behavior when entitlements apply.
- Any joints I've missed or where you think the structure should bend differently.

Full report: `role-reports/information-architect.md`.
