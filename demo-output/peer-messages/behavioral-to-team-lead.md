# Behavioral Scientist → Team Lead

Subject: Task #15 complete — top findings, one tension, peer handoffs

## Three findings worth your attention

1. **The default tab is choosing for the user.** "Travel credit" defaults a tired 10:46 p.m. user toward the option that costs the airline least short-term, when the modal user wants to fly tomorrow. Default effect + status-quo bias. This is the single highest-leverage change in the flow and the clearest dark-pattern fix. [observed from brief + inferred]

2. **Hidden hotel/meal entitlements are the biggest trust risk in the existing flow.** Burying them in a collapsed "Other policies" FAQ is roach-motel-adjacent. Users either pay out of pocket and lose trust later, or call support to verify — exactly the call volume the business wants to reduce. Surfacing eligibility as a first-class card (not auto-claim) is a Pareto move: better for users, better for call-deflection. [observed from brief + inferred]

3. **The confirmation screen is wasted peak-end real estate.** "Trip updated / Done" is the user's last memory of this disruption — that's what peak-end rule says shapes their recalled view of the airline. A structured recap (flight, hotel, baggage, check-in, what-if-this-changes-again) is where trust gets rebuilt, AND it likely reduces 24h post-confirmation calls. [observed from brief + inferred]

## One tension to flag

**Tension: "Recommended" badge — useful signal vs. unearned authority.**

The business wants to nudge users toward a sensible option (good — reduces decision paralysis under stress). I'm asking content-designer-2 to replace the unexplained "Recommended" badge with a labeled reason ("Earliest arrival in your original window"). If she pushes back that this lengthens the card and hurts mobile scannability, my fallback is: keep "Recommended" as the visual, but require the rationale to be one-tap-revealable AND require us to be able to write the rationale in one short line. If we can't write the reason, we haven't earned the recommendation. **Decision needed from you if content-designer-2 and I can't land it: do we ship "Recommended" without an inline rationale, or do we hold the line on rationale-or-no-badge?** My recommendation is hold the line — unexplained authority triggers reactance and the business goal here is sustained trust, not one-flow conversion.

## Peers I've messaged

- **content-designer-2** — ethical framing / phrasing risks: loss-aversion language tests, "Recommended" wording, urgency / countdown copy, fare-difference framing, SMS opener, peak-end confirmation copy, no-confirmshaming on decline labels.
- **interaction-designer-2** — choice-architecture risks: default tab, equal-weight tabs / no asymmetric friction, sort order, inventory-hold communication (only after user-initiated hold), entitlement surfacing, confirmation screen affordances, no silent forced continuity on close, two specific places to ADD friction (before "Accept travel credit" and before "Standby").

## Not yet messaged
- accessibility-specialist-2 — I have one ask (any friction I propose must be accessible; the two confirmation modals before credit/standby need co-design). Happy to send if you want, or fold into a3y review.
- ux-researcher-2, info-architect-2, visual-designer-2 — no behavioral asks from me yet; will respond if they raise something.

Full report: `/demo-output/role-reports/behavioral-scientist.md`.

Task #15 → completed.

— behavioral-scientist-2
