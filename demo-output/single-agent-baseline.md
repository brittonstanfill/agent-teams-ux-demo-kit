# Single-Agent Baseline: Northstar Air Canceled-Flight Recovery

> Generated from `03-single-agent-baseline-prompt.md`. One generalist pass across UX research, IA, interaction design, UX writing, accessibility, visual/UI, and behavioral science. Assumptions are labeled. No metrics or user quotes are invented.

---

## 1. Executive Recommendation

Rebuild the canceled-flight recovery flow around three jobs, in this order: **(1) tell me what happened and what I'm owed, (2) get me on a flight that actually works for me, (3) confirm everything I need to survive tonight and tomorrow.** The current flow inverts these priorities — it leads with travel credit, hides hotel and meal entitlements behind an FAQ, and never tells the traveler what the airline will do for them.

The redesign collapses recovery into **four mobile screens** plus an upgraded SMS. It surfaces hotel and meal support as first-class options (not policies), replaces euphemisms like "schedule irregularity" with plain language, defaults to **rebooking** rather than travel credit, and ends on a tangible itinerary the traveler can show at a hotel desk or gate without re-opening the app.

Why this should work (assumption, to be tested): the abandonment problem is likely a **trust and clarity problem**, not a feature gap. The flow already offers rebooking, hotels, and meals — it just buries them. Surfacing them, naming them honestly, and confirming them concretely should reduce the "I'll just call" reflex without removing any option.

**Assumption:** the business definition of a "successful self-service recovery" is a confirmed rebooking (or credit) plus any owed support, without a follow-up call. We use that as the success criterion below.

---

## 2. Redesigned Flow (4 Screens + SMS)

### SMS (entry)

```
Northstar: Your 6:15 AM flight NS482 (DEN→LGA) was canceled
due to a crew shortage. You have options — including a hotel
tonight if you need one. Tap to rebook or get help: [link]
Reply HELP for a live agent.
```

Why: names the event in plain language, names the cause, signals entitlement to support, gives two paths (self-serve or human).

### Screen 1 — What happened & what we'll do

**Header:** "Your 6:15 AM flight was canceled"
**Subhead:** "NS482 DEN → LGA. Cause: crew shortage."

**"Here's what Northstar will cover"** (visible, not collapsed):
- Rebooking on the next available Northstar flight at no extra cost
- A hotel room tonight if your new flight is tomorrow
- A meal credit while you wait
- A full refund if you'd rather not travel

Primary button: **"See my rebooking options"**
Secondary: **"Get a refund instead"**
Tertiary link: **"Talk to an agent"** (always visible, never buried)

Why: leads with cause + entitlements before asking the traveler to decide anything. Removes the "am I being shortchanged?" cognitive load that drives the call to support.

### Screen 2 — Choose a new flight

Default sort: **earliest arrival to LGA**. Three flight cards, each with:
- Departure / arrival times **and total trip duration**
- Stops, with airport codes spelled out on tap
- A **plain-language tag** instead of "Recommended": e.g. "Earliest arrival" / "Only nonstop" / "Most legroom available"
- No fare difference shown during disruption recovery — this is a recovery flow, not a shopping flow

Filters above the list (chip row):
- Nonstop only
- Arrive by [time picker]
- Travel party / accessibility needs → opens a short form that escalates to an agent if needed

Primary button on each card: **"Rebook on this flight"**

Below the list:
- **"None of these work — show me a travel credit"** (the old default, demoted to an explicit choice)
- **"Try standby instead"** with a one-line plain-language explanation: *"Standby means we'll try to get you on an earlier flight, but a seat isn't guaranteed."*

Why: makes the consequence of each option legible. Demotes credit (which is in the airline's interest) without removing it. Names what "standby" means so it isn't mistaken for a confirmed seat.

### Screen 3 — Confirm support

Pre-selected based on Screen 2 choice; user can toggle:

- ☑︎ **Hotel tonight** — "We'll book and pay for a room near DEN. You'll get the address by text."
- ☑︎ **Meal credit** — "$X added to your trip for food at the airport." *(amount pulled from policy, not invented)*
- ☐ **Rideshare to the hotel** — "We'll cover one ride each way."
- ☐ **I'll arrange my own** — "Save your receipts; we'll review reimbursement."

Primary button: **"Confirm my trip"**

Why: presents support as defaults (loss-averse framing — the traveler now has to opt *out* of help, which mirrors what they're actually owed). The "arrange my own" option preserves autonomy and avoids a dark-pattern feel.

### Screen 4 — Confirmation & survival kit

**Header:** "You're rebooked. Here's everything you need tonight."

A single scrollable summary:
- ✈ **New flight**: NS6204, 2:40 PM tomorrow, DEN → LGA nonstop, seat 14C, gate posts 90 min before
- 🏨 **Hotel**: [Name], [address], confirmation #, check-in until 2 AM, shuttle pickup at Door 6 every 20 min
- 🍽 **Meal credit**: $X — show this screen at any airport restaurant
- 🧳 **Bags**: Will travel with you on the new flight
- 📞 **If anything changes**: tap to call, text, or chat — open 24/7
- 📅 **Add new flight to calendar** · **Save offline copy (PDF)** · **Text this to someone**

Why: this is the single most important screen. It replaces "Done" with a usable artifact. "Save offline" matters for low-bandwidth or airport-wifi conditions; the share-by-text option matters for travelers coordinating with family.

---

## 3. Main Issues Found in the Current Flow

| # | Issue | Where | Why it matters |
|---|---|---|---|
| 1 | Euphemism hides the event | SMS, Screen 1 | "Schedule irregularity" forces the user to decode the message before they can act |
| 2 | Entitlements buried in FAQ | Screen 4 | Travelers pay out of pocket or call to confirm what they're owed — a low-trust pattern |
| 3 | Default tab is travel credit | Screen 2 | The default nudges users away from their likely goal (getting to their destination) |
| 4 | "Recommended" is unexplained | Screen 3 | Forces trust without giving the basis for it |
| 5 | Fare differences shown during recovery | Screen 3 | Mixes a sales pattern into a service-recovery moment |
| 6 | "Standby" is unexplained | Screen 2 | Risk of false equivalence with a confirmed rebooking |
| 7 | Confirmation is content-free | Screen 5 | "Your changes have been applied" gives the user nothing to hold onto |
| 8 | No offline / share path | Screen 5 | Mobile-only, low-bandwidth users can't retrieve details if they lose signal |
| 9 | No filters for real constraints | Screen 3 | Travel party, arrival-by, accessibility needs are invisible to the system |
| 10 | "Done" implies the journey is resolved | Screen 5 | But the user still has a hotel night and a 14-hour wait ahead |

---

## 4. Recommended Copy

**SMS:** see Screen 0 above.

**Screen 1 header:** "Your 6:15 AM flight was canceled"
**Screen 1 cause line:** "NS482 DEN → LGA. Cause: crew shortage."
**Screen 1 primary CTA:** "See my rebooking options"
**Screen 1 secondary CTA:** "Get a refund instead"
**Screen 1 tertiary link:** "Talk to an agent"

**Screen 2 sort label:** "Sorted by earliest arrival"
**Screen 2 flight tag examples:** "Earliest arrival" · "Only nonstop tomorrow" · "Same-day option"
**Screen 2 standby explainer:** "Standby means we'll try to get you on an earlier flight, but a seat isn't guaranteed."
**Screen 2 demoted-credit link:** "None of these work — show me a travel credit"

**Screen 3 hotel line:** "We'll book and pay for a room near DEN. You'll get the address by text."
**Screen 3 meal line:** "$X added to your trip for food at the airport."
**Screen 3 self-arrange line:** "I'll arrange my own — save your receipts and we'll review reimbursement."
**Screen 3 primary CTA:** "Confirm my trip"

**Screen 4 header:** "You're rebooked. Here's everything you need tonight."
**Screen 4 footer line:** "Plans changing again? Tap to call, text, or chat — 24/7."

**Voice rules:**
- Use plain English. No "irregularity," "modification," "advisement."
- Name the cause when it is known. If it is not known, say so: "Cause: still being confirmed."
- Use active voice from Northstar's side: "We'll book and pay for a room," not "A room will be provided."
- Never promise what isn't policy. *(Assumption: actual entitlement amounts and hotel coverage come from existing Northstar policy and are not invented in this baseline.)*

---

## 5. Accessibility and Trust Risks

### Accessibility

- **Screen reader order.** Each screen should read in the order: what happened → what you're owed → primary action. The "Talk to an agent" link must be reachable without scrolling past the full flight list.
- **Headings.** One H1 per screen, named after the user's job ("Your 6:15 AM flight was canceled" — not "Itinerary update"). Cause and entitlements as H2.
- **Contrast & size.** Body text ≥16 px, AA contrast minimum. Flight cards must not rely on color alone to distinguish "Earliest arrival" from other tags — use an icon or label.
- **Tap targets.** ≥44×44 pt. Filter chips on Screen 2 are a common offender; verify spacing.
- **Time and date.** Always include the day of the week and timezone ("Wed, 2:40 PM MT"). Tired travelers misread bare timestamps.
- **Forms.** The accessibility-needs / travel-party form on Screen 2 must support voice input and offer a "talk to a human" escape after one step.
- **Motion.** No auto-advancing carousels on the flight list. Respect `prefers-reduced-motion`.
- **Offline.** Screen 4 must render the saved PDF without app login. *(Assumption: PDF or static HTML is feasible within the existing stack.)*
- **Language.** Confirm the flow works in every language Northstar already supports, not just English. Don't ship until translations are reviewed by native speakers, because tone matters more in a disruption flow than in a marketing one.

### Trust

- **Default-on support.** Pre-selecting hotel and meal credit is intentionally loss-averse, but it must be **honestly available** — never pre-checked for a user who doesn't qualify. If qualification is conditional, replace the checkbox with a one-tap "Check if I qualify" action.
- **No fare difference during recovery.** Disruption is not the moment to upsell. Reintroducing fare differences would feel exploitative and likely drive calls, not reduce them.
- **Always-visible agent link.** Even one screen without a "Talk to an agent" path will spike calls, because the user assumes the option has been taken away.
- **Explainable recommendations.** Replace "Recommended" with the specific reason ("Earliest arrival"). Otherwise the user can't audit the suggestion and defaults to distrust.
- **Don't hide options to look better.** If standby is a real option, keep it visible — but explain it. Removing it to simplify the page would be a dark pattern dressed as minimalism.
- **Honest "Done" state.** The confirmation must reflect what's actually settled (rebooked + hotel) and what isn't (e.g., weather risk on the new flight). Overpromising resolution is what creates the next call.

---

## 6. Experiment Plan

A simple A/B with a clear primary metric and explicit guardrails.

**Hypothesis.** Rewriting the recovery flow around cause + entitlements, with rebooking as the default and a usable confirmation, will reduce inbound support calls per canceled-flight event without reducing the share of travelers who reach a successful recovery.

**Primary metric.**
Calls to support within 4 hours of a cancellation event, per affected traveler.

**Secondary metrics.**
- Self-service completion rate (any chosen option that ends on Screen 4)
- Hotel/meal entitlement uptake among eligible travelers
- Refund vs. rebooking vs. credit split
- Day-after CSAT for travelers in the experiment
- Time from SMS to chosen option

**Guardrail metrics (must not regress).**
- Refund rate (don't want to silently push everyone into rebooking)
- Eligible-but-unclaimed hotel rate (don't want hidden entitlements)
- Accessibility complaints / agent-handoff rate from assisted travelers
- App crash rate and Screen 4 load time on low-bandwidth networks

**Design.**
Randomize at the cancellation-event level (not the user level) so every traveler on the same flight gets the same experience. Split 50/50 between current flow and new flow. Stratify by route, time of day, and disruption cause so the comparison is honest.

**Duration.**
Long enough to capture enough cancellations across causes — weather, crew, mechanical — not just calendar weeks. *(Assumption: this is event-rate-limited; the team should calculate the required sample from baseline cancellation volume, which we don't have.)*

**What we won't claim.**
- No invented call-deflection numbers.
- No invented uplift estimates.
- No claim about what specific travelers thought, since we have no user quotes.

**Pre-launch qualitative check.**
Five moderated sessions on a clickable prototype with travelers who have experienced a real overnight cancellation in the last 12 months. Listen specifically for: do they understand what they're owed, do they trust the rebooking suggestion, do they feel they need to call. *(Assumption: research recruitment is feasible inside Northstar's existing UXR ops.)*

**Decision rule.**
Ship if calls per event drop with no regression on guardrails. Hold if calls drop but refund rate also drops materially — that would suggest we're hiding the refund path rather than improving recovery. Roll back if any accessibility guardrail regresses.

---

## Assumptions (collected)

- The business definition of "successful self-service recovery" is rebooking or credit plus owed support, without a follow-up call.
- Hotel, meal, rideshare, and refund entitlements already exist in Northstar policy; nothing new is being invented.
- Offline / shareable confirmation (PDF or static page) is technically feasible.
- User research recruitment via existing UXR ops is feasible.
- Sample size for the experiment is event-rate-limited and must be calculated from baseline cancellation volume not provided in the brief.
- "Crew shortage" is used as the example cause because the scenario states "crew availability"; real copy should reflect the actual policy-approved phrasing.
