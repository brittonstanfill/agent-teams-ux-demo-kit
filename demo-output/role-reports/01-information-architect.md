# Information Architect — Canceled-Flight Recovery

## Header

- **Role:** Information Architect. Owns user-job spine, flow structure, hierarchy, label/copy constraints, scoped gaps.
- **Scope:** Mobile-first recovery flow from SMS tap through post-decision confirmation. 5 screens or fewer.
- **Non-goals:** Visual styling, exact pixel layout, full body copy, interaction micro-states, brand voice. Those belong to the Visual Designer and downstream copy review.

---

## User-job spine (jobs to be done, ordered)

A tired traveler at 10:46 p.m. with a 6:15 a.m. cancellation needs, in this order:

1. **Confirm what happened and that it's real.** "Is my flight actually canceled? Is this a scam text?" *(inferred from brief: SMS lacks urgency, no confirmation of cause)*
2. **Understand they have options and won't be stranded.** Reassurance comes before choice. *(inferred)*
3. **See the recovery options side-by-side with consequences.** Rebook vs. credit vs. standby — what each one *means* tonight and tomorrow. *(observed: brief flags label ambiguity and hidden tradeoffs)*
4. **Pick a flight or path with enough info to commit.** Times, stops, and any fare delta visible up front. *(observed: brief gives the three flight options verbatim)*
5. **Get tonight's logistics handled (hotel, meal) without hunting.** *(observed: brief flags hotel/meal hidden under "Other policies")*
6. **Leave with a written record and a way back to a human if anything breaks.** *(observed: Screen 5 "Done" gives no summary, no offline fallback, no support handoff)*

Ordering principle: **acknowledge → orient → choose → support → confirm.** Choice is sandwiched between reassurance and confirmation because a stressed user does not commit to options they don't trust.

---

## Revised flow — 4 screens

I'm proposing 4, not 5, because the brief's current Screen 1 ("Your itinerary has changed") and Screen 2 (tabs) do the same job badly across two taps. Collapsing them is the single biggest structural win. *(recommendation)*

### Screen 1 — Status & Plan

- **Primary decision:** Trust this is real; decide whether to act now or read more.
- **Content hierarchy (top → bottom):**
  1. Plain-language event statement (flight, route, time, cause).
  2. Reassurance line: you have options, we'll show them next.
  3. Tonight's logistics callout (hotel/meal support is part of this flow, not buried).
  4. Primary CTA: "See my options".
  5. Secondary CTA: "Talk to someone" (support handoff, no invented phone number — placeholder).
- **Copy constraints:**
  - Lead with "Your 6:15 a.m. flight to LGA was canceled." Not "schedule irregularity." Not "itinerary has changed."
  - Name the cause in user words: "Crew availability — this was not weather." *(observed cause; the contrast is recommendation, because crew-cause is what the brief gives us and travelers often assume weather)*
  - Do not promise specific compensation, hotel name, or voucher amount.
- **Required entry/exit copy:** Page heading reads as the event, not the system action. Exit CTA names the next screen ("See my options"), not "Continue."
- **Accessibility/landmark guidance:** `<main>` lands here. H1 = the event statement. Skip-link target. Status region uses `role="status"` so screen readers announce the cancellation on load without trapping focus.

### Screen 2 — Choose your path

- **Primary decision:** Which of four recovery behaviors fits my situation: **rebook, travel credit, standby, or refund-equivalent decision later**.
- **Content hierarchy:**
  1. Question framing: "What works best for you?"
  2. Four cards, in this order (rationale below):
     - **Rebook on a Northstar flight** — "Confirmed seat on the next available flights."
     - **Standby on an earlier flight** — "No confirmed seat. You wait at the gate and may not get on." *(brief flags standby being confused with confirmed rebooking; the label and one-line consequence must do that work)*
     - **Take travel credit** — "Keep the value of your ticket for a future trip." *(do not name expiration — not in brief)*
     - **Hotel & meal support for tonight** — surfaced as a peer card, not a footnote. *(observed: brief flags this as hidden)*
  3. Persistent "Talk to someone" link at bottom.
- **Copy constraints:**
  - No "Recommended" badge on any card without a stated reason. *(observed problem on current Screen 3)*
  - Each card has a 1-line consequence statement, not just a label.
  - Default selection: none. The user picks. *(brief flags Travel Credit being defaulted; that's a coercion risk — recommendation)*
- **Required entry/exit copy:** Back affordance returns to Screen 1 without losing state. Each card opens its own screen or, for hotel/meal, an in-place support panel.
- **Accessibility/landmark guidance:** Cards are `<button>` or `<a>` with full text as the accessible name (not "Learn more"). Order in DOM matches visual order. Heading per card at H3 under an H2 page heading.

### Screen 3 — Pick a flight (only if user chose Rebook or Standby)

- **Primary decision:** Which specific flight to take.
- **Content hierarchy:**
  1. Heading restates the choice: "Confirmed rebooking" or "Standby list."
  2. Three flight cards in time order (earliest first). Brief gives:
     - 7:10 a.m. tomorrow, one stop, fare difference: not stated → label "Same fare or fare difference shown here" placeholder. *(brief says "Recommended" — that's marketing, not info — drop)*
     - 2:40 p.m. tomorrow, nonstop, "$84 fare difference"
     - 6:30 p.m. tomorrow, one stop, "$0"
  3. Each card shows: departure time, stops, fare delta (or "$0" / "no extra cost"), and arrival time as `{new_arrival_time}` placeholder — brief does not give arrival times, so this is a token, rendered unobtrusively, never the headline. *(assumption: arrival time is decision-critical for a family-event traveler; if unavailable, render "Arrival time confirmed at booking")*
  4. Filter affordances (recommendation, may be deferred to a later release): nonstop only, arrival before X. Brief flags absence; if not built now, name as scoped gap.
  5. Persistent "Hotel & meal support" link and "Talk to someone" link.
- **Copy constraints:**
  - Do not show a fare difference without also showing the option that costs nothing. The $0 card must be visibly equal in weight to the $84 card. *(behavioral concern, flagged here as IA-level hierarchy)*
  - Do not use "Recommended" without a transparent reason.
  - Button on each card: "Choose this flight" — not "Select" or "Book."
- **Accessibility:** Each card is a single actionable region. Fare delta is part of the accessible name ("Choose 2:40 p.m. nonstop, $84 more").

### Screen 4 — Confirm & save

- **Primary decision:** Confirm the choice; capture proof.
- **Content hierarchy:**
  1. Heading: "You're booked on the {selected_flight}." (or "You're on the standby list for…" / "Your travel credit is ready.")
  2. Summary block: new flight number `{new_flight_number}`, departure `{new_dep_time}`, arrival `{new_arrival_time}`, stops, confirmation code `{confirmation_code}`, baggage status `{baggage_status}`.
  3. Tonight's logistics block: hotel & meal support status — either "Support has been added to your trip" or a clear link to request it. No invented voucher amounts or hotel names. Placeholders: `{hotel_status}`, `{meal_status}`.
  4. "Send to my email / text me a copy" — offline backup.
  5. "If plans change again" — link back to options, plus "Talk to someone."
- **Copy constraints:**
  - Heading must restate what they chose, not just "Trip updated."
  - Never say "Done" as the only CTA. Offer a save action and a way back.
- **Accessibility:** Summary block uses a definition list or labeled rows. Confirmation code is selectable text, not an image. Focus lands on the heading.

---

## Required copy elements — verbatim and tokens

Visual Designer must use these strings (or near-verbatim) so we don't drift back into vague airline-speak. All `{tokens}` must render small and inline, not as headline-weight type.

**Entry SMS (replaces current):**
> "Northstar: Your 6:15 a.m. flight NS482 DEN→LGA tomorrow was canceled (crew availability). Tap to see your options: {link}"

*(Rationale: names the flight, route, time, and cause. No "schedule irregularity." Recommendation-grade copy — brief does not dictate SMS wording but flags every problem this fixes.)*

**Screen 1 heading:**
> "Your 6:15 a.m. flight to LGA was canceled."

**Screen 1 sub:**
> "Flight NS482, DEN→LGA. Cause: crew availability. We have options for you, including hotel and meal support for tonight."

**Screen 1 primary CTA:** "See my options"
**Screen 1 secondary:** "Talk to someone"

**Screen 2 heading:** "What works best for you?"
**Screen 2 card labels (exact):**
- "Rebook on a Northstar flight"
- "Try standby on an earlier flight"
- "Take travel credit"
- "Hotel & meal support for tonight"

**Screen 2 card one-liners (consequence, not feature):**
- Rebook: "Confirmed seat on the next available flights."
- Standby: "No confirmed seat. You wait at the gate and may not get on."
- Credit: "Keep the value of your ticket for a future trip." *(no expiration claim)*
- Hotel/meal: "We can help cover tonight's stay and food." *(no amount, no hotel name)*

**Screen 3 card pattern:**
> "{dep_time}, {stops}, arrives {new_arrival_time}. {fare_delta_or_zero}."
> Button: "Choose this flight"

**Screen 4 heading variants:**
- "You're booked on the {new_dep_time} flight to LGA."
- "You're on the standby list for the {new_dep_time} flight."
- "Your travel credit is ready."

**Screen 4 reassurance line:**
> "If your plans change again, you can come back here or talk to someone."

**Placeholder tokens (must render unobtrusively, not dominate):**
`{first_name}`, `{new_flight_number}`, `{new_dep_time}`, `{new_arrival_time}`, `{stops}`, `{fare_delta_or_zero}`, `{confirmation_code}`, `{baggage_status}`, `{hotel_status}`, `{meal_status}`, `{selected_flight}`, `{link}`.

---

## Scoped gaps — flag to lead, handoff to Visual Designer

These are real user segments / failure modes the brief named or implied. If we don't solve them in the artifact, the memo must name them.

1. **Family / multi-passenger travel.** Brief says "traveling with family." Flow currently assumes a single pax. *(scoped gap — recommend a "+ others on this trip" affordance on Screen 1 status block; if not built, name in memo)*
2. **Refund-seeker.** Brief lists rebook / credit / standby / hotel-meal as the four behaviors. A user who wants a refund (cash back, not credit) has no path. *(scoped gap — do not invent a refund promise; name it explicitly: "If you want a refund instead of credit, talk to someone." That's an honest dead-end, not a hidden one.)*
3. **Low bandwidth.** Screens must work without large hero images, autoplay, or web fonts that block paint. *(handoff to Visual)*
4. **Screen reader.** All four screens need a proper landmark, H1, focus order, and accessible-name discipline on cards. *(handoff to Accessibility Specialist; IA provides heading structure)*
5. **Support visibility.** "Talk to someone" must be on every screen, not just when the flow fails. Brief flags users abandoning and calling — we should make the human path visible, not hide it as a failure signal. *(observed problem; recommendation)*
6. **Dynamic data not in brief.** Arrival times, hotel info, voucher amounts, credit expiration, eligibility rules, wait times — all tokens. If the real system can't fill a token, the screen must degrade to honest copy ("Arrival time confirmed at booking"), not invent a value. *(handoff to Visual)*
7. **Standby ambiguity.** Standby is the highest-risk label in the flow. If a user picks standby thinking it's a confirmed seat, we've harmed them. The consequence line is non-negotiable copy. *(recommendation)*

---

## Tradeoffs weighed

- **4 screens vs. 5.** Collapsing status + options into one screen risks information overload on Screen 1. Mitigation: Screen 1 leads with the event and reassurance, not the options list — the options live on Screen 2 one tap away. Net: one fewer dead-end tap for the user. *(recommendation)*
- **Task-based grouping vs. content-type grouping.** Current flow groups by content type (status, options, flights, support, confirmation). Revised flow groups by user job (acknowledge, choose path, pick flight, confirm). Hotel/meal stops being its own screen and becomes a peer choice + persistent link. *(recommendation)*
- **Defaulting a choice vs. no default.** Current default = travel credit. Cheaper for the airline, worse for many users. Revised: no default. User picks. *(behavioral concern, IA names it; Behavioral Scientist owns final call.)*
- **"Recommended" badge.** Dropped. Information scent without justification is marketing, not IA. If the airline has a real reason to recommend a flight (e.g., fastest, same arrival window), say *that* — not "Recommended." *(recommendation)*

---

## Claim labels — summary

- **Observed from brief:** flight number NS482, DEN→LGA, 6:15 a.m., crew availability, three flight options with stated times/stops/fare deltas, four behaviors (rebook / credit / standby / hotel-meal), current screen problems, mobile-first, 5-screen cap, family/screen-reader/low-bandwidth users.
- **Inferred from brief:** users are abandoning because they don't trust or don't understand; "schedule irregularity" hides cause; default-to-credit is suspect; standby label is risky.
- **Assumption:** arrival time matters for a family-event traveler; users want a written record; users want a visible human-handoff path.
- **Recommendation:** 4-screen structure (collapse status+options), drop "Recommended" badge, no default selection on Screen 2, persistent "Talk to someone" on every screen, hotel/meal as peer card not footnote, SMS rewrite, refund-seeker named as honest dead-end.

---

## Tree-test scenarios — for Visual Designer and audits

For each task, the expected path and acceptable alternates:

1. **"I want the cheapest option that gets me there tomorrow."**
   Expected: Screen 1 → Screen 2 (Rebook) → Screen 3 (pick the $0 6:30 p.m. card).
   Acceptable: same path, picks 7:10 a.m. card if fare delta there is also $0.
2. **"I just want my money back."**
   Expected: Screen 1 → Screen 2 → sees no refund card → uses "Talk to someone."
   Failure mode: user picks "Take travel credit" thinking it's a refund. Mitigation: credit card copy says "value of your ticket for a future trip," not "refund."
3. **"I need a hotel for tonight."**
   Expected: Screen 1 (hotel mentioned in reassurance line) → Screen 2 → Hotel & meal card.
   Acceptable: any later screen, via the persistent link.
4. **"I'm traveling with my kids; can I rebook all of us?"**
   Expected: Screen 1 shows party size or names; user proceeds. *Scoped gap if not built — name in memo.*
5. **"I want to know what happens to my checked bag."**
   Expected: Screen 4 confirmation includes `{baggage_status}`. If unknown, copy degrades to "Baggage details will be confirmed at the airport," not invented.

---

## Handoff note to Visual Designer

The single craft constraint: **every placeholder token must render at body-text weight, never at headline weight, and must not be the most visually dominant element on its screen.** A screen whose hero is `{new_arrival_time}` instead of "You're booked" has failed the IA. Tokens are decision-support content, not the message itself.
