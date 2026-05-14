# Interaction Designer — Northstar Canceled-Flight Recovery

**Role:** Interaction Designer (behavior, states, flow, error recovery)
**Scope:** SMS → Status → Choose flight → Review → Confirmed (+ persistent support module)
**Inputs used:** Brief, info-architect's flow model, accessibility-specialist's state-level requirements. No invented policies.
**Task:** #11 (in_progress → completed at end of this report)

---

## Top 3 Findings

1. **Every state change in this flow must announce itself.** [observed from brief — silent "Trip updated"; recommendation — make every transition speak] Cancellation arrival, flight selection, hotel-requested, rebook submitted, rebook confirmed, undo fired, undo expired, error states — none of these can be silent. Today's "Trip updated / Done" is the canonical failure: the most consequential moment in the flow has the least feedback.
2. **Error recovery has to be a first-class set of states, not edge cases.** [recommendation] The four most likely failures during a midnight rebook — *no flights*, *inventory race*, *payment declined*, *network drop / session expired* — each need a named state, an announced message, a primary recovery, and a path to a human. None can dump the user back to the start.
3. **A two-step commit (Select → Review → Confirm) is the trust-earning interaction, not gratuitous friction.** [recommendation, anticipating behavioral-scientist tension] The friction *prevents* regret because consequences are surfaced *before* the commit, not after. This is the single biggest behavioral lever in the redesign and the one most likely to be argued about.

---

## Evidence Labels

- **[Observed from brief]:** 5-screen flow today; "Continue" / "Done" labels; tabs with travel-credit default; entitlements buried in FAQ; "Trip updated" outcome with no detail; mobile-only, possibly-tired traveler.
- **[Inferred]:** Tabs likely re-fetch on switch; flight cards likely tap-to-commit (no review screen); confirmation likely optimistic without live announcement; no undo today.
- **[Assumption — flagged for engineering]:** Inventory can be held briefly (5–10 min) when a user enters review. *Brief does not confirm.* If holds are impossible, see fallback in §"Inventory race" below.
- **[Recommendation]:** Two-step commit, persistent support module as a slide-up sheet, undo window as a real state, all errors named, no tabs.

---

## Step-by-Step Interaction Model (SMS → Confirmation)

### Step 0 — SMS arrives

- **Trigger:** server-side cancellation event.
- **Behavior:** SMS sent with event-first language + deep link + fallback phone number. (Copy is content-designer's call.)
- **State:** static text; no in-app state.
- **Failure modes:** SMS undelivered (no in-app feedback possible — email backup); link expired (handled in Step 1).

### Step 1 — Open link → Screen 1 "Status & Path"

- **Trigger:** user taps SMS link.
- **Behavior:**
  1. Authenticate passively when possible (magic link or already-signed-in).
  2. On render, move focus to the new `<h1>`. (per accessibility-specialist)
  3. Announce the cancellation as a status message: `role="status"` with the event in plain language.
  4. Render: Status, plain-language reason, party scope ("you and 2 others"), Primary CTA, Secondary CTA, persistent support module.
- **Primary action:** "See rebooking options" → Step 2.
- **Secondary action:** "Other recovery options" → inline expander revealing credit / standby / call. (No tabs; per a11y handoff.)
- **Persistent support module:** always visible at a known position from this screen forward.

### Step 2 — Choose a flight → Screen 2

- **Trigger:** user taps "See rebooking options."
- **Behavior:**
  1. Move focus to the screen's `<h1>`.
  2. Sticky banner: "Your 6:15 a.m. NS482 was canceled."
  3. Flight list loads. Each card is a single semantic button with a full accessible name (per a11y).
  4. Filter row collapsed by default; expanding announces the new state (e.g. "Showing nonstop only — 2 of 5 flights.").
  5. Hotel module visible at a consistent position (mid-list or sticky — visual-designer's call).
  6. Tapping a flight card does **not** commit — it advances to Step 3 with the choice preserved.
- **Decision points:** which flight; whether to request hotel before or after rebook.
- **Inventory hold:** when the user advances to Step 3, attempt to hold the selected seat for 5 minutes [assumption — needs business confirmation]. If the system cannot hold, display a non-panic banner: "We can't hold this seat — please confirm quickly or someone else may take it." Do **not** show a countdown timer on the choice itself; that pressures the wrong decision.

### Step 3 — Review & Confirm → Screen 3

- **Trigger:** user taps a flight card.
- **Behavior:**
  1. Move focus to "Review your changes" `<h1>`.
  2. Show old → new diff, cost (with explanation), what's included free, what happens next.
  3. Live-announce when the page is ready: "Review your changes. Confirming will rebook all 3 travelers on the 2:40 p.m. nonstop tomorrow."
  4. Primary CTA: "Confirm rebooking" — consequence-bearing label.
  5. Secondary CTA: "Back to flight list" — preserves selection.
  6. If hotel was requested in Step 2, show as a bundled change ("we'll also hold a hotel for tonight").
- **No charges, no commits, no destructive change** until the user taps Confirm.

### Step 4 — Confirmed → Screen 4

- **Trigger:** server confirms the rebooking.
- **Behavior:**
  1. Live-announce success as `role="status"` (not `role="alert"` — positive events stay polite).
  2. Render itinerary block, hotel block (if any), confirmation code, support number, undo window.
  3. Start the 60-second undo timer. Announce its presence once: "You can undo within 60 seconds." Visual countdown shown; AT announces start + end, not every tick (per a11y).
  4. Trigger outbound SMS + email with the same content; show "Sent to your phone and email" once delivery callbacks return.
  5. Persistent support module stays visible.

### Step 5 — Post-confirmation

- **Inputs:** none required; user can leave the app.
- **Behavior:** at undo-window expiry, announce calmly ("Undo window has closed. You can still change plans by tapping Call support.").

---

## States Per Screen

> Each row says **what announces** and **where focus goes**. This is the structure accessibility-specialist requested. Any blank "Announcement" cell is a bug.

### Screen 1 — Status & Path

| State | Visual | Announcement | Focus on entry |
|---|---|---|---|
| Default | Event headline + 2 CTAs + support module | `role="status"`: "Your 6:15 a.m. flight tomorrow is canceled." | `<h1>` |
| Loading (passive auth) | Skeleton lines, not spinner alone | "Loading your trip status." | `<h1>` placeholder |
| Partial | Status shown, options not yet loaded | "Loading options." | `<h1>` |
| Empty | (n/a — there is always a status) | — | — |
| Error (auth fail) | Inline error + Call support CTA | `role="alert"`: "Sign-in failed. Tap Call support, or try the link again." | error banner |
| Success | (transitions out) | — | — |
| Undo | (n/a on this screen) | — | — |

### Screen 2 — Choose a Flight

| State | Visual | Announcement | Focus on entry |
|---|---|---|---|
| Default | Filter row + flight list + hotel module + secondary actions | "Showing N flights tomorrow, sorted by best match." | `<h1>` |
| Loading | Skeleton flight cards | "Loading flights." | `<h1>` placeholder |
| Partial (some loaded, more pending) | Visible cards + skeleton rows | "5 flights loaded. Checking for more." | `<h1>` |
| Empty (no flights) | Empty-state with named recovery: "No same-day flights. Try next-day, or call support." | `role="alert"`: "No flights match. Two options:" | empty-state CTA |
| Filter applied | Updated list | (live) "Showing 2 nonstop flights." | retained |
| Error (inventory call failed) | Inline error + retry + Call support | `role="alert"` with retry instruction | error banner |
| Success (card tapped) | Transitions to Screen 3 | "Holding seat. Loading review." | retained until S3 |
| Undo | (n/a on this screen) | — | — |

### Screen 3 — Review & Confirm

| State | Visual | Announcement | Focus on entry |
|---|---|---|---|
| Default | Full review block + primary/secondary CTAs | "Review your changes. Confirming will rebook all N travelers." | `<h1>` |
| Loading (holding seat) | "Holding seat" inline | "Holding your seat." | `<h1>` |
| Partial | Review shown, hotel pending | "Hotel availability still loading." | retained |
| Empty | (n/a) | — | — |
| Error (hold lost) | Banner: "Seat is gone — pick another." → returns to S2 | `role="alert"` | banner |
| Error (payment declined) | Inline payment error + retry | `role="alert"` | error field |
| Error (network) | Toast + offline CTA | `role="alert"` | banner |
| Success | Transitions to S4 | "Submitting." | — |
| Undo | (handled on S4) | — | — |

### Screen 4 — Confirmed

| State | Visual | Announcement | Focus on entry |
|---|---|---|---|
| Default | Itinerary + hotel + undo window + save actions + support | `role="status"`: "Success. Rebooked on the 2:40 p.m. flight tomorrow. Hotel confirmed." | `<h1>` |
| Loading (server still finalizing) | Skeleton itinerary block | "Finalizing your booking." | `<h1>` |
| Partial (rebook done, hotel pending) | Itinerary firm, hotel pending block | "Flight confirmed. Hotel still processing." | `<h1>` |
| Empty | (n/a) | — | — |
| Undo active (0–60s) | Countdown visible, "Undo" button enabled | Start announcement only; not per-second | retained |
| Undo fired | "Rebook canceled — your original cancellation is restored. Tap to try again." | `role="alert"` | "Try again" CTA |
| Undo expired | "Undo window closed." | `role="status"` once | retained |
| Success (delivery confirmed) | Inline checkmark + label | (live) "Itinerary sent to your phone." | retained |
| Error (outbound SMS/email fail) | "We couldn't text you — copy your info or tap to retry." | `role="alert"` | retry CTA |

### Persistent Support Module (cross-cutting)

| State | Visual | Announcement | Focus behavior |
|---|---|---|---|
| Closed (default) | Pill / button at known position | none | tab-reachable |
| Opening (slide-up sheet) | Animated sheet (respects reduce-motion) | "Help options." | first focusable in sheet |
| Loading (fetching hotel availability) | Disabled CTA + skeleton | "Checking hotel options." | retained |
| Partial (form pre-filled, awaiting confirm) | Form: dates pre-filled from itinerary | (live) inline validation | form fields |
| Empty (no entitlement) | Honest: "Hotel voucher isn't available for this disruption — here's why and what to do." | `role="status"` | first focusable |
| Submitting | Disabled CTA + label | "Submitting hotel request." | retained |
| Success (Submitted) | Confirmation + "Sent to your phone." | `role="status"` | "Close" |
| Error (Failed) | Inline retry + Call support | `role="alert"` | error |
| Closed | Returns focus to opener | "Help options closed." | original trigger |
| Undo (cancel a pending hotel request) | "Cancel this request" within 30s | start + end announcement | retained |

---

## Error Recovery Paths

### No flights available
- **State:** Screen 2 → empty.
- **Behavior:** name **two** alternatives — "Try next-day flights" (loads next-day list inline) and "Call Northstar support" (tap-to-call). Optional third: "Add me to standby on the earliest flight."
- **Anti-pattern avoided:** dumping the user with a "Sorry, no flights found" dead end.

### Payment / fare-difference fails
- **State:** Screen 3 → error, inline (do not leave the screen).
- **Behavior:** show the actual reason in plain language ("Card declined"), keep the user's selection intact, offer (a) try another card, (b) pick a $0 alternative on a contextual back-link to S2, (c) call support. Do **not** throw the user back to Step 1.

### Plans change again (after confirmation, after undo window)
- **State:** post-confirm.
- **Behavior:** persistent support module exposes "Change plans again" → re-enters Screen 2 with the *new current itinerary* as context. Re-rebooks against the new itinerary, not the original ticket. Announces: "Starting from your current 2:40 p.m. flight."

### Network drop mid-flow
- **State:** error, anywhere.
- **Behavior:** local cache of selection; offline banner: "You're offline. Your choice is saved." On reconnect, attempt to resume; if hold has expired, return to Screen 2 with a banner explaining and the original selection auto-scrolled into view if still available.

### Session expired (e.g., SMS link reopened next morning)
- **State:** error, gentle.
- **Behavior:** re-auth passively; if not possible, show "Your sign-in expired — sign back in to see your options" with Call support fallback. Do not require the user to re-discover the cancellation; surface the event again on re-auth.

### Inventory race (seat gone between Screen 2 and Screen 3)
- **State:** Screen 3 → error.
- **Behavior:** announce assertively, return to Screen 2 with banner: "That seat just went. Here are the closest alternatives." Auto-scroll to a similar-time flight if any. **Fallback if holds aren't technically possible:** Screen 3 collapses to a single-screen "quick confirm" pattern with the may-sell-out caveat surfaced honestly above the CTA. No silent re-quotes.

### Double-submit (user taps Confirm twice / refreshes mid-submit)
- **State:** Screen 3 → submitting.
- **Behavior:** first tap disables the CTA, swaps to a labeled spinner, and gates a server-side idempotency key. Second tap is a no-op. Refresh during submit returns to Screen 3 with current request status, not Screen 2.

### Back button mid-flow
- **State:** any.
- **Behavior:** S2→S1 is safe (no commit). S3→S2 preserves selection. S4→S3 is blocked (the booking has happened); back lands on S4 with a polite "Your booking is confirmed — to change again, use Change plans." Browser/OS back never silently undoes a commit.

### Undo fired
- **State:** post-undo.
- **Behavior:** restore original cancellation context (not the original flight — it doesn't exist). Land back at Screen 1. Announce: "Rebooking canceled. You're back to choosing options." Refund / hotel reversal handled server-side; user is told what's happening, not asked to manage it.

---

## Handoff Moments (where humans / channels take over)

1. **Tap-to-call "Call Northstar support"** — always available via the persistent module. Pre-fills caller ID with reservation # if the OS supports it. Hours announced honestly.
2. **Failure escalation:** every named error state offers Call support as a fallback action. No dead ends.
3. **SMS / email backup at confirmation:** equivalent content sent so the user has an offline record even if the app crashes or the device dies. The on-screen "Sent to your phone" badge is the user's signal to feel safe putting the phone down.
4. **"Add to calendar" handoff:** allows the user to leave the app entirely and trust their calendar / OS notifications.
5. **Airport handoff:** confirmation copy and SMS include "If your hotel pickup or check-in has issues, show this confirmation at the Northstar desk." (Phrased as guidance, not a guarantee — no invented policy.)

---

## Pattern Choices (X over Y because…)

- **Two-step commit (Select → Review → Confirm) over one-tap rebook.** A one-tap rebook is faster but unrecoverable for a tired user at midnight. The Review screen is the regret-prevention layer; pairs with the 60s undo as a safety net.
- **Segmented expander / inline secondary actions over tabs.** Tabs hide consequence. Three mutually-exclusive recovery paths with consequence labels are easier for AT/voice users and clearer under stress. (Adopted from a11y handoff.)
- **Slide-up sheet for support over a full-screen "Help" route.** A sheet preserves user context (they don't lose their flight selection) and returns focus to the opener — important for screen-reader and keyboard users.
- **60s undo window over a "Are you sure?" confirm modal.** Modals interrupt; undo respects the user's decision and gives a graceful out. Falls back to a stronger Review screen if undo is technically infeasible (escalation flagged to engineering).
- **Skeleton loaders over spinners.** Reduces perceived latency, works without motion (per reduce-motion users), and lets us mark "what's coming."
- **Tap-to-call persistent over a "Contact us" page link.** A stressed user should never have to navigate to ask for help.

---

## Open Questions (need business / engineering input)

1. **Inventory hold feasibility.** Can we hold a seat for 5 minutes between Select and Confirm? If no, Review screen must collapse to a quick-confirm with a sell-out caveat; we lose some regret-prevention.
2. **Undo window technical feasibility.** Can a confirmed rebook be reversed within 60s without finance/ops side-effects? If not, we replace undo with a stronger pre-commit confirmation and surface the irreversibility honestly.
3. **Hotel entitlement source-of-truth.** Where does the app learn whether this disruption qualifies for a hotel voucher? The empty/honest state ("not available — here's why") depends on this signal being accurate.
4. **Magic-link auth on SMS deep link.** Is passive re-auth acceptable to security? If not, sign-in becomes a state with its own announcement and recovery.

---

## Handoffs Sent

- **→ accessibility-specialist** (`a11y-state-list-from-interaction-designer.md`): full state list above for AT blocker review; specific questions on `role="status"` vs `aria-live`, undo announcement cadence, sheet pattern, filter announcements.
- **→ visual-designer** (`visual-designer-state-list-from-interaction-designer.md`): same state list for visual treatment; specific asks on skeletons, sticky-CTA-vs-focus rule, undo countdown styling, empty/error first-class treatment, "Best match" non-color encoding, hotel module placement.

---

## Handoffs Received

| Sender | Message | What changed in this report |
|---|---|---|
| info-architect | 4 in-app screens + persistent support module, two-step commit, no tabs. | Adopted directly. Built the error-state matrix against this structure. |
| accessibility-specialist | Status messages required, focus management, no keyboard traps, undo as a real state, persistent help (WCAG 3.2.6), tabs vs segmented control preference. | Added focus-management column to every state table. Made "undo" a named state with explicit announcement model. Confirmed sheet pattern for support module. Dropped tabs. |
| behavioral-scientist | (Anticipated — friction concerns) | Two-step commit framed as *consequence surfacing*, not friction-for-friction. Will revise if behavioral-scientist's concerns materially differ. |

---

## To Team Lead (status)

**Top 3 findings:** every state announces; error recovery is first-class; two-step commit earns trust.

**One tension:** the **inventory hold assumption.** I have designed for a 5-minute hold (Select → Review → Confirm) but the brief does not confirm this is technically possible. If holds are infeasible, the Review screen must shrink to a quick-confirm pattern with a clear "may sell out" warning — which weakens the regret-prevention case. Flagging for synthesis and engineering follow-up. Secondary tension: 60s undo also depends on backend reversal capability.

**Messaged:** accessibility-specialist, visual-designer.

**Task #11:** completed.
