# Information Architect Report — Canceled-Flight Recovery

Labels used throughout: **[BRIEF]** observed from brief, **[INFER]** inferred from brief, **[ASSUME]** assumption I am making, **[REC]** recommendation.

---

## 1. User-job spine

What the traveler is actually trying to do, in plain language, ordered by what matters first. The earlier jobs unblock the later ones — if job 1 is unresolved, the user cannot make a good decision in job 3.

1. **Know what just happened to my flight.** Plain words, not jargon. **[BRIEF]** ("Schedule irregularity hides the real event.")
2. **Know what my options are right now, and which one is realistic for me.** **[BRIEF]** ("The user still does not know what choices they have.")
3. **Know whether the airline will help with a place to sleep and food tonight.** This must be visible before the user commits to an option, because it changes which option is viable. **[BRIEF]** ("Hotel and meal support are absent. Entitlements are hidden.")
4. **Pick a recovery path and have it actually be booked, not just selected.** **[BRIEF]** (Standby vs. confirmed rebooking confusion.)
5. **Walk away with a single source of truth I can show at the airport or re-open offline.** **[BRIEF]** ("No summary of new flight, hotel, baggage, arrival, check-in… No offline backup.")
6. **Know how to reach a human if any of this breaks.** **[BRIEF]** (Business goal is to reduce calls "without hiding important options or pushing users into worse choices.")

Implication for IA: support visibility (job 3) and the human-fallback path (job 6) cannot be buried. They are part of the spine, not a footer. **[REC]**

---

## 2. Revised screen sequence

Five screens, mobile-first. Each screen has exactly one primary decision. Anything that does not serve that decision either moves to another screen or comes off the screen entirely.

### Screen 1 — What happened

- **Primary decision:** Read and acknowledge. Tap "See my options."
- **Content hierarchy (top to bottom):**
  1. Plain-language headline: "Your 6:15 a.m. flight to New York was canceled."
  2. One-sentence cause in plain words, drawn from the SMS event (crew availability). **[BRIEF]**
  3. Reassurance sentence: the airline will help arrange a new flight and, if eligible, a place to sleep tonight. No promise of specific entitlement. **[REC]**
  4. Primary button: "See my options."
  5. Secondary link: "Talk to a person." Always visible. **[REC]**
- **Must not appear here:** fare differences, upsells, marketing, loyalty pitches, legalese, the word "irregularity," collapsed FAQs. **[REC]**

### Screen 2 — Choose how to recover

- **Primary decision:** Pick one of three recovery paths.
- **Content hierarchy:**
  1. One-line restatement of what was canceled (anchor).
  2. Three equally-weighted choices, each as a tappable card with a one-line consequence:
     - "Rebook on another Northstar flight" — "Confirmed seat, new departure time."
     - "Get a refund or travel credit" — "Cancel the trip. Money back or credit, your choice on the next screen."
     - "Wait for a seat (standby)" — "Not guaranteed. You may not fly today."
  3. A persistent banner above or below the cards: "Tonight's hotel and meal support may be available — we'll show what you qualify for after you pick a path." Wording is conditional, not a promise. **[REC]**
  4. Secondary link: "Talk to a person."
- **Must not appear here:** a default-selected tab, a "Recommended" label without an explanation, fare-difference dollar amounts, hotel/meal info buried in an FAQ. **[REC]** Standby must read as clearly non-equivalent to confirmed rebooking. **[BRIEF]**

### Screen 3 — Pick your flight (rebook path) / Confirm refund-or-credit (refund path) / Confirm standby (standby path)

This screen is one screen with three variants based on the choice on Screen 2. The variants share a frame.

- **Primary decision (rebook variant):** Pick one flight.
- **Content hierarchy (rebook variant):**
  1. Filter bar at the top: arrival time, nonstop only, earliest available. **[BRIEF]** ("No filters for arrival time, direct flight…")
  2. Flight cards, sorted by earliest arrival by default, with explicit reasoning. Each card shows: depart time, arrive time, stops, duration. **[REC]**
  3. If a "Recommended" tag appears on a card, it must be followed by the *reason* on the same line ("Earliest arrival" or "Closest to original time"). No bare "Recommended." **[BRIEF]**
  4. Fare difference, *only if non-zero and only on a card where Northstar is genuinely offering a paid upgrade* — not as a default during disruption recovery. The Behavioral Scientist may push this further. **[REC]**
  5. Primary button on tap of a card: "Confirm this flight."
- **Primary decision (refund variant):** Choose refund to original payment or travel credit. Plain consequence under each. **[REC]**
- **Primary decision (standby variant):** Acknowledge the risk ("You may not fly today") and tap "Join standby." **[REC]**
- **Must not appear on any variant:** seat-selection upsells, bag upsells, insurance, loyalty enrollment. **[REC]**

### Screen 4 — Tonight and tomorrow (support and add-ons)

This is the screen the current flow buries. It must exist as its own step. **[BRIEF]**

- **Primary decision:** Accept or decline the support the airline is offering for tonight, then continue.
- **Content hierarchy:**
  1. Plain statement of what is being offered tonight, expressed as what the system can see in the user's case — not as a generalized policy claim. Example phrasing: "Based on this cancellation, we can arrange a hotel room and a meal credit for you tonight." If the system cannot determine eligibility, say so plainly: "We need to check whether tonight's stay is covered. Tap to talk to a person." **[REC]** No invented voucher amounts, hotel chains, or guarantees. **[BRIEF]**
  2. Tappable accept / decline for hotel.
  3. Tappable accept / decline for meal credit.
  4. Baggage: where to claim or re-check bags, if relevant to the rebook choice. **[BRIEF]** ("No summary of new flight, hotel, baggage…")
  5. "Talk to a person" link.
  6. Primary button: "Confirm tonight's plan."
- **Must not appear here:** marketing, loyalty offers, paid hotel upsells presented as if they are the entitlement, dark-patterned pre-checked add-ons. **[REC]**

### Screen 5 — Your updated trip

- **Primary decision:** Save or share the trip summary; know how to come back if something changes.
- **Content hierarchy:**
  1. Confirmation headline naming the outcome the user just chose ("You're rebooked," "Refund started," or "You're on standby"). No generic "Trip updated." **[BRIEF]**
  2. New flight summary: flight number, depart time and gate-status note, arrival time, stops. **[BRIEF]**
  3. Tonight's plan: hotel arrangement status, meal credit status, baggage instructions. **[BRIEF]**
  4. What to do next: when to be at the airport, how to check in, where to find the boarding pass.
  5. "Save offline" or equivalent affordance so the page is readable without signal. **[BRIEF]** ("No offline backup.")
  6. "Plans changed again? Talk to a person." link, always visible. **[BRIEF]**
- **Must not appear here:** survey prompt, marketing, "rate your experience," anything that competes with the summary. **[REC]**

---

## 3. Copy constraints

These rules apply across all five screens. The Visual Designer and the lead enforce them in the HTML and recommendation.

**Tone**

- Plain, calm, second-person. Short sentences. **[REC]**
- Acknowledge the disruption once on Screen 1. Do not re-apologize on every screen. **[REC]**
- Do not use language that implies the user caused the problem. **[REC]**

**Banned phrases**

- "Schedule irregularity." Say "canceled" or "delayed" depending on what actually happened. **[BRIEF]**
- "Your itinerary has changed" as a standalone headline. It hides the event. **[BRIEF]**
- "Continue" or "Done" as a button label when something more specific is true. **[BRIEF]**
- "Recommended" without a reason on the same line. **[BRIEF]**
- "Other policies" as a section label that hides entitlements. **[BRIEF]**
- Any specific dollar amount, voucher value, hotel name, phone number, wait time, eligibility promise, or credit-expiration window that is not given in the brief. **[BRIEF]** + **[REC]**

**Primary button rule**

Every primary button must be **verb + outcome**. The user should be able to read the button alone and predict what the next screen contains. Examples (the Visual Designer can refine wording):

- Screen 1: "See my options" — not "Continue." **[REC]**
- Screen 2: "Choose this path" or the card itself is the affordance. **[REC]**
- Screen 3 (rebook): "Confirm this flight." Screen 3 (refund): "Get my refund" or "Get travel credit." Screen 3 (standby): "Join standby."
- Screen 4: "Confirm tonight's plan."
- Screen 5: no forward primary; the primary action is "Save offline" or "Share." **[REC]**

**Confirmation rule**

Every confirmation (Screen 5 plus any in-line confirmation modals) must summarize, in this order:

1. What was chosen (rebook / refund / standby).
2. New flight or refund details, concrete.
3. Tonight's hotel and meal status, concrete.
4. Baggage instructions.
5. How to reach a person if something changes.

If the system does not have a value for one of those, the confirmation must say "we'll send this when it's ready" rather than omit the row. Silence is worse than a pending state. **[REC]**

**Support-visibility rule**

"Talk to a person" must be reachable from every screen as a secondary (not primary) action. The brief's business goal is to reduce calls, but not by hiding help — the link stays visible. **[BRIEF]**

---

## 4. Scoped gaps

Things the brief calls out that I am deliberately not solving inside the screen sequence. The lead should flag each in the final recommendation as a known limit of this artifact.

1. **Multi-passenger and family travel.** The brief says "traveling with family" is in scope as a user condition, but a full multi-passenger management UI (per-passenger seat selection, per-passenger refund choice, splitting a party across recovery paths) is out of scope for a 5-screen artifact. The artifact should treat the booking as one unit and add a single visible note on Screen 2 or Screen 3 that says, in plain words, that travelers booked together will be moved together unless they call. **[BRIEF]** + **[REC]**
2. **Screen-reader-specific layout and announcements.** Owned by the Accessibility Specialist. I provide hierarchy and reading order; SR-specific live-region behavior, focus order, and landmark roles are theirs to specify. **[REC]**
3. **Low-bandwidth offline mode beyond a save affordance.** The brief flags low bandwidth. The artifact addresses it with a "save offline" affordance on Screen 5 and minimal media. A full offline-first PWA is out of scope. **[BRIEF]** + **[REC]**
4. **Refund-seeker deep flow.** Screen 3's refund variant covers the choice; the actual refund-processing UI (payment method routing, partial refunds, taxes) is a deeper flow and is scoped out. **[REC]**
5. **Standby clearing UX over time.** Screen 3 standby variant covers commitment to standby; the live-update UI for clearing position is out of scope. The Visual Designer should not invent it. **[REC]**
6. **Entitlement determination logic.** Whether the traveler is eligible for hotel and meal support is an upstream policy and systems question. The IA assumes the system knows the answer at the moment Screen 4 loads; if it does not, Screen 4 must say so plainly (see copy rules) rather than guess. **[ASSUME]**
7. **Experiment plan and metrics design.** Owned by the Behavioral Scientist and the lead. **[REC]**

---

## 5. Handoff to Visual Designer

You can author the HTML from this report alone. You do not need to re-read the brief.

**What you are building**

A mobile-first prototype with five screens in order: (1) What happened, (2) Choose how to recover, (3) Pick your flight / Confirm refund-or-credit / Confirm standby (one screen, three variants — author at least the rebook variant; refund and standby variants can be a sketch or a single representative state), (4) Tonight and tomorrow, (5) Your updated trip.

**Primary decision per screen**

- Screen 1: tap "See my options."
- Screen 2: choose one of three recovery paths.
- Screen 3 (rebook variant): pick one flight and confirm it.
- Screen 4: accept or decline hotel and meal support, then confirm.
- Screen 5: save or share the trip summary.

**Content hierarchy per screen** is in Section 2. Treat the ordered lists as the reading order top-to-bottom on a phone.

**Copy constraints** are in Section 3. Pay attention to: banned phrases (no "schedule irregularity," no bare "Continue," no bare "Recommended," no "Other policies"); the verb+outcome button rule; the confirmation summary rule on Screen 5; "Talk to a person" visible on every screen.

**Do not invent**

Voucher amounts, hotel names, phone numbers, wait times, credit expiration windows, eligibility promises, fare-difference dollar values, loyalty offers, or any operational facts not in this report. Use placeholder tokens (e.g. `{flight_number}`, `{depart_time}`) where concrete data would be filled in by the system. The lead will check for this.

**Scoped gaps to respect**

Do not build a multi-passenger management UI. Do not build a refund-processing deep flow. Do not build live standby clearing. Do not build a full offline-first mode beyond a "save offline" affordance on Screen 5. If you find yourself reaching for one of these, stop and leave the surface area visible but unbuilt — the lead names it as a scoped gap.

**What to expect from the other audits**

The Accessibility Specialist will return blockers on keyboard, focus, contrast, target size, landmarks, headings, and forms. The Behavioral Scientist will return blockers on coercion, trust, choice architecture, and dark-pattern risk — particularly around how Screen 2's three choices are weighted, how Screen 4's accept/decline is framed, and whether "Talk to a person" is genuinely reachable. Plan one surgical revision pass after both.
