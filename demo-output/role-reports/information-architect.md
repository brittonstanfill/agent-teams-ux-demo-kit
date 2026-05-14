# Information Architect — Northstar Canceled-Flight Recovery

**Owner:** information-architect
**Task:** #10
**Status:** in_progress → completed (on report finalization)

Claim legend used throughout this doc:
- `[observed]` — directly described in the brief.
- `[inferred]` — reasonable read from what the brief says or implies.
- `[assumption]` — I am stating a working premise; flag it if wrong.
- `[recommendation]` — my proposed change.
- I have **not** invented any airline policy, legal duty, or compensation rule. Where entitlements appear, they are placeholders gated on "if this is offered by Northstar."

---

## Top 3 findings

**1. The entry point destroys information scent before the app ever opens.**
The SMS uses the phrase "Schedule irregularity" `[observed]`, which does not name what happened, does not predict what's behind the link, and does not signal urgency or available help `[observed]`. Users under stress need labels that predict consequences. A label that hides the event is an IA failure, not a tone-of-voice failure. `[recommendation]` The SMS itself must name the event ("flight canceled"), the next action ("see your options"), and reassurance that options exist. Content-designer owns the words; I own that those three slots exist.

**2. Entitlements (hotel, meal) are filed under an org-chart label.**
"Other policies" `[observed]` is the classic IA anti-pattern: it groups content by the team that owns it ("Policy"), not by the question the user is asking ("Where will I sleep tonight?"). Under stress and on mobile, anything behind a collapsed FAQ is functionally invisible `[inferred]`. `[recommendation]` Hotel/meal/ground-transport support gets its own first-class screen (or section), labeled in user-task terms, and is surfaced **before** the user completes their choice — not as an afterthought on a confirmation page.

**3. There is no real confirmation — just a dismissal.**
"Trip updated / Your changes have been applied / Done" `[observed]` contains no flight number, no terminal, no hotel address, no support number, no offline copy `[observed]`. For a stressed traveler at 11 p.m. with a 6 a.m. plan now in pieces, the confirmation screen *is* the artifact they will re-open four times before sunrise `[inferred]`. `[recommendation]` Confirmation must be a structured facts list, savable offline, with a single visible escape hatch ("plans changed again? call us / redo this").

---

## Revised screen sequence (5 screens, mobile-first)

```
SMS  →  S1 Status  →  S2 Choose recovery  →  ┬─ S3 Pick a flight  →  S4 Add support  →  S5 You're set
                                              ├─ (credit/refund path skips S3, S4 if no entitlements apply)
                                              └─ (standby uses S3 with standby framing, then S4, S5)
```

Five screens, conditional skips, single persistent escape (call support) on every screen. Back is always available; nothing is a one-way door until the user taps **Confirm** on S4.

### S0 — SMS (entry, not counted as a screen)

Three slots only. Content-designer owns the exact words; I own that these three slots exist and are in this order:

1. Event named (canceled, flight number, original time).
2. Action available (one tap to options).
3. Reassurance that options exist (rebook / refund / hotel help if eligible — *do not promise specific entitlements in SMS*).

`[recommendation]` Slot 3 lists option *categories* in plain words, not legal/policy language. `[assumption]` SMS character budget allows ~3 short lines; if not, drop reassurance line — never drop the named event.

---

### S1 — "Your flight is canceled"  *(status + scent)*

**Purpose:** Tell the user what happened, what their options are *at a glance*, and that help is real and reachable.

**Content hierarchy (top → bottom):**
1. Header: event named in plain language `[recommendation]` (content-designer).
2. Subhead: original flight + original departure (so the user verifies they're in the right trip).
3. Reason chip: short, factual (e.g. crew availability) `[observed]` — no euphemism.
4. **Options preview** — three or four labeled cards stacked, each one previewing what's behind it. This is the part the current Screen 1 lacks entirely.
5. Support entry: "Call Northstar" — persistent from this screen forward.
6. Tertiary: itinerary details (collapsed, but labeled as itinerary, not as "details").

**Decision point:**
- Tap an option card → S2 with that option pre-selected.
- Tap call support → out of flow (phone).
- Tap itinerary → expand inline, do not navigate away.

**Back-out:** SMS / browser back returns to phone home. No data has been committed.

---

### S2 — "Choose how to recover"  *(recovery options, consequence-labeled)*

**Purpose:** Make the three (or four) recovery paths comparable and honest. This replaces the current tabbed Screen 2 `[observed]`, which uses ambiguous labels and a misleading default `[observed]`.

**Content hierarchy:**
1. Header naming the choice ("How would you like to recover?").
2. Option cards, **stacked, not tabbed.** Stacked because tabs hide siblings on mobile and let one option (the default) eat attention `[inferred]`.
3. Each card carries:
   - Label (user-task verb, e.g. "Rebook on another flight")
   - One-line consequence ("You'll pick from available Northstar flights.")
   - One-line cost/risk signal ("No extra fare during a cancellation" *if and only if that is Northstar's actual policy — not invented here* `[assumption flagged for team-lead]`).
4. Persistent: "Call Northstar."

**Default:** No pre-selection. `[recommendation]` The current default of "Travel credit" `[observed]` is hostile under disruption — it nudges toward the cheapest-to-airline outcome. Removing the default forces an active choice and is more honest. Behavioral-scientist should weigh in on whether a *recommended* (not pre-selected) option helps decision fatigue.

**Decision points:**
- Rebook → S3
- Standby → S3 (flagged as standby — see content-designer note)
- Travel credit / refund → skip to S4 if entitlements apply, else S5
- Call support → out of flow

**Back-out:** Back returns to S1. Nothing committed.

---

### S3 — "Pick a new flight"  *(or "Join standby" — same screen, different framing)*

**Purpose:** Let the user filter to flights that actually solve *their* problem (arrival time, nonstop, mobility, party size), not the airline's default sort `[observed problem]`.

**Content hierarchy:**
1. Header naming the action ("Pick a new flight" or "Pick a standby flight").
2. Filter row (collapsible, single tap to open):
   - Arrival by [time picker] — most common goal under disruption `[inferred]`
   - Nonstop only [toggle]
   - Mobility / accessibility needs [link → expanded options]
   - Travel party [count]
3. Sorted list (default: earliest arrival to original destination — *not* "Recommended" alone).
4. Each flight card carries:
   - Depart / arrive times + duration
   - Stops, with layover airport named
   - Why-it's-recommended badge (if used) must include the *reason*: "Recommended: earliest arrival, no extra cost" — coordinated with content-designer and accessibility-specialist.
   - Fare difference shown **only if Northstar's policy actually charges one during a cancellation** `[assumption flagged]`. If it does not, do not surface the field. If it does, the framing must be unambiguous.

**Decision points:**
- Select flight → S4 (support add-on)
- Adjust filters → in-page, no navigation
- Back → S2 (choice not yet committed)
- Call support → out of flow

**Back-out:** Back to S2. Selection is held in state but not committed.

---

### S4 — "Hotel and meal help"  *(entitlements, surfaced before confirmation)*

**Purpose:** Surface what the user is entitled to *before* they commit, in plain user-task language. This replaces "Other policies" `[observed]`, which is an org-chart label.

`[assumption]` Whether a given user is entitled to hotel/meal/ground transport is determined by Northstar's actual rules (cause of cancellation, time of day, distance from home, status). I am **not** writing that policy. I am defining the slot where it appears.

**Content hierarchy:**
1. Header: "Hotel and meal help" — task language, not policy language.
2. State block:
   - If entitled: list each support type as a separate, plainly-named row (Hotel, Meals, Ground transport) with a one-line summary of what is offered and any action the user must take.
   - If not entitled: a short, honest line ("Hotel and meal support isn't offered for this cancellation type.") — do **not** hide the section, because hiding it re-creates the original trust problem.
3. Add/decline controls per row. `[recommendation]` Default these to *added* if entitled, with an explicit decline action — under fatigue, opt-out beats opt-in for benefits the user is owed. Behavioral-scientist owns this call; flagging for them.
4. Persistent: "Call Northstar."

**Decision points:**
- Confirm → S5 (this is the commit point)
- Adjust → in-page
- Back → S3 (or S2 if no flight was picked, e.g. refund path)

**Back-out:** Back is allowed. Confirm is the one-way door. `[recommendation]` On the Confirm tap, show a single-sentence summary in the button or in a non-blocking inline state so the user sees what they're committing to. Interaction-designer owns the pattern.

---

### S5 — "You're set — here's what happens next"  *(real confirmation)*

**Purpose:** Be the durable artifact the user will re-open between now and the new departure. Replaces "Your changes have been applied / Done" `[observed]`.

**Content hierarchy (facts list, not paragraph):**
1. New flight: number, depart time, arrive time, terminal, gate (or "gate TBD — check the morning of"), confirmation code.
2. Hotel (if added): name, address, check-in window, confirmation code.
3. Meal / ground transport (if added): how to redeem, by when.
4. Baggage note (if relevant).
5. **Save offline** action — download/share as PDF or add to wallet. `[recommendation]` Critical for the low-bandwidth / dead-battery-by-morning case.
6. **If plans change again** — two clear actions: "Call Northstar" and "Change my recovery" (returns to S2 with current state preserved).
7. Tertiary: link to full itinerary.

**Decision points:**
- Save offline → device action, stays on screen
- Call support → out of flow
- Change my recovery → back to S2

**Back-out:** This is the resting state. There is no further commit. The user can leave and return.

---

## Decision points + back-out paths (consolidated)

| Screen | Forward (primary) | Forward (secondary) | Back-out | Always-available escape |
|---|---|---|---|---|
| S1 Status | Tap an option preview → S2 | Expand itinerary inline | Phone back / close | Call Northstar |
| S2 Choose | Rebook → S3 / Standby → S3 / Credit → S4-or-S5 | None | Back → S1 | Call Northstar |
| S3 Pick flight | Select flight → S4 | Adjust filters in-page | Back → S2 (selection held) | Call Northstar |
| S4 Support | Confirm → S5 (commit point) | Adjust add-ons in-page | Back → S3 or S2 | Call Northstar |
| S5 You're set | Save offline | Change recovery → S2 | — (resting state) | Call Northstar |

**Commit boundary:** Confirm on S4 is the only one-way door. Everything before is reversible. This matters because a stressed user who picks the wrong thing on S2 and discovers it on S3 should be able to step back without penalty.

**Persistent escape:** A "Call Northstar" affordance lives in the same place on every screen. The business goal is to reduce calls `[observed]`, but the brief is explicit: "not by hiding help" `[observed]`. The IA position is that a visible escape *increases* successful self-service, because it removes the feeling of being trapped.

---

## Navigation / section labels (high-level)

I'm proposing the **slots and their structural meaning**. Word-level copy is content-designer's call; we should align before lock.

| Slot | Working label | What it means structurally | Alternatives I considered |
|---|---|---|---|
| S1 header | "Your flight is canceled" | Names the event in user terms | "Itinerary changed" (current — too vague), "Disruption notice" (org-chart) |
| S1 options preview group | "Your options" | Predicts a chooser is next | "Next steps" (vague), "Recovery options" (jargon) |
| S2 header | "How would you like to recover?" | Frames the screen as a decision | "Recovery options" (noun-ish, less active) |
| S2 card 1 | "Rebook on another flight" | Verb + consequence | "New flights" (current — noun, hides verb) |
| S2 card 2 | "Join standby" | Verb + honest naming | "Standby" (current — ambiguous) |
| S2 card 3 | "Get a travel credit or refund" | Names both, doesn't bury refund | "Travel credit" (current — hides refund if it exists) |
| S3 filter group | "Filter flights" | Standard, predictable | "Refine" (jargon) |
| S4 header | "Hotel and meal help" | Task language | "Other policies" (current — org-chart anti-pattern), "Entitlements" (legalese) |
| S5 header | "You're set — here's what happens next" | Reassurance + scent for the facts list | "Confirmation" (vague), "Trip updated" (current — empty) |
| Escape | "Call Northstar" | Names the receiver, not "Support" | "Help," "Contact us" (both vague) |

`[recommendation]` Avoid: "Manage trip," "Details," "More," "Continue," "Done." All of them fail the information-scent test — they don't predict what's behind them.

---

## Tree-test scenarios (informal — for use when we can test)

For each user task, **expected path** is where I'd defend the IA. **Acceptable** means the structure didn't fail the user even though they took a slightly different route.

1. **"I just want to get to my family event tomorrow."**
   Expected: S1 → tap "Rebook" preview → S2 (rebook pre-selected) → S3 → filter by arrival → pick flight → S4 → S5.
   Acceptable: S1 → S2 → S3 without filtering.
   Failure mode: user picks Travel credit by mistake because of decision fatigue. Mitigation: no default selection on S2; consequence labels on each card.

2. **"I need a hotel — where do I even find that?"**
   Expected: User sees hotel mentioned on S1 options preview, taps through to S2, picks recovery, hits S4 with hotel surfaced.
   Acceptable: User taps "Call Northstar" — *this is acceptable*, not a failure. The IA succeeds if they don't *abandon to a different app* to find a hotel.
   Failure mode (current): hotel is behind "Other policies" on S4 confirmation — user never finds it and books their own at full price.

3. **"I don't want to fly anymore — I just want my money back."**
   Expected: S1 → tap "Credit or refund" preview → S2 → confirm → S5.
   Acceptable: Calls support.
   Failure mode (current): "Travel credit" tab is default and the word "refund" never appears — user calls because the option seems absent.

4. **"My partner uses a wheelchair. Can we still do this?"**
   Expected: S3 filter row → mobility/accessibility → expanded options. Accessibility-specialist owns this surface deeply; flagging for them.
   Acceptable: Calls support.
   Failure mode (current): No filter exists `[observed]`. User has no way to know what's possible.

5. **"It's 5 a.m., my hotel address is on a screen with no signal."**
   Expected: S5 was saved offline last night; user opens the saved artifact.
   Acceptable: User remembers and screenshots S5.
   Failure mode (current): "Your changes have been applied" `[observed]` contains zero useful info.

---

## Risks (IA-specific)

- **Risk: "Recommended" badge becomes a default by stealth.** If the recommended flight is visually heavier, we recreate the S2 default-tab problem on S3. Visual-designer and I need to align on weight.
- **Risk: Stacked S2 cards push S3 deeper on small screens.** Tradeoff accepted: stacked > tabbed for honesty. If S2 gets long, collapse "Credit or refund" details on first paint — but keep the *label* visible.
- **Risk: Entitlements vary by user, and S4 may show "Not offered" frequently.** This is a feature, not a bug. Hiding the section to avoid showing "Not offered" is what got us into this mess.
- **Risk: Persistent "Call Northstar" cannibalizes self-service.** Counter-argument: the brief states the business goal is to reduce calls *and* not hide help `[observed]`. A visible escape that is never tapped is fine; an invisible escape that drives abandonment is the problem.
- **Risk: Org-chart labels creep back in during build.** "Policies," "Services," "Support tier." Naming this now so it doesn't slip in.

---

## Open questions for team-lead

1. Is "Travel credit *or* refund" accurate? (i.e., does Northstar actually offer cash refunds for crew-caused cancellations?) If not, the S2 card label drops "refund." I will not invent policy.
2. Is fare-difference ever charged during a cancellation recovery? S3 design depends on this.
3. Is hotel/meal eligibility a user-segment decision the system already knows at S1 time, or is it computed later? Affects whether S1 can preview "Hotel help available" honestly.

---

## Handoffs sent

- → **interaction-designer**: flow model + decision points (see `peer-messages/ia-to-interaction-designer.md`).
- → **content-designer**: section/screen label slots to align copy against (see `peer-messages/ia-to-content-designer.md`).
- → **team-lead**: summary + tension (see `peer-messages/ia-to-team-lead.md`).

Also relevant (no message sent, flagging here):
- **behavioral-scientist**: opt-out vs. opt-in default for hotel/meal on S4; no default selection on S2.
- **accessibility-specialist**: mobility/accessibility filter on S3; offline-save on S5; reading level across all label slots.
- **visual-designer**: do not let "Recommended" weight recreate the default-tab problem.
