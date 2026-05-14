# Northstar Air — Canceled-Flight Recovery (Single-Agent Baseline)

## Executive recommendation

The current flow doesn't fail because of any one screen. It fails because at the moment a tired traveler most needs a plan, the product hands them a tab strip and asks them to construct one. Three changes are load-bearing:

1. **Lead with what's already done for you.** Before showing options, show entitlements — hotel reserved, seats held, bags handled. This is the single largest unlock: it converts a stressful "manage your trip" task into a "confirm the plan we built" task, which is the version most stressed travelers can complete on a phone at 10:48 p.m.
2. **Replace tabs with stacked, named options.** "New flights / Travel credit / Standby" tabs hide three different *outcomes* behind labels that don't carry their consequences. The redesign stacks them with consequence-first copy ("Confirmed when you tap" vs. "Standby is not a confirmed seat") and removes Travel Credit from the default position — picking credit during a disruption is almost always against the user's interest.
3. **Make support visible on every screen.** The business goal is fewer calls, but the dark-pattern way to hit that metric is to hide the call button. We keep it visible everywhere, pair it with a wait estimate, and offer self-routing cues ("Traveling with kids or mobility needs?") so users *opt into* the right channel rather than abandoning into one.

This collapses the experience from five linear screens to a 4-screen flow plus drill-downs, and recovers most of the trust the current flow leaks. [recommendation]

---

## What's wrong with the current flow

Annotated against the brief. [observed from brief]

| Screen | Failure mode | Cost to the user |
|---|---|---|
| SMS | "Schedule irregularity" hides the event; no urgency, no entitlements, no next step. | The user opens the app already anxious, with no anchor. They don't know if this is a 20-minute delay or a missed family event. |
| Trip Status | "Continue" doesn't say what's next; the consequential info is one tap deeper behind "View details". | Stressed users underclick optional links. They reach the options screen still missing context. |
| Recovery Options | Three peer tabs imply three peer outcomes; default tab is Travel Credit. Hotel and meal entitlements are absent here. | The product nudges the wrong default. Travel Credit during disruption is almost always worse for the user than rebooking. |
| New Flights | "Recommended" is opaque. Fare difference appears during disruption. No filters for arrival time, mobility, party size. | The user can't pick on their goal (often: arrive in time for the event). "Recommended" reads as airline interest, not user interest. |
| Support | Hotel and meal credit hidden under "Other policies". | Tired travelers pay out of pocket for things they're entitled to. Erodes trust if discovered later. |
| Confirmation | "Trip updated. Done." | Closes the loop on the system's task, not the user's task. The user still doesn't know which door to walk to. |

The pattern across all of them: the system is talking to itself, not to the person holding the phone. [inferred]

---

## Redesigned flow (4 in-app screens + entry SMS)

The HTML prototype renders these as actual screens. The mapping back to the brief's screens 1–5: we *merge* old Screens 1 + 4 (status + support) into a single status-and-care screen, *merge* old Screens 2 + 3 (options + flights) into a single options screen, and *expand* old Screen 5 (confirmation) into something the user can actually act on offline.

### Entry SMS

Replaces the current "Schedule irregularity on NS482." SMS.

```
Northstar: Your 6:15a flight NS482 to LGA tomorrow
is canceled (crew). We've reserved you a hotel
near DEN and are holding 2 seats on tomorrow's
morning flights — pick one in about 2 minutes:
ns.app/trip/X9F2

Reply HELP to talk to an agent now (24/7).
```

**Design intent.** Names the event in plain language, gives the reason (one word), front-loads the entitlements that exist *before* the user does anything, sets a realistic time expectation (2 minutes, not "manage your trip"), and surfaces the human path as a literal text reply. [recommendation]

### Screen 02 — Status &amp; care plan

Replaces old Screens 1 and 4.

The eyebrow gives trip identity ("Trip X9F2 · DEN → LGA"). The headline is the event: *"Your 6:15 a flight tomorrow is canceled."* A reason chip — *"Crew availability"* — sits in the meta row so it's available but not the headline.

Below that, a single grouped card titled **"What we've already done for you"** with a time-held label ("held until 7:30 a"). Three rows:

- **Hotel reserved · Hampton Inn DEN-Airport** — Free shuttle from Door 6 every 20 min · in your name. Status: **Done**.
- **2 seats held on tomorrow's morning flights** — Confirm one to lock it in · no fare difference. Status: **Choose** (this is the only "your turn" row).
- **Bags will follow your new flight** — Same tag · no recheck unless you change airlines. Status: **Done**.

Below the care card, a persistent support row: *"Talk to a person — 24/7. Average wait tonight: 6 min. Call →"*

Bottom action bar:
- Primary: **Choose your new flight** (amber, large, single decision)
- Ghost: **Take travel credit instead** (visible, never hidden)

### Screen 03 — Held flights &amp; alternatives

Replaces old Screens 2 and 3.

Eyebrow: *"Held in your name · expires 7:30 a tomorrow"*. Headline: *"Two seats are already yours — tap one to confirm."*

Two stacked option cards (not three, not a tab strip). Each card carries:

- **Time-of-day in large numerals** with both departure and arrival times, plus an "NYC time" tag on the arrival so the user can plan against the destination, not the origin.
- **Route + duration + a one-line goal cue.** *"Closest to your original arrival"* vs. *"Later arrival, fewer connections."* No "Recommended" without a reason.
- **Three honest chips:** Seat number held · No fare difference · Same bag tag.
- **Flight-level detail rows** (NS214 + NS118 timing, layover note).
- **CTA: "Confirm this flight."** Tapping is the commitment — there is no extra confirmation step.

Below the two cards, a collapsed disclosure **"Other ways to recover · 3 options"** that contains the alternatives we don't want to bury but also don't want to push:

- Search all DEN → LGA flights — "Any time tomorrow, including other airlines we partner with. We'll cover the rebooking."
- Standby on tonight's last DEN → LGA (11:55 p) — *"14 open seats right now. Standby is not a confirmed seat — if it doesn't clear, you'll fly tomorrow."*
- Take travel credit instead — *"Only choose this if you no longer need to fly."*

A trust note: *"You won't be charged a fare difference for any of these. We'll text you a copy of whatever you pick."*

A second support row, framed for the cases where call is the better channel: *"Traveling with kids or mobility needs? An agent can lock in a better fit fast."*

### Screen 04 — Confirmed · what happens next

Replaces old Screen 5.

Eyebrow chip: ✓ Locked in · seat 14C. Headline: *"You're flying at 9:05 a tomorrow."*

A high-contrast new-flight card shows the route as DEN 9:05a → ORD 12:01p → LGA, with arrival pill "Arrives LGA Terminal B · 3:12 p NYC time".

Then **"Your night, step by step"** — a vertical timeline with the *user's* next actions, not the system's:

- **Now · 10:49 p:** Walk to Door 6, level 5. (Free Hampton Inn shuttle, every 20 min until 1 a. Look for the navy minibus.)
- **Tomorrow · 6:30 a:** Shuttle back to DEN · check in by 7:30 a. (Hotel breakfast opens at 5:30 a — grab-and-go bag available at the desk.)
- **9:05 a · NS214:** Boarding from Gate B22. (Seat 14C, aisle. Gate may move — we'll text you any change.)
- **12:01 p Chicago · ORD:** 38 min layover · Gate F11. (Same terminal, same concourse.)
- **3:12 p NYC · LGA:** Arrive Terminal B. (Your bag will be on belt B3. If it's not there in 20 min, tap the trip — we'll start tracing.)

Trust note: *"We'll text any change to this trip from 1-800-NS-ALERT. Forward that number to family if they're tracking you."*

Bottom action bar:
- Primary: **Save trip offline · Wallet & PDF** (low-bandwidth concession; the brief explicitly names this user state)
- Secondary: **Plans changed? Switch flight** (escape hatch — no dead ends)
- Ghost: **Call Northstar · 1-800-NS-HELP** (humans always available)

### Screen 05 — Hotel detail (drill-down)

Reached from Screen 02's hotel row. Shows that the airline's promise is real:

- Map block with pin near DEN.
- Hotel name + address (Hampton Inn DEN-Airport, 4685 Airport Way) + distance (1.4 mi · 6 min by shuttle).
- A four-cell receipt grid: Confirmation #HMP-7F2J9C · Check-in: Tonight, ready now · Check-out: Tomorrow, 11:00 a · Paid by: Northstar Air.
- **"What's covered tonight"** list: room (with a free room-change option for family/2-bed), $18 meal credit with a literal code, free toothbrush/charger/child basics at the front desk, late-checkout option if the user takes the 1:40 p flight.
- Trust note: *"If the front desk asks for a card, show them this confirmation. Northstar is paying — you should not be charged."*

Actions:
- Primary: **Get shuttle directions · Door 6**
- Secondary: **Decline hotel · I have other plans** (user agency, not a trap door)
- Ghost: **Hotel issue? Call Northstar**

---

## Recommended copy (verbatim)

### SMS

> Northstar: Your 6:15a flight NS482 to LGA tomorrow is canceled (crew). We've reserved you a hotel near DEN and are holding 2 seats on tomorrow's morning flights — pick one in about 2 minutes: ns.app/trip/X9F2
>
> Reply HELP to talk to an agent now (24/7).

### Screen 02 — Status & care plan

- Eyebrow: **Trip X9F2 · DEN → LGA**
- Headline: **Your 6:15 a flight tomorrow is canceled.**
- Meta: NS482 · Thu, May 15 · *Reason: crew availability*
- Care card label: **What we've already done for you · held until 7:30 a**
- Row 1: **Hotel reserved · Hampton Inn DEN-Airport** — *Free shuttle from Door 6 every 20 min · in your name* · ✓ Done
- Row 2: **2 seats held on tomorrow's morning flights** — *Confirm one to lock it in · no fare difference* · Choose →
- Row 3: **Bags will follow your new flight** — *Same tag · no recheck unless you change airlines* · ✓ Done
- Support row: **Talk to a person — 24/7. Average wait tonight: 6 min.** [Call]
- Primary CTA: **Choose your new flight**
- Ghost CTA: **Take travel credit instead**

### Screen 03 — Held flights

- Eyebrow: **Held in your name · expires 7:30 a tomorrow**
- Headline: **Two seats are already yours — tap one to confirm.**
- Card 1: **9:05 a → 3:12 p NYC** · DEN → ORD (1 stop) → LGA · 7h 7m · *Closest to your original arrival* · chips: *Seat 14C held*, *No fare difference*, *Same bag tag* · CTA: **Confirm this flight**
- Card 2: **1:40 p → 7:48 p NYC** · DEN → LGA · Nonstop · 4h 8m · *Later arrival, fewer connections* · chips: *Seat 22A held*, *No fare difference*, *Same bag tag* · CTA: **Confirm this flight**
- Disclosure label: **Other ways to recover · 3 options**
  - **Search all DEN → LGA flights** — *Any time tomorrow, including other airlines we partner with. We'll cover the rebooking.*
  - **Standby on tonight's last DEN → LGA (11:55 p)** — *14 open seats right now. Standby is not a confirmed seat — if it doesn't clear, you'll fly tomorrow.*
  - **Take travel credit instead** — *Only choose this if you no longer need to fly. Worth roughly the cash you paid; valid 1 year.*
- Trust note: *You won't be charged a fare difference for any of these. We'll text you a copy of whatever you pick.*
- Support row: **Traveling with kids or mobility needs? An agent can lock in a better fit fast.** [Call]

### Screen 04 — Confirmation

- Eyebrow chip: **✓ Locked in · seat 14C**
- Headline: **You're flying at 9:05 a tomorrow.**
- Flight card: **DEN 9:05 a → ORD 12:01 p → LGA** · NS214 + NS118 · 1 stop · 38 min layover · 7h 7m · *Arrives LGA Terminal B · 3:12 p NYC time*
- Timeline header: **Your night, step by step**
- Trust note: *We'll text any change to this trip from 1-800-NS-ALERT. Forward that number to family if they're tracking you.*
- Primary CTA: **Save trip offline · Wallet & PDF**
- Secondary CTA: **Plans changed? Switch flight**
- Ghost CTA: **Call Northstar · 1-800-NS-HELP**

### Screen 05 — Hotel detail

- Headline: **Hampton Inn DEN-Airport**
- Address line: *4685 Airport Way, Denver CO 80249 · 1.4 mi from your terminal · 6 min by shuttle*
- Section: **What's covered tonight**
  - Room for 1 (king bed). Need 2 beds or extra room? *Change room — no charge.*
  - $18 meal credit at the lobby café until 1 a · code NS-DEN-X9F2.
  - Toothbrush, charger, child basics free at the front desk — just ask.
  - Late checkout by 11 a if you take the 1:40 p flight instead.
- Trust note: *If the front desk asks for a card, show them this confirmation. Northstar is paying — you should not be charged.*
- Primary CTA: **Get shuttle directions · Door 6**
- Secondary CTA: **Decline hotel · I have other plans**

---

## Accessibility risks and mitigations

| Risk | Mitigation in this design | WCAG criterion |
|---|---|---|
| Tired, low-vision user on a dim phone at night can't read fare/time numbers. | All body text ≥ 4.5:1, large text ≥ 3:1. Numerals use tabular-nums so they don't shift. Dark-mode tokens are not just inverted — they're independently tuned for low-light reading. | 1.4.3, 1.4.6 |
| Screen-reader user can't tell *held* vs *confirmed* if status is color-only. | Every chip carries text ("Seat 14C held", "✓ Locked in"). The care card uses semantic list structure; row status is a textual badge, not a color. | 1.4.1, 1.3.1 |
| Tap targets too small on a stressed thumb. | All interactive elements ≥ 44×44 CSS px including back/menu icons. Primary CTAs are 48px tall. | 2.5.5 |
| Motion-sensitive user gets nauseous from "we've already done X" flourishes. | `prefers-reduced-motion` zeroes out transitions and animations. The only motion in the prototype is a focus ring; that stays. | 2.3.3 |
| Keyboard-only user can't see where focus is. | Visible 2px focus ring on every interactive element, 2px offset. Tab order matches reading order. | 2.4.7, 2.4.3 |
| Disclosure (`Other options`) hidden from screen readers or keyboard. | Uses native `<details>/<summary>` — keyboard- and AT-accessible by default. Summary text describes the count of items. | 4.1.2 |
| User in low-bandwidth area can't reload the confirmation when they reach the gate. | Screen 04 ships a "Save trip offline · Wallet & PDF" primary CTA so the itinerary survives connectivity loss. | (not a WCAG criterion — but it's the disability the brief explicitly names: "low bandwidth") |
| Color-blind user can't distinguish ok/hold/info chips. | Each chip pairs color with an explicit text label and shape (dot + word). No state depends on color alone. | 1.4.1 |
| User on a screen reader gets the wrong mental model from "Recommended" without reason. | Removed the unexplained "Recommended" label entirely. Replaced with one-sentence rationales the AT will read out: "Closest to your original arrival" vs. "Later arrival, fewer connections." | 3.3.2 (in spirit — provides instructions where they reduce error) |

---

## Trust and behavior risks and mitigations

| Risk | Mitigation |
|---|---|
| **Dark-pattern: hiding humans to drop call volume.** The business goal is fewer calls, and the cheap way to hit it is to bury the phone number. | The call CTA is visible on every screen, paired with a live wait estimate and a self-routing cue ("Traveling with kids or mobility needs?"). The metric we'd defend is "calls per disruption that *didn't* need self-service" — not raw call volume. |
| **Dark-pattern: pushing travel credit during disruption.** Default-tabbing into Credit (as the current flow does) nudges a stressed user toward the option that's worst for them and best for the airline's deferred revenue. | Travel credit is demoted to a disclosure with explicit copy: *"Only choose this if you no longer need to fly."* No pre-selection. |
| **Dark-pattern: false scarcity.** "Held until 7:30 a" creates urgency — if it isn't real, it's manipulation. | We only state holds we actually intend to honor, and the prototype names a concrete release time (7:30 a) rather than vague "limited time." [assumption: operationally enforceable; if not, this copy must change.] |
| **Trust erosion: front desk asks the user to pay.** A hotel covered "by the airline" that still asks for a card at check-in is a common real-world failure that breaks the implicit promise. | The hotel screen includes the verbatim line: *"If the front desk asks for a card, show them this confirmation. Northstar is paying — you should not be charged."* This pre-empts the failure mode and tells the user what to do if it happens. |
| **Decision regret.** A confirmed flight after midnight may feel wrong after a minute of thought. | Confirmation screen has **Plans changed? Switch flight** as a persistent secondary action — no penalty, no dead end. Combined with hold release of the *other* held seat (not modeled in prototype) so re-switching has a real outcome. |
| **Anchoring on the wrong arrival time.** Origin-time numerals can mislead a user planning a 3 p.m. family event in NYC. | Every option pairs the departure time with the destination-time arrival, explicitly labeled "NYC time." |
| **Implied entitlement vs. explicit entitlement.** "We've already done X" is a strong promise that, if not actually executed, becomes a churn event. | Each "Done" row links to a real receipt (hotel detail, bag confirmation) so the promise is auditable. We do not display "Done" until the underlying system confirms — design contract with the back end. [assumption] |

---

## Experiment plan

Each experiment is one change, one hypothesis, one primary metric, one guardrail, one exit rule. Tests gated to disruption events tagged *cancellation* (not weather-day mass events, which behave differently).

### E1 — Lead with entitlements (Screen 02 redesign)

- **Hypothesis.** Presenting hotel/seats-held/bags up front before asking the user to "choose" reduces support call rate during the recovery window.
- **Primary metric.** Support-call rate within 60 minutes of SMS, among users who open the link.
- **Guardrail.** Self-service successful-rebooking rate ≥ control (we don't want to drop calls by also dropping completions).
- **Sample / duration.** Powered for a 15% relative reduction at α=0.05, 80% power. Estimated run length: 3–4 weeks across cancellation events. [assumption — depends on weekly disruption volume]
- **Exit rule.** Stop early and roll back if call rate goes *up* by ≥5% at the midpoint check, or if NPS for affected travelers drops ≥3 points in weekly survey.

### E2 — Replace tabs with stacked options + remove credit default (Screen 03)

- **Hypothesis.** Travelers who reach the options screen complete a confirmed rebooking more often when the options are stacked and consequences are explicit, vs. tabbed with Travel Credit defaulted.
- **Primary metric.** Rate of confirmed rebooking (any flight) per session reaching the options screen.
- **Guardrail.** Share of users who eventually take travel credit must not *fall* below a floor — credit is the right answer for *some* users (their trip is no longer needed). Floor: 80% of historical baseline credit rate. If credit rate falls below that, we're either over-nudging or removing legitimate optionality.
- **Sample / duration.** Same volume basis as E1. Estimated 3 weeks.
- **Exit rule.** Roll back if confirmed-rebook rate drops, or if post-trip refund requests rise by ≥10% (signal that we pushed people into flights they didn't actually want).

### E3 — "What happens next" timeline on confirmation (Screen 04)

- **Hypothesis.** A concrete timeline on the confirmation screen reduces post-confirmation support contacts ("where do I go?", "did the hotel actually get booked?", "what's the gate?").
- **Primary metric.** Support contacts within 12 hours of confirmation among users who completed self-service rebooking.
- **Guardrail.** Show-up rate at the new flight stays ≥ control. We do not want a clearer screen that somehow reduces follow-through. (This is a low-risk guardrail but worth instrumenting.)
- **Sample / duration.** 2–3 weeks; downstream contact behavior is the lagging measurement.
- **Exit rule.** Roll back if support contacts rise (suggests timeline introduces more confusion than it removes) or if hotel-arrival rate at the partner property drops ≥5% (suggests the directions are wrong).

### E4 — SMS rewrite (entry message)

- **Hypothesis.** A plain-language SMS that names the event, the entitlements already arranged, and a 2-minute time expectation increases the open rate of the trip link.
- **Primary metric.** Click-through rate on the trip link within 30 minutes of SMS.
- **Guardrail.** Reply-to-SMS rate ("HELP" replies and inbound calls within 10 minutes) — we don't want a clearer SMS to *unnecessarily* drop the human channel for travelers who legitimately need it. Hold replies/calls within ±15% of control.
- **Sample / duration.** Highest-volume test; could complete in 1–2 weeks.
- **Exit rule.** Roll back if click-through goes down, or if downstream confirmed-rebooking rate drops (the click-through went up but the experience didn't deliver).

### E5 — "Save trip offline" adoption

- **Hypothesis.** A visible offline-save action on the confirmation screen is used by enough travelers to justify the development cost, and predicts lower at-airport support contacts.
- **Primary metric.** Adoption rate of "Save trip offline · Wallet & PDF" among confirmed rebookings.
- **Guardrail.** No regression on Screen 04 completion (the secondary CTAs shouldn't compete with primary).
- **Sample / duration.** Read-only experiment for the first 2 weeks; if adoption clears a 15% floor, instrument downstream at-airport support contacts. [assumption: 15% floor is the right cost/benefit threshold for engineering effort here]
- **Exit rule.** If adoption is below the floor *and* downstream contacts don't drop for adopters, retire the feature in a quiet rollback.

---

## Assumptions called out

Where the design extends past what's strictly given in the brief:

- **Reason chip says "Crew availability."** [observed from brief — the brief states the cancellation is for crew availability.]
- **"Held until 7:30 a"** as a seat-hold release time. [assumption — operationally plausible but must be confirmed with ops before this copy ships.]
- **Hotel + meal entitlements** exist for this disruption. [inferred — the current flow has them buried under "Other policies," so they exist; we're surfacing them, not inventing them.]
- **"6 min" support wait estimate.** [assumption — would be a live value from the contact-center system in production. The prototype shows the *pattern* of pairing the CTA with an honest live estimate; the literal number isn't a claim.]
- **Hampton Inn DEN-Airport** as the specific hotel partner. [inferred / illustrative — the brief is fictional; a real implementation would surface the actually-booked property.]
- **"1-800-NS-ALERT"** and **"1-800-NS-HELP"** as separate inbound numbers. [inferred / illustrative — the design intent is that outbound texts come from a number the user can forward to family without exposing the support line; the actual numbering plan is operational.]
- **Confirmation-screen timeline assumes the gate, layover, and bag-belt info are available to the trip-status system at confirmation time.** [assumption — gate may not be assigned at 10:49 p.m. for a 9:05 a flight. The design contract is: show what you know, name the rest as "we'll text you any change." The prototype shows the all-information-available case; a real implementation must gracefully degrade.]

No metrics, user quotes, airline policies, or legal obligations are invented. Where the prototype shows a specific minute or address, treat it as illustrative of the *level of concreteness* the design calls for, not as a fact about Northstar.

---

## Run metadata

| Field | Value |
|---|---|
| Branch | `experiment/northstar-baseline-20260514-0059` |
| Starting commit | `80e800076ed5205ebd1df6922d866073096e0a0c` (short: `80e8000`) |
| Start time (UTC) | `2026-05-14T07:05:26Z` |
| End time (UTC) | `2026-05-14T07:13:25Z` (~8 min wall time) |
| Model | `claude-opus-4-7` (1M context window) |
| Mode | Single-agent baseline · clean room |
| Clean-room checks | **Passed.** `git rev-parse --short HEAD` = `80e8000` (≥ required); `find demo-output -type f ! -name .gitkeep -print` printed nothing at run start. No prior Northstar outputs, demo branches, or PR #2 contents were inspected. |
| Agent delegation used | None. Single Claude session; no subagent calls. |
| Artifacts | `demo-output/single-agent-baseline/index.html` (working prototype), `demo-output/single-agent-baseline.md` (this doc). |
