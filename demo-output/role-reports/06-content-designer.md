# 06 — Content Designer: Voice, SMS, Screen Strings, Errors

Posture: every string in this flow is operational. At 10:46 p.m. the user reads to act, not to feel. I write the words to match the register CD set, the order UXR named, the slots IA cut, and the lengths VD locked. I do not invent policy.

Drop-in quality: a copy editor reading section 3 onward should be able to paste these strings into the prototype without changing a character.

---

## 1. Voice / tone rules

Five rules for this surface (recommendation, calibrated to a tired traveler at 10:46 p.m.):

1. **State the fact in the user's words, present tense, no softening verbs.** "Your 6:15 a.m. flight tomorrow is canceled." Not: "has been impacted," "regret to inform," "we're working on it."
2. **Verbs on buttons describe what happens next, not what the user is doing emotionally.** "See your options." "Confirm 7:10 a.m. flight." "Claim meal credit." Banned: Continue, Submit, OK, Done, Got it, Oops.
3. **Numbers are tabular and unambiguous.** Always "6:15 a.m." not "6:15AM." Always "1-800-555-0142" not "(800) 555.0142." Dates carry weekday + month + day when ambiguity is possible. (observed-from-brief: UXR — "numbers tabular")
4. **Warmth lives in the verb choice on actions, never in the headline.** "Claim" (not "Get"), "Pick" (not "Choose your"), "Add me to standby" (the "me" is the warmth — the noun stays cold). The headline is matter-of-fact; the actions acknowledge there is a person reading. (observed-from-brief: UXR)
5. **No apology lede, ever. No "we're sorry," no "oops," no "unfortunately."** If something failed, the copy says what failed and what to do next, in that order. Apology, if needed, comes after the recovery action, never before it. (observed-from-brief: CD ban)
6. **Idiom-free for ESL and screen-reader users.** No "heads up," "no worries," "hang tight," "we've got you covered." Plain Anglo-Saxon verbs whenever there's a choice. (inferred from UXR Risk section)

Tone gradient on this surface: matter-of-fact at headline, plain-direct on actions, factual on errors, neutral on receipt. Never celebratory; never apologetic.

---

## 2. SMS entry copy

Hard constraints (observed-from-brief + IA): airline identity first token, the word "canceled," flight number + original time, current state, deep link, phone fallback. Banned: "Schedule irregularity," "Alert," apology lede.

**Primary (157 chars, recommendation):**

> Northstar Air: Flight NS482, Wed 6:15 a.m. DEN-LGA, is canceled (crew). Not yet rebooked. See 3 options: northstar.app/ns482 or call 1-800-555-0142.

**Alternate A (152 chars, terser, no reason fragment):**

> Northstar Air: NS482, Wed 6:15 a.m. DEN-LGA, is canceled. You're not yet rebooked. Open 3 options: northstar.app/ns482 — or call 1-800-555-0142.

**Alternate B (159 chars, state-first ordering for screen-reader cadence):**

> Northstar Air: You're not yet rebooked. NS482, Wed 6:15 a.m. DEN-LGA, is canceled (crew). Tap for 3 options: northstar.app/ns482. Phone: 1-800-555-0142.

Recommendation: ship Primary. It leads with the fact (the thing the user has to decode first), names the cause in three letters, makes the non-rebooked state explicit, and offers both channels. Alternate B is the right choice if research shows screen-reader users with TTS at high speed miss the state line buried mid-message. (assumption)

---

## 3. Screen-by-screen copy

All strings drop-in. Where the prototype already has the final string, I am ratifying it (not re-writing for the sake of it). Where it doesn't, the new string is below.

### Screen 1 — Status & Stake (default)

| Slot | Final string |
|---|---|
| Meta line | `NS482 · DEN to LGA · Wed, May 14` |
| Fact (h1) | `Your 6:15 a.m. flight tomorrow is canceled.` |
| State line | `Reason: crew availability. **You have not been rebooked yet.** Three options are ready below.` |
| Primary CTA | `See your options` |
| Secondary | `View full itinerary` |
| Tertiary | `Or call 1-800-555-0142` |
| Strip label | `Hotel and meal support available` |
| Strip status | `Not yet claimed — eligible for tonight` |

### Screen 1 (variant) — Second cancellation

| Slot | Final string |
|---|---|
| Meta | `NS214 · DEN to LGA · Wed, May 14 (rebooked from NS482)` |
| Fact | `Your rebooked 10:20 a.m. flight is also canceled.` |
| State | `**This is the second cancellation on this trip.** Credit and standby are listed first below. You can still try another rebook.` |
| Strip label | `Hotel claimed — Marriott DEN Airport` |
| Strip status | `Meal credit also available` |

### Screen 2 — Choose Your Recovery

| Slot | Final string |
|---|---|
| Meta | `NS482 canceled · 3 travelers on this booking` |
| Fact | `Pick a path.` |
| State | `All three are available right now. Choose what arrives first, what waits, or what cashes out.` |
| Section head | `YOUR THREE OPTIONS` |
| Primary CTA (after selection) | `Continue with rebook` / `Continue with credit` / `Continue with standby` (label updates to match selected card; never just "Continue") |
| Tertiary | `Why these three?` |

(Path-card label and consequence copy in section 4.)

### Screen 3 — Rebook variant

| Slot | Final string |
|---|---|
| Meta | `DEN to LGA · 3 travelers` |
| Fact | `Pick the flight.` |
| State | `Sorted by arrival time. Party-size status is on each card.` |
| Sort row | `Sorted by **Arrival**` · link: `Filters` |
| Primary CTA | `Confirm 7:10 a.m. flight` (time updates to match selection; never just "Confirm") |
| Tertiary | `Back to options` |

(Flight-card field copy in section 5.)

### Screen 3 — Credit variant

| Slot | Final string |
|---|---|
| Meta | `NS482 · canceled` |
| Fact | `Take $847 in travel credit.` |
| State | `Good for 12 months from today. **No flight is held for you.** You can rebook later from your account.` |
| Section head | `WHAT YOU GET` |
| Body bullets | `$847 credit, valid through May 14, 2027.` / `Use it on any Northstar flight.` / `Original baggage refund processes in 7–10 business days.` |
| Primary CTA | `Accept credit` |
| Tertiary | `Back to options` |

### Screen 3 — Standby variant

| Slot | Final string |
|---|---|
| Meta | `DEN to LGA · 3 travelers` |
| Fact | `Join standby for the next flight.` |
| State | `Next flight: **9:55 a.m., NS388.** Estimated standby position: 4th, 5th, 6th of 8 today. **A seat is not guaranteed.**` |
| Section head | `WHAT TO EXPECT` |
| Body bullets | `We'll text you the moment a seat clears.` / `Check in at gate B24 by 9:25 a.m.` / `If you don't clear, we'll roll you to the next flight automatically.` |
| Primary CTA | `Add me to standby` |
| Tertiary | `Back to options` |

### Screen 4 — Receipt

| Slot | Final string |
|---|---|
| Stamp | `NORTHSTAR AIR · TRIP UPDATED` |
| Headline | `You're on the 7:10 a.m.` |
| dt labels | `FLIGHT` · `TRAVELERS` · `CONFIRM` · `BAGS` · `HOTEL` · `MEAL` · `SUPPORT` |
| Flight dd | `**NS214** — DEN 7:10 a.m. → LGA 11:48 a.m. · 1 stop ORD` |
| Travelers dd | `3 confirmed: Stanfill / Stanfill / Stanfill` |
| Confirm dd | `**K7H2QR**` |
| Bags dd | `Re-tagged through to LGA. No re-check at ORD.` |
| Hotel dd | `**Marriott DEN Airport — claimed.** Confirm WX44218 · Check-in tonight, breakfast included.` |
| Meal dd | `$36 credit available.` link: `Claim now` |
| Support dd | `**1-800-555-0142**` sub: `Have your confirm code ready.` |
| Secondary | `Save / share receipt` |
| Tertiary | `Plans changed? Start over` |

### Loading state

Primary button replaces label with: `Checking seats…` (ink-3, `aria-busy="true"`). Never a spinner gif; never a percentage. (observed-from-brief: VD)

### "Plans changed? Start over" confirm dialog

| Slot | Final string |
|---|---|
| Sheet title | `Start over?` |
| Body | `Your current confirmation stays valid until you confirm a new option. Hotel and meal claims also stay.` |
| Primary | `Start over` |
| Secondary | `Keep current trip` |

---

## 4. Path card copy (Screen 2)

Length-locked: one line for consequence at 17/25, single visual line. I tested every consequence line against ~52 characters at 17px on a 390px-wide card with 20px internal padding; all three fit on a single line. (recommendation)

| Card | Label | Right-aligned data | Consequence (1 line, 17/25) |
|---|---|---|---|
| Rebook | `Rebook on a new flight` | `Earliest: 7:10 a.m.` | `You arrive Wednesday morning. All 3 seats confirmed, no charge.` |
| Credit | `Take travel credit` | `$847 value` | `You decide later. No flight is held. Credit good for 12 months.` |
| Standby | `Join standby` | `Next: 9:55 a.m.` | `You wait at the gate. A seat is not guaranteed.` |

Changes from VD's placeholders, with rationale:

- Rebook consequence: tightened "tomorrow morning" → "Wednesday morning" (the brief's Wednesday — eliminates relative-time ambiguity that a screen-reader read at 11:30 p.m. would render ambiguously; "tomorrow" of "tonight at 10:46" is the same day mathematically and the user is already confused). Added "all 3 seats confirmed, no charge" — this is the *consequence* the rebook card must promise, not just "you arrive."
- Credit consequence: kept VD's "no flight is held" — that was the load-bearing word. Added the term length so the consequence is complete in one read.
- Standby consequence: kept verbatim. It is correct.

All three pass the "what happens if I tap this?" test from IA.

---

## 5. Flight card copy (Screen 3 rebook variant)

### "Why?" link — final decision

**Recommendation: cut "Why?" on cards where fare is "No charge." Keep it only on cards where a fare difference applies, and write the disclosure as one factual sentence.**

Reasoning: CD's standing concern is that "Why?" must earn its keep. On a "No charge" card, "Why?" is asking the user to investigate why they aren't being charged on a cancellation — which is the moment the user concludes the airline is shopping for an excuse to charge them. The link itself is the trust violation. On "No charge" cards, drop the link entirely.

On cards where a fare difference *does* apply (not shown in the current prototype but real in production), the disclosure copy, on tap, is one sentence:

> `Fare difference is the cabin/route price gap between your original ticket and this flight. Northstar covers cancellation rebooking; cabin upgrades and route changes you select are billed.`

If legal/policy refuses to ship that sentence verbatim, the fallback is to remove the user-facing fare-difference field from the rebook surface entirely and surface it only on the credit variant. (recommendation; the "Why?" link cannot be a black box on this surface)

For the current three-card prototype state (all "No charge"): **remove the "Why?" link from the prototype.** Replace nothing — "No charge" is the complete answer.

### Party-size status lines — final

| State | Final string |
|---|---|
| All seats together | `All 3 confirmed together` |
| Split required | `Only 2 seats together. **Split party?**` |
| All seats but not adjacent (edge case) | `All 3 confirmed — seats not adjacent` |
| Insufficient seats (edge case) | `Only 1 seat available on this flight` |

VD's wording is correct on the first two. I'm adding the two edge-case strings because party-size has more than two states and the prototype currently has no copy for them. (recommendation)

### Flight card field labels (for assistive-tech aria-label only, no visible text change)

Each flight card's full aria-label, computed from the visible content, in this order: arrival time + arrival date + flight number + departure time + stops + duration + party status + fare. Engineering builds the string; I'm specifying the *order* because it matches the user's scanning sequence and the screen-reader cadence UXR called for. (handoff to A11y in section 9)

---

## 6. Entitlements strip + sheet copy

### Strip — four status variants

| Status | Strip label (line 1, 17/25) | Strip status (line 2, 14/20) |
|---|---|---|
| Not yet claimed | `Hotel and meal support available` | `Not yet claimed — eligible for tonight` |
| Partially claimed (one of two) | `Hotel claimed — Marriott DEN Airport` | `Meal credit also available` |
| Both claimed | `Hotel and meal — claimed` | `See receipt for details` |
| Not eligible for this disruption | `Support options for tonight` | `Hotel not available — meal credit only` |
| Pending (claim submitted, not confirmed) | `Hotel — confirming with Marriott` | `Usually takes under a minute. Tap to check.` |

Eligibility phrasing rule (recommendation): the strip never promises something a downstream surface might retract. "Eligible for tonight" is true only when the back-end has confirmed eligibility for *this* disruption. If eligibility is conditional on facts the user must check (e.g., "if your delay exceeds 4 hours"), the strip says: `Hotel and meal — may apply` with status `Tap to see what qualifies.` (assumption; depends on what state the system actually knows)

### Sheet copy

| Slot | Final string |
|---|---|
| Title | `Hotel and meal support` |
| Subtitle | `For tonight's cancellation. No code needed — tap to claim.` |
| Hotel row title | `Hotel — one night` |
| Hotel row body | `Marriott DEN Airport, shuttle on demand. Eligible for all 3 travelers, one room.` |
| Hotel claim | `Claim` (becomes `Claimed` post-tap, non-interactive, ink-3) |
| Meal row title | `Meal credit` |
| Meal row body | `$12 per traveler at any DEN airport vendor. Valid tonight and tomorrow morning.` |
| Ground transport row title | `Ground transport` |
| Ground transport row body | `Not available for this disruption. Hotel shuttle is on us.` |
| Ground claim slot | `Not eligible` (ink-3, non-interactive) |
| Close action | `Back to options` |

"Not eligible" copy rule: when something is not available, the sheet says so plainly with a one-line reason. We never hide unavailable entitlements — the user must be able to confirm what they aren't getting so they don't keep looking. (recommendation, addresses UXR confidence collapse at "what about my hotel")

---

## 7. Receipt block copy

Already specified in section 3. Two additional notes for screenshot survival:

- The stamp line `NORTHSTAR AIR · TRIP UPDATED` must render as plain text, not an image, so it survives screenshot OCR and screen readers. (handoff to A11y)
- The support number on the receipt is the only `tel:` link on the surface. Its visible text is `1-800-555-0142`; its aria-label is `Call Northstar support, 1-800-555-0142` so a screen-reader user understands what the link does without having to traverse the surrounding dd. (handoff to A11y)
- "Plans changed? Start over" — the question mark is deliberate. It signals an offer, not a directive. Banned alternates: "Need to change?" (vague), "Modify trip" (org-chart), "Restart" (sounds destructive).

---

## 8. Error / edge copy

Every error follows the rule: what happened / what it means / what to do — in that order, in as few words as possible. Never blame the user.

| Error | Final copy |
|---|---|
| Held-seat expired | Title: `Those seats just released.` Body: `Held seats time out after 10 minutes. The 7:10 a.m. is still showing 3 seats together — try again, or pick another.` Primary: `Try 7:10 a.m. again` · Secondary: `See other flights` |
| Rebook submit failed | Title: `That didn't go through.` Body: `The booking didn't save. Your old ticket is still active. Try again, or we can do this on the phone.` Primary: `Try again` · Secondary: `Call 1-800-555-0142` |
| Claim failed (hotel or meal) | Title: `Couldn't claim the hotel.` Body: `Marriott didn't confirm. Your spot in line is held for 15 minutes. Try again, or call so we can place it manually.` Primary: `Try again` · Secondary: `Call 1-800-555-0142` |
| Deep link, logged out | Title: `Sign in to see your options.` Body: `Your flight NS482, Wed 6:15 a.m., is canceled. Sign in to rebook, claim credit, or join standby.` Primary: `Sign in` · Secondary: `Call 1-800-555-0142` (Note: the fact is still visible before sign-in — observed-from-brief, IA: "auth interstitial that does not hide the fact") |
| Offline | Title: `You're offline.` Body: `Your last confirmation is saved below. The support number works without data.` (Receipt block still renders from cache; "Save / share receipt" remains active; "Start over" becomes inert with sub: "Reconnect to change your trip.") |
| Filter returned zero flights | Title: `No flights match those filters.` Body: `Try removing one filter, or switch off arrival window. You can also accept credit and rebook later.` Primary: `Clear filters` · Secondary: `Take credit instead` |
| Standby roll-forward (auto, post-confirm) | SMS: `Northstar Air: You didn't clear the 9:55 a.m. We rolled you to the 12:40 p.m., NS476, gate B22. Seat still not guaranteed.` (Note: no apology — this is the state, not a failure on the user's part.) |

Ban list for errors on this surface: "Oops," "Sorry," "Something went wrong" (vague), "Please try again later" (no horizon), "An error occurred" (clinical-evasive), "Unable to process" (passive-evasive).

---

## 9. Handoff messages

### To Information Architect

Two pushbacks on label slots and one ratification.

1. **Ratify:** every Screen 2 card label fits cleanly in one honest one-line phrasing, and the Screen 4 "Plans changed? Start over" affordance holds up at the slot length you allocated. No pushback there.
2. **Pushback — the Screen 1 primary, "See your options."** I considered this slot carefully. It does the structural job ("exploration without commitment") but reads slightly anodyne next to the operational headline. I tried `Show me my options` (warmer, but the "me" tips into hand-holding UXR explicitly banned) and `View 3 options` (a number is more precise but the "3" repeats the state line). I'm shipping `See your options` — it's the right phrasing for this slot, but I want to flag that this is the one button where the register is *barely* covering the slot. If we later need to add a fourth option (split refund, voucher transfer, anything), this label won't extend. Suggest reviewing the slot if recovery options expand beyond three.
3. **Pushback — the entitlements strip's "not eligible for this disruption" state.** The slot you allocated is two lines (label + status). When *both* hotel and meal are ineligible, the strip becomes "Support options for tonight" / "Hotel not available — meal credit only" — which is honest but reads as a downgrade. If both are *fully* ineligible (rare but possible: e.g., controllable-by-passenger cancellation), the strip has no useful state to show, and per IA's spec it still appears. I'd argue: when both are ineligible, the strip should hide entirely and the receipt should carry a plain note ("No hotel or meal support for this disruption — see why"). The user shouldn't have a permanent affordance leading to a "no" answer. **Recommendation: add a "strip hidden" structural state to your spec, conditioned on full ineligibility.**

### To Accessibility Specialist

Strings with aria-labels different from visible text, plus screen-reader sequence asks:

| Element | Visible text | aria-label |
|---|---|---|
| Entitlements strip tap target | (multi-line label + status) | `Hotel and meal support: not yet claimed, eligible for tonight. Tap to see what's available.` (first-paint state; updates per status variant) |
| Support phone link on receipt | `1-800-555-0142` | `Call Northstar support, 1-800-555-0142` |
| Support phone link on Screen 1 tertiary | `Or call 1-800-555-0142` | `Or call Northstar support, 1-800-555-0142` |
| "Why?" link (if retained on fare-difference cards) | `Why?` | `Why is there a fare difference on this flight?` |
| Path card (Rebook, active state) | (label + data + consequence) | `Rebook on a new flight. Earliest arrival 7:10 a.m. You arrive Wednesday morning. All 3 seats confirmed, no charge. Selected.` |
| Path card (Rebook, default) | (same) | `Rebook on a new flight. Earliest arrival 7:10 a.m. You arrive Wednesday morning. All 3 seats confirmed, no charge.` |
| Primary CTA, loading state | `Checking seats…` | `Checking seats, please wait.` (`aria-busy="true"`) |
| Flight card | (multi-row) | Order: arrival time + arrival date + flight number + departure time + stops + duration + party status + fare. Engineering assembles the string from the visible content in that order. |
| Strip chevron | (icon) | `aria-hidden="true"` (the strip button already labels itself) |

Two sequence asks:

1. **State line emphasis** — `<strong>You have not been rebooked yet.</strong>` on Screen 1 must receive *prosodic emphasis* on screen readers, not just visual bold. Suggest `<strong>` (semantic) plus testing with VoiceOver and TalkBack to confirm the emphasis carries. If it doesn't, fall back to phrasing the sentence so the load-bearing word is the verb: "You are not yet rebooked." (recommendation; assumption that semantic strong + TTS emphasis is sufficient — falsifiable by a one-pass test)
2. **"All 3 confirmed together" / "Only 2 seats together"** — the colored dot is `aria-hidden`. The text alone must carry the state. "Together" is the load-bearing word; please pressure-test that it reads unambiguously in TTS (a screen-reader user without the visual dot must understand this is about seat adjacency, not group booking). If the test fails, I'll switch to "All 3 seats adjacent" / "Only 2 seats adjacent" — flagging now because it's the riskiest plain-language call on this surface.

---

## Summary

- **SMS primary (157 chars):** `Northstar Air: Flight NS482, Wed 6:15 a.m. DEN-LGA, is canceled (crew). Not yet rebooked. See 3 options: northstar.app/ns482 or call 1-800-555-0142.`
- **Path-card consequences (length-locked, one line each):**
  - Rebook: `You arrive Wednesday morning. All 3 seats confirmed, no charge.`
  - Credit: `You decide later. No flight is held. Credit good for 12 months.`
  - Standby: `You wait at the gate. A seat is not guaranteed.`
- **"Why?" link decision:** **Cut it from the current prototype.** On "No charge" cards the link itself signals doubt the user doesn't need. Keep "Why?" only on cards where a real fare difference applies, with one factual sentence on tap: "Fare difference is the cabin/route price gap between your original ticket and this flight. Northstar covers cancellation rebooking; cabin upgrades and route changes you select are billed." If policy can't ship that sentence, remove fare-difference framing from rebook entirely.
- **Pushbacks:** IA — flag the Screen 1 primary slot as barely-covered and not extendable to a 4th option; add a "strip hidden" structural state for full-ineligibility cases. VD — preserved all consequence-line lengths as locked; one ratified, two refined within budget. To A11y — flagged "together" vs. "adjacent" as the riskiest plain-language call on the surface, pending TTS test.

*Confidence: SMS — high. Screen strings — high (the prototype is concrete and the slots are unambiguous). Path-card consequences — high. "Why?" cut — medium-high (depends on whether policy comfort wins; the principled answer is to cut). Error catalog — high. Aria-label handoff — medium (depends on A11y's actual screen-reader cadence preferences, which I've asked them to confirm).*
