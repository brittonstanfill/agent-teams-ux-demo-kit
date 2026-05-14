# Northstar Air — Canceled-flight recovery

A redesigned five-screen mobile flow for a traveller who learns at 10:46 p.m. that their 6:15 a.m. flight is canceled.

---

## Executive recommendation

The current recovery flow optimises for the airline's vocabulary ("schedule irregularity," "Other policies") and hides what the user is owed. The redesign does three things differently:

1. **Names the event in plain language, in the first message.** "Canceled" replaces "schedule irregularity." A seat is pre-held on the next viable flight, with a visible timer, so the user can act without feeling rushed.
2. **Surfaces entitlements before commitment.** Hotel and meal support are visible on the first in-app screen and opt-out by default on the support screen — not buried in a collapsed "Other policies" FAQ. [observed from brief]
3. **Treats the disruption as a recovery flow, not a buy flow.** No fare-difference labels on replacement flights. No "Recommended" without a reason. No "Done" button without a summary. [recommendation]

The trade-off this commits to: we will probably *increase* the number of users who tap the agent line, because the agent line is always visible. We accept that, because the goal is reducing *unnecessary* support calls — calls driven by confusion and missing information — not reducing all human contact. The scorecard for this work has to measure both. [assumption]

---

## Main issues found in the current flow

All issues are derived from the brief. [observed from brief]

| # | Where | What's wrong | Why it costs trust |
|---|-------|--------------|--------------------|
| 1 | Entry SMS | "Schedule irregularity on NS482. Manage trip: link" | Jargon. Hides the event. No reassurance. No next step. |
| 2 | Trip Status screen | "Your itinerary has changed" header; vague "Continue" button; key info behind "View details" | The user doesn't know what choices they have, or what "Continue" will do. |
| 3 | Recovery Options | Three tabs (New flights / Travel credit / Standby) defaulting to Travel credit | Default does not match the user's goal of getting there. Labels don't state consequence. Hotel and meal support are absent from this screen. Standby reads as a confirmed seat. |
| 4 | New Flights | "Recommended" without explanation; fare-difference shown during a carrier-caused disruption; no filters for arrival window, nonstop, mobility, or travel party | Opaque ranking. Inappropriate pricing surface. Wrong sort axis. |
| 5 | Support | Hotel voucher and meal credit inside a collapsed FAQ called "Other policies" | Entitlements feel like a refused upsell. Pays out of pocket when they shouldn't have to. |
| 6 | Confirmation | "Trip updated. Your changes have been applied. Done." | No summary, no offline backup, no path if plans change again. Deflection, not confidence. |

---

## Redesigned flow

Five screens. Mobile-first. Each screen is rendered as an actual phone-frame prototype in the accompanying HTML.

### Screen 01 — Alert (SMS / push)

**Job:** Name the event. Hold a seat. Tell the user help is real.

The message uses three short paragraphs in a single bubble so it survives line wrapping and reads cleanly in screen-reader linear order. A short link code (`ns.air/r/T49P`) is chosen because long tracked URLs degrade in SMS clients and accessibility tools. [recommendation]

### Screen 02 — What happened & choices

**Job:** Open on the truth. Present every meaningful path at the same depth.

Three primary choices, in this order: **Rebook a flight** (featured because user goal is "get there"), **Refund as travel credit**, **Talk to an agent**. Each card shows its consequence in one short line. Above them, the trip context (DEN → LGA · NS482 · TUE) is anchored. Below them, a visually distinct entitlement banner names hotel and meal support and gives the user a path to add them *before* they pick a recovery option.

### Screen 03 — Pick a flight

**Job:** Sort by what the user needs (arrival time), not by carrier-coded categories.

- Default sort: **arrival time**, closest to original landing first.
- "Recommended" is replaced with **"Closest to your original arrival"** — a reason the user can verify.
- **No fare-difference labels** during a carrier-caused disruption.
- Filters cover real goals: Arrive AM, Nonstop, Family-friendly, Mobility help.
- Standby is included for completeness but visually demoted and labeled "seat not guaranteed." [recommendation]

### Screen 04 — Add overnight support

**Job:** Show what's owed. Make adding it the default, not a quest.

- Hotel and meal credit are listed as eligible and **switched on by default**, with clear toggles to turn them off.
- A third item — **Travel-with help** — routes to a specialist agent (child / mobility / companion). [recommendation]
- Skip is one tap: "Skip — I'll handle it myself."

### Screen 05 — You're set

**Job:** Replace a "Done" button with a useful, calm summary.

- Flight (with mobile pass status)
- Hotel (with check-in window and shuttle pickup)
- Meal credit (with how to redeem)
- A "Save offline · add to wallet" button — works at low bandwidth, survives a dead-zone airport.
- A persistent **"If plans change, see options again"** link that returns to Screen 02 without restarting the flow.

---

## Recommended copy (verbatim)

> Use these strings as-is. Each is short enough for a 4-inch phone in portrait, and avoids invented amounts, dates, or policy.

### SMS (entry)
> Your 6:15 AM flight DEN → New York (LGA) is canceled. Reason: crew availability.
>
> We've held a seat for you on a 7:10 AM option for the next 30 min. Tap to confirm, switch, or get a refund: ns.air/r/T49P
>
> Hotel and meal support is inside — not behind a menu.
>
> Reply CALL to talk to someone. We see your trip.

### Screen 02 — header & choice cards
- Eyebrow: **Canceled · NS482**
- Header: **Your 6:15 a.m. to New York is canceled.**
- Subhead: **Crew availability. Sorry to wake you. Three things you can do — pick whichever fits tomorrow.**
- Choice 1 label: **Rebook a flight** · sub: **7:10 a.m. seat held. Other times available.**
- Choice 2 label: **Refund as travel credit** · sub: **Full fare, available right away. Use within 24 months.**
- Choice 3 label: **Talk to an agent** · sub: **We'll show the current wait before you commit.**
- Entitlement banner: **Overnight support is on this trip. Hotel near DEN and a meal credit are ready to add.**

### Screen 03 — list and badges
- Header: **Pick a flight that gets you there.**
- Subhead: **Sorted by arrival time — closest to your original landing first.**
- Featured badge (replaces "Recommended"): **Closest to your original arrival**
- Hold-timer line: **Your seat is held until 11:16 p.m. Tap to confirm.**
- Standby badge: **Standby · seat not guaranteed**

### Screen 04 — support
- Eyebrow: **Eligible · disruption support**
- Header: **Add what you need for tonight.**
- Subhead: **Already linked to your trip. Keep what helps. Turn off what you don't need.**
- Skip-out button: **Skip — I'll handle it myself**

### Screen 05 — confirmation
- Eyebrow: **Saved · tomorrow's trip**
- Header: **You're set for tomorrow.**
- Subhead: **Sleep when you can. Here's what's waiting.**
- Next-step prefix (boarding pass row): **Next:** board pass appears at DEN security 2h before takeoff.
- Persistent fallback: **If plans change, see options again**

### Always-visible support strip
> Agent line: +1 (888) 000-0000 · open through your trip

[assumption: the agent line number shown is a placeholder; the real one is provided by ops.]

---

## Accessibility risks and mitigations

Target: WCAG 2.1 AA across all screens.

| Risk | Mitigation |
|------|------------|
| **Screen-reader users hit "Continue" on Screen 02 without knowing what it does.** [observed from brief] | Removed. Every actionable element states its consequence in its label. Tested against 1.3.1 *Info and Relationships* and 2.4.6 *Headings and Labels*. |
| **Toggles on Screen 04 communicate state only via color.** | Toggles include an explicit "On" / "Off" text label adjacent to the switch. Meets 1.4.1 *Use of Color* and 4.1.2 *Name, Role, Value*. |
| **Filter chips on Screen 03 horizontally scroll and may be invisible to users on small screens.** [assumption] | Filter row is keyboard-scrollable; first chip is always the user's likely default (Arrive AM); selection state is announced via aria-pressed. [recommendation] |
| **Motion sensitivity — transitions between screens cause discomfort.** | All transitions respect `prefers-reduced-motion`. Tested in CSS only; engineering must mirror in any JS animation. Meets 2.3.3 *Animation from Interactions*. |
| **Low-vision users on the phone outside, glare-bound.** | Light theme uses ink (#1B1F25) on warm cream (#F5F1E9) — measured > 14:1. Primary buttons use ink-on-cream, > 14:1. Dark theme verified at AA minimum. |
| **The user is tired and may misread a confirmation screen as their boarding pass.** [inferred] | Screen 05 explicitly separates "mobile pass · Ready" from the rest of the summary, and the "Next:" prefix tells the user when the pass appears. |
| **Touch targets too small for tired, stressed thumbs.** | All interactive targets ≥ 44×44 px, with full-row tap zones on choice and support cards. Meets 2.5.5 *Target Size (AAA, applied here)*. |

---

## Trust risks and mitigations

| Risk | Mitigation |
|------|------------|
| **The user feels rushed into the 7:10 a.m. option because of the hold timer.** | The hold timer is shown but not blinking, not red, and the alternatives below are equally easy to reach. Loss aversion is engaged honestly. |
| **Entitlements are surfaced before the user has chosen a path — could feel like a marketing nudge.** | The banner uses neutral language ("Overnight support is on this trip") and does not say "free" or "complimentary." It links to a screen the user can opt out of in one tap. |
| **Standby looks identical to confirmed rebooking.** [observed from brief] | Standby is visually demoted (dashed border, muted color) and explicitly labeled "seat not guaranteed." |
| **The "Talk to an agent" choice could be perceived as cosmetic if waits are long.** | The choice card commits to showing the *current* wait before the user commits. If wait is over a threshold, surface the SMS-based callback option. [recommendation] |
| **"You're set for tomorrow" feels presumptuous if the trip then changes again.** | The persistent "If plans change" link is always visible on Screen 05, and returns to Screen 02 without restarting the flow. |

---

## Experiment plan

Three experiments, sized so they can run in parallel without confounding each other.

### Experiment 1 — Plain-language SMS

- **Hypothesis:** Replacing "Schedule irregularity" with the named event ("canceled" plus reason) increases first-tap engagement with the recovery link from the SMS within 10 minutes of receipt.
- **Primary metric:** % of disruption SMS recipients who tap the link within 10 minutes.
- **Guardrail:** Reply-to-text rate, including "STOP" and "CALL" replies. If the new SMS produces a meaningful jump in "STOP" replies vs. control, the language may read as alarming and we re-evaluate. [assumption: threshold to be set after a pre-rollout reference week]
- **Exit rule:** If the variant fails to outperform control after a pre-registered sample size, revert to control and re-author. We do not extend the test hoping for significance.

### Experiment 2 — Surfaced entitlements

- **Hypothesis:** Showing hotel and meal support on the first in-app screen (and as opt-out on the support screen) increases the share of eligible disruptions where the traveller actually receives the support they're entitled to.
- **Primary metric:** % of eligible disrupted trips where the user redeems at least one entitlement.
- **Guardrail:** Cost of fulfilled entitlements per disruption. If average cost climbs sharply because more users are accepting eligible offers, that is the intended effect — but the guardrail is whether *ineligible* users are slipping through. [assumption: ops can attribute eligibility upstream of the UI]
- **Exit rule:** Pause if ineligible-redemption rate exceeds a pre-set threshold. We're making something more visible, not more lenient.

### Experiment 3 — Removing fare-difference from the disruption rebook list

- **Hypothesis:** Removing the price tag from replacement flights during a carrier-caused cancellation increases the share of users who self-serve a rebook (instead of calling support to "ask if they have to pay").
- **Primary metric:** % of canceled-flight rebookings completed in-app without an agent contact in the same session.
- **Guardrail:** Downstream complaint or chargeback rate tied to surprise charges. If users are confused about whether they paid for the replacement flight, the absence of price has created a different problem.
- **Exit rule:** If self-serve rebook rate moves but post-trip complaints about charges also rise, reinstate price labelling *only for the cases that genuinely cost money* (rare during carrier-caused disruption). Do not roll the experiment back as a whole.

---

## Out of scope, on purpose

- **Compensation logic, vouchers, or legal entitlements.** This document does not invent amounts, durations, or eligibility rules. Ops and legal own those tables; the UI surfaces them.
- **Multi-traveller and itinerary-with-connections variants.** This concept covers a solo traveller with a single-leg trip. A follow-on pass should cover families and complex itineraries. [recommendation]
- **Push notification design beyond SMS.** Some travellers will not receive an SMS at 10:46 p.m. depending on carrier and device state. A parallel push design needs the same plain-language rules.
- **Agent-side experience.** When the user taps "Talk to an agent," what the agent sees on their side is at least as important as the user's screen. [recommendation]

---

## Companion artifact

A working phone-frame prototype rendering all five screens — with light, dark, and reduced-motion modes — accompanies this document.
