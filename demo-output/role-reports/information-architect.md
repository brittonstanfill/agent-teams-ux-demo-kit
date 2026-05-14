# Information Architect — Northstar Canceled-Flight Recovery

A stressed traveler at 10:46 p.m. with a canceled 6:15 a.m. flight does not want a "flow." They want four things in order: tell me what happened, show me my real choices, give me the help I'm owed, and let me leave knowing what to do next. The current flow buries two of those four (consequences of options; hotel/meal support). This report fixes the spine; the Visual Designer builds from Section 6.

Claim labels used throughout: **[observed]** from brief, **[inferred]** plausible reading of brief, **[assumption]** working premise we should validate, **[recommendation]** my design call.

---

## 1. User-job spine

Four jobs, sequential, each with what the UI must deliver. Mapped to the User Goal verbatim from the brief: "Understand what happened, choose the best available recovery option, get any required support, and leave with confidence about what happens next." **[observed]**

| # | Job (user voice) | UI must deliver | Failure mode if missed |
|---|---|---|---|
| 1 | "What actually happened to my flight?" | Plain-language cause, named flight, the fact that it is canceled (not "irregularity"), what is and isn't decided yet. **[recommendation]** | User calls support to confirm reality. **[inferred]** |
| 2 | "What are my real options and what does each one cost me?" | A small set of named options with consequences spelled out (arrival time, stops, money implications, what you give up). **[recommendation]** | User picks wrong option or abandons. **[observed: "default may not match the user's likely goal"]** |
| 3 | "What help am I owed tonight, and how do I get it?" | Hotel and meal support surfaced at the decision point, not in an FAQ. No claims about eligibility we haven't been given. **[recommendation, anchored in observed problem]** | User pays out of pocket; trust collapses. **[observed]** |
| 4 | "What do I do now — and what if this changes again?" | A summary they can re-open offline, a single clear next action, and a visible path back to change or to a human. **[recommendation]** | User calls support to re-confirm; or worse, no-shows. **[inferred]** |

Note on sequencing: jobs 2 and 3 are tightly coupled. Hotel/meal needs are partly *determined by* which rebooking option the user picks (a same-night flight may not need a hotel). The flow must let the user see support implications *while* choosing, not after. **[recommendation]**

---

## 2. Screen sequence

Five screens. Mobile-first. Each screen has one primary decision. Back behavior is always non-destructive until the user commits on Screen 4.

### Screen 1 — What happened
- **Primary decision:** acknowledge and proceed to options. (No real choice yet; this screen is comprehension.)
- **Hierarchy (top to bottom):**
  1. Status line: "Your 6:15 a.m. flight {NS482} {DEN to LGA} is canceled." **[recommendation: replace "irregularity"; "canceled" is the observed real event per brief]**
  2. Reason in plain words, only if system-supplied. Placeholder: "Reason: {system-supplied}." Do not invent. **[recommendation]**
  3. What this means right now: "You have not been rebooked yet. We'll show your options next." **[recommendation — addresses the "no next step" problem]**
  4. What you're entitled to tonight, at a glance: a short line that names hotel/meal support exists, with the caveat that eligibility is shown on the support screen. Do not promise. See Section 4. **[recommendation]**
  5. Primary button: **"See my options"** (names the consequence). **[recommendation]**
  6. Secondary: **"Get help from an agent"** — visible, not buried. See Section 5. **[recommendation]**
- **Back/exit:** back goes to the SMS/inbox; no destructive state.

### Screen 2 — Choose how you'll get there
- **Primary decision:** pick a recovery path (rebook on a new flight, take travel credit, or join standby) — or open agent handoff.
- **Hierarchy:**
  1. One-line restatement: "Canceled: 6:15 a.m. {NS482}."
  2. Three options as full-width cards, not tabs. Tabs hide siblings; cards keep all three visible and scannable. **[recommendation — addresses observed "default tab may not match user goal"]**
     - **Rebook on a Northstar flight** — "See available flights tomorrow."
     - **Take travel credit and arrange later** — "Cancel this trip; use the value later. {expiration: system-supplied}."
     - **Wait for standby** — "Not a confirmed seat. You only fly if a seat opens." **[recommendation — addresses observed "standby may sound equivalent to confirmed rebooking"]**
  3. Below cards: a quiet line — "Need a hotel or meal support tonight? See what's available." Links to Screen 4-style support, available *before* commitment. **[recommendation]**
  4. Persistent "Get help from an agent" entry.
- **No default selection.** The brief shows "Travel credit" pre-selected by default, which biases the user. **[observed problem; recommendation: remove default]**
- **Back/exit:** back to Screen 1, no state lost.

### Screen 3 — Pick a flight (only reached if user chose "Rebook")
- **Primary decision:** pick one replacement flight.
- **Hierarchy:**
  1. Filter row, collapsed by default to save vertical space: arrival time, nonstop only, travel party size. **[recommendation — addresses observed "no filters"]**
  2. Sort control, default to **earliest arrival at destination** (closest to the user's likely real job: get to the family event). **[recommendation, with assumption noted: traveler-with-family context implies arrival-time priority. ASSUMPTION to validate.]**
  3. Flight cards. Each card shows: depart time, arrive time, stops, total duration, and a single consequence line.
     - If there is no fare difference: show nothing about money. Silence is the signal.
     - If the system reports a fare difference at zero: show "No extra cost."
     - If the system reports a non-zero fare difference during a *cancellation* recovery: surface it clearly and explain it; do not hide. The brief flags this as suspect. We don't have policy to override it, so we name it honestly. **[observed problem; recommendation: surface, don't suppress]**
  4. Do not use the word "Recommended" without a reason next to it. If we badge a card, the badge says *why*: "Earliest arrival," "Nonstop," "Same fare." **[recommendation — addresses observed "'Recommended' is not explained"]**
  5. Tap a card → goes to Screen 4 (review and confirm). No silent commitment.
- **Back/exit:** back to Screen 2.

### Screen 4 — Review, support, and confirm
- **Primary decision:** confirm the rebooking AND opt into any support (hotel, meal) you need.
- **Hierarchy:**
  1. Your new plan: new flight summary (times, stops, seats if assigned), or "Travel credit pending" / "Standby request" if those paths were chosen.
  2. **Tonight's support** — surfaced here, inline, not in an FAQ. Each item is a toggle or button:
     - "Need a hotel tonight?" → opens the hotel support sub-step. Eligibility line is system-supplied; do not invent.
     - "Need meal support?" → same pattern.
     - If the user picked a same-night flight that departs soon, the hotel line still appears but with system-supplied eligibility context. We don't decide eligibility; we surface the question. **[recommendation]**
  3. What changes: baggage, check-in time, arrival airport gate-if-known. Only show fields the system can fill. **[recommendation]**
  4. Persistent "Get help from an agent" entry.
  5. Primary button: **"Confirm new flight and support"** (or "Confirm travel credit," or "Confirm standby request") — the button names the commitment. **[recommendation — addresses observed "Continue/Done don't say what will happen"]**
- **Back/exit:** back to Screen 2 or 3, with selections preserved. No destructive back.

### Screen 5 — Your updated trip
- **Primary decision:** none required; this is the "leave with confidence" screen. But it is also the re-entry point if plans change.
- **Hierarchy:**
  1. Header: "You're rebooked" / "Travel credit applied" / "You're on standby" — the actual outcome, not "Trip updated." **[recommendation — addresses observed vague "Trip updated"]**
  2. Trip-at-a-glance card: new flight, time, terminal/gate if known, check-in deadline, baggage status.
  3. Support confirmation: hotel booked (if so) with confirmation reference {system-supplied}; meal credit issued (if so) with how to use it {system-supplied}.
  4. **Offline backup:** "Save to phone" — produces a static page or wallet pass with the essentials. Do not require connectivity to re-read. **[recommendation — addresses observed "no offline backup"]**
  5. **If plans change again:** a labeled link, "My plans changed — change my trip again," that goes back to Screen 2 with current state as the new starting point. **[recommendation — addresses observed "no clear path if plans change again"]**
  6. Persistent "Talk to an agent."
- **Back/exit:** back to a normal "My trips" view, not into the recovery flow.

---

## 3. Copy constraints

### Voice rules
- Plain, short, declarative. **[recommendation]**
- Name the real event. "Canceled" beats "schedule irregularity" because the brief tells us it's a cancellation. **[observed]**
- Buttons name the consequence, not the mechanic. "See my options," "Confirm new flight and support," "Save to phone." Not "Continue," "Done," "Submit." **[recommendation — addresses observed problem]**
- Never use a superlative we can't back up ("best," "fastest," "recommended" without reason).
- Time references use absolutes plus the user's local context: "Tomorrow, 7:10 a.m." — not "in 8 hours."

### What NOT to write
- Do not invent: voucher amounts, hotel names, wait times, eligibility windows, credit expiration, refund timelines, phone numbers, "you are entitled to," "we guarantee." If the system doesn't supply it, the UI doesn't say it. **[recommendation, hard rule]**
- Do not use "Recommended" as a standalone badge. If we badge, the badge is the reason.
- Do not say "We apologize for the inconvenience" as the load-bearing line. The brief's current copy leads with the apology; the user needs the facts first. Apology can appear, but not as the headline. **[recommendation]**
- Do not pre-select an option for the user on the choice screen. **[observed problem]**

### SMS rewrite

Current **[observed]**:
> Northstar Alert: Schedule irregularity on NS482. Manage trip: link

Problems: hides the event, no next step, no reassurance, no mention of help. **[observed]**

Proposed **[recommendation]**, in two parts so it survives SMS character limits and screen readers:

> Northstar: Your 6:15 a.m. flight NS482 {DEN-LGA} is canceled. You have not been rebooked yet. See your options and any support you may need: {link}. Reply HELP for an agent.

Why this copy:
- Names the event ("canceled"), the flight, and the route so the user knows it's real and theirs.
- "You have not been rebooked yet" prevents the false-relief trap where users assume the airline handled it. **[recommendation]**
- "Any support you may need" hints at hotel/meal without inventing entitlement. **[recommendation]**
- "Reply HELP for an agent" gives a non-app fallback for low-bandwidth or screen-reader-fatigued users. **[recommendation, see Section 5]**

### Button label inventory (the full set, for the Visual Designer)

| Screen | Primary button | Secondary/tertiary |
|---|---|---|
| 1 | See my options | Get help from an agent |
| 2 | (no primary — three option cards) | Get help from an agent; See tonight's support |
| 3 | (no primary — flight cards tap to review) | Filter; Sort; Back |
| 4 | Confirm new flight and support / Confirm travel credit / Confirm standby request | Edit choice; Get help from an agent |
| 5 | Save to phone | My plans changed — change my trip again; Talk to an agent |

---

## 4. Hotel/meal entitlement surfacing

**Observed problem:** hotel voucher and meal credit are buried inside a collapsed "Other policies" FAQ on the current Screen 4. The brief explicitly flags this as a low-trust pattern that may cause users to pay out of pocket. **[observed]**

### Where it must surface

1. **SMS (Screen 0):** acknowledge support *exists* without promising it. "See your options and any support you may need." **[recommendation]**
2. **Screen 1 (What happened):** one line near the bottom — "If your travel is delayed overnight, hotel and meal support may be available. We'll show what applies on the next step." Do not state amounts, do not state eligibility. **[recommendation]**
3. **Screen 2 (Choose how you'll get there):** a persistent, quiet link below the three option cards: "See tonight's support (hotel, meals)." User can check support *before* committing to a recovery path. **[recommendation — this is the key change from current flow]**
4. **Screen 4 (Review, support, and confirm):** support is a *peer block* to the new flight summary, not a footer FAQ. Each support type is a labeled action ("Add hotel support," "Add meal support"), and each opens a system-supplied eligibility result. If the system says "not eligible," the UI says so plainly with reason, not by hiding the option. **[recommendation]**
5. **Screen 5 (Updated trip):** if support was added, it appears in the trip summary with its confirmation reference. If it was offered but declined, do not re-pitch.

### What we will NOT do
- Quote voucher amounts or hotel partners or meal-credit dollar figures. **[hard rule — brief constraint]**
- Promise eligibility before the system has confirmed it. **[hard rule]**
- Hide the *existence* of support behind a label like "Other policies." That label dies. **[recommendation — addresses observed problem]**

### Label rationale: why "tonight's support" beats alternatives
Considered: "Other policies" (current, observed problem — drift away from user job); "Your rights" (legal-sounding, raises expectations we can't guarantee, also implies a policy claim we don't have); "Hotel & meals" (concrete but presumes they apply); "Tonight's support" **[recommendation]** — names the *time horizon* the stressed user is in, hints at the kinds of help without committing to specifics, scans fast. Information scent: tells the user there is something time-sensitive to look at, without overpromising.

---

## 5. Edge-case routing

The brief explicitly names: tired, mobile-only, possibly with family, possibly low-bandwidth, possibly screen reader. **[observed]** Plus refund-seekers, plans-changed-again, and agent visibility. Each is either routed in-flow or named as a scoped gap.

| Edge case | Disposition | How |
|---|---|---|
| **Multi-passenger / family** | Solved in flow. | Screen 3 filter includes travel-party size. Flight cards must indicate when seats together are not available — that's a consequence the user needs before picking. Confirmation (Screen 5) lists each passenger. **[recommendation; relies on system data — flagged as ASSUMPTION that pax data is available to the recovery UI]** |
| **Low-bandwidth fallback** | Partly solved, partly scoped gap. | Screen 5 has "Save to phone" for offline re-read **[recommendation]**. SMS path is the bandwidth-light backup channel ("Reply HELP for an agent"). **Scoped gap:** I am not specifying an image-light/text-only render mode for the whole flow — Visual Designer and Accessibility Specialist should make sure no screen is image-dependent. **[scoped gap]** |
| **Screen reader path** | Routed; details deferred. | Hierarchy on every screen is heading → status → action, in that source order. No critical info conveyed by color or position alone. Button labels name consequences (better than "Continue" for screen-reader users who land mid-flow). Detailed ARIA, focus order, and live-region rules are the Accessibility Specialist's call — I'm flagging the structural requirement that source order match reading order. **[recommendation; defer specifics to Accessibility Specialist]** |
| **Refund-seeker** (user wants money back, not credit or rebook) | Partly solved, partly scoped gap. | Screen 2's "Take travel credit" card is honest about being credit, not cash. **Scoped gap:** the brief does not establish whether a cash refund is available for a Northstar-caused cancellation, and I will not invent policy. Recommendation: add a fourth option card *only if* policy/system supports it — "Request a refund instead." Until then, the agent-handoff path absorbs refund-seekers. **[scoped gap; recommendation conditional on policy]** |
| **Plans changed again** | Solved in flow. | Screen 5 has a labeled re-entry: "My plans changed — change my trip again." Goes back to Screen 2 with current trip as the starting state. **[recommendation — addresses observed problem]** |
| **Agent-handoff visibility** | Solved in flow. | "Get help from an agent" is a persistent entry on Screens 1, 2, 4, and 5 (and on Screen 3 in the filter/back area). It is never the primary button — we still want self-service — but it is never more than one tap away. The SMS includes a non-app fallback ("Reply HELP"). **[recommendation — addresses observed "people abandon the flow and call support" by making the agent path honest, not by hiding it]** |
| **User mid-flow loses connection** | Scoped gap. | Resumability of in-progress selection is a system/state concern. I'm naming it but not designing it here. Visual Designer should not assume a single uninterrupted session. **[scoped gap]** |
| **User on web vs. app vs. SMS-only** | Partly solved. | Mobile-first web works for both app and mobile browser. SMS-only users get the HELP fallback. **Scoped gap:** deep-linking and auth from SMS to a specific recovery context is a system concern. **[scoped gap]** |

---

## 6. Handoff to Visual Designer — build punch-list

This section is what you build from. Five screens, mobile-first. Each screen below lists: primary decision, content blocks in priority order (top of viewport first), button copy, and what the screen must NOT do. Anything not listed here is your call.

### S1 — What happened
- **Primary decision:** comprehend and proceed.
- **Content blocks, in order:**
  1. Status headline: "Your 6:15 a.m. flight {NS482} {DEN-LGA} is canceled."
  2. Reason line, only if system-supplied: "Reason: {system-supplied}."
  3. State-of-play line: "You have not been rebooked yet. We'll show your options next."
  4. Support teaser line: "If your travel is delayed overnight, hotel and meal support may be available. We'll show what applies on the next step."
- **Buttons:** Primary "See my options." Secondary "Get help from an agent."
- **Must NOT:** lead with an apology; use the word "irregularity"; promise rebooking; quote any amounts.

### S2 — Choose how you'll get there
- **Primary decision:** pick a recovery path.
- **Content blocks, in order:**
  1. One-line restatement of cancellation.
  2. Three full-width option cards, no pre-selection: (a) Rebook on a Northstar flight, (b) Take travel credit and arrange later, (c) Wait for standby.
  3. Each card has a one-line consequence sentence (copy in Section 2).
  4. A persistent link: "See tonight's support (hotel, meals)."
- **Buttons:** option cards are the action. Tertiary: "Get help from an agent."
- **Must NOT:** use tabs; pre-select an option; describe standby as if it were confirmed; bury support.

### S3 — Pick a flight (only if user chose "Rebook")
- **Primary decision:** pick one replacement flight.
- **Content blocks, in order:**
  1. Filter row (collapsed by default): arrival time, nonstop only, travel-party size.
  2. Sort control, default = earliest arrival.
  3. Flight cards: depart, arrive, stops, duration, consequence line. Badges only if reasoned ("Earliest arrival," "Nonstop," "Same fare").
- **Buttons:** flight card tap → Screen 4. Back returns to Screen 2 with state intact.
- **Must NOT:** show a bare "Recommended" badge; hide fare difference if it exists; default-sort by airline preference (e.g., revenue) without disclosure.

### S4 — Review, support, and confirm
- **Primary decision:** commit to the recovery path AND opt into support.
- **Content blocks, in order:**
  1. Your new plan (flight summary, or credit pending, or standby request).
  2. Tonight's support: two inline blocks — "Need a hotel tonight?" and "Need meal support?" — each opens system-supplied eligibility inline. Peer to the trip block, not below an FAQ.
  3. What changes: baggage, check-in deadline, gate-if-known. Only show fields the system can fill.
  4. Persistent "Get help from an agent."
- **Buttons:** Primary names the commitment — "Confirm new flight and support" (or the credit/standby equivalents). Secondary: "Edit choice."
- **Must NOT:** make support a footer FAQ; show eligibility we don't have; use "Continue" or "Submit"; commit silently on a back-button.

### S5 — Your updated trip
- **Primary decision:** leave with confidence; or re-enter if things changed.
- **Content blocks, in order:**
  1. Outcome headline that names the outcome: "You're rebooked" / "Travel credit applied" / "You're on standby."
  2. Trip-at-a-glance card: flight, time, terminal/gate if known, check-in deadline, baggage.
  3. Support confirmation block, if any: hotel reference {system-supplied}, meal credit usage {system-supplied}.
  4. "Save to phone" — the offline backup.
  5. "My plans changed — change my trip again" — labeled re-entry to Screen 2.
  6. "Talk to an agent."
- **Buttons:** Primary "Save to phone." Secondary "My plans changed — change my trip again." Tertiary "Talk to an agent."
- **Must NOT:** use "Trip updated" or "Done"; require connectivity to re-read; re-pitch support the user declined.

### Global rules across all five screens
- Mobile-first, single column, generous tap targets.
- "Get help from an agent" is reachable from S1, S2, S3, S4, S5 — never more than one tap away.
- Source order of the DOM matches reading order on screen. No critical signal in color alone.
- Back is never destructive until S4's confirm button is pressed.
- Time is always shown with date and timezone-anchored phrasing ("Tomorrow, 7:10 a.m. {local timezone}"), not relative ("in 8 hours").
- Every dynamic field is wrapped as `{system-supplied}` in the prototype until real data is wired in. Do not hard-code numbers, names, or amounts.

---

## 7. Labeled-claim discipline

Load-bearing claims in this report and how each is labeled:

- The four user jobs (understand, choose, get support, leave with confidence): **[observed]** — verbatim from brief's User Goal.
- "Canceled," not "irregularity," as the headline event: **[observed]** — brief says the flight is canceled.
- Tabs replaced by cards on Screen 2: **[recommendation]** addressing **[observed]** "default tab may not match user goal."
- Hotel/meal lifted out of "Other policies" FAQ to a peer block on Screen 4 and a teaser on S1/S2: **[recommendation]** addressing **[observed]** "entitlements are hidden."
- "Recommended" badge replaced with reasoned badges: **[recommendation]** addressing **[observed]** "'Recommended' is not explained."
- Default sort = earliest arrival on Screen 3: **[recommendation]** built on **[assumption]** that arrival-time priority is the dominant job for a traveler heading to a family event. Should be validated; do not treat as policy.
- "Save to phone" offline backup on Screen 5: **[recommendation]** addressing **[observed]** "no offline backup."
- "My plans changed — change my trip again" re-entry: **[recommendation]** addressing **[observed]** "no clear path if plans change again."
- Persistent agent-handoff: **[recommendation]** addressing **[observed]** "people abandon the flow and call support" — making the path honest, not hiding it.
- SMS rewrite: **[recommendation]** addressing the three **[observed]** SMS problems.
- Refund as a fourth option only if policy permits: **[scoped gap]** — I will not invent policy.
- Multi-passenger filter and same-seat indication: **[recommendation]** with **[assumption]** that passenger data is available to the recovery UI.
- Detailed ARIA, focus, and live-region behavior: **[deferred]** to Accessibility Specialist; structural prerequisite (source-order = reading-order) stated here.
- Default-no-selection on Screen 2 and any other anti-dark-pattern guardrails: **[recommendation]** — Behavioral Scientist has blocking authority and may tighten further.

---

## Open questions for the team (for the lead to triage)

- **For Accessibility:** any structural change needed for screen-reader landmark labeling on the option cards (S2)? I've made them cards, not tabs, partly for this reason — confirm.
- **For Behavioral Scientist:** is "Earliest arrival" as the default sort on S3 a nudge we can defend, or should sort start unsorted to avoid steering? My instinct says defend it given the brief's family-event context, but you have the call.
- **For Visual Designer:** if vertical space gets tight on S4, do not move support into a collapse. Compress the "What changes" block first. Support is load-bearing on this screen.
- **For the lead:** the refund-seeker scoped gap is the largest unresolved user need in this report. Worth a follow-up.
