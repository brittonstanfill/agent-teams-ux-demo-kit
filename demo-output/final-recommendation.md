# Canceled-Flight Recovery — Redesign Recommendation

## 1. Executive recommendation

Ship the redesigned five-screen recovery flow as a candidate, with a measured A/B against the current product gated by a refund-seeker call-rate guardrail. The current flow hides what happened (cause), hides what you can do (hotel and meal support), and equates a confirmed seat with a standby attempt. The proposed flow names the cause in plain language, presents the four recovery behaviors as peer choices with one-line consequences, makes hotel and meal support visible at the top of the choice screen, and ends on a saveable confirmation the user can come back to. Refund seekers are routed to a human, not into a credit funnel.

Mobile-first, no invented compensation rules, no invented hotel names, voucher amounts, support phone numbers, arrival times, or credit-expiration windows. Operational facts that vary per traveler appear as unobtrusive dynamic values.

## 2. Redesigned flow

**Screen 1 — SMS entry.** A plain-language alert that says the 6:15 a.m. flight NS482 DEN→LGA was canceled (cause: crew availability), names that options include hotel and meal support, and links to the recovery page. Replaces "schedule irregularity."

**Screen 2 — Status & Plan.** Headline names the cancellation in human terms. A status block separates cause from blame ("crew availability — not weather"). A reassurance line states that hotel and meal support are available. Two primary actions: *See my options* and *Talk to someone*. A persistent "Need a human?" link sits in the footer of every screen.

**Screen 3 — Choose your path.** Four peer cards with no default selection: *Rebook on a Northstar flight* (confirmed seat), *Try standby on an earlier flight* (no confirmed seat — you wait at the gate and may not get on), *Take travel credit*, *Hotel & meal support for tonight*. An honest dead-end note acknowledges that refunds are not handled in this flow and routes refund-seekers to *Talk to someone*. No "Recommended" badge.

**Screen 4 — Pick a flight.** The three rebooking options from the brief, in time order, all as visual peers: 7:10 a.m. one-stop (same fare, earliest), 2:40 p.m. nonstop (+ $84 fare difference), 6:30 p.m. one-stop (same fare). Arrival times shown as dynamic values, never invented.

**Screen 5 — Confirm & save.** Restates the choice in human language, summarizes flight, confirmation, baggage, and support status, sends a copy to email and SMS, and offers a *If plans change again* path back. *Talk to someone* still persistent in the footer.

## 3. Accessibility and trust guardrails

- WCAG 2.1 AA: single page-level H1, screen-level H2s, solid focus ring with double halo, touch targets ≥ 48 px, label-in-name compliance on flight CTAs, reduced-motion respected.
- Reflow to 320 px verified with no horizontal scroll. No `overflow: hidden` used to mask layout bugs. Long dynamic values wrap; they do not clip.
- Cause stated plainly; "schedule irregularity" retired.
- Hotel and meal support is a peer choice, not buried in an FAQ.
- Standby is labeled "no confirmed seat" at the choice point.
- Refund is an honest dead-end with a routed handoff — not a redirect into travel credit.
- "Talk to someone" is persistent on every screen, not hidden behind a self-service funnel.

## 4. Experiment plan

**Primary metric:** successful self-service recovery rate within 30 minutes of SMS tap (confirmed rebooking, standby joined, credit accepted, or hotel/meal support added) without abandonment to call. Pre-register before launch.

**Guardrail (falsifier):** call-rate among refund-seekers must stay flat or rise. A drop here while the primary climbs is the signal that the flow suppressed refund-seekers and is the strongest evidence of a hidden dark pattern. If this guardrail trips, halt the rollout.

**Secondary metrics:** completion-without-restart, time-to-first-action, hotel/meal-support attach rate, perceived helpfulness on a single post-flow item, downstream support cost.

**Scoped gaps (not solved in this artifact, surface in next iteration):** multi-passenger party rebooking on Screens 3–4; visual disambiguation of the standby branch from confirmed-rebook on Screen 4; nonstop and arrival-time filters; offline / low-bandwidth degraded view; accessibility request workflow (wheelchair, mobility, traveling-with-minor) during recovery.
