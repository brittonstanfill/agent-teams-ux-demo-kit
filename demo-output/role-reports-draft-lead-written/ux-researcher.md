# UX Researcher — Northstar Canceled-Flight Recovery

**Role:** UX Researcher
**Scope:** Disruption-recovery journey from 10:46 p.m. SMS through next-day arrival
**Inputs used:** Brief only. No invented metrics, interviews, or quotes.

---

## Top 3 Findings

1. **The user's first need is *understanding what happened*, not "managing trip."** [observed from brief] The SMS uses "Schedule irregularity," and Screen 1 says "Your itinerary has changed." Both delay the only fact the user actually needs: *the flight is canceled and you cannot fly at 6:15 a.m.* The product makes the user *work* for the headline. [inferred]
2. **At 10:46 p.m., the user is in a "decide-while-depleted" state.** [inferred from brief context: tired, mobile-only, family event] Cognitive load is high, working memory is reduced, and stakes are non-trivial (missing a family event). The flow asks for multiple consequential decisions (which option, which flight, whether to call) without first reducing uncertainty. [recommendation]
3. **Entitlements (hotel, meal) are part of the user's *core* need, not "other policies."** [observed from brief, hotel/meal currently in collapsed FAQ] If the user cannot fly until afternoon or tomorrow night, where they sleep and eat *is* the recovery. Treating hotel as ancillary forces the user to either pay out of pocket or call support. [recommendation]

---

## Evidence Labels

- **[Observed from brief]:** SMS copy, screen sequence, default tab is "Travel credit," "Recommended" badge unexplained, fare difference shown during disruption, hotel/meal in collapsed "Other policies" FAQ, "Done" confirmation says only "Your changes have been applied," users abandon and call support.
- **[Inferred]:** Tired-traveler context implies elevated stress and reduced decision capacity; mobile-only implies a small screen, possible low bandwidth, single-hand operation; family-event implies a hard deadline and a low tolerance for ambiguous outcomes.
- **[Assumption]:** The traveler is the sole decision-maker on a multi-passenger reservation; the link works; the user has a payment method on file; the user reads English.
- **[Recommendation]:** Treat *understanding* as the first deliverable; treat *entitlements* as core, not peripheral; treat *confidence-on-exit* as the success metric.

---

## Primary User Needs (in priority order)

1. **Understand what happened.** Plain language. The actual event ("canceled"), the reason in one phrase ("crew availability" [observed from brief]), and what it means for *me tomorrow*.
2. **See the options that solve my actual problem.** "Get me there," "get me there later but free," "give up and take a credit." The option that matches a cancellation user's likely goal (a new flight) should be the default. [recommendation]
3. **Know what help is available without hunting.** Hotel, meals, support phone — visible at decision time, not after a tab dive.
4. **Choose with confidence and undo if wrong.** A 60-second reversibility window or a clear pre-commit summary so the user is not afraid of "did I just do the wrong thing?" [recommendation, informed by accessibility-specialist's reversibility ask]
5. **Leave with a complete, offline-readable summary.** New flight time, terminal, hotel address, confirmation code, support number — accessible even if the app crashes or there's no signal at the hotel.

## Secondary User Needs

- Reach a human if self-service feels wrong. *Without* having to abandon the flow and find a phone number on Google.
- Receive the same information by a second channel (SMS / email) for partner, employer, or memory's sake.
- Family-party clarity: "rebooking for all 3 travelers on this reservation" — confirms scope.
- Mobility/medical/family filters on flight options (e.g., nonstop, arrival window).
- Low-bandwidth survival: the flow has to work on hotel Wi-Fi or 1-bar LTE.

---

## Emotional State by Step (current flow)

| Step | Likely emotional state | What the flow does | Gap |
|---|---|---|---|
| SMS arrives 10:46 p.m. | Spike of dread + confusion | Says "Schedule irregularity" with no next step | Ambiguity → catastrophizing |
| Tap link | Anxious, fumbling | "Your itinerary has changed" | No reassurance, no agency |
| Screen 1 → "Continue" | Wary | Doesn't explain what Continue does | Trust erosion |
| Screen 2 default tab "Travel credit" | Alarm ("did I just lose my flight?") | Defaults to credit, not rebook | Misaligned default → panic or wrong choice |
| Screen 3 fare difference | Anger / suspicion | Shows "$84" without context | Feels like upsell during a disruption |
| Looking for hotel | Hunting, frustrated | Buried in "Other policies" | Helplessness → calls support |
| "Trip updated. Done." | Uncertain | No itinerary detail | Doesn't *feel* resolved |

[inferred throughout; this is a reasoned read of the brief, not measured.]

## Emotional State by Step (target)

| Step | Target state | Mechanism |
|---|---|---|
| SMS | "Calmed, in control" | Lead with the event + one next step + reassurance: "We're holding options for you." |
| Screen 1 | Oriented | Show what changed and what we're doing about it. |
| Screen 2 | Confident | Default to rebook; show hotel/meal at the same level; explain "Recommended." |
| Screen 3 (review) | Decisive | Pre-commit summary: "Rebook on 2:40 p.m. tomorrow. Free. We'll hold a hotel near DEN for tonight." |
| Screen 4 (confirmation) | Done, equipped | Full itinerary, hotel address, confirmation code, support number, undo window. |

---

## Open Research Questions (validate before / during ship)

1. **Where does abandonment happen now?** Screen 1, Screen 2 default tab, Screen 3 fare-difference shock, or Screen 4 (hotel hunting)? Different failure points imply different fixes.
2. **What proportion of cancellation users *want* a credit vs. a rebook?** Brief implies most want to get there. Validate before defaulting the tab.
3. **Does the "Recommended" tag move behavior?** And does anyone trust it without an explanation?
4. **What language do users use for "hotel voucher"?** Is "Hotel help" clearer than "Hotel voucher"? Does "voucher" feel transactional or reassuring?
5. **What's the role of the SMS vs. the app?** Many users may make the decision in the SMS preview without opening the app. The SMS may be the product.
6. **Family/party scope confusion:** how often does the user not realize the rebook covers all passengers?
7. **What's the "moment of trust" in this flow?** The pre-commit summary? The confirmation? The follow-up SMS?

## Assumptions to Test

- **A1:** Most cancellation users on this flow want a same-day rebook. *Test:* directional analytics on tab dwell + selection.
- **A2:** Users want hotel help to be visible *before* they've chosen a flight, not after.
- **A3:** Users will tolerate a 60-second "undo" window in exchange for a faster pre-commit screen.
- **A4:** Plain-language framing ("canceled", "free", "no charge") reduces calls more than visual polish does.
- **A5:** A persistent, consistently placed "Call support" *reduces* total calls (because users feel safer choosing self-service when escape is visible) rather than increases them.
- **A6:** Confirmation that includes an *offline* summary (SMS + copyable block) reduces "did it work?" callbacks.

## Research Methods I'd Run if We Had Time

- **Diary study** with 8–12 travelers who experienced an overnight disruption in the last 90 days. Captures the real emotional arc.
- **Concept test (unmoderated)** comparing current flow vs. redesigned flow on the same scenario. Primary measure: confidence-on-exit (5-pt) + open-ended "what's next?" comprehension.
- **Comprehension test of "Recommended."** Show three labelings: "Recommended," "Recommended: earliest arrival," "Best match: earliest, no charge." Measure trust + selection.
- **Support-call audit.** Sample 100 cancellation calls; tag by which screen the caller bailed from. *(Cannot do this without real data; flagging as needed.)*

---

## Handoffs Sent

### → info-architect

**Subject: Top user needs to shape flow structure**

Three needs that should drive the IA, in priority order:

1. **Understand what happened (front-load the event, not the system).** Screen 1 must lead with: *flight canceled, here's what we're doing.* Not "itinerary changed."
2. **Surface the right *kind* of option first.** Most cancellation users want a rebook. Default landing should be "Get me there" — not a credit. Tabs that hide consequences are dangerous; consider replacing with named, consequence-bearing options.
3. **Hotel + meal are part of the recovery, not "policy."** Put a visible, named entry point on the same screen as flight selection. Not behind a disclosure.

Also: the SMS is a screen. Treat it as Screen 0 in your IA, not as outside the product.

### → content-designer

**Subject: Top user needs to shape voice and reassurance**

Three voice rules driven by user state:

1. **Lead with the event, then the reassurance, then the action.** "Your 6:15 a.m. flight tomorrow is canceled. We're holding options for you. Tap to see them." Three short sentences max.
2. **No system language.** "Schedule irregularity," "itinerary has changed," "your changes have been applied" — all replace with plain English. Target ~grade 6–8 (aligns with accessibility-specialist's 3.1.5 ask).
3. **Explain badges and prices.** "Recommended" without a reason erodes trust. "$84 fare difference" during a disruption looks like an upsell unless we phrase whether it applies.

Also: confirmation copy must be a recap of *facts* the user can act on, not a mission statement.

---

## Handoffs Received

| Sender | Message | What changed |
|---|---|---|
| _(none received at write time — this report was written first; revisions will come from info-architect's flow proposal and accessibility's blockers if they alter user-needs priority.)_ |  |  |

---

## What I Cannot Tell Without Data

- Whether the "Travel credit" default reflects an explicit business policy or a UX accident.
- Whether the support-call spike happens before, during, or after rebooking.
- Whether users currently *find* the hotel FAQ at all.
- How often a cancellation is overnight (hotel needed) vs. same-day (only rebook needed) — this changes how prominent hotel should be.

---

## Recommendation Summary (research view)

Design for the emotional arc, not the task list. The user enters tired, anxious, and time-pressured; the goal is to leave them rested-feeling, decided, and equipped. The flow earns trust by reducing uncertainty at every step — event first, options second, support visible, confirmation complete, undo possible.
