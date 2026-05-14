# Information Architect — Canceled-Flight Recovery

Working document. Claim labels: `[brief]` = stated in brief, `[inferred]` = reasonable read of brief, `[assumption]` = my framing absent evidence, `[recommendation]` = design proposal.

---

## 1. User-job spine

Priority order for a tired, mobile-only traveler at 10:46 p.m. trying to reach a family event [brief]:

1. **Understand** — "What actually happened to my flight, and what does it mean for tomorrow?" [brief: "Understand what happened"]
2. **Choose** — "What are my real options, and which one gets me there?" [brief: "choose the best available recovery option"]
3. **Get support** — "What is the airline responsible for tonight (hotel, meals), and how do I reach a human if I need to?" [brief: hotel/meal entitlements hidden in FAQ is a flagged problem]
4. **Leave with confidence** — "Do I have a clear, retrievable record of what's next, and a path if it changes again?" [brief: confirmation currently has "no summary… no offline backup… no clear path if plans change"]

Underlying assumption: jobs 1 and 3 are currently *underserved* in the flow; jobs 2 and 4 are *present but poorly executed*. [inferred from brief problem list]

---

## 2. Revised screen sequence (5 screens, mobile-first)

### Pre-screen: Entry SMS (counts as 0 of 5 — it's a notification, not a screen)

- **Decision the SMS triggers:** open the link or call.
- **Content:** plain-language event ("Your 6:15 a.m. flight DEN→LGA tomorrow is canceled"), one-line reassurance that options are ready, deep link, fallback support number as system-supplied dynamic value (do not hardcode) [recommendation].
- **Must NOT say:** "Schedule irregularity." [brief flags this phrase]
- **Claim labels in copy:** flight number, route, and scheduled time are system-supplied dynamic values, not authored copy.

### Screen 1 — What happened & what's covered tonight

- **Primary decision:** Do I need to act on tonight (hotel/meal/where am I sleeping) before I pick a new flight?
- **Content hierarchy (top → bottom):**
  1. Plain-language status: "Your 6:15 a.m. flight tomorrow, DEN to LGA, was canceled." [recommendation; flight values dynamic]
  2. Reason in human words (system-supplied; brief mentions "crew availability" as the actual cause — surface the system-provided reason, do not hardcode).
  3. **"What's covered tonight"** module — surfaces hotel and meal entitlements *if* the system says the traveler qualifies. Eligibility, dollar amounts, and provider names are system-supplied dynamic values; the prototype shows placeholders like `{hotel_entitlement_status}` and `{meal_entitlement_status}`. [recommendation — addresses brief's "hidden in FAQ" problem without inventing policy]
  4. "Your next step" framing leading into rebooking.
- **Primary CTA:** "See my rebooking options" [recommendation — explicit destination, replaces "Continue" which brief flags]
- **Secondary actions:** "Call Northstar support" (number is dynamic system value), "Text me this link" (offline backup, see scoped gaps).
- **What NOT to show:** marketing, loyalty upsell, fare-difference math, "we're sorry for the inconvenience" as the lede [inferred — brief says "no urgency, next step, or reassurance"], legal jargon, "Schedule irregularity."

### Screen 2 — Choose how you get there

- **Primary decision:** Which recovery path? (Replaces current 3-tab screen with default "Travel credit.") [brief flags default as misaligned]
- **Content hierarchy (top → bottom):**
  1. Three labeled paths as a single decision list, not tabs. Order reflects likely user goal of "get to the family event tomorrow" [inferred from brief scenario]:
     - **"Rebook on another flight"** — default-focused, described as "Confirmed seat on a later flight." [recommendation]
     - **"Join standby"** — described as "No guaranteed seat. You wait at the airport." [recommendation — brief flags standby sounding equivalent to confirmed]
     - **"Cancel and get a refund or travel credit"** — described as "You won't fly with us on this trip." Refund vs. credit choice handled on the next screen, not buried in a tab label. [recommendation — brief flags credit-default]
  2. Each option has a one-line consequence under the label (information scent).
  3. "Not sure? Talk to an agent" link, always visible. [recommendation — addresses support visibility]
- **Primary CTA:** the user taps an option; there is no global "Continue." [recommendation]
- **What NOT to show:** "Recommended" badges without an explanation string [brief flags this]; fare difference at this level [brief flags fare difference during disruption]; tab UI [inferred — tabs hide options].
- **Better default than "Travel credit":** Lead with **"Rebook on another flight"** as the visually primary choice. Rationale: the brief's scenario explicitly states the user is "trying to get to a family event the next day" — the modal user-goal is arrival, not refund. [recommendation, grounded in brief scenario]

### Screen 3 — Pick a flight (only reached if user chose "Rebook")

- **Primary decision:** Which specific flight?
- **Content hierarchy (top → bottom):**
  1. Filter chips: arrival time, nonstop only, same travel party. [recommendation — brief lists missing filters]
  2. Flight cards sorted by *earliest arrival that still gets them there* — sort logic stated in plain text above the list: "Sorted by arrival time. Change sort." [recommendation]
  3. Each card: departure time, stops, arrival time, total travel time, seat-confirmed indicator, and — only if applicable — fare difference shown with an explanation string ("Fare difference because this is a different cabin"). Fare-difference policy itself is `[assumption]` territory; the prototype labels the field as system-supplied and the team should confirm whether to charge during disruption recovery. [recommendation, flags brief's concern]
  4. No bare "Recommended" badge. If a card is best-match, the badge reads "Earliest arrival" or "Nonstop, closest to your original time" — the *reason* is the label. [recommendation — brief flags unexplained "Recommended"]
- **Primary CTA per card:** "Confirm this flight" [recommendation]
- **Secondary actions:** Back to options, Call support.
- **What NOT to show:** loyalty pricing, seat-map upsell, "Recommended" without rationale.

### Screen 4 — Review & confirm (one-screen confirm, not a wizard)

- **Primary decision:** Lock it in, or back out?
- **Content hierarchy:**
  1. New flight summary (dynamic values).
  2. **Tonight:** hotel and meal status from Screen 1, re-surfaced (eligibility, claim method) — placeholders, not invented amounts. [recommendation]
  3. **Bags:** placeholder for baggage handling for canceled-flight scenarios — system-supplied or scoped gap (see §4).
  4. **Travel party:** if more than one passenger on PNR, show all names; if mixed eligibility, surface that. [recommendation; multi-pax handling acknowledged]
  5. What we'll do if this flight also changes: short statement of re-notification path. [recommendation]
- **Primary CTA:** "Confirm rebooking" [recommendation — explicit verb, replaces "Done"]
- **Secondary actions:** "Go back," "Call support."

### Screen 5 — Your trip is set

- **Primary decision:** Save / share / leave.
- **Content hierarchy:**
  1. One-sentence confirmation in plain words: "You're confirmed on the 2:40 p.m. flight tomorrow, DEN to LGA." [recommendation]
  2. Itinerary block: flight, confirmation code, gate-info-when-available placeholder, check-in time placeholder (do not invent specific times — system-supplied).
  3. Tonight block: hotel and meal status, plus how to claim if eligible.
  4. **"Save this trip"** — Add to wallet, email a copy, SMS a copy. Addresses brief's "no offline backup." [recommendation]
  5. **"If this changes again"** — short text plus support contact. Addresses brief's "no clear path if plans change again." [recommendation]
- **Primary CTA:** "Add to wallet" or "Email me a copy" (user picks one — both available) [recommendation]
- **Secondary actions:** "View full trip," "Call support."
- **What NOT to show:** "Done" as the only path out [brief flags].

---

## 3. Copy constraints

### Tone rules

- Plain language, second person, present tense. Read level: roughly 6th–7th grade [recommendation, no source].
- Acknowledge the disruption once, briefly, then move to action. No repeated apologies. [inferred from brief: "No urgency, next step, or reassurance"]
- Never blame the user. Never blame "the system."
- Calm, not chipper. No emoji in core flow copy [recommendation].

### Banned phrases (must never appear in user-facing copy)

- "Schedule irregularity" [brief flags]
- Bare "Continue" / "Done" / "Recommended" without an explanation string [brief flags]
- "We are sorry for the inconvenience" as a standalone lede [inferred — brief flags lack of next step]
- "Other policies" as a label hiding entitlements [brief: hotel/meal currently hidden in FAQ]
- Org-chart terms ("Tier 2," "irrops desk," "ops control") [recommendation — IA hygiene]
- Marketing terms during disruption ("Premier," "Elite perks") [recommendation]

### Must-appear elements

- Hotel entitlement status, surfaced on Screen 1 and Screen 5 — eligibility flag and claim method, dollar amounts are system-supplied. [brief requirement]
- Meal entitlement status, same treatment. [brief requirement]
- A visible path to a human on every screen ("Call Northstar support" with the number as a system-supplied dynamic value). [recommendation — addresses brief's "support visibility"]
- A "save / take this with you" affordance on Screen 5 (wallet, email, SMS). [recommendation]

### Claim-labeling rules for the prototype HTML

- Any operational fact that is not in the brief — voucher dollar values, hotel names, refund timelines, credit expiration, callback windows, support hours, baggage rules, gate info, phone numbers, eligibility promises — must be rendered as a **placeholder token** in the HTML (e.g., `{hotel_entitlement_amount}`, `{support_phone}`, `{credit_expiration_date}`) OR explicitly labeled "system-supplied." [recommendation]
- No "we'll get back to you in 24 hours"-style promises in static copy. [recommendation]
- Visual Designer should treat `{token}` strings as a known pattern and style them as live-data slots, not as written content.

---

## 4. Scoped gaps (named, not solved)

Each is a real user need the brief raises that this artifact will not fully solve in the prototype. Named so the team and the lead see them.

1. **Family / multi-passenger groups on one PNR.** Screen 4 lists passenger names; Screen 2 does not branch logic by group size. Mixed-eligibility cases (e.g., an adult eligible for one entitlement, a minor for another) are out of scope for the prototype. Reason: entitlement matrices are operational facts not in the brief. [scoped gap; brief constraint: "traveling with family"]

2. **Low-bandwidth degradation.** Flow is designed text-first with minimal images, which helps, but no offline mode, no progressive enhancement, no SMS-only fallback flow is built. Mitigation in artifact: SMS confirmation copy on Screen 5. [scoped gap; brief constraint: "low bandwidth"]

3. **Screen reader parity.** IA proposes a linear, heading-led DOM order matching the visual hierarchy above; full ARIA spec and live-region behavior is the interaction-designer's call. [scoped gap; brief constraint: "using a screen reader"]

4. **Refund-seeker path depth.** Screen 2 names the refund-or-credit option, but the actual refund-vs-credit decision screen, eligibility logic, and refund-timeline copy are not authored — placeholders only. Reason: refund policy is operational fact not in brief. [scoped gap]

5. **Support-channel selection.** "Call Northstar support" appears on every screen, but chat / callback / wait-time-visibility is not designed. Reason: callback windows and support hours are operational facts not in brief. [scoped gap; brief: "reduce calls, but not by hiding help"]

6. **Re-disruption (the rebooked flight also cancels).** Screen 4 and Screen 5 mention the re-notification path in one sentence; the actual re-entry into the flow is not designed. [scoped gap]

7. **Baggage handling on cancellation.** Placeholder on Screen 4 only. Reason: baggage rules are operational facts not in brief. [scoped gap]

---

## 5. Handoff to Visual Designer

What you need from me to author the HTML:

- **Screen count:** 5 (plus SMS pre-screen).
- **Per-screen primary decision and CTA copy:** see §2. Use the exact CTA strings.
- **Token convention:** `{snake_case_token}` for any system-supplied dynamic value. Style them as data slots, not as authored copy. List of tokens to expect: `{flight_number}`, `{route}`, `{scheduled_time}`, `{cancellation_reason}`, `{hotel_entitlement_status}`, `{hotel_entitlement_amount}`, `{meal_entitlement_status}`, `{meal_entitlement_amount}`, `{support_phone}`, `{confirmation_code}`, `{rebooked_flight_summary}`, `{credit_expiration_date}`, `{refund_timeline}`, `{baggage_status}`.
- **Hierarchy contract:** the top-to-bottom order in §2 is load-bearing. If a section needs to collapse on small screens, collapse from the bottom up; never collapse hotel/meal entitlement on Screen 1 or Screen 5.
- **No tabs on Screen 2.** Three stacked decision cards instead. [brief flags tabs as a problem]
- **No bare badges.** "Recommended" badges must contain a reason string or not appear.
- **Always-visible support link** on every screen — visual treatment is yours, presence is non-negotiable.
- **Plain-language status block** at top of Screen 1 — this is the brief's #1 unmet need.

Open the report; if anything is unclear, ping me before authoring — the structure is the artifact, not the styling.

---

## 6. Open questions / risks for the lead

1. **Refund-vs-credit branching depth.** Do we author a refund stub screen or fully scope it out? I've scoped it out; happy to add a sixth screen if the lead wants it, but that breaks the 5-screen ceiling.
2. **"Standby" as a top-level option.** Brief lists it as a current tab; it may not deserve top-level placement in the redesign. I kept it for parity, but recommend the lead consider moving it under "Rebook on another flight" as an alternate path.
3. **Entitlement surfacing without eligibility logic.** If the backend cannot return a per-user eligibility flag, Screen 1's "What's covered tonight" module either over-promises or has to say "check with support" — which the brief implies is the failure mode we're trying to fix. Confirm backend can provide eligibility status.
4. **Fare difference during disruption recovery.** Brief flags it as a problem but doesn't say to remove it. I've kept the field as system-supplied + explanation string. Policy call.
5. **Support visibility vs. reduce-calls goal.** Brief asks for both. I've defaulted to "support visible everywhere" because hiding it is the brief's explicit anti-pattern. If call volume is the harder constraint, the team should decide where to dial down support prominence — I'd argue not on Screen 1.
6. **Multi-passenger handling.** Real risk: a family of four hits Screen 2 and the flow assumes one decision-maker. Worth a follow-up sprint.

---

*End of report.*
