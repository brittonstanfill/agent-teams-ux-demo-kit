# Northstar Air canceled-flight recovery — Meeting-ready recommendation

## Executive recommendation

The current flow loses people because it tells them what changed instead of helping them decide what to do, and because it tucks the support they're entitled to inside an FAQ. Three changes do most of the work:

1. **Lead with the user's likely first move.** Rebook is the default path. Travel credit and standby are equal-weight options on the same screen — not a tabbed control with the wrong default.
2. **Surface tonight's stay and meals as a screen of the flow.** When the disruption is overnight, hotel and meal coverage are a step, not a policy footnote.
3. **Replace the dead-end confirmation with a what-happens-next timeline that saves offline.** A stressed traveler with one bar of signal at a gate needs the next 24 hours, not "Done."

The flow drops from five screens to four. The SMS is rewritten so the user knows the actual event before they tap. No invented voucher amounts, hotel names, compensation rules, or wait times — the prototype uses bracketed placeholders or dynamic phrasing wherever the brief is silent.

Three decisions to ratify in the meeting:

- **Drop the tabbed control on the options screen.** Tabs hide alternatives and let us ship the wrong default.
- **Persist a "Talk to a Northstar agent" affordance on every screen.** Self-service is the goal; making support hard to find is not how we get there.
- **Make "Save trip details offline" a primary action on the confirmation screen.** This is the one place we know users are on the move with bad signal.

[recommendation] Treat the four-screen flow as a starting point. The current redesign keeps the canceled-flight happy path inside the brief's 5-screen ceiling and leaves room for an "alternative airports / nearby airports" branch in a follow-up.

## Main issues in the current flow

1. **The SMS hides the event.** "Schedule irregularity on NS482" reads like a system code. The text should carry the cause and the first two choices the user might make. [observed from brief]
2. **Trip Status doesn't move the user forward.** A "Continue" button that doesn't say what continuing means is friction under stress. The screen should show the three real paths immediately. [observed from brief]
3. **The defaults nudge against the user's likely goal.** Travel credit defaulted in a tabbed control buries rebook, which is most overnight users' first move. [observed from brief] [inferred from user goal]
4. **"Recommended" is unexplained.** Users distrust unlabeled recommendations during a disruption. Replace with explicit reason labels ("Earliest arrival," "Fewest stops"). [observed from brief]
5. **Fare differences during canceled-flight rebooking feel punitive.** During disruption recovery, comparable rebooks shouldn't display fare deltas. Reserve price for real upgrade decisions, later in the flow. [observed from brief]
6. **Entitlements are hidden in policy.** Hotel and meal credit are core support, not "Other policies." Surfacing them is the trust move that also drops calls. [observed from brief]
7. **The confirmation is a dead end.** "Trip updated / Done" leaves the user with nothing concrete and no offline copy. [observed from brief]

## Redesigned flow

The redesign is four screens after the SMS. Each screen has one job. Screen names are user-facing.

### 0. SMS (the wake-up text)

> **Northstar Air**: Your 6:15 AM flight NS482 (DEN → LGA) was canceled — crew availability. Tap to see your options for tonight and tomorrow: [link]

Why: names the event, names the cause, names what tapping does, fits under 160 characters.

### Screen 1 — What happened, and what you can do

- Title: **Your 6:15 AM flight was canceled.**
- Subtitle: NS482 · DEN → LGA · Crew availability
- Body: Northstar will help you get there. Pick what works:
- Three stacked choice cards (rebook on top, sized larger):
  - **Find me a new flight** — "Most people start here. Pick from confirmed seats tomorrow."
  - **Take a travel credit** — "Skip the trip and use the credit on a future booking."
  - **Join standby** — "Try for an earlier seat today if one opens up."
- "Covered tonight" panel below the choices, with an icon plus the words:
  - **Tonight's stay and meals**: "Northstar will cover tonight if you're stuck overnight. You'll see the details after you choose."
- Persistent footer affordance: **Talk to a Northstar agent**

### Screen 2 — Pick a flight

- Title: **Pick a new flight**
- Filter chips: **Earliest arrival** · **Direct only** · **Traveling with family**
- Three flight cards, each with:
  - Departure time in large tabular numerals
  - Route as text: DEN → LGA, with stop count
  - A clear reason tag — "Earliest arrival" or "Fewest stops" — never a bare "Recommended"
  - Arrival shown as `[arrival time]` placeholder, supplied by the system at render time
  - Action button repeats the time: **Confirm 7:10 AM**
- No price shown. The footer reassures: "No fare difference for any of these. Need something tonight? Try standby."

### Screen 3 — Tonight's stay & meals

- Title: **Tonight's stay & meals**
- Body: You'll be in DEN overnight. Northstar covers tonight.
- Two equal cards:
  - **Northstar books for me** — "We'll text the hotel and shuttle details after you confirm."
  - **I'll book my own** — "Submit your receipt with the steps we'll send you."
- Third card, smaller: **Meals** — "Credit applied at airport restaurants. The amount is on your confirmation."
- Skip link: "Skip — I'm staying with family or friends."
- Persistent footer: **Talk to a Northstar agent**

### Screen 4 — What happens next

- Title: **You're set.**
- Subtitle: Here's what to expect.
- A literal timeline with dotted vertical markers:
  - **Now** — Confirmation and hotel details texted to you.
  - **Tonight** — Check in at the hotel we sent.
  - **Tomorrow [check-in time]** — Be at the airport [time before flight].
  - **Tomorrow 7:10 AM** — NS[new flight number] boards at gate [gate].
- Three buttons:
  - **Save trip details offline** (primary — works without signal)
  - **Share with a friend or family member**
  - **Add to my calendar**
- Visible link, not buried: "Plans changed? You can change your booking again."
- Persistent footer: **Talk to a Northstar agent**

## Recommended copy (verbatim, beyond what's on the screens)

**Empty state — no rebook options yet:**
> No seats yet on the routes you'd want. Join standby and we'll text you when something opens, or take a travel credit and use it within Northstar's standard window.

**Mid-confirm error — seat taken before we could lock it in:**
> That seat got taken before we could confirm it. Pick another, or join standby — we'll text you when something opens.

**Standby waiting state:**
> You're on standby for flights to LGA tomorrow. We'll text you when a seat opens. You can still change your mind or take a credit.

**Re-entry into the flow after the cancellation is reversed:**
> Your flight is back on. NS482 is operating as originally scheduled. Check your itinerary.

**Persistent agent affordance (every screen):**
> Talk to a Northstar agent

**Tonight's-stay opt-out:**
> Skip — I'm staying with family or friends.

## Accessibility and trust risks, with proposed mitigations

| Risk | Mitigation | WCAG ref |
|---|---|---|
| Tired user on a small screen taps the wrong primary action. | All primary buttons ≥ 44×44 px. Distinct spacing between competing actions; only one primary per screen. | 2.5.5 Target Size |
| Screen reader user can't tell the page is about a cancellation. | Cancellation status is in an `aria-live="polite"` region at page load; status uses both text and icon, never color alone. | 1.4.1, 4.1.3 |
| Low-bandwidth user loses access mid-flow. | "Save trip details offline" produces a static, signal-free summary; the SMS confirmation link is the durable re-entry. | (no specific SC; trust + resilience) |
| Keyboard-only user can't navigate. | Visible focus ring on every interactive element; logical tab order; no keyboard trap. | 2.4.7, 2.1.1, 2.1.2 |
| User with motion sensitivity gets unwanted animation. | Transitions disabled when `prefers-reduced-motion: reduce`. | 2.3.3 |
| Color-blind user can't distinguish "covered" from "your choice" tags. | Tags carry icon plus text label, not color alone; contrast ≥ 4.5:1 body, ≥ 3:1 large. | 1.4.1, 1.4.3, 1.4.11 |
| Trust risk: "Recommended" steers the user without explanation. | Replaced with reason tags ("Earliest arrival," "Fewest stops"). | — |
| Trust risk: hiding hotel/meal coverage to reduce voucher cost. | Coverage is a screen of the flow, with explicit opt-in and opt-out. | — |
| Trust risk: making "talk to a human" hard to find. | Persistent agent affordance on every screen, same visual weight as primary actions. | — |
| Trust risk: user fears they're locked in. | "You can change your booking again" link is visible on confirmation, not in a footer. | — |
| Trust risk: dynamic-data placeholders leak through to production. | Placeholders are clearly bracketed in design; copy review must confirm system-supplied values render before launch. | — |

**Scoped gaps (named, not solved here):**

- Family / multi-passenger travel is acknowledged via a filter chip but not fully designed. A multi-passenger seat selection screen needs follow-up.
- Refund-seeking paths (cash refund vs. travel credit) are not in this flow. The travel-credit card is the visible entry point; the cash-refund logic depends on policy not stated in the brief.
- A VoiceOver / TalkBack walkthrough of the prototype was not performed. It should run before any field test.
- Push-notification copy is not designed here; the SMS is the assumed primary delivery channel.

## Experiment plan

### Experiment 1 — Plain-language SMS

- **Hypothesis**: Replacing "Schedule irregularity" with a clear cause plus next step in the SMS will increase first-tap-through and reduce inbound calls for the same canceled-flight cohort.
- **Primary metric**: Share of canceled-flight SMS recipients who open the manage-trip link within 30 minutes of send.
- **Guardrail**: SMS opt-out rate (no significant rise vs. the prior 60 days).
- **Exit rule**: If tap-through doesn't move past an agreed threshold over four weeks of comparable cancellations, revert and try a different message rather than keep iterating in flight.

### Experiment 2 — Rebook becomes the visible default

- **Hypothesis**: Showing rebook, travel credit, and standby as equal-weight cards (with rebook visually first) will lift confirmed self-service rebooks and lower handoffs to phone.
- **Primary metric**: Share of disruption sessions ending in a confirmed rebook within the same session.
- **Guardrail**: Travel-credit selection doesn't fall below the rate seen in users whose trip purpose itself is canceled — we don't want to over-push rebook on people who shouldn't fly.
- **Exit rule**: If rebook completion doesn't lift meaningfully, or if credit-selection drops below a healthy floor, revert.

### Experiment 3 — Stay & meals as a screen of the flow

- **Hypothesis**: Moving hotel and meal coverage out of the FAQ and into an explicit screen will cut "do I get a hotel?" calls and increase NPS for overnight-disruption users.
- **Primary metric**: Share of overnight-disruption sessions where the user confirms or declines the stay offer without contacting support.
- **Guardrail**: Stay-take rate stays inside an expected band; large unexpected swings get a review before continuing.
- **Exit rule**: If support contacts don't fall, or if hotel cost rises in a way that can't be explained by more eligible users using existing entitlements, pause and study.

### Experiment 4 — Confirmation timeline plus offline save

- **Hypothesis**: Replacing "Trip updated / Done" with a what-happens-next timeline plus a primary offline save will cut "what happens now?" tickets in the 24 hours after a confirmed rebook.
- **Primary metric**: Inbound support contact rate in the 24 hours after a confirmed disruption rebook.
- **Guardrail**: No rise in show-up errors (wrong gate, wrong terminal, missed shuttle).
- **Exit rule**: If support contacts don't fall, the answer is probably not "another screen" — revisit which piece of information is still missing and where users actually look for it.

## Labeling key

- [observed from brief] — drawn directly from the input brief.
- [inferred] — drawn from a plausible read of the brief plus general user goals.
- [assumption] — load-bearing assumption that should be verified.
- [recommendation] — a choice this doc is recommending, not a fact.

Load-bearing assumptions in this doc:

- [assumption] Most users who get a 10:46 p.m. cancellation message for a 6:15 a.m. flight want to be put on the next flight; some smaller share want a credit or to give up. The default ordering is built on this — verify in research before scaling.
- [assumption] Northstar's existing entitlement rules (hotel and meal coverage during overnight disruptions) apply in this scenario. The flow surfaces those entitlements without changing them; if the underlying policy differs, the copy must follow the policy, not the other way around.
- [assumption] The new flight number, hotel name, gate, and shuttle times are system-supplied at render time. The prototype shows them as bracketed placeholders.
