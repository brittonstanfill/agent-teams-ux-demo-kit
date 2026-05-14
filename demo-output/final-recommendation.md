# Canceled-flight Recovery — Recommendation

## 1. Executive recommendation

Replace the current five-screen canceled-flight flow with a redesigned mobile flow that does three things the current product does not: states the cancellation in human words on first frame, surfaces entitlements (rebooking protection, hotel, meal credit) as status the airline is already holding rather than offers the user must claim, and co-equalizes the "I'm not traveling — refund or credit" path with rebooking on the first decision screen.

Ship the attached working prototype as the design reference. It is mobile-first, dark by default, type-led, motion-free, and uses placeholder slots for every operational value (hotel name, meal credit, support line, voucher id, PNR). No fare-difference is shown during disruption, no opaque "Recommended" badge, no countdown timer, no Done dead-end. A persistent route to a human is present on every interactive screen.

We expect this design to reduce calls without hiding help, on three mechanisms: clear orientation before choice, status-framed entitlements that survive a tired skim, and reversibility through the final confirm. We are explicit about what would change our mind in section 4.

## 2. Redesigned flow

Five screens, mobile-first, ≤5 per the brief.

- **Screen 0 — SMS entry.** Plain-language event: flight number, route, time, and cause in the first sentence. One link to the trip. No "schedule irregularity."
- **Screen 1 — Situation and fork.** One headline naming the cancellation. One supporting line naming the cause and that the airline is responsible for rebooking and overnight support. A status block ("Already held for you") with three system-provided lines: protected seat on the next eligible flight, hotel night, meal credit. Two stacked, equal-weight path buttons: "Find me another flight" and "I'm not traveling — refund or credit." Persistent support link.
- **Screen 2 — Replacement flights.** Chronological list (no "Recommended"). Filters: arrive-by, nonstop, party size. Per-row: times, stops, flight numbers, and a textual flag where the held seat sits. **Standby is a separate section** below the confirmed list under "Standby option (not a confirmed seat)" so it cannot be mistaken for a confirmed alternative. No fare delta. Copy: "Choosing a flight does not finalize it. You confirm on the next screen."
- **Screen 3 — Confirm and support.** Chosen flight summary. Per-passenger eligibility rows where the system returns multi-passenger status. Each support item (hotel, meal credit, ride) is its own radiogroup with Accept selected by default and Decline available with equal visual weight; selection narrates to a live status node. Copy: "Decline anything you don't want. Nothing is charged. You can change support choices until departure."
- **Screen 4 — Receipt.** Offline-viewable summary: new flight, hotel, baggage instruction, meal credit, support line, and explicit copy that the trip can be reopened from the SMS link or email to rebook again. No "Done" terminal.

## 3. Accessibility and trust guardrails

Built into the artifact, not described in prose:

- One `<h1>` per page; each screen's main heading is `<h2>`. Real `<button>` for actions, real `<a>` for links and `tel:`. Skip-link as the first focusable element.
- AA contrast verified at documented hex values; primary-button focus ring has both an inner dark ring and an outer focus ring so it reads against the near-white fill and the dark canvas.
- Support items use a native `<fieldset>`/radio pattern with an `aria-live="polite"` status node; screen-reader users hear which option is selected and what was accepted or declined.
- Touch targets ≥44 CSS px with ≥12 px spacing between Accept and Decline. `prefers-reduced-motion` honored.
- Entitlements (hotel, meal, ride) are status, not offers. Refund/credit is a co-equal stacked button on Screen 1, not a tab or a buried link. No urgency timers, no "limited availability" copy, no confirmshaming.
- Every numeric value (hotel name, voucher id, meal credit, support line, pickup location) renders from a system-provided slot — never hard-coded.

## 4. Experiment plan

One falsifiable trial per claim. Run a moderated test (n ≥ 12) before any production rollout. In production, gate behind a controlled rollout with the following stop rules.

- **Primary metric:** self-serve completion rate (confirm on Screen 3 without calling support within the same session).
- **Guardrail metrics:**
  1. Post-confirm support-item reversals or disputes within 24 h. **Exit rule: > 15 %** — the Accept-pre-selected defaults are harvesting acceptances people did not read; switch to neutral defaults and rerun.
  2. Self-reported confidence at receipt ("Do you know what happens next?"). **Exit rule: < 75 % yes** in moderated testing — the receipt is theater, not orientation; redesign Screen 4.
  3. Screen 1 fork comprehension. **Exit rule: > 30 %** of participants tap "Find me another flight" and back out within 10 s without selecting a flight — the single-decision claim fails at the load-bearing screen.
  4. Call rate per canceled-flight event. **Exit rule:** calls do not fall, *or* calls fall but post-confirm disputes rise — the team is reducing call volume by hiding help, which the brief forbids.
- **Scoped gaps to investigate before broad rollout:** non-English-dominant traveler comprehension; multi-leg cascade events the Screen 1 fork does not model; whether SMS-native resolution outperforms the web flow for single-passenger PNRs.
