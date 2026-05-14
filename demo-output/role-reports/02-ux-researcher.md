# 02 — UX Researcher: Needs, Confidence Collapse, Assumption Audit

Scope: 10:46 p.m. cancellation, mobile-only, family event next day. Working from brief and CD anchor only. No invented data.

---

## 1. Top 3 user needs (jobs-to-be-done, in user's voice at 10:46 p.m.)

1. **"Tell me plainly what just happened to my flight tomorrow morning, before you ask me to do anything."** (inferred from brief; emotional state: jolted-awake, not-yet-oriented)
   - The user cannot make a choice until they have the fact. "Schedule irregularity on NS482" forces interpretive work the user is in no state to perform.
2. **"Show me my real choices side-by-side, with the consequence of each, so I can pick without gambling."** (inferred; emotional state: triaging, comparing against the family event)
   - "Travel credit" vs. "New flights" vs. "Standby" are not equivalent and the user knows it intuitively, but the current flow treats them as parallel tabs (observed-from-brief).
3. **"Confirm I'm safe tonight and arriving tomorrow — with a receipt I can show, screenshot, or read offline."** (inferred; emotional state: needs proof, distrusts the system that just failed them)
   - Confirmation must include hotel, new flight number, baggage state, arrival time, and a human fallback number. Without these in one capturable block, the user calls support to "make sure." (inferred from brief's noted absence of these on Screen 5)

---

## 2. Emotional state arc & confidence collapse

The current flow's emotional arc (inferred from brief structure):

| Stage | What the user is doing | What the screen demands | Gap |
|---|---|---|---|
| SMS receipt | Reading half-asleep, parsing "irregularity" | Decode jargon | Fact is hidden. Confidence starts neutral; ambiguity erodes it. |
| Screen 1 (Trip Status) | Looking for the fact and the next move | "Continue" with no target | Confidence dips — button promises nothing. |
| Screen 2 (Recovery Options, Travel-credit default) | Looking for "how do I still get there tomorrow" | Pick a tab | **Confidence collapse point.** The default tab pushes a path that abandons the trip. The user reads this as the airline steering them away from rebooking. (inferred-from-brief; high signal because the brief explicitly notes the default mismatch and the tabs hiding comparison) |
| Screen 3 (Flight list) | Comparing against family-event arrival time | Decode "Recommended"; absorb a fare-difference charge | Confidence does not recover — a charge during a cancellation reads as a second betrayal. (inferred) |
| Screen 4 (Support FAQ) | Wondering "do I get a hotel?" | Find the entitlement themselves under "Other policies" | The user concludes self-service is hiding the help. **This is where they call support.** (inferred-from-brief; the brief's own framing is "people abandon the flow and call support") |
| Screen 5 (Confirmation) | Needing proof to sleep on | "Done" | No receipt to screenshot. User calls support to confirm what they just confirmed. (inferred) |

**Confidence collapses at Screen 2, the default-tab moment, and shatters at Screen 4 when entitlements are hidden.** (inferred-from-brief, medium confidence — single-source evidence, but the brief itself flags both points as suspected problems and they align with the CD's order-of-operations frame.)

What each stage demands (recommendation):
- SMS: name the event, name the next action, name the time horizon.
- Stage 1 (Fact): the cancellation as a plain sentence and the current state ("you are not yet rebooked").
- Stage 2 (Options): three paths visible simultaneously, with one-line consequences.
- Stage 3 (Choose): no fare difference framing during cancellation recovery; arrival time is the primary sort key, not airline-internal "Recommended."
- Stage 4 (Entitlements): surfaced, not earned. Persistent, not nested.
- Stage 5 (Confirm-with-receipt): screenshotable block; works offline; one number to call if it falls apart.

---

## 3. Assumptions to validate

| # | Assumption | Why risky | Lightest test | What would falsify it |
|---|---|---|---|---|
| A1 | Travelers want rebooking by default, not travel credit. (assumption) | Current flow defaults to credit; if the brief's authors guessed wrong about user intent, our redesign inherits the error. | 5-person moderated test on a clickable prototype; observe first-tap behavior on the options screen. | ≥2 of 5 deliberately choose credit first when asked to "get to the family event." |
| A2 | Arrival time is a higher-priority sort dimension than nonstop/price. (assumption) | The "family event next day" frame implies arrival-time priority, but a business traveler scenario would invert this. | Card-sort with 8 participants across two scenarios (urgent event vs. flexible trip). | Arrival time ranks below price for >40% of urgent-event participants. |
| A3 | Hidden entitlements are the primary driver of support calls, not flight-choice anxiety. (assumption) | The brief lists both; we don't know which dominates. | Read 50 anonymized recent support-call transcripts/tickets and tag the *first* unresolved question. | Flight-choice questions outnumber entitlement questions ≥2:1. |
| A4 | A persistent entitlements strip is read as helpful, not as visual noise that competes with the primary choice. (assumption — CD anchor proposes the pattern) | Visible-everywhere UI can blur into chrome. | 5-second test: after viewing the options screen, can users recall that hotel/meal support exists? | <60% recall unaided. |
| A5 | Users want one screenshotable receipt on confirm, not a sequence of confirmation emails. (inferred) | Behavior here may already be habituated to email confirmations. | Diary-style follow-up: ask 10 recent disruption travelers what they did with the airline's confirmation screen. | Majority deleted/ignored it and relied on email. |

---

## 4. Research questions for the post-launch experiment

(recommendation; behavioral-scientist owns the experimental design — these are the questions to instrument against)

1. Does self-service completion (rebook OR credit OR standby chosen and confirmed without calling) rise vs. the current flow?
2. At which screen do abandonment-to-call events drop most? (Diagnostic — tells us *which* fix mattered.)
3. Do users who see the entitlements strip claim hotel/meal at a rate closer to actual eligibility (proxy: rate of voucher claims per cancellation event)?
4. Does the "operational header" (fact + current state) reduce time-to-first-decision on the options screen?
5. Among users who do still call: what is the first thing they ask? (Free-text capture from agents — tells us what the screen failed to communicate.)
6. Accessibility cut: does completion rate for screen-reader and 200%-zoom users match the sighted/default-zoom cohort within 5 percentage points? If not, we have shipped a two-tier product. (recommendation)

---

## 5. Risk: who this design will fail

Specific users this design, as currently anchored, is most likely to fail (inferred + recommendation):

- **Group of 4 (e.g., family) trying to sit together.** The flight cards say nothing about seat-map availability for a party. They will pick a flight, discover no four seats, and call. **Highest-likelihood failure mode given the "family event" framing in the brief.** (inferred, high confidence)
- **Traveler with infant or service animal.** No filter or surfacing for bassinet rows, pet-in-cabin restrictions, or service-animal accommodation on the rebooking cards. They will not trust the self-service path and will call.
- **Deaf / hard-of-hearing user reliant on SMS.** The entry SMS is the entire context. "Schedule irregularity" fails them hardest because the phone-fallback is not equivalent (TTY/relay friction). The SMS must carry more weight for this user than for any other.
- **ESL traveler.** "Schedule irregularity," "standby," "fare difference," and "Other policies" are all idiomatic. Plain-language is not a preference here; it is access.
- **Low-bandwidth airport / hotel-wifi user.** If the confirmation screen relies on a live fetch to render the receipt, it fails exactly when the user needs it. Receipt must render from cached state. (recommendation to interaction-designer)
- **Mobility-needs traveler.** No surfacing of accessible seating, jet-bridge boarding, or wheelchair-assist continuity on the new itinerary.
- **Traveler whose plans change *again* mid-recovery** (e.g., the rebooked flight is also delayed). The current Screen 5 has "Done" as the terminal state. There is no re-entry path. (observed-from-brief)

The **group-of-four-seats** failure is the one I would flag to CD as not-yet-addressed by the current anchor. The entitlements strip solves the hotel problem; nothing yet solves the party-size problem.

---

## 6. Handoff messages

### To Information Architect

Top 3 user needs map to a decision order, not a screen order. The decision order is:

1. **Fact** ("what happened") — must precede everything; user cannot decide without it.
2. **State** ("am I rebooked yet — no") — sets the stakes for the next screen.
3. **Options with consequences** (three paths, comparable in one view, no tabs) — the highest-leverage screen; this is where confidence currently collapses.
4. **Choose** (flight cards sorted by arrival time, with party-size + accessibility filters surfaced — not buried).
5. **Entitlements** (persistent strip, per CD; user should not have to "find" hotel/meal).
6. **Confirm-with-receipt** (one screenshotable block; offline-renderable; re-entry path visible).

Specific ask: do not let "Choose" and "Options" collapse into one screen at the cost of side-by-side consequence visibility. If you can make four screens work without losing the simultaneous comparison, do four — but compare-in-one-view is the load-bearing pattern. (recommendation)

Open question for you: where does the **party-size / accessibility filter** live? It is not yet anchored. My recommendation: surface it on the options-to-flights transition, not as a hidden filter icon. Treat it as part of the question "which flight," not a refinement.

### To Content Designer

Top 3 user needs translated to emotional register:

1. **Need 1 (the fact):** plain operational language, present tense, no softening verbs. "Your 6:15 a.m. flight tomorrow is canceled." Not "has been impacted." Not "we regret to inform you." CD has banned apology-first headlines and I am aligned. (recommendation)
2. **Need 2 (the choices):** the consequence line under each option is the most important sentence in the product. Examples to pressure-test: "You arrive tomorrow afternoon." "You decide later. No flight is held for you." "You wait at the gate. A seat is not guaranteed." Write the consequence first; the label second.
3. **Need 3 (the receipt):** the confirmation block must be scannable in 4 seconds and survive being screenshotted. Order: new flight number + times, hotel name + address, baggage state, arrival time, fallback phone number. No marketing close.

Register notes:
- The user is tired, not stupid. No hand-holding. No "Don't worry!"
- Numbers (times, flight numbers, fare differences) must be unambiguous and tabular.
- "Recommended" is currently doing copy work that should be doing logic work — if a flight is recommended, the *reason* must be in the line, not in a badge. (recommendation; aligns with CD's call-out)
- SMS copy carries the most weight for the deaf-user / ESL-user cuts. Write the SMS as if it is the only thing they will read. It might be.

Open question for you: the entitlements-strip microcopy. "Hotel and meal support available. Tap to claim." is a starting point — but if it's wrong about *who* is eligible, it becomes a trust violation. Coordinate with whoever owns policy truth so the strip doesn't promise something the next screen retracts.

---

*Confidence levels: needs and arc — medium (single-source brief, but internally consistent and CD-aligned). Assumptions section — low by design; that is the point. Risk section — medium-high (these failure modes are well-established in airline-disruption literature and inferable from the brief's own constraints list).*
