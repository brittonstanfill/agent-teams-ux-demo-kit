# Information Architect — Structure Note

## 1. User-job spine

Under stress, in priority order:

1. **Understand what actually happened** — is my flight gone, or delayed? (observed: brief says current copy "hides the real event")
2. **Know whether I still get there in time for the thing I care about** — the family event is the real goal, not the flight (observed: brief names the family event)
3. **See what the airline will do for me without my having to ask** — rebooking, hotel, meals (observed: brief flags hidden entitlements)
4. **Pick one path forward without feeling I've waived the others** (inferred: brief says users abandon to call support — implies low trust in self-service commitment)
5. **Leave with something I can show at a gate or a hotel desk** — proof, offline (inferred: brief asks for "confidence about what happens next" and names low-bandwidth users)
6. **Know how to reach a human if this gets worse** (observed: brief's whole premise is call-volume)

## 2. Answer to CD's handoff question

Screen 1 must force exactly one decision: **"do you still need to travel, or are you out?"** That is the only fork that changes every downstream screen. Everything else — which flight, whether to take a hotel, whether to add a companion's seat, refund vs. credit mechanics — is deferred to screen 2+ and explicitly framed as reversible until a final confirm. Screen 1 names the cancellation in human words, shows what the system is already holding for the traveler (system-provided: protected seat, hotel eligibility, meal credit — present as status, not offers), and asks the travel-or-not question. It does not ask the user to choose between flights, tabs, or trade-offs before they have read the situation.

## 3. Screen sequence

**Screen 0 — SMS entry (redesigned).** Primary decision: open or ignore. Present: event in plain words ("Flight NS482 6:15a DEN→LGA is canceled"), one-line status of what's already held (system-provided), one link. Absent: marketing voice, "irregularity", apology. Rationale: information scent must match destination.

**Screen 1 — Situation + fork.** Primary decision: *still traveling, or done.* Present: event sentence, named cause (crew), what's already held for this traveler (system-provided fields, read as status), two equally legible paths: "Find me another flight" / "I'm not traveling — refund or credit". Absent: flight list, fare deltas, tabs. Why absent: forces comparison-shopping before orientation.

**Screen 2 — Replacement flights (if "still traveling").** Primary decision: pick one option. Present: chronological list, each row carries arrival time, stops, and any per-traveler eligibility flag (system-provided). Filter: arrival-by, nonstop, party-size. Absent: fare difference during disruption, opaque "Recommended" badge. Why absent: brief flags both as trust-breakers.

**Screen 3 — Confirm + support.** Primary decision: confirm the rebook and accept/decline each support item explicitly. Present: chosen flight, hotel eligibility line (system-provided), meal credit line (system-provided), per-passenger status if party >1. Absent: upsell, seat-map nudge. Why absent: not the job at this hour.

**Screen 4 — Receipt.** Primary decision: save/share. Present: new flight, hotel confirmation (system-provided), baggage instruction, offline-viewable summary, one route to a human. Absent: "Done" dead-end, survey. Why absent: brief names the no-next-step failure.

## 4. Edge cases

- **Family / multi-passenger** — solved screen 2 (party-size filter) and screen 3 (per-traveler eligibility rows). Assumes system can return per-PNR passenger status; if not, see gaps.
- **Low bandwidth** — solved screen 4 (offline-viewable text receipt) and CD's no-motion, no-illustration anchor (screens 0–3 are type-only).
- **Screen-reader** — solved structurally: one primary decision per screen, headline states event, status lines are text not iconography. Visual Designer must preserve heading order.
- **Refund-seeker** — solved on screen 1: the "I'm not traveling" fork is co-equal with rebooking, not buried in a tab. Refund vs. credit mechanics resolve on a screen 2-equivalent under that branch (same slot, different content).

## 5. Scoped gaps / assumptions

- **Load-bearing assumption:** the airline system can return per-traveler eligibility (hotel, meal, rebooking protection) as structured fields. If it cannot, screen 3's per-passenger rows collapse to a single party-level status and the trust gain is reduced.
- **Assumption:** "I'm not traveling" can be offered without the system pre-committing the traveler to a specific refund instrument. If only credit is available, screen 1's second fork must say so in its label.
- **Assumption:** SMS sender can carry a real flight identifier and cause string. If the upstream system only emits "irregularity," screen 0 cannot be fixed at the IA layer.
- **Recommendation:** treat every numeric (wait time, voucher amount, credit expiry, hotel name) as a system-provided slot rendered by Visual Designer; never hard-code.
- **Inferred:** users abandoning to phone is a trust-and-orientation failure, not a feature gap. Structure fixes most of it; copy fixes the rest.

## 6. Handoff to Visual Designer

First thumb-reach, no scroll, per screen:

- **Screen 0 (SMS):** flight id + event verb + one link. Nothing else above the fold of a notification.
- **Screen 1:** headline (event in human words), one supporting line (cause), status block (what's held — system-provided fields), two path buttons of equal visual weight. The travel-or-not fork must be visible without scrolling.
- **Screen 2:** sort/filter row, first two flight rows, each row legible end-to-end without horizontal scan. No "Recommended" badge.
- **Screen 3:** chosen flight summary, hotel line, meal line, per-passenger rows if party >1, single confirm. Decline controls per support item, not buried.
- **Screen 4:** new flight block, hotel block, "save offline" affordance, one "talk to a person" link. No celebratory state, no "Done" terminal.

Hold the dispatcher posture: type-led, motion-free, no sympathy-theater. If a screen needs an illustration to feel calm, the structure is wrong — come back to me.
