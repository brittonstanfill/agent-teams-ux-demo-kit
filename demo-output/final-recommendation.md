# Canceled-Flight Recovery — Recommendation

## 1. Executive recommendation

Replace the current 5-screen recovery flow with the 5-screen sequence in the prototype: name the cancellation in plain language, present three equally-weighted recovery paths (rebook / refund-or-credit / standby), surface hotel and meal support as a first-class step before confirmation, and end with a saveable summary that distinguishes confirmed from pending rows. "Talk to a person" stays reachable from every screen. Ship behind an A/B test gated on entitlement-grant rate and post-completion support-contact rate — not call rate alone. A call-rate drop is a misleading success metric if help merely got harder to find.

## 2. Redesigned flow

1. **What happened.** Plain-language headline naming the canceled flight, plus a one-sentence cause. Primary CTA: "See my options." Support is described as a check the airline runs, not as an offer being floated.

2. **Choose how to recover.** Three equally-weighted cards: rebook, refund-or-credit, standby. Standby carries a "Not guaranteed" chip and a plain-words consequence. No default tab. No bare "Recommended."

3. **Pick your flight / Confirm refund-or-credit / Confirm standby.** Rebook variant uses a native radio-group of flight cards — fully keyboard- and screen-reader-accessible. Filters: arrival time, nonstop, earliest. Default sort: earliest arrival, with the reason named on the card. Fare difference appears only on a genuinely paid upgrade card, not as a default during disruption.

4. **Tonight and tomorrow.** Hotel and meal support are first-class rows with accept/decline. The primary button stays disabled until both rows are answered, so no silent default survives to the confirmation. Honest "still working" state if eligibility is not yet determined.

5. **Your updated trip.** Confirmation names the outcome ("You're rebooked / Refund started / You're on standby"), then a 5-row summary: new flight, hotel status, meal status, baggage, next-step contact. Pending rows render with a distinct "Pending — we'll send this when it's ready" pill, so the user knows what is and is not done. Save-offline and share affordances on the same screen.

## 3. Accessibility and trust guardrails

- Flight cards are a native radio-group, fully keyboard- and AT-accessible (replacing div+click handlers caught in audit).
- Focus indicator uses a two-color ring that survives on any button color (passes 3:1 non-text contrast on the primary).
- All interactive controls meet a 44×44px minimum target size — including the "Talk to a person" link and the Screen 4 accept/decline toggles.
- "Talk to a person" is a persistent footer affordance on every screen, never deprioritized below clutter.
- Token placeholders only. The design promises no specific dollar amount, hotel chain, voucher value, phone number, wait time, or expiration. Eligibility is described as a check, not as an entitlement.
- Standby's risk is named on Screen 2 and again on the standby confirm variant of Screen 3. Pending vs. confirmed status on Screen 5 is visually distinct, not absorbed into identical body type.
- `prefers-reduced-motion` respected; `lang="en"` set; landmarks and aria-labels per screen.

## 4. Experiment plan

**Primary success**: recovery completion without a call, at parity or better with the current flow.

**Falsifier — calls hidden, not helped**: track help-link reach rate, post-flight support-contact rate, and per-incident CSAT. If calls drop AND help-link taps drop AND post-flight contacts rise, we are hiding help — roll back.

**Falsifier — entitlement disappointment**: among users who see the Screen 1 eligibility-check framing, compare grant rate to post-decision complaint rate. If denials drive complaints, the framing still over-anchors.

**Falsifier — standby surprise**: among users who chose standby, compare same-day arrival rate to contact-support rate after non-clearance. If a meaningful share are surprised they did not fly, the standby consequence copy needs strengthening (recommend adding "and no fallback flight is booked" — Behavioral nudge that did not make this revision pass).

**Segment cuts**: low-bandwidth, screen-reader, multi-passenger bookings. The multi-passenger UI is a known scoped gap; if abandonment is concentrated there, that flow is the next priority.

**Decision gate**: roll back if any falsifier triggers materially. Iterate on copy first, layout second.

**Scoped gaps** carried forward, not solved in this artifact:

- No multi-passenger management UI.
- No design for slow asynchronous eligibility determination (e.g., a wait >30 minutes at Screen 4).
- Elite-status, award-ticket, codeshare/interline, and unaccompanied-minor segments are under-modeled.
- Refund-processing deep flow not designed.
- Standby clearing live-update UI not designed.
- Eligibility-determination logic is upstream and assumed; if the system cannot return synchronously, Screen 4 must say so in copy.
