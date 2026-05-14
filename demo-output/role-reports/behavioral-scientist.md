# Behavioral Scientist — Northstar Canceled-Flight Recovery

## Audit summary

The prototype's choice architecture is, on the whole, honest. The defining trust failure of the original flow — a Travel-Credit default that bent the user toward the business-preferred outcome — has been removed: Screen 2 ships with no path pre-selected (`aria-pressed="false"` on all three), refund is shown as a peer of credit (not buried inside it), and the agent affordance is present on every screen as a persistent, identical pattern. Screen 4 surfaces entitlements before confirmation rather than after, breaking the FAQ-burial pattern named in the brief. There are no manufactured-urgency cues, no confirmshaming strings, no hidden cost reveals, no forced continuity. What remains are softer trust risks — mostly around what the prototype leaves to the system (placeholders) and a handful of copy strings that could collapse into false reassurance once filled in. One blocker stands. The flow appears to honor "reduce calls without hiding help" by *solving the job* rather than by suppressing the agent door. (observed from HTML)

## Blockers

**B1 — False reassurance risk on Screen 1's lead copy.** (mechanism: *false reassurance* / over-claiming agency)
- Where: line ~1050, "We're sorry — this isn't on you, and we can take care of the next steps from here."
- User impact: A stressed user at 11 p.m. reads "we can take care of the next steps" as a promise. If Screen 4 then shows two "Check with agent" rows (meals, bags — observed), the earlier reassurance contradicts the later honesty and the user feels bait-and-switched. Trust collapses precisely when the user is deciding whether to self-serve or call.
- Minimum fix: weaken the verb to a hedged statement of capability — "we'll walk you through your options now, and flag anything we still need to confirm." (recommendation; content-designer owns the final string.) Do not delete the reassurance — its absence in the original flow was the original trust failure. Calibrate, don't remove.

That is the only blocker. (assumption: I am treating coercion / dark-pattern presence as the bar for blocking; calibration risks are should-fix.)

## Should-fix

**S1 — "Confirmed" on Screen 4 is doing two jobs.** (mechanism: *ambiguous endowment*) The Hotel and Shuttle rows render `Confirmed` with an `Accept` button. If "confirmed" means *available to you, awaiting your acceptance*, the badge and the button conflict semantically — confirmed-ness implies the booking is done. A tired user may tap Confirm-support-choices on Screen 4 assuming the hotel is already theirs, then discover on Screen 5 it was conditional on acceptance. Recommend the badge read "Available for you" (or similar) until the user accepts, then flip to "Confirmed." (recommendation; content-designer.)

**S2 — Screen 4 says "Pick 'I don't need this' on the row," but no such control is visible in the HTML.** (mechanism: *phantom affordance*) Either render the decline control on each row or remove the sentence. As written, the user is told silence isn't consent — but is given no visible non-silent way to decline. (observed; interaction-designer / visual-designer.)

**S3 — Screen 5 lists Meals and Bags as "Pending agent" without a clear path to resolve them from this screen.** (mechanism: *resolution gap*) The persistent agent affordance at the bottom does this implicitly, but a tired user on Screen 5 has finished the flow and may close the app. Recommend the "Pending agent" badge be tappable, routing to the agent with the specific row's context pre-filled. Otherwise the unconfirmed rows become a quiet handoff to *no one* — and the user calls support anyway, which is the exact failure mode the business is trying to avoid. (recommendation.)

**S4 — Stepper for party size on Screen 2 starts at 2.** (mechanism: *anchoring*) For a solo traveler this anchors against their reality and asks them to decrement. The default should be 1 (or read from booking record if available). Defaulting to 2 isn't manipulative, but it's a sloppy anchor. (recommendation.)

**S5 — Filter chip "Earliest arrival" is pre-pressed on Screen 3.** (mechanism: *implicit default, low coercion*) This is a soft default that probably matches user intent for a canceled-morning-flight scenario, but it should be inspected: a pre-pressed filter is still a default, and the team's principle is *no defaults on choice-bearing surfaces*. Filters are a lower-stakes surface than path selection, so this is should-fix not blocker. Recommend either un-pressing it or labeling the screen "Sorted by earliest arrival" so the user knows the sort is active. (recommendation.)

## Considered but acceptable

- **Standby's visual subordination.** This *looks* like a dark pattern (suppressing a peer option) but on inspection is the opposite: Standby is structurally non-equivalent to Rebook — it is a non-confirmed seat. Making it visually equal would be the dishonest move. The dashed container, the "Or, a non-confirmed option" divider, the "Not equivalent to rebooking" warning chip, and the smaller type ramp together communicate *what kind of thing* this is. The path remains reachable (single tap, in tab order), labeled clearly, and not behind a confirmation. This is honest framing, not burial. (Brignull's *Aesthetic Manipulation* would require the suppression to be against the user's interest; here it protects it.)
- **Persistent agent affordance positioned below the primary CTA.** Could be read as deprioritizing the human path. On inspection, it's on every screen in identical shape, copy spine, and tab order — and the sub-line changes contextually ("Not sure which fits?", "Eligibility unclear?"). The cognitive load it adds is zero (same pattern every time) and the discoverability is high (end-of-screen, never collapsed, never behind a tap). This honors *available, not pushy*.
- **Reassurance block on Screen 1 (the green-tinted box).** Reads as *managed expectations*, not manufactured calm. Names three concrete things the user can do; does not promise compensation, hotel coverage, or wait times. (Subject to B1's calibration of the lead sentence above it.)
- **"Travel credit" sub-copy "Terms shown before you confirm."** This is the *opposite* of drip pricing — the user is told there are terms and where they'll appear, before commitment. Honest.

## Falsifiers / watch-for metrics

If the flow is secretly reducing calls by hiding help rather than solving the job, these would catch it:

1. **Agent-tap-to-call-handoff conversion rate by screen.** If users tap "Talk to an agent" on Screen 1 or 2 (early, before they've engaged with paths) at materially higher rates than Screens 3–5, the flow may not be answering the user's question early enough. Conversely, if Screen 4's agent taps drop relative to other screens but post-flow inbound call volume on entitlement topics (hotel, meals, bags) stays flat or rises, the flow is *deflecting the agent affordance without resolving the question* — which is the failure mode. (recommendation: instrument per-screen agent-tap rate plus a post-flow 24-hour inbound-call topic match.)
2. **"Pending agent" resolution rate from Screen 5.** Of users who reach Screen 5 with one or more rows in "Pending agent" state, what percent contact an agent within 24 hours, and what percent of those contacts resolve the pending item? If the resolution rate is low, the "pending" state is a parking lot, not a handoff. (This is the single falsifier I'd put in the experiment plan.)
3. **Standby selection rate among users with non-disruption baseline urgency.** If Standby is selected at materially higher rates than baseline for similar disruption recoveries — especially by users who later call to complain — its non-equivalence is not landing despite the visual subordination. (recommendation; would need product-side baseline to interpret.)
4. **Refund-to-credit ratio.** The previous flow defaulted to credit. If post-launch the refund-to-credit ratio shifts materially toward refund, the old flow was suppressing refund. If it doesn't shift at all, the peer framing isn't doing its job and credit is still being chosen via inertia. Either direction is informative; flat is the suspicious one. (recommendation.)

## Handoff to Visual Designer and lead

**For Visual Designer (blocker fix, then should-fixes):**
- B1 (copy calibration on Screen 1 lead) is a content-designer call but visual designer should leave the reassurance block intact during the revision; do not strengthen its visual weight.
- S1: distinguish "Available for you" (pre-acceptance) from "Confirmed" (post-acceptance) visually on Screen 4 — could be the same evergreen rail at half opacity for pre-acceptance, full for post.
- S2: add an explicit decline affordance per support row, or remove the "silence isn't consent" sentence. Co-design with accessibility-specialist — the decline control must be reachable for screen readers and not buried in an overflow menu.
- S3: make Screen 5's "Pending agent" badges tappable and visually treat them as actions, not labels.
- S4: drop party-size default to 1 in markup; the stepper can still increment.
- S5: either un-press the "Earliest arrival" chip or surface the active-sort state in plain text under the H1 ("Sorted by earliest arrival").

**For lead (final recommendation):**
- One blocker, one trust risk worth naming in the writeup (false-reassurance calibration on Screen 1).
- Put falsifier #2 (Pending-agent resolution rate from Screen 5) into the experiment plan. It is the single best signal that the flow is genuinely solving the job rather than deflecting agent contact.
- The flow honors the "reduce calls without hiding help" constraint *as designed*. The remaining risk is in production fill-ins: placeholders like `[hotel name from system]`, `[interval]`, `[arrive-by time from system]` must be wired honestly. If the system can't supply them, the rows must demote to "Check with agent" — never paper over absence with plausible-looking defaults. (recommendation, scoped gap from IA report; flagging that the falsifier metric is what catches a failure here.)
