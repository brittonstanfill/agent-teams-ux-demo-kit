# Behavioral Scientist Role Report — Northstar Canceled-Flight Recovery

## Summary

The flow shows strong behavioral integrity: no default recovery is pre-selected, Refund sits as a first-class peer to Rebook, Standby is honestly demoted with "not a confirmed seat" in danger ink, and entitlements are line-itemed instead of hidden in a FAQ. The cognitive moment (10:46 p.m., tired, mobile) is respected — restrained tone, plain "canceled," and a parallel "Talk to an agent" exit on every screen. Two concrete operational promises do leak into the UI as unsupported claims and must be reframed before sealing. Trust floor passes overall.

## BLOCKERS

Count: **3** (claim-provenance: 3 / choice-architecture/trust: 0)

1. **Screen 4 — Rebooking assistance "Included" chip.**
   Mechanism: **unsupported operational promise** (asymmetric information; reads as guarantee). The brief never says rebooking assistance is universally included for every disruption; all other entitlements correctly use `{eligibility per booking}`. The lone hard "Included" chip is an unsourced commitment.
   Reframe: render as `{eligibility per booking}` like the others, or scope it to "Rebooking via this flow" (which is a process truth, not an entitlement promise).

2. **Screen 4 review card — concrete flight values "NS744 / 2:40 p.m. / 8:35 p.m. / DEN → LGA / nonstop".**
   Mechanism: **sneaking** — these aren't tokenized, so they read as airline-committed operational facts rather than the user's most recent selection echoed back from Screen 3. Same applies to Screen 5's "You're booked on NS744," "2:40 p.m.," "8:35 p.m." and "tomorrow."
   Reframe: tokenize as `{new flight number}`, `{new departure}`, `{new arrival}`, `{new route}`, `{new date}`. Brief supplies none of these.

3. **Screen 5 — "A copy of this plan has been sent to {contact channel}" and "Bag tags reprint there."**
   Mechanism: **unsupported operational promise** — "has been sent" asserts a completed action and "bag tags reprint there" asserts an airport process not in the brief.
   Reframe: "We'll send a copy to `{contact channel}` if configured." and "Check in at a Northstar counter or kiosk per airport instructions." Remove the "reprint there" claim.

(Note: Screen 5 "Baggage: Moves with your flight" is borderline. It's a process description not a promise of free/included baggage, so I leave it as a watch-item rather than a blocker — but the Visual Designer should consider tokenizing to `{baggage policy per booking}` for consistency with Screen 4.)

## CHOICE-ARCHITECTURE FINDINGS

**Strengths**
- **No default on Screen 2.** Copy explicitly states "No option is selected for you." Removes the Fogg-style ambient prompt that pushes users into the airline's cheapest path. (Strong.)
- **Card order Rebook → Refund → Travel credit.** Matches user-likely goal hierarchy (get there → get money → defer), not airline cost-containment order (credit-first would be cheapest for Northstar). The brief's *current* default of Travel Credit is correctly inverted.
- **Standby honesty at point of choice.** "Not a confirmed seat" sits next to the affordance — not in a downstream disclosure. This is the textbook fix for asymmetric information.
- **Screen 3 filters and comparator chips are substantive.** "Earliest arrival / Fewest stops / Latest departure" replace the unexplained "Recommended" — anchoring is now transparent. No fare-difference framing during disruption removes a loss-aversion exploit.
- **Parallel agent path.** "Talk to an agent" appears in every screen footer plus Screen 1's secondary CTA. Support is not gated behind a self-service failure.

**Risks**
- **Filter state.** "Arrive by" is `aria-pressed="true"` on load with no value bound. Cosmetically pressed but operationally inert. Behaviorally fine for a prototype, but in production an unbound pressed filter is *theater* — flag for handoff.
- **Cancellation chip text "· Canceled" on Screen 1** is `aria-hidden`. Screen-reader users miss the salience cue the chip provides sighted users. Coordinate with accessibility-specialist.

## DARK-PATTERN AUDIT

- **Confirmshaming** — absent. No "No thanks, I'd rather pay" or guilt copy on the agent-exit or refund paths.
- **Forced action** — absent. Exit to agent on every screen; "Change my recovery option" available on Screen 4; "Start recovery over" on Screen 5.
- **Sneaking** — present in mild form (see Blocker 2: untokenized flight values read as airline commitments rather than user-selection echo).
- **Misdirection** — absent. Visual weight is balanced across Rebook/Refund/Credit; none is bigger or accent-tinted versus the others.
- **Urgency manufacturing** — absent. No countdown timers, no "only X seats left" pressure during disruption. `{seats remaining indicator}` is a state token, not a manufactured scarcity claim.
- **Loss aversion exploited** — absent. Travel credit is not framed as something the user is "losing" by choosing refund.
- **False social proof** — absent. No "98% of travelers chose rebook," no fake reviews.
- **Hidden costs** — absent. Fare-difference is explicitly excluded from Screen 3 ("No fare-difference shown during recovery").
- **Roach motel** — absent. Refund is one tap from Screen 2; Screen 4 has an explicit "Change my recovery option" reversal.
- **Asymmetric information** — present in the Rebooking "Included" chip (Blocker 1) — that single option self-explains while the others stay tokenized.

## TRUST-FLOOR CHECK

- **Refund not hidden behind Rebook** — PASS. Refund is the second of three peer cards on Screen 2 with the same visual weight as Rebook.
- **Hotel/meal entitlements visible at the moment of decision** — PASS. Both are line items on Screen 4 with eligibility chips, surfaced before "Confirm and finish."
- **Support/human agent as parallel path, not failure exit** — PASS. Persistent footer link on every screen + Screen 1 secondary CTA. Not labeled "I couldn't figure this out."
- **Flow doesn't optimize "did not call support" as proxy for success** — PASS (in IR), but **WATCH** in measurement (see Falsifier 1).

## CLAIM-PROVENANCE FINDINGS

Walked all user-visible copy. Classification: **B** = brief-supplied, **S** = `{system-supplied}` token, **U** = unsupported. Verdict: **OK** or **BLOCKER**.

- "NS482 / DEN / LGA / 6:15 a.m." (S1) — B — OK.
- "crew availability" (S1) — B — OK.
- "Rebook on Northstar / Refund to original payment / Travel credit" (S2 titles) — recommendation-supplied via IA — OK as labels; no amount/expiration leaks.
- `{refund amount if applicable}`, `{credit amount if applicable}`, `{if applicable per booking}` (S2) — S — OK.
- "Standby is not a confirmed seat" (S2) — recommendation; honest negative claim, not a promise — OK.
- "Sorted by arrival time" (S3) — process truth — OK.
- Screen 3 flight rows "7:10 a.m. → 11:05 a.m. / NS612 / DEN → ORD → LGA / 2:40 → 8:35 / NS744 / 6:30 → 10:55 / NS888 / DTW" — **U** — **WATCH** but acceptable as prototype demonstration scaffolding since they are visibly in a selectable list (user-pick context, not airline promise). Flag for production tokenization.
- "Earliest arrival / Fewest stops / Latest departure" chips (S3) — derived from the rows themselves — OK.
- "Rebooking assistance — Included" (S4) — **U** — **BLOCKER 1**.
- Screen 4 review card hard values "NS744 / 2:40 p.m. / 8:35 p.m. / DEN → LGA / nonstop" — **U** — **BLOCKER 2**.
- "Held for you. Not ticketed until you confirm." (S4) — process truth aligned with IA's "selection is provisional" — OK.
- Screen 5 hero "You're booked on NS744 / 2:40 / 8:35 / tomorrow / nonstop" — **U** — **BLOCKER 2 (continued)**.
- "A copy of this plan has been sent to {contact channel}" (S5) — **U** asserted-completed-action — **BLOCKER 3**.
- "Bag tags reprint there" (S5) — **U** — **BLOCKER 3 (continued)**.
- "Baggage — Moves with your flight" (S5) — borderline process truth; WATCH, not blocker.
- "Arrive by {check-in time}. Have ID ready." (S5) — S + universal — OK.
- "Head to your gate (shown in the app closer to departure)." (S5) — process truth — OK.
- "Support channels: {support channel options as configured}" (S5) — S — OK.
- No appearance of: "free hotel," "24/7," "call you back in X minutes," "credit never expires," "no fees," "no questions asked." Clean on the high-risk-string list.

## FALSIFIERS / WATCH-FOR SIGNALS

1. **Hiding-help hypothesis test.** If we ship and support-call rate drops, the flow could still be failing users. Track **calls down AND refund rate stable-or-up AND post-trip complaints stable-or-down AND social mentions of "couldn't get a refund" flat**. Primary metric: refund-completion rate among canceled-flight users. Guardrail: NPS or post-disruption survey on "I got what I needed" must not drop more than 2 points vs. baseline. **Invalidator:** calls -30% but refund rate -15% = we hid the refund path; revert.

2. **Standby honesty test.** Predicted effect of moving "not a confirmed seat" to the choice moment: **standby selection rate drops, but standby-to-complaint conversion drops more.** Primary metric: complaints-per-standby-selection. **Invalidator:** standby selections drop with no drop in complaint conversion = users were already informed and we just suppressed the option.

3. **Entitlement visibility test.** Predicted effect of surfacing hotel/meal on Screen 4: **out-of-pocket hotel reimbursement requests rise short-term, then fall** as eligible users redeem in-flow. Primary metric: in-flow hotel-voucher claim rate among eligible bookings. Guardrail: ineligible-booking complaint rate (people angry they were shown a category they didn't qualify for) must stay below 3% of sessions where the ineligible chip rendered. **Invalidator:** ineligible-complaint rate spikes = we created a new frustration class; reframe ineligibility copy.

A user complaint if this flow shipped broken would read: *"It said my plan was sent but I never got it, and the flight times in the confirmation didn't match what I actually picked."* — directly traceable to Blockers 2 and 3.

Strongest opposing design that does not use this flow: a **single-screen triage card** that asks "Do you need to travel tomorrow or get your money back?" and routes to two narrow flows. Lower cognitive load, but loses the comparison affordance and the entitlement-visibility moment — would likely raise calls back up.

## ONE-LINE DISSENT

If Visual or IA argues the Screen 4 "Included" chip and the concrete NS744 echo are harmless prototype scaffolding, I push back hardest there — a confirmation screen with un-tokenized flight values is the single highest-trust real estate in the flow, and any unsourced commitment that renders there will be the one users screenshot and post when it's wrong.
