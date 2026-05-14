# Canceled-flight recovery — meeting-ready recommendation

## Executive recommendation

A 10:46 p.m. cancellation text is the worst time to ask a tired person to read a menu of policies. The redesigned flow makes one job easy at every step: understand what happened, pick a path, ask for help if you need it, and leave with something you can show the gate at 4:30 a.m. We move from five screens of policy administration to five screens of decision support — same step budget, very different posture.

Three system-level moves do most of the work:

1. **The SMS does its own job.** Plain-language event, plain-language next step, and a single tap back in. The text replaces "schedule irregularity" with "Your 6:15 a.m. flight tomorrow was canceled."
2. **The Orient screen replaces the three-tab pile.** It names what happened, shows the recovery paths flat (not buried in a tab default), and puts "Talk to a person" and tonight's hotel/meal options on the same screen — not behind a collapsed FAQ.
3. **The Confirmation becomes a takeaway, not a receipt.** Everything the traveler will need in the next twelve hours lives on one screen with a recap that doesn't depend on signal.

We did *not* invent compensation, refund eligibility, hotel amounts, credit expiration windows, callback wait times, or baggage-handling promises. Every operational claim in the product UI is either present in the brief, dynamic and labeled as a placeholder, or moved into this document as a [recommendation].

## Redesigned flow (5 screens)

> Labels: [observed from brief] · [inferred from brief] · [assumption] · [recommendation]

### Screen 1 — SMS notification (entry)

The text is the first screen of the experience whether we like it or not. [observed from brief]

**Plain-language event, plain-language action, single open path.** [recommendation]

- The "schedule irregularity" wording is replaced with the actual event. [recommendation] [observed from brief]
- The text names the three things the user can now do (pick a new flight, request a hotel for tonight, talk to a person) without promising any specific outcome. [recommendation]
- "Northstar Air" sender identity sits in the SMS card, not the message body. [recommendation]

Verbatim copy is in the **Recommended copy** section below.

### Screen 2 — Orient

Replaces the existing "Trip Status" screen and the three-tab "Recovery Options" screen with a single screen that sets context and exposes the paths flat. [recommendation]

- Eyebrow: `Canceled · NS482` to anchor the user in the right trip without a vague "schedule" framing. [recommendation] [observed from brief]
- Cancellation reason is shown as **"Reason given: flight crew unavailable"**, framing it as what Northstar reported rather than as adjudicated fact. [recommendation] [inferred from brief]
- Three paths are presented as a list, not tabs, with one-line hints for the *consequence* of each — not just its name. The default selected path is "Pick another flight" because the traveler is mid-trip and has a next-day commitment. [recommendation] [observed from brief]
- "Talk to a person" sits in the top bar on this and every subsequent screen — a deliberate behavioral choice. We are not trying to suppress calls by hiding the option; we are trying to make the self-serve flow good enough that the call is a real choice rather than a fallback. [recommendation]
- A "Tonight" card on the same screen previews hotel and meal options. The card uses **conditional language** ("may be offered", "see what's available to you") because the brief does not specify eligibility rules and we will not invent them. [recommendation]

### Screen 3 — Pick another flight

Replaces the existing "New Flights" list. [observed from brief]

- Default sort: **arrives first**. This replaces an unexplained "Recommended" tag. [recommendation]
- "Arrives soonest of these" replaces "Recommended" on the top card, because the user can see *why* it's at the top instead of trusting an opaque label. [recommendation]
- Fare differences are labeled per card with a `{fare-difference}` placeholder; we do not hardcode the $84 from the brief into the UI, because that number is example data, not policy. [recommendation] [observed from brief]
- Arrival times and layover cities are `{system-supplied}` placeholders. We refuse to invent arrival times or layover cities not in the brief. [recommendation]
- Filter chips for **Arrives first, Nonstop only, My travel party, Aisle / mobility** address the brief's call-out that filters for arrival time, direct flight, mobility needs, and travel party are missing. [observed from brief]
- A muted secondary button exposes standby with the explicit hedge **"seat not guaranteed"** — addressing the brief's concern that standby might sound equivalent to a confirmed rebooking. [observed from brief]

### Screen 4 — Tonight (support)

Replaces the existing collapsed "Other policies" FAQ. [observed from brief]

- Hotel and meal support are surfaced as their own cards with **conditional copy** — "may be offered", "if a meal credit is offered" — and dynamic amount/terms shown before the user accepts. [recommendation]
- A travel-party card lets the user declare family / accessibility needs (accessible room, same row, room for a service animal) so the rebooking and hotel options can match. This addresses the brief's family / multi-passenger and screen-reader constraints. [recommendation] [observed from brief]
- "Talk to a Northstar person" is a full card with three live-availability actions: **Call (with current wait), Request callback, Chat**. All times and availability are dynamic — we never hardcode a wait time or a callback window. [recommendation]

### Screen 5 — Confirmation

Replaces the existing "Trip updated · Done" minimal confirmation. [observed from brief]

- A summary card lists the four things a tired traveler actually needs at 4:30 a.m.: **new flight, tonight's hotel, bag status, and how to reach a person if plans change again**. [recommendation]
- All operational fields (flight number, layover city, arrival time, seat, hotel name) are `{system-supplied}` placeholders. We did not invent NS-numbers, airports, or amounts. [recommendation]
- A "Text or email me a recap" secondary action gives a low-bandwidth backup. We do not promise a specific wallet pass channel in the UI, because the brief does not specify what backup channels exist. [recommendation]
- `aria-live="polite"` on the confirmation subheader so screen-reader users get the state change announced. [recommendation]

## Main issues found in the current flow

1. **The SMS does nothing useful.** "Schedule irregularity on NS482" hides the event, has no next step, no reassurance, and no path. A tired person at 10:46 p.m. has to assume the worst. [observed from brief]
2. **The Trip Status screen withholds the choices.** "Your itinerary has changed" + "Continue" forces a tap before the user even knows what options exist. [observed from brief]
3. **The Recovery Options tabs are mis-defaulted.** Travel credit is the default, but a traveler with a next-day commitment is not most likely to want a credit. The default reflects business preference, not user goal. [observed from brief] [inferred from brief]
4. **"Recommended" is unexplained.** It pushes a flight without giving the user a reason to trust the push. Under stress, that reads as manipulation rather than help. [observed from brief]
5. **Hotel and meal entitlements are behind a collapsed FAQ.** This is a low-trust pattern at the moment of highest need — and a likely cause of the abandonment-then-call behavior the business says it sees. [observed from brief]
6. **Standby may read as equivalent to a confirmed rebooking.** No hedging language; no expectation setting. [observed from brief]
7. **The Confirmation says nothing useful.** No summary of new flight, no hotel, no bag, no support path, no offline backup. The user has to remember everything. [observed from brief]
8. **There is no visible escape hatch.** "Talk to a person" never appears in the flow as described; the user's only way out is to leave the app and call. [inferred from brief]

## Recommended copy (verbatim)

**SMS body**
> Your 6:15 AM flight tomorrow was canceled. Flight crew unavailable. Open the app to pick a new flight, request a hotel for tonight, or talk to a person — your options are ready.

**Orient screen header**
> Your 6:15 AM flight to New York was canceled.
> Reason given: flight crew unavailable. Here's what you can do from here.

**Path labels and hints**
> Pick another flight
> See the Northstar flights to New York available to you. You pick the seat and confirm.

> Hold the trip as travel credit
> Don't fly now. The amount and terms of the credit are shown before you confirm.

> Try standby on another flight
> No guaranteed seat. You'd wait at the gate and get on only if space opens.

**Tonight card (orient screen)**
> Tonight
> Hotel and meal support may be offered for tonight. Tap below to see what's available to you and the terms.

**Flight card explanation (replaces "Recommended")**
> Arrives soonest of these
> Of the flights shown here, this one gets you to New York earliest.

**Standby disclosure**
> See standby options — seat not guaranteed

**Support screen ("Talk to a Northstar person")**
> Pick the way that suits you. Wait times and callback availability shown live before you commit.
> Call — see current wait · Request callback · Chat

**Confirmation header**
> Your trip is updated.
> A copy is saved in this app so you can show it at the airport without re-opening anything.

**Confirmation "If plans change again"**
> One tap to a Northstar person
> Current wait and callback availability shown before you commit.

**Confirmation footer**
> Recap kept in the app · text or email a copy below
> Buttons: "Done" / "Text or email me a recap"

## Accessibility and trust risks (with mitigations)

| Risk | Why it matters | Mitigation |
|---|---|---|
| Screen-reader users miss the state change at confirmation | A silent state change after a stressful decision = re-checking everything | `aria-live="polite"` on the confirmation subhead; semantic `role="status"` on the offline-copy line [recommendation] |
| Color-only state signaling | Users with low vision, color-blindness, or in glare can't distinguish "soonest" from "fare difference" | Every status uses an icon or word in addition to color (e.g., "Arrives soonest", "+{fare-difference}", "Seat not guaranteed") [recommendation] |
| Touch targets too small for a tired thumb in a phone case | Mis-taps under stress feel like the app is fighting you | All primary tap targets meet a 44 px minimum height; spacing prevents adjacent-tap mistakes [recommendation] |
| Focus state lost on dark backgrounds | Keyboard / switch users can't see where they are | Custom `:focus-visible` ring in warm yellow that survives both color schemes [recommendation] |
| Low bandwidth at the airport | A retry against a flaky network can lose the user's confirmation | Recap is kept in-app; user can opt into a text or email copy. We do not hardcode a wallet-pass channel because the brief doesn't say one exists. [recommendation] |
| Dark pattern: defaulting to travel credit | Pushes the user away from a rebooking the business is on the hook to provide | Paths are presented flat, not as tabs with a default. The first path is "Pick another flight". [recommendation] |
| Dark pattern: hidden refund / hotel / meal eligibility | Under stress, hidden entitlements read as bad faith | Hotel and meal cards appear on the orient screen *and* get a dedicated screen. Eligibility shown dynamically, never promised in static copy. [recommendation] |
| Coercive "Recommended" label | An unexplained nudge under stress is manipulation, not help | Replace with "Arrives soonest of these" + an explanation sentence. The label states a fact the user can verify on the card. [recommendation] |
| Standby framing collapse | "Standby" might read as equivalent to a confirmed rebooking | The standby action is a secondary button with the disclosure "seat not guaranteed" inline; on the orient screen it is described as "You'd wait at the gate and get on only if space opens." [recommendation] |
| Compensation / policy invention | Inventing wait times, credit windows, or compensation rules creates trust collapse the moment reality diverges | The product UI ships zero hardcoded operational facts beyond what the brief supplies. Every variable is a `{system-supplied}` placeholder, with the values shown inline before the user accepts. [recommendation] |
| Family / multi-passenger and accessibility needs invisible | Brief explicitly names these as in-scope | "Update travel party" support card on the Tonight screen captures these and feeds rebooking + hotel matching. [recommendation] [observed from brief] |

## Scoped gaps (named, not solved)

- **Refund as a fourth path.** A refund option for an airline-caused cancellation is plausible and common, but the brief does not establish refund eligibility for this scenario, so we did not ship "Request a refund" in the product UI. If Northstar's legal/policy team confirms eligibility for this cause code, adding it as a fourth path on the Orient screen is a small change. [recommendation] [scoped gap]
- **Baggage handling.** The brief does not specify whether bags get re-tagged automatically. The Confirmation screen shows a bag-status line without promising the bag will be moved; if Northstar's bag system supports an automatic transfer, the copy can be sharpened. [recommendation] [scoped gap]
- **Multi-passenger rebooking.** The product flow allows the user to declare a travel party so options match, but the brief does not specify the rebooking system's group-keep behavior. This is named on the Tonight screen but the underlying logic is out of scope for this redesign. [recommendation] [scoped gap]

## Experiment plan

Each experiment has a hypothesis, a primary metric, a guardrail, and an exit rule.

### Experiment 1 — SMS rewrite

- **Hypothesis:** Replacing "Schedule irregularity on NS482" with the redesigned plain-language SMS will increase the share of recipients who open the app within 15 minutes and reach the orient screen.
- **Primary metric:** Open-and-arrive rate on the orient screen within 15 minutes of SMS send.
- **Guardrail:** No increase in inbound support calls within 60 minutes of SMS send. Per-SMS unsubscribe / opt-out rate flat or down.
- **Exit rule:** Pull the new SMS if call volume rises against control or if open-rate is flat after 2 weeks of statistically meaningful traffic. [recommendation]

### Experiment 2 — Flat paths vs. tabbed recovery options

- **Hypothesis:** Replacing the three-tab recovery screen with a flat list of paths defaulting to "Pick another flight" will increase the share of cancellations that result in a confirmed rebooking without a support contact.
- **Primary metric:** Self-serve confirmed-rebooking rate per cancellation event.
- **Guardrail:** Time-to-first-action on the recovery screen does not increase by more than 10%. Refund / credit volume does not collapse (we are not trying to hide credit, only un-default it). [recommendation]
- **Exit rule:** Roll back if time-to-action rises >10% sustained, or if credit volume drops in a way that suggests the user couldn't *find* it rather than chose not to use it. [recommendation]

### Experiment 3 — Tonight card on orient screen vs. collapsed FAQ

- **Hypothesis:** Surfacing hotel and meal options on the orient screen will reduce inbound support calls that are *just* asking what hotel/meal benefits the user has.
- **Primary metric:** Share of inbound support contacts within 90 minutes of a cancellation whose primary topic is "what am I owed tonight?" (tag rate).
- **Guardrail:** Hotel/meal eligibility accept rates remain consistent with prior trend (we are not trying to *push* uptake, only to reveal availability). Customer satisfaction (CSAT) on cancellation events does not drop. [recommendation]
- **Exit rule:** Roll back if hotel/meal contacts don't fall after 30 days of meaningful cancellation volume, or if CSAT drops on the cancellation cohort. [recommendation]

### Experiment 4 — Confirmation as takeaway

- **Hypothesis:** A confirmation screen with new flight, hotel, bag status, and a one-tap path to a person will reduce return-trip support contacts in the 12 hours after rebooking.
- **Primary metric:** Repeat support contact rate per cancellation event within 12 hours after rebooking.
- **Guardrail:** Self-reported confidence in the new plan (one-question post-confirmation survey) holds or rises against control. [recommendation]
- **Exit rule:** Roll back if repeat contacts don't fall after 30 days, or if survey confidence drops, suggesting the takeaway answers the wrong questions. [recommendation]

## Provenance note on the prototype

The companion HTML prototype is a static walk of the five screens. It is intentionally non-interactive beyond filter-chip and path-selection state, because the goal is to communicate the design posture, not to simulate the backend. Every claim in user-visible copy was audited for operational provenance before sealing; see the accessibility-and-trust table and scoped-gaps section above for what was deliberately not promised.
