# Information Architect — Northstar Canceled-Flight Recovery

## 1. Revised Flow (Screen-Level)

**SMS (pre-screen, counted as the entry, not one of the 5).**
Decision: tap or not. Leaves with: what happened (cancellation, not "irregularity"), that a seat is already held, and that hotel is covered if needed. *Recommendation.*

**Screen 1 — "Your 6:15 a.m. is canceled. We've held a seat on the 7:10 a.m."**
Decision: keep the held seat, or see other options.
Leaves with: knowledge that a confirmed rebooking already exists, and that hotel + meal support are available tonight. *Recommendation, grounded in observed Problem 1.1 ("Continue does not say what will happen") and 1.4 (entitlements hidden).*

**Screen 2 — "Other flights" (only if user taps "See other options")**
Decision: pick a different flight from a sorted, filterable list.
Leaves with: a chosen flight, or a return to the held seat. *Recommendation.*

**Screen 3 — "Tonight's support"**
Decision: accept hotel voucher (yes / already have lodging), accept meal credit.
Leaves with: voucher claimed or declined — *explicitly*, not buried. *Recommendation, addresses observed Problem 4 (entitlements in FAQ).*

**Screen 4 — "You're set" (confirmation + offline pocket card)**
Decision: none required; optional "Add to wallet," "Text me a copy," "Something changed — get help."
Leaves with: new flight time, gate-TBD note, hotel address, baggage status, check-in window, and a one-tap path back to a human. *Recommendation, addresses observed Problem 5 (vague confirmation).*

Total: 4 screens. Standby is handled inside Screen 2 as a filter chip ("Show standby"), not a peer tab. *Recommendation.*

## 2. What Changed vs. Current Flow (by Problem)

- **Problem: "Schedule irregularity" hides the event.** SMS now names cancellation and the held seat. *Recommendation.*
- **Problem: Tabbed picker forces adjudication while tired.** Replaced with a single held-seat default + "See other options" escape hatch. One decision per screen. *Recommendation, aligns with CD anchor (observed).*
- **Problem: "Recommended" is unexplained.** The held seat is labeled with *why* it was chosen (earliest confirmed arrival, same airline, no fare difference) — see §3. *Recommendation.*
- **Problem: Entitlements in FAQ.** Hotel and meal get a dedicated screen in the main flow, not a disclosure. *Recommendation.*
- **Problem: Vague confirmation.** Screen 4 carries the full itinerary recap + offline copy. *Recommendation.*
- **Problem: Fare difference shown during disruption.** Other-flights list suppresses fare-diff for same-cabin same-day rebooks within disruption window. *Inferred from brief's "do not push users into worse choices."*

## 3. Decision Points & Defaults

- **Default rebooking = earliest confirmed seat, same airline, same cabin, no added fare.** Surfaced as "We held this for you because it gets you in earliest with no fare change." *Recommendation; "Recommended" must be explainable per brief.*
- **Default support state = offered, not opted-in.** User must tap "Claim hotel" — avoids presuming need, but the offer is visible above the fold. *Recommendation.*
- **Standby default = hidden behind a filter.** *Assumption*: most tired 11 p.m. users want confirmed, not standby. Filter chip preserves access without elevating risk. *Recommendation.*
- **Sort default on Screen 2 = earliest arrival at destination** (not departure time, not price). *Recommendation tied to user goal in brief.*

## 4. Information Hierarchy (Above-the-Fold, per Screen)

- **Screen 1:** (1) "Your 6:15 a.m. is canceled." (2) "We've held seat 14C on the 7:10 a.m., arriving 3:42 p.m." (3) "Hotel tonight is covered." (4) Two buttons: "Keep this seat" / "See other options."
- **Screen 2:** (1) Sort/filter row (default: earliest arrival). (2) Held-seat card pinned top, marked "Held for you." (3) Other flights. (4) "Back to held seat" persistent.
- **Screen 3:** (1) "Hotel tonight" with property name + distance. (2) "Meal credit" amount-agnostic offer. (3) "I have lodging" decline. (4) "Talk to someone" link — never removed.
- **Screen 4:** (1) New flight time + arrival. (2) Hotel address + confirmation code. (3) Baggage + check-in window. (4) "Plans changed?" → support.

## 5. Where Entitlements & Standby Live

- **Hotel + meal:** Mentioned on Screen 1 (one line, above fold) and given a full screen (Screen 3). *Recommendation; do not bury per brief constraint.*
- **Travel credit:** Lives inside Screen 2 as a filter/option ("Take credit instead"), not a peer tab. *Recommendation* — it's a fallback, not a co-equal default.
- **Standby:** Filter chip on Screen 2. *Recommendation* — accessible, not equivalent in weight to confirmed rebooking.
- **Human support:** Persistent footer link on every screen, labeled "Talk to someone." *Recommendation, addresses brief's "do not hide help."*

## 6. Message to Team

> Team — proposed flow is 4 screens: **Held-Seat Offer → (optional) Other Flights → Tonight's Support → You're Set.** The big move is replacing the three-tab picker with a single pre-held seat and an escape hatch; entitlements get their own screen, not an FAQ. One decision per screen, held-seat default explainable as "earliest confirmed arrival, no fare change."
>
> Decision points where defaults matter: (a) held seat on Screen 1, (b) sort = earliest arrival on Screen 2, (c) support offered-not-opted-in on Screen 3, (d) standby demoted to a filter chip.
>
> **Interaction Designer — one ask:** the "See other options" path must feel like a side-trip, not a commitment. I'm proposing a pinned "held seat" card on Screen 2 so the user can always retreat. Does that hold up as a pattern, or do we need a different affordance?
>
> **Content Designer — one ask:** I need the held-seat explainer string ("We held this because…") to carry the *reason* in under ~14 words, mobile single-line. The word "Recommended" is banned per brief; help me find the replacement that earns trust without overclaiming.

---

*Labels: observed = stated in brief; inferred = drawn from brief logic; assumption = my read of user state; recommendation = my proposal.*
