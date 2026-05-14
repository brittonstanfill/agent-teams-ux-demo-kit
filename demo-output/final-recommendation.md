# Canceled-Flight Recovery — Recommendation

## 1. Executive recommendation

Ship a five-screen mobile recovery flow that names the cancellation plainly, offers four peer recovery paths (rebook, refund, travel credit, standby), surfaces overnight support without an FAQ, and closes with an offline-readable summary plus a re-entry path if plans change again. The current flow loses people because it hides information; the fix is to make options, consequences, and entitlements visible — not to make support harder to reach.

Three principles we are committing to:

- **Refund is a peer option, never a buried link.** A stressed traveler should not have to call to confirm a refund exists.
- **Hidden help is the failure mode.** Reductions in call volume are only real if total cross-channel support contact also falls. We will measure both.
- **No invented operational facts.** The flow uses non-promising placeholders for hotel names, voucher amounts, refund timing, and credit expiration. Real values come from policy/legal/ops on the implementation track.

## 2. Redesigned flow

**SMS (screen zero).** Replace "Schedule irregularity on NS482" with a plain message that names the cancellation, lists the available paths (rebook, refund, credit, support), and gives a phone fallback.

**Screen 1 — What happened.** Plain status: flight number, route, scheduled time, the word "Canceled." One-sentence apology. Traveler count for multi-passenger bookings. Primary action: "See my options."

**Screen 2 — Choose how to recover.** Four stacked option cards — rebook on Northstar, refund to original payment, travel credit, standby (labeled "Not guaranteed"). No default selection. No "Recommended" badge. A support row below the cards announces that hotel/meal information is on the next screen, not behind an FAQ.

**Screen 3 — Decide the details.** Path-specific content (flight list with filters, refund summary, credit summary, or standby summary). No flight is pre-selected; the primary action is disabled until the user picks one. No fare difference shown. No seat-scarcity cues. Always-present "Tonight's support" block shows hotel and meal items — including the honest "not included" state when applicable.

**Screen 4 — Review and confirm.** Per-item recap with explicit Accept / Decline pairs for each support item (consent moment moved here from Screen 3). Names which travelers the change covers. Confirm button names the action ("Confirm changes," never "Submit").

**Screen 5 — You're set.** Plain confirmation, numbered next-steps, an offline-friendly summary the user can save, a "Plans changed again?" re-entry link, and the persistent call link. Refund variant says "Refund requested," not "Refund complete."

## 3. Accessibility and trust guardrails

Accessibility floors verified in the prototype: single page-level `<h1>` with a clean outline; landmark structure (one `<main>`); two-tone focus indicators visible against every button background; flight options use a single-select toggle pattern with text-and-shape state, not radios mixed with `aria-pressed`; 44px touch targets on primary and undo affordances; the disabled standby card announces "Unavailable" to assistive tech; filter result-count updates live; no aria-hidden on consequence labels. Responsive smoke check at 320/360/390/desktop: zero offenders, no horizontal scroll.

Trust guardrails: no pre-selected flight, no pre-checked support consent, no pre-pressed arrival-time filter, no scarcity badges on rebook cards, no euphemized denials. Standby always carries "Not guaranteed." Support eligibility shows even when negative.

## 4. Experiment plan

**Primary hypothesis.** The redesigned flow reduces support call volume per disruption event by ≥15% at 90 days without reducing total cross-channel support contact.

**Primary metric.** Calls per disruption event. **Falsifier guardrail:** total support contact volume (calls + chat + email + social) per disruption event must not rise.

**Critical secondary metrics:**

- Refund-selection rate among users with no future booked travel — guards against quiet refund suppression.
- Post-completion call rate within 24 hours — if it rises, "You're set" closed the loop falsely.
- Web-to-call link click-through rate — if this falls faster than call rate, the call affordance got harder to find.
- Standby callback rate including the phrase "I thought I was booked" (transcript tag) — guards against standby misread as rebooking.
- "Not included" support state instrumentation paired with downstream out-of-pocket reimbursement requests — guards against hidden-eligibility failure.

**Exit rule.** Roll back if (a) total contact volume rises, (b) post-completion call rate within 24 hours rises by ≥5 percentage points, or (c) refund-selection rate among low-future-travel users drops without an explanatory population shift.

**Scoped gaps to monitor separately.** Multi-passenger split decisions, connecting itineraries, unaccompanied minors, mobility assistance, the traveler who is already at the airport at notification time, and authentication on the SMS link. None are solved by the five-screen prototype; each needs a paired support-channel design.
