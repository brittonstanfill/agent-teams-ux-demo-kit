# Role Report — Content Designer / UX Writer

**Role:** Content Designer (UX Writer)
**Task:** #12
**Date:** 2026-05-13
**Status:** Completed

---

## Top 3 Findings

1. **The current copy hides the event behind system-speak.** "Schedule irregularity," "itinerary changed," "changes have been applied" — none of these tell a tired person at 10:46 p.m. that their 6:15 a.m. flight is canceled. The single highest-leverage change in this flow is **leading every surface with the event in plain language**: the SMS, the page title, the H1, and the link preview text. This fix alone likely prevents a significant share of support calls because the user understands what happened before they tap anything.

2. **Every CTA in the current flow is a verb without a consequence.** "Continue," "Done," "View details," "Other policies" — none of these tell the user what will happen if they tap. Under stress, ambiguous buttons get abandoned. **Every button must name the result of the tap** ("See rebooking options," "Go to my trip," "See hotel and meal help"). This is also a WCAG 2.4.6 / 3.3.2 requirement per accessibility-specialist — plain language *is* accessibility.

3. **Hotel and meal help are buried under "Other policies" — and the copy compounds the IA failure.** Even if information-architect moves it up, the words matter: "voucher," "entitlement," "policy" all read as gatekeeping. We need warm-but-honest language that **doesn't promise what the brief doesn't authorize**: "You may qualify for hotel and meal help — we'll check now." This trades a fake promise for a real path. Users trust honesty under stress; they punish overpromises.

---

## Evidence Labels

- **Observed from brief:** SMS reads "Schedule irregularity on NS482." H1 reads "Your itinerary has changed." Primary buttons are "Continue" and "Done." Hotel/meal sit inside "Other policies" FAQ. Default tab on recovery is "Travel credit." Confirmation says only "Your changes have been applied."
- **Inferred:** User is mobile-only, tired, possibly screen-reading, possibly traveling with family. Cognitive load is near-ceiling. Reading speed and comprehension are degraded.
- **Assumptions:** Northstar legal/ops will let us name "canceled" plainly (vs. "irregular operations"). Hotel/meal eligibility logic exists server-side and can return a yes/no/check decision. Party size is on the reservation.
- **Recommendations:** See screen-by-screen copy below.

---

## Voice & Tone

### Emotional arc the voice serves (from ux-researcher)

**Orientation → Understanding → Agency → Closure.**

| Stage | Surfaces | Voice job |
|---|---|---|
| Orientation | SMS, Screen 1 | Name the event plainly. Signal a path exists. Reassure support is reachable. |
| Understanding | Screen 2 (recovery options) | Explain *consequences*, not just labels. Every option answers "what does this mean for me tomorrow?" |
| Agency | Screen 3 (flight pick), Screen 4 (help) | Make the user feel they're *choosing*, not being steered. No airline-flattering language. |
| Closure | Screen 5 (confirmation) | Receipt + plan, not a thank-you note. Spell out what's true now and what to do if it changes again. |

### Voice attributes (steady across the flow)

- **Direct** — leads with the event, names actions, no euphemism
- **Calm** — short sentences, no exclamation, no urgency theater
- **Honest** — claims what's true, hedges what's uncertain ("you may qualify")
- **Respectful of effort** — never blames, never asks the user to "be patient"
- **Practical** — every screen ends with a clear next step

### We sound like this / not this

| We sound like this | Not this |
|---|---|
| "Your 6:15 a.m. flight tomorrow was canceled." | "Schedule irregularity on NS482." |
| "We'll check if you qualify for a hotel tonight." | "Please review applicable policies." |
| "Standby — not a guaranteed seat." | "Join the standby list." |
| "See rebooking options." | "Continue." |
| "Sorry — that 7:10 a.m. flight just sold out. Here are flights still available." | "Oops! Something went wrong." |
| "You're rebooked. Here are the details." | "Your changes have been applied." |

### Tone gradient by moment

| Moment | Tone | Example |
|---|---|---|
| First contact (SMS) | Direct + reassuring | "Your 6:15 a.m. flight tomorrow was canceled. Tap for options including hotel and meal help." |
| Recovery choice | Neutral, clarifying | "Three ways to recover your trip. Pick one." |
| Inline error (sold out, network) | Apologetic + redirective | "Sorry — that flight just sold out. Here's what's still available." |
| Confirmation | Plain, factual | "You're rebooked. Save this screen." |
| Sensitive (no flights tonight, stuck overnight) | Slow, honest, helpful | "There are no more flights tonight. You may qualify for a hotel — we'll check now." |

---

## Plain-Language Guardrails

- **Target reading level:** Flesch–Kincaid grade 6. Maximum grade 8 anywhere.
- **Sentence length:** ≤ 15 words. Hard cap 20.
- **Sentences per screen:** Aim for 5–7 short sentences total above the fold. Lists over paragraphs.
- **No idioms or metaphors:** killed "Hang tight," "We've got you covered," "Sit back and relax."
- **No filler apology lead:** "We apologize for the inconvenience" never opens a screen. If it appears at all, it pairs with the help being offered.
- **No "Oops."** Ever. Errors get respect.
- **No time-based urgency on cognitive choices.** No countdown timers on the recovery options screen. (Behavioral-scientist may push; I'll defend this line.)
- **No jargon:** "voucher," "entitlement," "irregularity," "irrops," "rebook" used only in headers (paired with action verbs).
- **No "User," no "Submit," no "Initialize."**

---

## Revised SMS / Push Notification

### Current
> Northstar Alert: Schedule irregularity on NS482. Manage trip: link

### Proposed — SMS

> Your 6:15 a.m. Northstar flight NS482 (DEN→LGA) tomorrow was canceled. Tap for options including hotel and meal help: [link]

**Why:**
- Leads with the event ("canceled"), not the system ("Schedule irregularity").
- Names the time and route so the user knows it's their flight before they tap.
- Promises options *and* hotel/meal awareness — but with a softer verb ("including hotel and meal help") so we don't claim entitlement.
- Link preview will surface the page title, which matches this lead (WCAG 2.4.2).

**Length note for accessibility/i18n review:** ~150 characters. Long for SMS but within standard concatenation. German/Finnish expansion will push past 200 — confirm with localization that segmentation is acceptable.

### Proposed — Push notification

**Title:** Flight canceled — see your options
**Body:** Your 6:15 a.m. flight NS482 to LGA was canceled. Tap to rebook and check hotel/meal help.

**Why:** Title is the smallest unit that survives a lock-screen glance. "Flight canceled" earns the tap.

### Alternates considered
- **A.** "Your Northstar flight tomorrow morning was canceled. Tap for options." — *Less specific; loses route + flight number for screen readers/users with multiple trips.*
- **B.** "We're sorry — NS482 was canceled. Here's how to recover your trip: [link]" — *Apology-led; pushes the event later in the line.*

**Chose primary** for event-first clarity + party context.

---

## Screen-by-Screen Copy

### Screen 1 — Cancellation context

**Page title (browser/SR):** Flight canceled — Northstar NS482
**H1:** Your 6:15 a.m. flight tomorrow was canceled.
**Subhead:** NS482, Denver (DEN) to New York (LGA). Reason: crew availability.
**Body:**
> Here's what to do next. Most travelers finish this in 3–4 minutes.
>
> Rebooking for all 3 travelers on this reservation.  *(suppress count if solo)*

**Primary CTA:** See rebooking options
**Secondary CTA:** Hotel and meal help
**Tertiary link:** Call Northstar support: 1-800-XXX-XXXX

**Microcopy below CTAs:** "You can come back to any option from this screen."

**Why:**
- H1 leads with the event in the user's words.
- "Reason: crew availability" gives a fact without inventing legal language about rights.
- The "3–4 minutes" line lowers anxiety and sets a frame.
- Hotel/meal help is reachable from this screen, not buried.
- The party-aware line prevents the "did I just rebook only myself?" panic.

---

### Screen 2 — Recovery options

**H1:** How would you like to recover? *(adopted from info-architect — active voice, question framing creates agency)*
**Subhead:** Three options. You can change your choice until you confirm.

**Option A — Rebook on another flight** *(default visual position: first)*
> **Consequence subline:** Pick a Northstar flight tomorrow. Most travelers choose this.
>
> **CTA:** Pick a new flight

**Option B — Join standby**
> **Consequence subline:** Standby — not a guaranteed seat. You'll only board if a seat opens up. We'll text you if you get one.
>
> **CTA:** Join standby

**Option C — Get a travel credit** *(or "travel credit or refund" — pending team-lead confirmation on refund availability)*
> **Consequence subline:** Keep the value of your ticket and fly later. Good for 12 months. *(confirm with policy team)*
>
> **CTA:** Take travel credit

**Persistent help row at bottom:** "Need hotel or meal help? We'll check what you qualify for. → **See hotel and meal help**"

**Why:**
- Vertical option list, not tabs. Tabs hide options under stress.
- **Default position favors rebooking, not travel credit.** The brief flagged that "Travel credit" being the default tab likely doesn't match user goal. Rebooking is what most travelers want at 10:46 p.m. before a family event.
- **Each option has an inline consequence subline** (per ux-researcher): not just a label, but "what this means for *me* tomorrow." Clarity beats brevity for stressed users.
- Standby explanation is inline, not in a tooltip (per a11y).
- Travel credit specifies duration so the user can judge it.
- Hotel/meal is a persistent affordance, not a hidden FAQ.
- **Open:** info-architect flagged "refund" availability is a team-lead question. If refund isn't actually offered, we keep "Get a travel credit." Do not invent.

---

### Screen 3 — Pick a new flight

**H1:** Pick a new flight.
**Subhead:** Flights to LGA tomorrow. Prices shown only if there's a difference.

**Filter row labels:** "Earlier" · "Nonstop only" · "Same airport (LGA)" · "Mobility help"

**Flight card examples:**

> **7:10 a.m. — one stop via ORD**
> Arrives 4:15 p.m. ET. No extra cost.
> **Tag:** Recommended: earliest arrival, no extra cost.
> **CTA:** Choose 7:10 a.m. flight

> **2:40 p.m. — nonstop**
> Arrives 8:55 p.m. ET. **+$84 vs. your original ticket.**
> **Inline note:** "Higher fare class than what you paid. Other flights at no extra cost are below."
> **CTA:** Choose 2:40 p.m. flight

> **6:30 p.m. — one stop via ATL**
> Arrives 1:10 a.m. ET (+1). Same fare as your original ticket.
> **CTA:** Choose 6:30 p.m. flight

**Why:**
- "Recommended" now explains itself. (a11y point 4; behavioral-scientist point 2.)
- **Fare difference is anchored against the user's original ticket, not against $0.** Per behavioral-scientist: anchoring against the cheapest option triggers loss aversion against a disruption the user didn't cause. "Same fare as your original ticket" / "+$84 vs. your original" replaces "$0" / "+$84."
- **No "$0" chip displayed prominently.** The absence of a price chip is itself the message. (behavioral-scientist point 4.)
- Filter labels are user-language, not airline-language ("Mobility help" not "Special services").
- Late-arrival flight gets a "(+1)" so people don't accidentally book themselves arriving after midnight.

---

### Screen 4 — Hotel and meal help

**H1:** Hotel and meal help
**Subhead:** Because your flight was canceled overnight, you may qualify for help.

**Body:**
> We'll check now. Eligibility depends on the reason for the cancellation and the time of day. *(no overpromise)*
>
> If you qualify:
> - Hotel near the airport tonight
> - Meal credit for the airport or hotel
>
> If you don't qualify, we'll tell you what to do next and what to keep your receipts for.

**Primary CTA:** Check what I qualify for
**Secondary CTA:** Go back to recovery options

**While the check runs (loading state):** "Checking — usually takes about 10 seconds."

**Result — qualifies:**
> You qualify for a hotel tonight and a $XX meal credit. Here's how to use them: [details]
> **CTA:** Book hotel now

**Result — does not qualify:**
> You don't qualify for hotel coverage for this cancellation. If you book a hotel on your own, save the receipt and we'll review reimbursement on request.
> **CTAs:** Call Northstar · Back to recovery options

**Decline copy (when user dismisses help offer):**
> **Neutral, equal-weight decline labels** (per behavioral-scientist — no confirmshaming):
> - Primary: "Check what I qualify for"
> - Secondary: "Skip for now" *(not "No thanks, I'll figure it out myself")*

**Why:**
- "You may qualify" + "We'll check" preserves trust without inventing a policy.
- The negative result still ends with a path, not a wall.
- Receipt language is honest about the manual path without promising reimbursement.

---

### Screen 5 — Confirmation

**H1:** You're set — here's what happens next. *(adopted from info-architect — confirms + previews scent)*
**Subhead:** Save this screen or screenshot it.

**Facts list (bullets, screen-reader friendly):**
- **New flight:** NS614 — 2:40 p.m. tomorrow, DEN → LGA, nonstop
- **Arrives:** 8:55 p.m. ET tomorrow
- **Terminal:** DEN Terminal A · Gate posted 2 hours before departure
- **Hotel tonight:** Hyatt Place DEN Airport — confirmation #XXXXX  *(or:* "Hotel not included — you didn't qualify for this cancellation.")
- **Bags:** Checked bags rebooked on your new flight automatically.
- **Confirmation code:** ABC123
- **Need help:** Call Northstar support 1-800-XXX-XXXX or reply to your trip text.

**Primary CTA:** Save offline *(adopted from info-architect — names the action; supports low-bandwidth users)*
**Secondary CTA:** Change my recovery *(adopted from info-architect — replaces "Done"; keeps agency)*
**Tertiary link:** Email me this confirmation
**Persistent escape:** Call Northstar 1-800-XXX-XXXX *(per IA: name the receiver, not "Help/Support/Contact us")*

**Below the fold microcopy:** "If you lose this screen, your trip is still rebooked. We'll text you a reminder 3 hours before departure."

**Why:**
- 7 facts, not a feel-good paragraph. (a11y point 6.)
- "Save this screen" speaks to low-bandwidth/offline reality.
- The "Plans changed again?" link addresses the brief's "no clear path if plans change again."
- Reassurance about losing the screen counters the panic of "did this actually go through?"
- "Email me this confirmation" is the offline backup the current flow lacks.

---

## Microcopy Catalog

| Location | Current | Proposed | Why |
|---|---|---|---|
| SMS subject | "Northstar Alert: Schedule irregularity" | "Your 6:15 a.m. flight NS482 was canceled" | Event-first. Specific. |
| Screen 1 H1 | "Your itinerary has changed" | "Your 6:15 a.m. flight tomorrow was canceled" | Names what happened. |
| Screen 1 CTA | "Continue" | "See rebooking options" | Names the consequence. |
| Screen 1 link | "View details" | "See why it was canceled and your options" | Stands alone (WCAG 2.4.4). |
| Screen 2 tab default | "Travel credit" | (Vertical list; rebooking first) | Default matches likely goal. |
| Screen 2 badge | "Recommended" | "Recommended: earliest arrival, no extra cost" | Self-explaining. |
| Screen 3 sort label | (none) | "Sorted by arrival time. Change sort." | Predictable. |
| Screen 4 location | Inside FAQ "Other policies" | Top-level: "Hotel and meal help" | Surface > hide. |
| Screen 4 lead | (absent) | "You may qualify — we'll check now." | Honest, not promising. |
| Screen 5 H1 | "Trip updated" | "You're rebooked." | Active, plain. |
| Screen 5 body | "Your changes have been applied." | 7-bullet facts list | Facts > feelings. |
| Screen 5 CTA | "Done" | "Go to my trip" | Names destination. |

---

## Error Message Catalog

All errors follow: **(1) what happened → (2) what it means → (3) what to do.** Three sentences max. Never blames the user. Never "Oops."

| Error | Copy |
|---|---|
| Flight just sold out mid-flow | "That 7:10 a.m. flight just sold out. The 2:40 p.m. nonstop is still available at no extra cost. **Choose 2:40 p.m.** or **See all flights**." |
| Network drop during rebook | "We lost connection before saving your choice. Your trip wasn't changed yet. **Try again** or **Call Northstar support**." |
| Hotel eligibility check fails (system error, not "you don't qualify") | "We couldn't check hotel eligibility right now. Your rebooking is still saved. **Try again** or **Call support to check by phone**." |
| Standby list full | "Standby is full for the 7:10 a.m. flight. You can join standby for the 2:40 p.m. flight or rebook to a confirmed seat. **See options**." |
| Confirmation email fails to send | "Your trip is rebooked, but we couldn't send the email. Take a screenshot of this screen, or **resend email**." |
| User does not qualify for hotel | "You don't qualify for hotel coverage for this cancellation. If you book a hotel yourself, save the receipt — **request a review**." *(This is information, not error tone.)* |
| Session timeout | "We paused your session to keep your trip safe. Your rebooking choice wasn't saved. **Start again** — it should take about 2 minutes." |

**What we will NOT write:**
- "Oops, something went wrong." — useless to a stressed user.
- "An error has occurred." — passive, no action.
- "Please be patient." — never.
- "Sorry for any inconvenience this may cause." — apology theater.

---

## Confirmation + Handoff Copy

### Confirmation (Screen 5, above)
See Screen 5 section. Facts list + "save this screen" + offline reminder + "plans changed again?" link.

### Handoff to support (when user taps "Call support")
**Modal H1:** Calling Northstar support
**Body:**
> We'll share your trip number and what you've done so far so you don't have to repeat yourself. Wait time right now: about 8 minutes.
**Primary CTA:** Call now
**Secondary CTA:** Have an agent call me back

### Handoff to "plans changed again" path
**H1:** Plans changed again?
**Body:**
> Your trip is still rebooked for now. You can change it again or cancel.
**Primary CTA:** Change my flight
**Secondary CTA:** Cancel my trip

---

## Tone Rules — Do / Avoid

### DO

- Lead every screen with the event in plain words.
- Use verbs that name the consequence on every button.
- Tell the user what's true and what's uncertain ("you may qualify").
- Keep apologies short and paired with action.
- Address the party when count > 1.
- Tell the user what to do if they lose the screen.

### AVOID

- System-speak: "schedule irregularity," "itinerary changed," "applied."
- Empty verbs: "Continue," "Submit," "Done," "OK."
- Apology-as-lead: "We apologize for the inconvenience."
- Fake comfort: "We've got you covered," "Hang tight."
- "Oops." Always. Ever.
- Time-based pressure on cognitive choices.
- Promises the brief doesn't authorize: "We'll pay for your hotel."

---

## Phrase Library for Hedged Eligibility

Per behavioral-scientist's open question — vague phrasing reads as a hedge and can re-trigger trust loss. Here's the small phrase library I propose, ranked from strongest (most committed) to softest, and **when to use each.**

| Phrase | Use when | Don't use when |
|---|---|---|
| **"You qualify for X."** | Eligibility check has returned yes. | Eligibility is unknown. Never use as a teaser. |
| **"X is available for this cancellation."** | The benefit is policy-guaranteed for this cancellation type, regardless of user-specific facts. | The benefit is conditional on something user-specific (residency, time of day, fare class). |
| **"You may qualify for X. We'll check now."** | We genuinely don't know yet and we're about to check. Followed within seconds by a definite answer. | We don't intend to check, or the check is slow/uncertain. |
| **"X isn't offered for this cancellation type."** | Eligibility check returned no. | Eligibility is technically open but unlikely — don't pre-decide for the user. |
| **"If you book X yourself, save the receipt — we'll review."** | No coverage, but post-hoc review path exists. | The post-hoc review path doesn't exist. |

**Rule:** never use a hedge phrase as the lead and then leave the user hedging. Every "you may qualify" must resolve to a definite answer in the same flow, within the same screen, ideally within 10 seconds. A hedge that doesn't resolve is the trust-loss pattern behavioral-scientist warned about.

## Label Claim Audit (no overpromises)

Per team-lead instruction: I did not promise entitlements the brief doesn't authorize. The brief explicitly forbids inventing legal obligations, airline policy, or compensation rules.

| Topic | I did write | I did NOT write |
|---|---|---|
| Hotel | "You may qualify for hotel help — we'll check now." | "We'll pay for your hotel." |
| Meals | "Meal credit if you qualify." | "Free meals during your delay." |
| Standby | "Not a guaranteed seat." | "You'll definitely get on." |
| Travel credit duration | "Good for 12 months *(confirm with policy team)*." | A specific period asserted as fact. |
| Reimbursement (no-qualify path) | "Save the receipt — request a review." | "We'll reimburse you." |
| Reason for cancellation | "Reason: crew availability." | Any framing of legal rights tied to that reason. |

**Open dependency:** Several lines have `(confirm with policy team)` flags. Before lock, policy/legal must verify exact durations, eligibility wording, and the phrase "request a review."

---

## Handoffs Sent

| Recipient | Message | Why It Matters |
|---|---|---|
| information-architect | `content-to-info-architect.md` — screen labels + four label sign-offs + structural question on Hotel/Meal as co-equal surface | Copy can't lock until IA confirms where things live and what they're called. |
| accessibility-specialist | `content-to-accessibility-specialist.md` — how each of their 10 points landed + 4 things to re-check (SMS length, "may qualify" phrasing, em-dash with SR, confirmation bullet order) | Plain language *is* accessibility. They are the second author on this copy. |
| information-architect (reply) | `content-reply-to-info-architect.md` — accepted labels, flagged one mild disagreement, delivered S2 consequence sublines | Closes the IA→content label loop. |
| ux-researcher (reply) | `content-reply-to-ux-researcher.md` — accepted emotional arc + consequence subline framing; accepted offer of support-call transcripts | Anchors voice in evidence for the next round. |
| behavioral-scientist (reply) | `content-reply-to-behavioral.md` — adopted fare anchor reframe, neutral decline labels; delivered phrase library for hedged eligibility | Settles the framing question on hotel/meal eligibility. |

## Handoffs Received

| Sender | Message | What Changed |
|---|---|---|
| accessibility-specialist | `a11y-to-content-designer.md` — 10 copy/a11y blockers | Drove reading level target, action-label rewrites, "Standby — not a guaranteed seat" inline, error pattern, SMS lead, family-aware phrasing, idiom kill-list. **All 10 points integrated.** |
| information-architect | `ia-to-content-designer.md` (+ `-2.md` re-routed copy) — label slots table + ban list + structural constraints | Adopted active-voice question for S2 H1 ("How would you like to recover?"). Adopted "Rebook on another flight" for card 1. Adopted "You're set — here's what happens next" for S5 H1. Adopted "Save offline" / "Change my recovery" as S5 peer actions. Adopted "Call Northstar" as persistent escape. **Flagged refund availability as team-lead question.** |
| ux-researcher | `ux-researcher-to-content-designer-2.md` — emotional arc + 5 voice asks + transcript offer | Added the "orientation → understanding → agency → closure" arc to the voice section. Added consequence sublines to every S2 option ("what this means for *me* tomorrow"). Accepted their offer of support-call transcripts as voice evidence in next round. |
| behavioral-scientist | `behavioral-to-content-designer.md` — 7 framing risks + ethical guardrails | **Anchored fare difference against original ticket** ("+$84 vs. your original," "Same fare as your original ticket"), removing the implicit $0 anchor. **Suppressed "$0" chip.** Added **neutral, equal-weight decline labels** ("Skip for now," not "No thanks, I'll figure it out myself") to the Hotel screen and decline pattern. Adopted their open-question framing on the phrase library — answered in my reply. |

---

## Recommendation

1. **Adopt the new SMS and Screen 1 H1 immediately** — they are the cheapest, highest-leverage changes in the flow. They likely move call volume on their own.
2. **Reorder Screen 2 so rebooking is the default option, not travel credit.** This is a copy-and-IA collaboration.
3. **Promote Hotel and Meal help out of the FAQ** and use the "you may qualify — we'll check" frame. Honest > hidden.
4. **Rebuild Screen 5 as a facts list, not a paragraph.** Add "Plans changed again?" and "Email me this confirmation."
5. **Adopt the error message pattern** across the recovery flow and audit existing errors against it.
6. **Send the copy through a Flesch–Kincaid check before lock** — target grade 6, hard cap grade 8.

---

## Risks

1. **Policy/legal pushback on plain-language reason copy.** "Crew availability" instead of "operational reasons" may run into policy review. If they push back to vaguer language, we lose trust and a chunk of the improvement.
2. **Overpromise creep.** Stakeholders may ask to soften "you may qualify" to a more reassuring phrase. We need to defend the hedge — it's the trust mechanism.
3. **Behavioral-scientist may want urgency framing** on the recovery options (e.g., "Only 2 seats left at this price"). On a cognitive choice under stress, that's coercive. I'll defend a no-countdown stance and loop accessibility in if pushed.
4. **i18n length.** SMS is ~150 chars in English; German/Finnish expansion may break. Needs localization audit before global rollout.
5. **Visual-designer may flag length on Screen 5** (7-bullet confirmation). The bullets are the point — if they're too long, the design is too tight. Defend the content.

---

## Open Questions

1. **Travel credit duration** — is "12 months" correct? Policy team.
2. **Reimbursement-on-receipt** language — does Northstar actually offer that path, and what's the operative phrase ("request a review" vs. "submit for reimbursement")? Policy/CS team.
3. **Wait time copy in support handoff** — is the 8-minute number live, or canned? If canned, we shouldn't write it.
4. **Push notification platform constraints** — do iOS and Android both support a two-line body, or do I need a single line variant?
5. **Should the SMS link include a deep-link target screen** (e.g., directly to Screen 2 if user is logged in)? IA/eng question.
6. **Party language threshold** — do we say "all 3 travelers" up to 4, then "all travelers on this reservation"? Confirm with research what feels right above 4.

---

## One Tension for Team-Lead

**Honesty vs. comfort on hotel/meal copy.** Behavioral-scientist will likely want warmer, more confident language ("We'll get you a hotel tonight") to reduce abandonment. Accessibility-specialist and I want hedged-honest language ("You may qualify — we'll check") to preserve trust and stay within what the brief authorizes.

My position: hedged-honest wins. Users punish overpromises in disruption recovery harder than they punish hedges. If we say "we'll get you a hotel" and they don't qualify, we lose them forever and they call support angry. If we say "you may qualify" and they do, they're relieved. If they don't, the path is still warm. **Flag for team-lead arbitration if behavioral-scientist pushes.**

---

*— content-designer, 2026-05-13*
