# Canceled-flight recovery — recommendation

## 1. Executive recommendation

Ship a five-screen, mobile-first recovery flow that leads with what happened and what's covered tonight, flips the default away from "Travel credit" toward rebooking, and keeps a human-reachable support affordance visible on every screen. The redesign treats every operational value — hotel/meal entitlements, refund timelines, support phone, gate, baggage status — as a placeholder slot resolved by backend systems at runtime. No dollar amounts, hotel names, wait times, callback windows, expirations, or compensation guarantees are baked into copy. This matters because the brief explicitly forbids inventing policy and because the current flow's "Other policies" FAQ is the failure mode we are replacing — surfacing entitlement *status* without inventing it is the core unlock.

We recommend the team validate the redesign with a controlled experiment scoped to disrupted bookings, with falsifiers that catch the most plausible failure mode: a call drop driven by hiding help, not by genuine self-service success.

## 2. Redesigned flow

Five screens, plus the entry SMS.

- **Entry SMS** — plain-language event, fallback support number, deep link. Remove "Schedule irregularity." Flight number, route, and time are dynamic.
- **Screen 1 — What happened & what's covered tonight.** Status sentence in plain words. Reason supplied by system. A warm-toned "What's covered tonight" module surfaces hotel and meal entitlement *status* (eligibility, amount, claim method — all tokenized). Primary CTA: "See my rebooking options." Secondary: text-me-this-link affordance.
- **Screen 2 — How would you like to get there?** Three stacked decision cards, no tabs. Order: Rebook (visually primary, light accent and a small "Primary" tag), Cancel and get a refund or travel credit, Join standby (subordinate label only — consequence is plain, no dashed-border rejection). Each card carries an explicit consequence string. The previous default of "Travel credit" is gone.
- **Screen 3 — Pick a flight.** Filter chips (arrival time, nonstop, same travel party). Cards sorted by earliest arrival with a visible sort label. Reason badges contain their reason ("Earliest arrival," "Nonstop, closest to original time," "Later option"); no bare "Recommended." Fare difference shown as a tokenized value.
- **Screen 4 — Review & confirm.** Itinerary, tonight (entitlement re-surface), bags, travel party, plus a tokenized re-notification statement. Primary CTA "Confirm rebooking," secondary "Go back."
- **Screen 5 — Your trip is set.** Confirmation, itinerary, tonight re-surfaced with claim method, four-channel save (wallet, email, text, PDF), tokenized re-notification path, persistent support affordance.

## 3. Accessibility and trust guardrails

- Decision cards are `<ul><li><button>` so screen readers announce them as buttons, not list items. All in-page navigation moves focus to a `tabindex="-1"` heading; visible focus rings everywhere.
- Heading hierarchy is intact; landmarks per screen via `aria-labelledby`. Skip link works. Reduced-motion honored. Touch targets meet WCAG 2.2 24-px floor and exceed it for primary actions.
- Every operational assertion in product UI is either a `{snake_case_token}` placeholder, a user-action affordance label, or a definitional consequence ("Confirmed seat" / "No guaranteed seat"). No invented amounts, names, timelines, or eligibility promises.
- Default architecture flipped to rebooking via order + accent + label, not via inverted-black coercion. No social-proof claims, no urgency manipulation, no fake scarcity. Support visible on every screen.

**Known scoped gaps** (documented, not solved in this prototype): refund-or-credit branch screens, eligibility-unknown and not-eligible visual states for entitlements, second support modality beyond phone, re-disruption re-entry path, multi-passenger eligibility branching. These are real risks; the team should sequence them next.

## 4. Experiment plan

Hypothesis: the redesigned flow increases successful self-service recovery while reducing support calls, without reducing entitlement claim rates.

- **Primary metric:** successful-recovery rate per disrupted session (rebooked or refund completed + confirmation reached).
- **Guardrail metric:** entitlement claim rate among eligible sessions. Must not fall vs. control.
- **Secondary metrics:** support-call rate per disrupted session; refund-share among recovery decisions; per-screen support-tap rate.
- **Falsifier (do not ship if this is true):** call rate falls but recovery rate and entitlement claim rate do not rise. That pattern indicates the design is suppressing calls by hiding help, not by resolving need.
- **Exit rule:** at least ~400 disrupted sessions per arm to detect a 5-point completion delta at α=0.05; pause and review if guardrail trips by more than 2 points week-over-week.

Sample arms: current flow (control), redesigned flow (treatment). Treatment runs to all disrupted bookings within a single airline region to avoid mode-of-disruption confounds.
