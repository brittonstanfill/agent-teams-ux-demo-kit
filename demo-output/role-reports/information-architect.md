# Information Architect Report: Canceled-Flight Recovery

## 1. User-Job Spine

Ordered by urgency for a tired, mobile-only traveler at 10:46 p.m. with a morning family event:

1. **"Tell me plainly what happened and what it means for tomorrow."** (observed from brief: user does not currently know the flight is canceled vs. delayed; "schedule irregularity" hides the event)
2. **"Get me on a flight that still makes the event — or tell me that is not possible."** (inferred from scenario: arrival-time is the success criterion, not fare or loyalty)
3. **"Make sure I have a bed tonight and food, without paying out of pocket if I do not have to."** (observed from brief: hotel and meal support are entitlements buried in FAQ)
4. **"Leave with a record I can show at the gate or read offline if my battery dies."** (inferred from brief constraints: low bandwidth, stress, mobile-only)

## 2. Revised Screen Sequence (5 screens)

### Screen 1 — Status & Cause
- **Primary decision:** Do I trust this and continue, or call?
- **Hierarchy:**
  1. Plain-language statement: flight canceled, cause, route, original time
  2. What we are doing for you next (rebook + support check)
  3. CTA + secondary "Call support" link
- **Primary CTA:** `See your options`
- (recommendation)

### Screen 2 — Choose Your Path
- **Primary decision:** Rebook on Northstar, take credit, or get a refund.
- **Hierarchy:**
  1. **Rebook on a Northstar flight** (default, top) — "Get there as soon as we can"
  2. **Request a refund** — "Get your money back; cancel the trip"
  3. **Take travel credit** — "Use later, valid per terms shown at confirmation"
  - Standby is demoted into the Rebook flow as an inline option, not a peer tab. (recommendation; brief flags standby-as-peer as a problem)
- **Primary CTA:** depends on path selected; label matches choice (`Find a flight`, `Start refund`, `Take credit`)

### Screen 3 — Pick a Flight (only on Rebook path)
- **Primary decision:** Which replacement flight fits tomorrow?
- **Hierarchy:**
  1. Filter chips at top: **Arrive by**, **Nonstop only**, **Morning / Afternoon / Evening**
  2. Sort default: **earliest arrival** at destination (recommendation; aligns to job #2)
  3. Each card shows: depart time, arrive time, stops, duration. No fare-difference badge during disruption rebooking. No unexplained "Recommended" tag. (observed from brief)
- **Primary CTA on card:** `Hold this flight`

### Screen 4 — Tonight's Support
- **Primary decision:** Do I need a hotel or meal help tonight?
- **Hierarchy:**
  1. Eligibility check result — shown plainly: either "You may be eligible for hotel and meal support tonight" or "Hotel and meal support is not available for this cause." (recommendation; framed without inventing policy)
  2. If eligible: how to claim (in-app request → confirmation arrives by SMS/email), what to do if no response in N minutes — call support (assumption: backend supports an async eligibility check)
  3. Always-visible: `Call support` link
- **Primary CTA:** `Request hotel & meal support` OR `Continue without support` if not eligible

### Screen 5 — Confirmation & Offline Record
- **Primary decision:** Save / screenshot / share.
- **Hierarchy:**
  1. New flight summary: confirmation code, depart/arrive times, gate TBD note, baggage status
  2. Support status: hotel request submitted / not eligible / declined
  3. Next steps checklist: check-in window, what to do if plans change, support number
  4. `Save as PDF` / `Send to email` / `Add to wallet`
- **Primary CTA:** `Done — save a copy`

## 3. Copy Constraints (Visual Designer must follow)

- **Plain language only.** Say "canceled" not "schedule irregularity," "no longer operating," or "itinerary changed." (observed from brief)
- **Do not name a dollar amount, hotel brand, meal voucher value, or expiration window** anywhere in screens unless the backend has confirmed and returned it for this specific PNR. (recommendation; brief forbids inventing policy)
- **Do not promise eligibility.** Use conditional framing: "You may be eligible," "depends on the cause of the cancellation and availability tonight." (recommendation)
- **Do not use "Recommended"** without an inline reason ("earliest arrival," "fewest stops"). (observed)
- **No fare-difference badges during disruption rebooking.** Fare delta, if any, is shown at the hold/confirm step with policy text the backend returns — not as a card-level price tag. (observed)
- **Buttons name the outcome,** not the motion. Avoid bare "Continue," "Next," "Done" without object. (observed)
- **Required disclosure on Screen 4:** "Hotel and meal support depends on the cause of the cancellation and what is available tonight. We will tell you what you qualify for before you confirm." (recommendation)

## 4. Entry-Point Copy

**SMS (proposed, recommendation):**
> Northstar: Your 6:15a flight NS482 DEN→LGA tomorrow is canceled (crew shortage). Tap to rebook and check hotel/meal support: [link]. Or call 1-800-XXX.

**Screen 1 header (recommendation):**
> Your 6:15 a.m. flight tomorrow is canceled

**Screen 1 body (recommendation):**
> NS482 DEN to LGA will not operate. The cause is crew availability. We can help you rebook now, and check whether hotel and meal support is available for tonight. If you would rather talk to someone, you can call us.

## 5. Scoped Gaps

- **Family / multi-passenger:** addressed at Screen 3 via filter chip "Seats for [N]" pulled from PNR (recommendation). Group-split handling (some pax rebook, others refund) — **scoped gap**: needs policy clarification.
- **Low bandwidth:** addressed at Screen 5 via offline record (PDF / wallet / SMS summary). Image-light layout is a Visual Designer constraint (recommendation).
- **Screen reader specifics:** addressed structurally — one H1 per screen, decisions in reading order, no information conveyed by color or badge alone. Detailed ARIA patterns are **deferred to interaction/visual handoff** (scoped gap reason: not IA-owned).
- **Refund-seeker path:** first-class peer on Screen 2, not buried. (recommendation)
- **Support visibility:** `Call support` link is persistent in the header across all 5 screens, not only on errors. (recommendation; brief flags hidden help as a trust failure)

## 6. Handoff Note to Visual Designer

Five constraints that must not be violated:

1. **Cause and consequence come before options.** Screen 1 names the cancellation and the cause in plain words before any CTA.
2. **Refund is a peer of rebook and credit on Screen 2.** Do not demote it to a footer link or a "more" menu.
3. **Hotel/meal support is its own screen, not an FAQ.** Eligibility framing is conditional; never assert entitlement the backend has not confirmed.
4. **No invented numbers, brands, or windows.** Dollar amounts, hotel names, voucher expirations, and percentages only appear when returned by the backend for this PNR.
5. **Confirmation must be sharable offline.** Screen 5 is not a dead end — it produces an artifact the traveler can show at a gate with no signal.
