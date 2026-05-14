# Information Architect — Northstar Canceled-Flight Recovery

**Role:** Information Architect
**Scope:** Revised flow structure ≤5 screens (mobile-first), content hierarchy, decision points, navigation labels.
**Inputs used:** Brief + inbound from ux-researcher (top user needs). No invented policy.

---

## Top 3 Findings

1. **The current IA is task-shaped; it needs to be *event-shaped*.** [observed from brief] The user lands on "Your itinerary has changed" and is asked to navigate tabs by *option type*. Better: orient first (the event), then offer the *outcomes* the user wants (get there, come back, get help). Outcome-first IA reduces the user's choice load and the team's copy load.
2. **"Recovery options" should not be a separate screen from "New flights."** [recommendation] In ≤5 screens, the options and the actual flight list have to live on the same surface, with the rest (credit, standby, call) reachable but secondary. Three tabs + a separate list is wasted depth.
3. **Hotel / meal / support are cross-cutting; they belong as a persistent module, not a screen.** [recommendation] They show up everywhere the user might need them (after rebook, before rebook, at confirmation, after returning) — not as a separate destination buried in FAQ.

---

## Evidence Labels

- **[Observed from brief]:** 5 screens (Trip Status → Recovery Options tabs → New Flights list → Support FAQ → Confirmation). Default tab Travel credit. Hotel/meal in "Other policies" disclosure. "View details" / "Continue" / "Done" labels.
- **[Inferred]:** Tabs likely render as horizontal segmented control on mobile; FAQ disclosure likely an accordion; flight cards likely tappable rows.
- **[Assumption]:** The product has the data to populate a pre-commit summary (new flight, baggage, hotel candidate, confirmation code).
- **[Recommendation]:** Collapse "Recovery Options" + "New Flights" into a single decision surface; make hotel/meal/support a persistent module; treat SMS as Screen 0.

---

## Revised Screen Sequence (5 screens, including SMS as Screen 0)

> **Counting note:** the brief asks for ≤5 screens in-app. I treat the SMS as a pre-screen (Screen 0) because it carries content. In-app screens are 1–4 + a sticky support module that is not its own destination. Total in-app = 4.

### Screen 0 — SMS (entry, also a content surface)

**Purpose:** Tell the user the event and pull them in with confidence.

**Hierarchy (top → bottom):**
1. Event in one sentence (flight #, time, route, "canceled")
2. Reason in plain language ("due to crew availability") [observed from brief]
3. One reassurance ("we're holding rebooking and hotel options for you")
4. Call to action (deep link → Screen 1)
5. Fallback (phone number for support, since the link might not work)

**Labels:** N/A — this is plain text. Content-designer owns wording.

### Screen 1 — Status & Path (the "what + we're on it" screen)

**Purpose:** Confirm the event, set context, offer two named paths.

**Hierarchy (top → bottom):**
1. **Headline:** the cancellation, with date, time, flight #, route
2. **Why** (one line)
3. **Party scope:** "for all 3 travelers on this reservation" — only if multi-pax [recommendation; family clarity per ux-researcher]
4. **Primary action:** "See rebooking options" → Screen 2
5. **Secondary action:** "Choose a different recovery" (credit / standby / call) → Screen 3 *or* an inline expander on Screen 2
6. **Persistent support module:** Hotel + meal entry, Call support, SMS me this info

**Decision point:** rebook (most users) vs. other (credit, standby, support).
**Back-out:** none yet — the user has not committed to anything.

**Navigation labels (working):** none cross-screen yet; primary CTA is its own label.

### Screen 2 — Choose Your Flight (decision)

**Purpose:** Pick a same-/next-day flight. Hotel + support visible at the same level.

**Hierarchy:**
1. **Sticky status banner** (1 line): "Your 6:15 a.m. NS482 was canceled."
2. **Filter row (collapsed by default):** arrival window, nonstop only, mobility/medical needs, party-size aware sorting
3. **Flight list** (cards, sorted by "best match" — and explained)
4. **Persistent "Need a hotel for tonight?" card** at a known position (mid-list or sticky depending on visual-designer)
5. **Secondary actions:** "I'd rather have a travel credit" • "Add me to standby" • "Call Northstar support"

**Decision points:** which flight to take, whether to request hotel before or after rebook (allow both).
**Back-out:** back arrow returns to Screen 1 with no commitment. Selecting a flight goes to Screen 3 (review), not direct commit.

**Navigation labels:** "Best match" replaces "Recommended" (with inline reason); section labels are "Available flights tomorrow," "If your plans change," "Get hotel + meal help."

### Screen 3 — Review & Confirm (pre-commit summary)

**Purpose:** Show stakes plainly *before* the user changes their reservation. This is the trust moment.

**Hierarchy:**
1. **What will change:** old flight → new flight, with date/time/terminal
2. **What's included free:** rebooking, baggage carries over, hotel held *if requested*
3. **What it costs:** $0 or fare difference (with explanation: "applies because you chose an earlier nonstop")
4. **What happens next:** confirmation by SMS + email, undo window length, support number
5. **Primary CTA:** "Confirm rebooking" (consequence-bearing label)
6. **Secondary CTA:** "Back to flight list"

**Decision point:** commit vs. back. No surprise charges past this point.
**Back-out:** "Back to flight list" preserves choices.

### Screen 4 — Confirmed (done + equipped)

**Purpose:** Confirm the change and equip the user with what they need offline.

**Hierarchy:**
1. **Live-announced success status** (per accessibility-specialist 4.1.3)
2. **The new itinerary block** (flight, time, terminal, baggage status, confirmation code) — visually copyable
3. **The hotel block** (if requested): name, address, check-in window, confirmation code
4. **Send-me-this-info actions:** SMS, email, add to calendar
5. **Undo window:** "Within 60 seconds you can undo this rebooking" with countdown + announce [recommendation, integrating accessibility input]
6. **Persistent support module:** Call support, change plans again
7. **Next steps timeline:** "We'll text you 3 hours before boarding" — sets expectation

**Decision point:** undo (within window), call support, leave. No further forced choices.

---

## Cross-cutting (not their own screen): Persistent Support Module

Reachable from every in-app screen, visually consistent (per WCAG 3.2.6 Consistent Help), containing:

- **"Get hotel + meal help"** — opens an inline request flow without losing the user's place
- **"Call Northstar support"** — tap-to-call, with hours stated honestly
- **"Text me this info"** — copies the current state to SMS

This is the IA's answer to the brief's "hotel + meal buried in FAQ" failure: it's not a destination, it's a service that follows the user.

---

## Decision Points (summary)

| Where | Decision | Default | Reversible? |
|---|---|---|---|
| Screen 1 | rebook vs. other recovery | rebook is the named primary action | yes (no commit yet) |
| Screen 2 | which flight | "Best match" highlighted with reason; user freely selects | yes (no commit yet) |
| Screen 2 | request hotel? | optional, prominent | yes (toggle) |
| Screen 3 | confirm rebook | confirm is primary CTA; back-to-list is one tap | yes (no commit until tapped) |
| Screen 4 (within 60s) | undo rebook | not active | yes via undo |
| Screen 4 (after window) | call support to change | n/a | requires human |

---

## Navigation / Section Labels (high-level, working — content-designer owns final wording)

- **Top status banner (sticky on screens 2–3):** "Flight canceled — recovery in progress"
- **Section label, Screen 2:** "Available flights — pick one"
- **Section label, Screen 2:** "Need a hotel for tonight?"
- **Section label, Screen 2:** "If your plans change" (credit / standby)
- **Section label, Screen 3:** "Review your changes"
- **Section label, Screen 4:** "You're rebooked"
- **Section label, Screen 4:** "Your hotel"
- **Section label, Screen 4:** "Save this info"
- **Persistent support label:** "Get help" or "Need help?" — single phrase across screens

I am intentionally not finalizing word-level copy; that's content-designer's job. These are *slots*.

---

## What Got Rejected

- **Keeping the tab pattern (New flights / Travel credit / Standby).** Hides consequences; defaulting one of three is dangerous; replaces with primary + secondary actions instead.
- **A separate "Support" screen.** Becomes a destination users won't visit; replaced with the persistent module.
- **A confirmation modal *before* the decision.** Friction in the wrong place; replaced with a full Screen 3 review.
- **An exit interview ("how was your experience?") on Screen 4.** Wrong moment for a survey; capture later.
- **Showing all recovery types at equal weight on Screen 1.** Treats a rebook user and a "want a credit" user as the same; they aren't. The flow points the dominant case at the dominant solution and *visibly* offers the alternative.

---

## Handoffs Sent

### → interaction-designer

**Subject: Proposed flow model and decision points**

The structural decisions I'm asking you to design behavior into:

1. **4 in-app screens + persistent support module** (SMS = Screen 0). Status → Choose flight → Review → Confirmed. Support follows the user.
2. **No tabs.** Replace with one primary path (rebook) + two named secondary recovery paths reachable inline on Screen 2.
3. **Two-step commit** (Screen 2 select → Screen 3 review → confirm). The review is the trust moment.
4. **Persistent support module** is a behavior question: how do we open hotel/meal request without losing place? Slide-up sheet? Inline expander? Your call.
5. **Undo window** on Screen 4 is a real state, not decoration — needs a live status announcement (accessibility-specialist already flagged 4.1.3) and a clean state if the timer expires.
6. **Back-out paths:** none of the first three screens should commit the user. Confirm only happens on Screen 3 tap. Please name every back/cancel state.
7. **Decision points (above table) are yours to model with states** (default, loading, partial, error, sold-out mid-flow, payment fail, network lost, session expired, undo fired, undo expired).

Two specific risks I'm handing you to figure out:
- **Inventory race:** what if the flight sells out between Screen 2 select and Screen 3 commit?
- **Hotel request fails after flight succeeds:** how do we keep the rebook but not strand the user on the hotel?

### → content-designer

**Subject: Section labels and screen slots so you can write copy**

I am giving you slots, not words. Here are the slots:

| Screen | Slot | What it has to say (job to be done) |
|---|---|---|
| SMS | Event + reassurance + link | Lead with event; one-line reassurance; deep link; fallback support number |
| 1 | Headline | Event, flight #, date/time, route |
| 1 | Reason | One short line |
| 1 | Party scope (conditional) | "for all N travelers" |
| 1 | Primary CTA | Promises what the next screen will do |
| 1 | Secondary CTA | "Other recovery options" naming — not "Continue" |
| 2 | Sticky banner | Reminds the user of the canceled flight in one line |
| 2 | "Best match" tag | Replaces "Recommended"; must carry the *reason* |
| 2 | Fare-difference framing | Honest, calm: when does it apply, when is it $0 |
| 2 | Hotel entry | Action label, not a description |
| 2 | Secondary recovery row | Credit / standby / call — explain consequence inline |
| 3 | "What changes" block | Old → new, plain, scannable |
| 3 | Cost block | $0 or $X, with reason |
| 3 | Primary CTA | "Confirm rebooking" or equivalent — consequence-bearing |
| 4 | Success header | Plain, live-announced |
| 4 | Itinerary block | Facts only — copyable |
| 4 | Hotel block (conditional) | Name, address, check-in window |
| 4 | Undo window copy | Time-bound, calm, not panicky |
| 4 | "Save this info" actions | SMS / email / calendar labels |
| Persistent | "Get help" entry | One consistent label across screens |

Tone notes (per ux-researcher): lead with event, then reassurance, then action. No system jargon. ~grade 6–8 reading level. Don't promise entitlements the brief doesn't authorize.

---

## Handoffs Received

| Sender | Message | What changed |
|---|---|---|
| ux-researcher | Top user needs: understand event, see options that match goal, hotel visible at decision time. | Confirmed the "outcome-first" IA direction. Pushed me to make hotel a persistent module instead of an inline link. |
| accessibility-specialist (via report) | Status messages absent, hotel buried, non-descriptive labels. | Added "persistent support module" as the IA answer to "buried entitlements." Confirmed two-step commit pattern to support the undo window. |

---

## To Team Lead (status)

**Top 3 findings:** outcome-first IA (not task-first); collapse options + flight list onto one surface; hotel/support is a cross-cutting module not a destination.

**One tension:** Behavioral-scientist may push back on the persistent support module on the grounds that visibly available phone support could *increase* calls. I disagree (it should reduce them by raising trust in self-service) but it is a real disagreement. Will flag for synthesis.

**Messaged:** interaction-designer, content-designer.
