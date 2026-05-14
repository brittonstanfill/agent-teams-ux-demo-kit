# Interaction Designer — Northstar Canceled-Flight Recovery

**Role:** Interaction Designer (behavior, states, flow, error recovery)
**Scope:** SMS → Status → Choose flight → Review → Confirmed (+ persistent support module)
**Inputs used:** Brief, info-architect's flow model, accessibility-specialist's state-level requirements. No invented policies.

---

## Top 3 Findings

1. **Every state change in this flow must announce itself.** [observed from accessibility brief + recommendation] Cancellation arrival, flight selection, hotel-requested, rebook submitted, rebook confirmed, undo fired, undo expired, error states — none of these can be silent. The current flow's "Trip updated" is the canonical failure mode.
2. **Error recovery has to be a first-class set of states, not edge cases.** [recommendation] The four most likely failure modes during a midnight rebook — inventory sold out mid-flow, payment declined, network drop, session expired — each need a named state, an announced message, a primary recovery, and a path to a human.
3. **The two-step commit (Select → Review → Confirm) is the trust-earning interaction, not friction.** [recommendation] Behavioral-scientist will argue about friction; my position is that this friction *prevents* regret rather than creating it, *because the consequences are surfaced before the commit*, not after.

---

## Evidence Labels

- **[Observed from brief]:** 5-screen flow, "Continue" / "Done" labels, tab UI with travel-credit default, FAQ disclosure, "Trip updated" outcome with no detail.
- **[Inferred]:** Tabs likely re-fetch on switch; flight cards likely tap-to-commit (no review); confirmation may be optimistic without live announcement.
- **[Assumption]:** Inventory is held briefly when a user selects a flight (5–10 min) — *I am flagging this as an open question; brief does not confirm.*
- **[Recommendation]:** Two-step commit, persistent support module as a slide-up sheet, undo window as a real state, all errors named.

---

## Step-by-Step Interaction Model

### Step 0 — SMS arrives

- **Trigger:** server-side cancellation event.
- **Behavior:** SMS sent with event-first copy + deep link + fallback phone number.
- **State:** static text; no in-app state.
- **Failure modes:** SMS not delivered (no in-app feedback possible); link expired (handle in Step 1).

### Step 1 — Open link → Screen 1 "Status & Path"

- **Trigger:** user taps SMS link.
- **Behavior:**
  1. Authenticate (passive if possible — magic link or already-signed-in).
  2. Move focus to the new `<h1>` on load. (per accessibility-specialist)
  3. Announce the cancellation as a status message: `role="status"` with the event in plain language.
  4. Render Status, Reason, Party scope, Primary CTA, Secondary CTA, persistent support module.
- **Primary action:** "See rebooking options" → Step 2.
- **Secondary action:** "Other recovery options" → inline expander revealing credit / standby / call.
- **Persistent support module:** always visible at a known position.

### Step 2 — Choose a flight → Screen 2

- **Trigger:** user taps "See rebooking options."
- **Behavior:**
  1. Move focus to the screen's `<h1>`.
  2. Sticky banner: "Your 6:15 a.m. NS482 was canceled."
  3. Flight list loads. Each card is a single semantic button with full accessible name (per accessibility).
  4. Filter row collapsed by default; expanding announces the new state ("Showing nonstop only — 2 of 5 flights.").
  5. Hotel module visible at a consistent position (mid-list or sticky — visual-designer's call).
  6. Tapping a flight card does **not** commit — it advances to Step 3 with the choice preserved.
- **Decision points:** which flight; whether to request hotel before or after rebook.
- **Inventory hold:** when the user advances to Step 3, attempt to hold the selected seat for 5 minutes [assumption — needs business confirmation]. If the system cannot hold, display a banner: "We can't hold this seat — please confirm quickly or someone else may take it." Do *not* show a panicky countdown timer on the choice itself; that pressures the wrong decision.

### Step 3 — Review & Confirm → Screen 3

- **Trigger:** user taps a flight card.
- **Behavior:**
  1. Move focus to "Review your changes" `<h1>`.
  2. Show old → new diff, cost (with explanation), what's included free, what happens next.
  3. Live-announce when the page is ready: "Review your changes. Confirming will rebook all 3 travelers on the 2:40 p.m. nonstop tomorrow."
  4. Primary CTA: "Confirm rebooking" — consequence-bearing label.
  5. Secondary CTA: "Back to flight list" — preserves selection.
  6. If hotel was requested in Step 2, show as a bundled change ("we will also hold a hotel for tonight").
- **No charges, no commits, no destructive change** until the user taps Confirm.

### Step 4 — Confirmed → Screen 4

- **Trigger:** server confirms the rebooking.
- **Behavior:**
  1. Live-announce success as `role="status"` (not `role="alert"` — this is a positive event, polite is correct).
  2. Render itinerary block, hotel block (if any), confirmation code, support number, undo window.
  3. Start the 60-second undo timer. Announce its presence: "You can undo within 60 seconds." Visually count down; assistive tech announces start + end of window, not every tick.
  4. Trigger outbound SMS + email with the same content; show "Sent to your phone and email" once delivery callbacks return.
  5. Persistent support module stays visible.

### Step 5 — Post-confirmation

- **Inputs:** none required; user can leave the app.
- **Behavior:** at undo-window expiry, announce the expiry calmly ("Undo window has closed. You can still change plans by tapping Call support.").

---

## States Per Screen

> Each row says what announces and where focus goes. This is the table accessibility-specialist asked for.

### Screen 1 — Status & Path

| State | Visual | Announcement | Focus on entry |
|---|---|---|---|
| Default | Event headline + 2 CTAs + support module | `role="status"`: "Your 6:15 a.m. flight tomorrow is canceled." | `<h1>` |
| Loading (passive auth) | Skeleton lines, not spinner alone | "Loading your trip status." | `<h1>` placeholder |
| Empty | (n/a — there's always content) | — | — |
| Partial | Status shown, options not yet loaded | "Loading options." | `<h1>` |
| Error (auth fail) | Inline error + Call support CTA | `role="alert"`: "Sign-in failed. Tap Call support, or try the link again." | error banner |
| Success | (transitions out) | — | — |

### Screen 2 — Choose a Flight

| State | Visual | Announcement | Focus on entry |
|---|---|---|---|
| Default | Filter row + flight list + hotel module + secondary actions | "Showing N flights tomorrow, sorted by best match." | `<h1>` |
| Loading | Skeleton flight cards | "Loading flights." | `<h1>` placeholder |
| Empty (no flights) | Empty-state with named recovery: "No same-day flights. Try next-day, or call support." | `role="alert"`: "No flights match. Two options:" | empty state CTA |
| Partial (some loaded, more pending) | Visible cards + skeleton for remaining | "5 flights loaded. Checking for more." | `<h1>` |
| Filter applied | Updated list | "Showing 2 nonstop flights." (live) | retained |
| Error (inventory call failed) | Inline error + retry + Call support | `role="alert"` with retry instruction | error banner |
| Success (card tapped) | Transitions to Screen 3 | "Holding seat. Loading review." | retained until S3 |

### Screen 3 — Review & Confirm

| State | Visual | Announcement | Focus on entry |
|---|---|---|---|
| Default | Full review block + primary/secondary CTAs | "Review your changes. Confirming will rebook all N travelers." | `<h1>` |
| Loading | "Holding seat" inline | "Holding your seat." | `<h1>` |
| Error (hold lost) | Banner: "Seat is gone — pick another." → back to S2 | `role="alert"` | banner |
| Error (payment required and declined) | Inline payment error + retry | `role="alert"` | error field |
| Error (network) | Toast + offline CTA | `role="alert"` | banner |
| Success | Transitions to S4 | "Submitting." | — |

### Screen 4 — Confirmed

| State | Visual | Announcement | Focus on entry |
|---|---|---|---|
| Default | Itinerary + hotel + undo window + save actions + support | `role="status"`: "Success. Rebooked on the 2:40 p.m. flight tomorrow. Hotel confirmed." | `<h1>` |
| Undo active (0–60s) | Countdown visible, "Undo" button enabled | Start announcement only; not per-second | retained |
| Undo fired | "Rebook canceled — your original cancellation is restored. Tap to try again." | `role="alert"` | "Try again" CTA |
| Undo expired | "Undo window closed." | `role="status"` once | retained |
| SMS/email delivery confirmed | Inline checkmark + label | "Itinerary sent to your phone." (live) | retained |
| Error (outbound SMS/email fail) | "We couldn't text you — copy your info or tap to retry." | `role="alert"` | retry CTA |

### Persistent Support Module (cross-cutting)

| State | Visual | Announcement | Focus behavior |
|---|---|---|---|
| Closed (default) | Pill / button at known position | none | tab-reachable |
| Opening (slide-up sheet) | Animated sheet (respects reduce-motion) | "Help options." | first focusable in sheet |
| Inside (request hotel) | Form: dates pre-filled from itinerary | inline errors announced | form fields |
| Submitting | Disabled CTA + label | "Submitting hotel request." | retained |
| Submitted | Confirmation + "Sent to your phone." | `role="status"` | "Close" |
| Failed | Inline retry + Call support | `role="alert"` | error |
| Closed | Returns focus to opener | "Help options closed." | original trigger |

---

## Error Recovery Paths

### No flights available
- **State:** empty
- **Behavior:** name two alternatives — "Try next-day flights" (loads next-day list inline) and "Call Northstar support" (tap-to-call). Optional third: "Add me to standby on the earliest flight."
- **Anti-pattern avoided:** dumping the user with a "Sorry, no flights found" dead end.

### Payment / fare-difference fails
- **State:** error, inline
- **Behavior:** show the actual reason in plain language ("Card declined"), keep the user's selection, offer (a) try another card, (b) pick a $0 alternative, (c) call support. Do not throw the user back to the start.

### Plans change again (after confirmation, after undo window)
- **State:** post-confirm
- **Behavior:** persistent support module exposes "Change plans again" → re-enters Screen 2 with current itinerary as context. Re-rebooks against the new itinerary, not the original ticket.

### Network drop mid-flow
- **State:** error
- **Behavior:** local cache of selection; offline banner: "You're offline. Your choice is saved." On reconnect, attempt to resume; if hold is lost, return to Screen 2 with a banner explaining.

### Session expired (e.g., SMS link reopened next morning)
- **State:** error, gentle
- **Behavior:** re-auth passively; if not possible, show "Your sign-in expired — sign back in to see your options" with a Call support fallback.

### Inventory race (seat gone between Screen 2 and Screen 3)
- **State:** error
- **Behavior:** announce assertively, return to Screen 2 with banner: "That seat just went. Here are the closest alternatives." Auto-scroll to a similar-time flight if any.

### Undo fired
- **State:** post-undo
- **Behavior:** restore original cancellation context (not the original flight — it doesn't exist). Land back at Screen 1. Announce: "Rebooking canceled. You're back to choosing options."

---

## Handoff Moments (where humans take over)

1. **Tap-to-call "Call Northstar support"** — always available via the persistent module. Pre-fills caller ID with reservation # if the OS supports it. Hours announced honestly: "Open 24 hours" or actual hours.
2. **Failure escalation:** every named error state offers Call support as a fallback action. No dead ends.
3. **SMS / email backup at confirmation:** equivalent content sent so the user has an offline record even if the app crashes or the device dies.
4. **"Add to calendar" handoff:** allows the user to leave the app entirely and trust their calendar.
5. **Airport handoff:** confirmation copy and SMS include "If your hotel pickup or check-in has issues, show this confirmation at the Northstar desk." (No invented policy — phrasing reads as guidance, not a guarantee.)

---

## Handoffs Sent

### → accessibility-specialist

**Subject: State list for blocker review**

(See state tables above.) Specific questions:

1. For each "live-announced" state, is `role="status"` vs. `aria-live="polite"` vs. `role="alert"` correct? My defaults: positive events polite; errors alert; status changes polite unless they block action.
2. The undo window — single start + end announcement only, not per-second tick. Confirm this is right for screen-reader fatigue.
3. The persistent support module as a slide-up sheet: focus trap, escape closes, return focus to trigger. Confirm pattern.
4. Filter row collapsed by default — expanding announces "Showing N flights, M nonstop." Confirm announcement model.

### → visual-designer

**Subject: State list so you can plan visual treatment**

You'll need a visual treatment for each row above. Specific asks:

1. **Skeleton loaders** for partial/loading states, not spinners alone — reduces perceived latency and works without motion.
2. **Status banner on screen 2** must survive scroll and not obscure focused elements (sticky-bottom-CTA rule, WCAG 2.4.11).
3. **Undo window** needs a visible countdown that does not feel panicky — non-red, not pulsing. (Reduce-motion default per a11y.)
4. **Empty / error states** need first-class visual treatment, not generic "Oops!" art.
5. **"Best match" badge** must be text+icon+adjacent-reason — not color-only.
6. **Hotel module** position is your call but must be reachable in the first scroll and at a consistent position screen-to-screen.

---

## Handoffs Received

| Sender | Message | What changed |
|---|---|---|
| info-architect | 4 in-app screens + persistent support module, two-step commit, no tabs. | Adopted directly. Built error-state matrix against this structure. |
| accessibility-specialist | Status messages required, focus management, no keyboard traps, undo as a real state, persistent help (3.2.6). | Added focus-management column to state tables. Made "undo" a named state with explicit announcement model. Confirmed sheet pattern for persistent support module. |
| behavioral-scientist | (Anticipated — will note ethical friction concerns) | Two-step commit framed as *consequence surfacing*, not friction-for-friction's-sake. Will revise if behavioral-scientist's risks materially differ. |

---

## To Team Lead (status)

**Top 3 findings:** every state announces; error recovery is first-class; two-step commit earns trust.

**One tension:** the "inventory hold" assumption. I have designed for a 5-minute hold, but the brief does not confirm this is technically possible. If holds are not possible, the Review screen must shrink to a quick-confirm pattern with a clear "may sell out" warning. Flagging for synthesis and follow-up with engineering.

**Messaged:** accessibility-specialist, visual-designer.
