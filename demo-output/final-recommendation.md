# Canceled-flight recovery: meeting-ready recommendation

## 1. Executive recommendation

Ship a five-screen mobile recovery flow that names the cancellation plainly, presents Rebook, Refund, and Travel credit as equal first-class peers (Standby honestly demoted), and surfaces hotel/meal/baggage/mobility entitlements as eligibility-conditional line items at the moment of confirmation rather than inside a collapsed FAQ. The flow earns its call-deflection by being legible, not by hiding help. Every operational detail the brief does not supply (credit amounts, expirations, voucher values, hotel names, support hours, callback windows, gate info, baggage policy) appears as a clearly-labeled dynamic placeholder, so production rollout requires data wiring, not copy invention.

The redesign solves four documented failure modes from the current flow: euphemistic SMS, vague "Continue" CTAs, hidden entitlements, and an empty "Trip updated" confirmation. It preserves a parallel "Talk to an agent" path on every screen so support is a choice, not a failure exit.

## 2. Redesigned flow

1. **Cancellation Notice.** SMS rewrite (plain "canceled," reason, three concrete next steps). Screen H1 names the event directly. Primary CTA opens recovery options; secondary CTA opens human support.
2. **Recovery Options.** Three equally-weighted cards — Rebook on Northstar / Refund to original payment / Travel credit — with no pre-selected default. Standby appears as a separately-styled secondary affordance labeled "not a confirmed seat" at the point of choice. Refund and credit values render as `{system-supplied}` tokens; expiration shows as `{if applicable per booking}`.
3. **Choose a flight.** Replacement-flight list with neutral comparator chips (Earliest arrival, Fewest stops, Latest departure) instead of unexplained "Recommended." Filters for arrival time, nonstop, travel party, mobility needs. No fare-difference shown during disruption recovery.
4. **Support & confirm.** Entitlements rendered as a visible list — Overnight accommodation, Meals, Rebooking assistance, Accessibility & mobility, Checked baggage — each with an eligibility chip sourced per booking. Ineligible items remain visible so the user is never quietly excluded. Review card echoes the user's selection as tokens.
5. **Confirmation & plan.** Portable trip summary, at-airport checklist, save-as-PDF / add-to-wallet / text-summary actions, persistent re-entry path if plans change again, persistent support link.

## 3. Accessibility and trust guardrails

- WCAG 2.1 AA bar: single `<h1>` per page, semantic landmarks, visible focus rings with a separate light variant for pressed-dark filters, 44px tap targets, contrast ≥4.5:1 body / 3:1 UI, `prefers-reduced-motion` honored.
- Screen-reader integrity: the SMS hero is announced as "Example of the SMS the traveler received" with a visually-hidden prefix sentence, not as a real incoming message. Skip-to-content link present. Flight-card accessible names match visible time/route copy (WCAG 2.5.3 Label in Name).
- Trust floor: refund is a first-class peer to rebook (not buried behind it); entitlements are surfaced at the decision moment; the human-agent exit is a parallel path on every screen, not a failure exit.
- Claim provenance: every operational assertion in user-visible copy is either supplied by the brief, rendered as a `{system-supplied}` placeholder, or removed. The flow promises no specific fees, refund amounts, credit values, expirations, hotel names, voucher amounts, wait times, callback windows, support hours, gate numbers, or baggage rules.

## 4. Experiment plan

**Primary metric:** Refund-completion rate among canceled-flight users (proves users who want a refund get one). **Guardrail:** Post-disruption "I got what I needed" survey must not drop more than 2 points vs. current flow.

**Falsifier 1 (hiding-help test).** If support calls drop but refund rate also drops ≥15% relative to the current flow, the redesigned flow is suppressing the refund path — revert.

**Falsifier 2 (entitlement visibility test).** If ineligible-booking complaint rate ("you showed me a category I don't qualify for") exceeds 3% of sessions where an ineligible chip rendered, ineligibility copy needs reframing before scaling.

**Falsifier 3 (standby honesty test).** Predicted: standby selections drop, but standby-to-complaint conversion drops further. If selections drop without a corresponding complaint-conversion drop, the demotion is suppressing a legitimate option.

**Scoped gaps surfaced for follow-up, not solved in this prototype:**
- Multi-passenger / family-travel per-passenger logic — currently a filter input plus a "coming soon" flag.
- Low-bandwidth / offline confirmation save mechanism — referenced via "Save as PDF" and "Add to wallet" controls, but offline-first behavior is not specified.
- Refund-seeker who has not yet experienced cancellation (proactive refund eligibility check) is out of scope.
- Cosmetic "Arrive by" filter is pressed on load with no time bound — must accept a value before shipping or be unpressed by default.
