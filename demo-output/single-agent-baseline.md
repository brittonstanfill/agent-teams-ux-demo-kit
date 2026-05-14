# Canceled-flight recovery — recommendation

A redesign brief for the cancellation-recovery flow described in the input scenario. Scope is the screens a traveler sees on a phone between the cancellation SMS and a confirmed forward plan. The companion HTML prototype renders the four screens this memo recommends.

Labeling convention used throughout: **[observed]** = stated in the brief, **[inferred]** = drawn from the brief's framing, **[assumption]** = my working belief that needs validation, **[recommendation]** = a design call I am making.

---

## Executive recommendation

The current flow loses the user because every screen withholds the information that would let a tired person make a decision. The redesign inverts that: **first screen names the event, names what's already handled, and names what needs the user**. Refund is a peer to rebook, not a buried link. Hotel and meal entitlements load up front instead of hiding behind an FAQ. "Talk to a person" is on every screen.

Four screens, in this order:

1. **Status &amp; safety net** — names the cancellation, shows the three entitlements already arranged, points to the one thing the user must decide.
2. **Pick your path** — three outcome-named options (be there tomorrow / pick a different day / refund), each labeled with what happens to the hotel and meal entitlements if you pick it.
3. **Rebook by arrival** — flight cards sorted by when you'd land, not when you'd leave. Filters for nonstop and travel-party size. "Recommended" replaced by a single concrete reason.
4. **Your packet** — saveable, shareable, screen-reader-first summary that works offline. "Something wrong?" routes to a live agent on the same trip context.

One promise, three constraints:

- **Promise:** the next physical action — pick a flight, confirm the hotel, talk to a person — is the most visible thing on every screen.
- **Constraint 1:** no invented operator policy in user-visible copy. Hotel availability, wait times, fare difference behavior, and credit terms are dynamic placeholders, never hard-coded promises.
- **Constraint 2:** the redesign cannot achieve its business goal by hiding refund, support, or entitlement information.
- **Constraint 3:** screen-reader, low-bandwidth, and family-traveler paths are solved in the artifact or named as scoped gaps.

---

## Main issues in the current flow

Numbered against the screens in the input brief.

**SMS entry**
- "Schedule irregularity on NS482" buries the event behind a euphemism. **[observed]**
- No mention of options, hotel, refund, or support. A tired user has no reason to tap the link before they call. **[inferred]**

**Screen 1 — Trip Status**
- "Your itinerary has changed" + "Continue" gives no information and no commitment. **[observed]**
- The important content sits behind "View details", which is exactly the click a tired user will not make at 10:46 p.m. **[inferred]**

**Screen 2 — Recovery Options**
- Defaulting to **Travel credit** misaligns with the most common user goal (get to the destination on time). The default frames credit as the operator's preferred outcome. **[inferred]**
- Tab labels are categories ("New flights / Travel credit / Standby") instead of outcomes ("Be there tomorrow / Pick a different day / Refund"). Categories require the user to translate; outcomes do not. **[recommendation]**
- Hotel and meal support are absent from this screen, even though they materially change which option a user can afford. **[observed]**
- "Standby" sounds equivalent to a confirmed rebook to a tired reader. **[observed]**

**Screen 3 — New Flights**
- "Recommended" is unexplained. A user under stress should never have to guess the system's reasoning. **[observed]**
- A **"$84 fare difference"** on involuntary cancellation rebooking reads as a fee in the moment, regardless of how the policy actually resolves. This is the highest-trust-cost element in the current flow. **[inferred]**
- Default sort is unclear; the user's optimization variable is **arrival**, not departure. **[recommendation]**
- No filters for nonstop, mobility, or travel-party size. **[observed]**

**Screen 4 — Support**
- Hotel voucher and meal credit are in a collapsed "Other policies" FAQ. This is the trust-floor violation: hiding entitlements to reduce calls. **[observed]**

**Screen 5 — Confirmation**
- "Trip updated → Done" gives the user nothing to take to the gate. **[observed]**
- No baggage status, no check-in time, no hotel pickup, no offline copy, no exit ramp if plans change again. **[inferred]**

---

## Redesigned flow — four screens

The artifact renders each screen as a phone. This section is the spec the artifact is built from.

### Screen 1 — Status &amp; safety net

**What it does:** Names the event in plain words. Shows three rows of "already arranged for you" (hotel hold, meal credit, rebook options ready) and one "needs you now" row (pick your path). Always-pinned "Talk to a person" sits at the foot. **[recommendation]**

**Why it works:** Replaces a vague header with an information density that matches what a tired user actually needs — what happened, what is already handled, and the single next decision. Loading entitlements up front removes the highest cause of out-of-pocket spend during disruption. **[inferred]**

### Screen 2 — Pick your path

**What it does:** Three outcome-named cards. Each shows the consequence for the hotel and meal entitlements **before** the user picks, so nothing is surprised at confirmation. Refund/credit appears as a peer option, not a buried link. **[recommendation]**

**Why it works:** Decisions named by outcome reduce translation load. Explicit consequences on each card are a small honesty tax that prevents the higher cost of post-confirmation regret and inbound calls. **[inferred]**

### Screen 3 — Rebook by arrival

**What it does:** Sort defaults to **arrival**, the user's actual optimization variable. Filters are visible (nonstop, travel-party size). Each flight card leads with arrival time; the "why we ranked it here" tag is a single concrete reason ("earliest", "nonstop"). No fare difference is displayed during involuntary recovery. **[recommendation]**

**Why it works:** A user trying to be somewhere by a deadline does not optimize for departure time — they optimize for landing time. Removing fare-difference language during involuntary recovery removes the most common reason users abandon to call support. **[inferred]**

**Constraint note:** Whether the operator's policy actually waives fare difference on involuntary cancellation is a policy question, not a design question. The recommendation here is to align the UI to the policy's intent — and, if policy does charge a fare difference during disruption, to display it as a clear, separate "operator-applied charge" rather than baking it into the rebooking flow as if the user opted into an upgrade. **[recommendation]**

### Screen 4 — Your packet

**What it does:** Full trip summary in one screen: flight, check-in window, seat status, bag status, hotel pickup, meal credit, and the one-line "if plans change again" exit. Saveable to wallet, shareable with the travel party, and degraded-gracefully to offline plain HTML. "Something is wrong" routes to a live agent who already has the trip context. **[recommendation]**

**Why it works:** The current confirmation gives the user a sense of completion without anything to take to the gate. The packet treats the confirmation screen as the artifact the user will actually use during travel, not the celebratory end-state. **[recommendation]**

---

## Recommended copy — verbatim

This is the copy that should ship; everything in brackets is a dynamic placeholder.

**SMS — new**

> Your 6:15a NS482 to LGA tomorrow is canceled (crew). You're protected for a rebook, a hotel tonight, and meals while you wait. Open to choose: [link] · Reply HELP for a person.

**Screen 1**

- Header: **Your 6:15 a.m. tomorrow is off.**
- Sub: **Cause: crew availability. You're protected. We've already lined up three things — confirm what you want next.**
- Row 1: **Hotel held near DEN** / *Free for tonight. One tap to confirm.* / tag: **Held**
- Row 2: **Meal credit on your account** / *Use at any food vendor on the concourse.* / tag: **Active**
- Row 3: **Pick your path** / *Rebook, change days, or get your money back.* / tag: **Needs you**
- Primary CTA: **See my options →**
- Secondary link: **What does "protected" mean here?**
- Footer: **Talk to a person** / *Current wait shown when you tap. Open all night.* / button: **Call or chat**

**Screen 2 — path cards**

- Card 1: **Get me there tomorrow** / *We'll show flights sorted by when you'd arrive at LGA, not when you depart.* / Hotel: keeps · Meals: keeps · Bag stays checked → **See flights by arrival →**
- Card 2: **Pick a different day** / *Browse the full schedule.* / Hotel: released · Meals: keep tonight → **Open the calendar**
- Card 3: **Refund or travel credit** / *Back to the card you paid with, or as credit if that helps you more.* / Hotel: released · Meals: end now → **Get my money back**

**Screen 3 — flight card tags (replacing "Recommended")**

- **earliest** — for the flight that arrives soonest at the destination
- **nonstop** — for the only nonstop option on screen
- (no tag) — when no honest one-word reason applies

**Screen 4 — packet header**

- Header: **You're set. Save this. It works offline.**
- Footer exit: **If plans change, reply CHANGE to this thread — same agent, same trip.**
- Tertiary link: **Something is wrong with this →**

**Copy not to use**

- "Schedule irregularity" anywhere user-facing.
- "Continue" or "Done" as a primary CTA — every button names its action and outcome.
- "Recommended" without a single-word reason adjacent.
- "Other policies" as a section name for entitlements.

---

## Accessibility risks and mitigations

| Risk | Mitigation |
|---|---|
| Screen reader hears "Recommended" without context. | Every flight card has a single labeled name; the "earliest" / "nonstop" tag is part of the accessible name, not a decorative chip. **[recommendation]** Maps to WCAG 1.3.1. |
| Color carries meaning ("needs you" amber). | "Needs you" pairs amber with both an icon and the literal word. **[recommendation]** Maps to WCAG 1.4.1. |
| Hit targets too small for a one-thumb 10:46 p.m. user. | All primary actions are ≥48px tall; chip filters are ≥36px with adequate spacing. **[recommendation]** Maps to WCAG 2.5.5. |
| Body type fatigue under stress. | Body ≥15px; titles in a serif with 1.12 line-height; respects prefers-color-scheme so the screen does not blast white at night. **[recommendation]** Maps to WCAG 1.4.4. |
| Motion sensitivity. | prefers-reduced-motion is honored; the redesign uses no animated transitions in the disruption path. **[recommendation]** Maps to WCAG 2.3.3. |
| Low-bandwidth users cannot load a heavy confirmation. | The packet is plain HTML; the SMS thread remains the always-available fallback channel. **[recommendation]** |
| Keyboard-only users may lose place inside the flow. | Skip link at the top of the page; visible focus ring on every interactive element. **[recommendation]** Maps to WCAG 2.4.7, 2.4.1. |
| Screen-reader scoped gap. | The artifact's spine "step 1 of 4" is exposed as role=img with a textual label, but the four phone-screen layout itself is a presentational composition for the walkthrough. A real implementation would render one screen at a time on a phone with the spine as a real progress indicator. **[scoped gap]** |

---

## Trust and behavior risks and mitigations

| Risk | Mitigation |
|---|---|
| Hiding entitlements to reduce calls. | Hotel + meal load on screen 1; refund/credit is a peer card on screen 2. **[recommendation]** |
| Dark-pattern default toward travel credit. | Screen 2 has no default. Each card states its own consequences. **[recommendation]** |
| "Recommended" without explanation steers users invisibly. | Replaced with a single concrete one-word reason ("earliest", "nonstop"). **[recommendation]** |
| Fare-difference framing on involuntary cancellation. | Removed from the rebook flow; if the operator's policy does charge a fare difference during involuntary disruption, it is shown as a clearly labeled operator-applied charge — not merged into the user's choice as if they opted in. **[recommendation]** |
| Fake scarcity (countdown timers, "1 seat left"). | Banned in this flow. Seat availability is dynamic but never used to coerce a faster click. **[recommendation]** |
| "Done" obscures repair paths. | Screen 4 has an explicit "Something is wrong with this →" routing to a live agent on the same trip context. **[recommendation]** |
| Multi-passenger / family path is unclear. | Travel-party filter on screen 3 names the count; path cards on screen 2 mention "bag stays checked" so a parent with checked bags is not surprised. A scoped gap remains: linked PNRs are not addressed in this artifact and would need a dedicated "your party" surface in implementation. **[scoped gap]** |
| Refund-seeker path is harder than rebooking. | Refund/credit is one path peer on screen 2; entitlement consequences are stated up front. **[recommendation]** |

---

## Experiment plan

Each experiment is one hypothesis, one primary metric, one guardrail, and one exit rule. **No prior-state numbers are claimed**; the brief does not supply any, and inventing them would be a constraint violation.

### Experiment 1 — Outcome-named path cards (Screen 2)

- **Hypothesis:** Replacing category tabs with outcome-named cards (be there tomorrow / pick a different day / refund) will raise self-service completion without raising regret as measured by post-decision changes.
- **Primary metric:** Self-service completion rate in the cancellation-recovery surface, measured as a confirmed rebook, accepted refund, or accepted travel credit within the same session.
- **Guardrail:** Post-decision change rate within 24 hours (i.e., the user reverses their own choice). Must not rise.
- **Exit rule:** Ship if completion rises and the guardrail does not breach a pre-registered threshold for two consecutive weeks. Kill if completion is flat after the run window and the guardrail rises.

### Experiment 2 — Sort by arrival on the rebook screen (Screen 3)

- **Hypothesis:** Defaulting flight sort to arrival time will reduce time-to-decision and reduce calls during rebook.
- **Primary metric:** Time from "Pick your path → Get me there" to "Pick this" on a flight.
- **Guardrail:** Net Promoter or equivalent recovery-experience survey score for users whose chosen flight arrived later than the default flight in the old sort. Must not drop.
- **Exit rule:** Ship if time-to-decision falls and the guardrail holds. Re-design if time-to-decision falls but the guardrail drops — that pattern would suggest users are picking faster but feeling rushed.

### Experiment 3 — Loading entitlements on Screen 1

- **Hypothesis:** Surfacing hotel and meal entitlements on the first screen will reduce out-of-pocket spend follow-up tickets ("I paid for a hotel, can I be reimbursed?") and reduce the rate at which users call before completing any self-service step.
- **Primary metric:** Rate of inbound reimbursement requests tied to disrupted itineraries.
- **Guardrail:** Rate of incorrect or duplicate entitlement claims; rate of hotel hold rejection at the property.
- **Exit rule:** Ship if reimbursement requests fall meaningfully and the guardrail does not breach the rejection-rate threshold for two consecutive weeks. Otherwise iterate on the screen 1 entitlement copy before re-running.

### Experiment 4 — Packet screen replacing "Trip updated → Done"

- **Hypothesis:** Replacing the confirmation screen with a saveable, shareable packet will reduce inbound calls during travel ("what's my hotel address, what gate, what bag tag").
- **Primary metric:** Inbound calls per disrupted itinerary in the 24 hours following confirmation.
- **Guardrail:** Reported missed connections / missed shuttles that trace back to packet detail accuracy. Must not rise.
- **Exit rule:** Ship if inbound calls fall and the guardrail holds. If calls fall and the guardrail rises, the packet is hiding something it shouldn't — re-examine which fields are dynamic vs. static.

---

## Scoped gaps

- **Linked PNRs / explicit family or party surface.** Mentioned in path-card copy but not solved as a dedicated screen. **[scoped gap]**
- **Authenticated entry path vs. SMS-link entry path.** The redesign assumes the SMS link drops the user into an authenticated state; an unauthenticated drop into the rebook flow would need its own light-touch verification screen. **[scoped gap]**
- **Operator policy interactions.** Anywhere this memo says "no fare difference during involuntary recovery" or "hotel held near DEN", the actual operator policy controls. The design is intended to align to the policy's spirit; the copy must be parameterized against operational reality before launch. **[scoped gap]**
