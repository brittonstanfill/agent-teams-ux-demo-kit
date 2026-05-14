# Information Architect — Northstar Canceled-Flight Recovery

## User-job spine

Grounded in the brief's stated user goal: "Understand what happened, choose the best available recovery option, get any required support, and leave with confidence about what happens next."

In order, the stressed traveler is trying to:

1. **Understand** — What happened to my flight, and is it really gone? (observed from brief)
2. **Orient** — What are my real options, and what does each one cost me in time and money? (inferred from "labels do not explain consequences")
3. **Choose** — Pick a path: rebook, take credit/refund, or get human help. (observed)
4. **Secure support** — Hotel, meals, baggage, accessibility, family needs. (observed; brief flags entitlements as "hidden")
5. **Leave with confidence** — Know exactly what happens next, with a fallback if plans change again. (observed)

The current flow inverts this: it asks the user to "Continue" before they understand, defaults to Travel Credit before they choose, and hides support behind FAQ. (observed)

## Revised flow (screen-by-screen)

Five screens, mobile-first. Each screen answers one question.

### Screen 1 — Status & what this means

- **Purpose:** Replace "schedule irregularity" with a plain account of the event and immediate reassurance that recovery is available.
- **Primary decision:** None yet — read and proceed. (One CTA: "See my options.")
- **Content hierarchy:**
  1. Plain-language event: "Your 6:15 a.m. flight NS482 to LGA was canceled."
  2. Reason in plain words (from brief: crew availability).
  3. Reassurance: "We can rebook you, refund you, or get you human help. Hotel and meal support may be available tonight."
  4. CTA: "See my options."
  5. Secondary: "Talk to an agent" (always visible, never buried). (recommendation)
- **Affordances visible:** Primary CTA, agent link, trip identifier, passenger count.
- **One-tap-deep:** Full flight details, accessibility settings, language toggle.

### Screen 2 — Choose a recovery path

- **Purpose:** Present the three real paths as peers, with consequences attached to each label.
- **Primary decision:** Pick a recovery path.
- **Content hierarchy:**
  1. Three equal-weight cards, no default pre-selected (recommendation; brief flags default-Travel-Credit as a problem):
     - **Rebook on another flight** — "Get to LGA on a confirmed seat."
     - **Refund or travel credit** — "Don't fly. Get your money back or keep credit." (Refund and credit shown as a pair, not credit-only — refund-seeker path. recommendation)
     - **Standby only** — "No confirmed seat. Wait at the airport for an open one." (Label must make non-equivalence to rebooking explicit. recommendation, addresses brief problem.)
  2. Persistent: "Talk to an agent" + "I'm traveling with family / others" toggle that carries party size through every subsequent screen. (recommendation)
- **Affordances visible:** All three paths, agent link, party-size context.
- **One-tap-deep:** "What's the difference?" explainer; accessibility/mobility needs picker.

### Screen 3 — Rebook (or Refund branch)

- **Purpose:** Let the user choose a specific flight (or confirm refund/credit).
- **Primary decision:** Select a flight, or confirm refund/credit choice.
- **Content hierarchy (rebook branch):**
  1. Filter chips at top: Arrival time, Nonstop only, Earliest, Seats together (for parties >1). (recommendation; brief notes missing filters.)
  2. Flight cards, each showing: depart/arrive times, stops, seats-together availability for the party, **fare difference shown as $0 during disruption recovery by default** — if a fare difference exists, label it plainly and explain why. (recommendation; brief flags fare difference as a problem.)
  3. Remove unexplained "Recommended" badge. If used, the badge must state the criterion in the label itself (e.g., "Earliest arrival"). (recommendation)
- **Content hierarchy (refund branch):**
  1. Side-by-side: Refund to original payment vs. Travel credit. Neither pre-selected.
  2. Plain statement of what each is — no invented expiration windows, no invented amounts. If credit has terms, surface them; if unknown to the IA, label as scoped gap. (recommendation)
- **Affordances visible:** Filters, agent link, back to path choice.
- **One-tap-deep:** Seat map, baggage implications, accessibility services request.

### Screen 4 — Support tonight

- **Purpose:** Surface hotel, meal, and ground-support entitlements before confirmation, not after.
- **Primary decision:** Accept or decline each offered support item; or request human help if eligibility is unclear.
- **Content hierarchy:**
  1. Each entitlement as its own row: Hotel, Meals, Ground transport, Baggage handling. Each row states only what the system can confirm; if eligibility is conditional, the row says so and offers "Check with an agent." (recommendation; never invent amounts or hotel names.)
  2. Family/party context carried over: rows reflect headcount.
  3. "I don't need this" is an explicit choice — silence is not consent. (recommendation)
- **Affordances visible:** Each support row, agent link, accessibility-needs flag.
- **One-tap-deep:** Policy detail per row, receipt-upload path for out-of-pocket reimbursement if applicable (scoped gap if eligibility cannot be confirmed in-app).

### Screen 5 — Confirmation & what happens next

- **Purpose:** Replace "Your changes have been applied" with a durable, offline-capable summary.
- **Primary decision:** None required. Optional: save, share with travel party, change plans again.
- **Content hierarchy:**
  1. New flight: times, gate (if known), confirmation code, seat(s), party manifest.
  2. Support secured: hotel confirmation, meal credit status, baggage status — only what's actually confirmed.
  3. Next three concrete steps with times: e.g., "Check in 24 hours before departure," "Hotel shuttle pickup info," "Arrive at airport by X."
  4. "Plans changed again?" → re-enters recovery flow without losing context. (recommendation)
  5. Offline backup: downloadable / SMS-able summary. (recommendation; brief calls out "no offline backup.")
- **Affordances visible:** Summary, share, agent link, re-enter recovery.
- **One-tap-deep:** Full receipt, accessibility services confirmation.

## Copy constraints

- **Tone:** Plain, calm, concrete. Second person. Short sentences. No exclamation marks. No apology theater beyond one acknowledgment.
- **Required shape on every disruption screen:** what happened → what you can do → what we owe you (only if confirmed) → what happens next.
- **Never say:** "schedule irregularity," "inconvenience" as a substitute for explanation, "we appreciate your patience," "subject to availability" without a concrete next step, "may be eligible" without telling the user how to find out, legal weasel words ("at our discretion," "where applicable") without a plain-English companion sentence.
- **Never invent:** compensation amounts, hotel names, voucher dollar values, wait times, credit expiration windows, eligibility guarantees, laws, phone numbers.
- **Button copy rule:** Buttons name the outcome, not the mechanism. "See my options" not "Continue." "Confirm refund" not "Submit."
- **Numbers and times:** Always include time zone and AM/PM. Always include date if not today.

## Entry SMS rewrite shape

The SMS should:

- Name the event plainly: flight number, route, scheduled departure, that it is canceled.
- Give one concrete next step: a link to the recovery flow.
- Acknowledge support exists without promising specifics.
- Offer a human path.

Shape (not final copy — defer to content-designer for final string):

> Northstar: Flight NS482 DEN-LGA, 6:15 AM [date], is canceled. Open your options (rebook, refund, or talk to an agent): [link]. Support like hotel or meals may be available — we'll walk you through it.

Must not promise: specific compensation, hotel coverage, voucher amounts, wait times, or eligibility. Must not use "schedule irregularity." Must not be the only channel — assume the link may fail; the SMS itself should carry the flight number and a callback path. (recommendation)

## Scoped gaps

- **Family / multi-passenger:** Solved in artifact via party-size toggle on Screen 2 carried through Screens 3–5, and "seats together" filter on Screen 3. (recommendation)
- **Low bandwidth:** Solved partially — Screen 5 offline summary, text-first content hierarchy, no required imagery for decisions. Scoped gap: the recovery flow's bundle size and image-heavy flight cards need engineering input. (scoped gap)
- **Screen reader:** Solved structurally — single primary decision per screen, semantic headings in the content hierarchy, no information conveyed by color or badge alone (e.g., "Recommended" must carry its criterion in text). Detailed ARIA and focus order belong to interaction-designer. (scoped gap for that role)
- **Refund-seeker path:** Solved in artifact — refund is a peer of credit on Screen 2 and on Screen 3's refund branch, not buried inside "Travel credit." (recommendation)
- **Support visibility:** Solved in artifact — Screen 4 is dedicated to support and runs before confirmation. (recommendation)
- **Eligibility truth:** Scoped gap. The IA cannot know which entitlements actually apply to this passenger; copy patterns assume the system passes confirmed eligibility in. If it can't, every support row must default to "Check with an agent" rather than invent a promise. (scoped gap, flagged to lead)
- **Re-disruption (cancel-after-rebook):** Solved structurally on Screen 5 via "Plans changed again?" re-entry. (recommendation)

## Open questions for Visual Designer

1. How do we make Screen 2's three paths feel like genuine peers, given that "Standby" is structurally worse than rebooking?
2. How is the persistent "Talk to an agent" affordance styled so it's always reachable but doesn't compete with the primary CTA?
3. What's the visual treatment for a support row whose eligibility is "unconfirmed — check with agent" vs. "confirmed"? They must not look the same.
4. How do filter chips on Screen 3 behave on a narrow viewport without hiding themselves?
5. Confirmation screen (5): how do we make the offline/share affordance feel primary without competing with the new-flight summary?

---

## Handoff to Visual Designer

**Screen sequence (5 screens, mobile-first):**

1. **Status & what this means** — plain event statement, reassurance, single CTA "See my options," persistent agent link.
2. **Choose a recovery path** — three equal-weight cards (Rebook / Refund or credit / Standby), no default selection, party-size toggle, persistent agent link.
3. **Rebook (or Refund branch)** — flight list with filter chips (arrival, nonstop, earliest, seats together); fare difference suppressed during disruption recovery unless real and explained; "Recommended" badges must name their criterion. Refund branch shows refund and credit as peers.
4. **Support tonight** — hotel, meals, ground transport, baggage as discrete rows; explicit accept/decline; no invented amounts; "Check with an agent" when eligibility is unclear.
5. **Confirmation & what happens next** — durable summary (flight, support, next three steps with times), offline/share affordance, re-entry path if plans change again.

**Primary decision per screen:** (1) read and proceed, (2) pick a path, (3) pick a flight or confirm refund choice, (4) accept or decline each support item, (5) none required.

**Content hierarchy rule for every screen:** what happened → what you can do → what we owe you (only if confirmed) → what happens next.

**Copy constraints to honor strictly:**
- Never "schedule irregularity," "inconvenience" alone, "may be eligible" without a how-to.
- Never invent amounts, names, times, expirations, or eligibility.
- Buttons name outcomes, not mechanisms.
- One primary decision per screen.
- Persistent "Talk to an agent" on every screen.

**Scoped gaps to design around, not paper over:**
- Eligibility truth: support rows must visually distinguish confirmed vs. check-with-agent.
- Low-bandwidth: prioritize text affordances; do not let imagery carry decisions.
- Screen reader: no information by color or badge alone.
- Family travel: party context must remain visible across screens 2–5.

**Honor most strictly:** the no-default rule on Screen 2 and the visual non-equivalence of Standby vs. Rebook. The current flow's default-to-Travel-Credit is the single biggest trust failure; do not let visual hierarchy reintroduce it.
