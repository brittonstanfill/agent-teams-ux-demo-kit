# Behavioral Scientist — Northstar Canceled-Flight Recovery

Role: behavioral-scientist-2
Task: #15
Status: in_progress → completed

---

## Top 3 findings

1. **The default tab is working against the user's actual goal.** [observed from brief] The Recovery Options screen defaults to "Travel credit," but the user described in the brief is trying to get to a family event the next day. [inferred] Default effect / status-quo bias means a non-trivial share of tired users will accept the framed default — especially at 10:46 p.m. on mobile — even when rebooking is what they came for. The default is choosing for them. [recommendation] Default tab should be "New flights" unless the system has explicit reason to believe the user prefers credit.

2. **Hidden entitlements (hotel, meal) are the single biggest trust risk in the flow.** [observed from brief] Hotel voucher and meal credit live inside a collapsed FAQ titled "Other policies." [inferred] Under stress and fatigue, users either (a) don't see them and pay out of pocket — discovering later and losing trust — or (b) suspect the airline of hiding help, which is exactly the perception that drives the call to support the business is trying to reduce. This is a roach-motel-adjacent pattern: easy to get into the flow, hard to find what's owed. [recommendation] Surface eligibility prompts contextually, not as a policy document.

3. **The flow gives the user no model of "what happens if I pick wrong."** [observed from brief] Tab labels ("New flights / Travel credit / Standby") don't describe consequences; "Recommended" isn't explained; the confirmation screen says only "Your changes have been applied." [inferred] Ambiguity aversion predicts that when users can't predict consequences of each option, they disengage from the self-service flow and seek a human — which matches the brief's stated abandonment-to-call problem. [recommendation] Each option needs a one-line consequence preview, and the confirmation needs a concrete recap.

---

## Trust risks

### Where the current flow loses trust
- **Vague SMS ("Schedule irregularity")** [observed from brief] — euphemism on a stress event reads as evasion. Erodes credibility before the user even opens the app.
- **"Continue" with no consequence preview** [observed from brief] — users learn the app won't tell them what's about to happen; they switch to phone support.
- **Hotel/meal buried in FAQ** [observed from brief] — when users later discover entitlements they missed, the airline looks like it was hoping they wouldn't ask. This is the most durable trust hit in the flow. [inferred]
- **"Recommended" with no rationale** [observed from brief] — perceived as airline-optimized, not user-optimized. Reactance follows: users distrust the badge and over-correct away from the recommended option, even when it's genuinely best for them. [inferred]
- **Fare-difference shown during disruption recovery** [observed from brief] — feels like being upsold during a crisis the airline caused. Pure trust erosion. [inferred]
- **"Trip updated" confirmation with no recap** [observed from brief] — leaves users uncertain whether anything actually happened, especially on flaky mobile networks. They re-check by calling. [inferred]

### Where the redesign could erode trust if we're not careful
- **Over-aggressive "best for you" personalization** — if we replace "Recommended" with "Best for you" but don't explain why, we recreate the same opacity problem with friendlier copy. [recommendation: always show the 1–2 reasons behind any recommendation.]
- **Urgency / countdowns on seat inventory** — even when factually true ("3 seats left"), urgency cues on a recovery flow read as manipulated scarcity. [recommendation: only show inventory pressure when it's a hold-timeout the user themselves initiated.]
- **Streaks / gamified "self-service rewards"** — would be entirely wrong here. This is a one-shot stressful recovery, not a habit context. [assumption: nobody is proposing this, but flagging preemptively.]
- **Defaulting users INTO hotel/meal** — well-intentioned, but if the entitlement has real eligibility conditions, auto-applying it and reversing later is worse than offering it clearly. [recommendation: surface + one-tap accept, don't auto-claim.]

---

## Choice architecture audit

### Default tab: "Travel credit"
- **Mechanism:** Default effect + status-quo bias. The first thing a fatigued user sees is the option the system has pre-selected.
- **Why it's wrong here:** [inferred] The modal user in the brief wants to travel tomorrow, not bank credit. A default of "Travel credit" silently steers a meaningful fraction of users toward the option that costs the airline least in the short run — which is exactly the pattern regulators and journalists name as a dark pattern.
- **Recommendation:** Default to "New flights." If the airline genuinely believes some users prefer credit, A/B test it — don't assume it.

### Sort order on Screen 3
- **Observation:** [observed from brief] The list is 7:10 a.m. (one stop, "Recommended") → 2:40 p.m. (nonstop, "+$84") → 6:30 p.m. (one stop, "$0").
- **Mechanism:** Anchoring + primacy. The first card sets the reference point against which all others are judged — including the price anchor.
- **Risk:** [inferred] Putting "Recommended" first and "+$84" second makes the $84 feel like a penalty for choosing nonstop. Pure framing effect — the same option would feel different if listed first with no comparison anchor.
- **Recommendation:** Sort by user-selected criterion (arrival time, stops, etc.) with sensible default = "earliest arrival." Surface "Recommended" as a tag, not as sort position.

### "Recommended" badge
- **Mechanism:** Authority + social proof heuristic ("the system knows best").
- **Risk:** [inferred] Unexplained authority labels trigger reactance in stressed users. They suspect they're being steered.
- **Recommendation:** Replace with a labeled reason — e.g., the badge expands to "Earliest arrival within your original window" or "Same arrival airport, fewest changes." If you can't write the reason in one line, the recommendation isn't earned.

### Fare-difference framing ("+$84", "$0")
- **Mechanism:** Loss aversion. "+$84" reads as a loss relative to the $0 anchor, even though all three options resolve a disruption the user didn't cause.
- **Risk:** [inferred] Framing recovery options as "free vs. costs more" during a disruption the airline caused is the framing most likely to (a) push users to a worse-fit flight and (b) drive trust loss on social media.
- **Recommendation — content-designer-2 owns the copy, but the behavioral spec is:** show fare difference only when it exists, frame as "same fare" / "+$84 vs. original" rather than "$0" / "+$84." Avoid the implicit zero anchor on a disruption the user didn't choose.

### Hotel hidden in FAQ
- **Mechanism:** Friction-as-suppression. Hiding an entitlement behind a collapsed accordion is functionally equivalent to opt-out architecture for a benefit the user is owed.
- **Risk:** This is the clearest dark-pattern-adjacent move in the current flow. [inferred]
- **Recommendation:** Eligibility check should run server-side. If eligible, surface a clear, in-flow card: "You're eligible for a hotel voucher tonight — claim now." One tap to accept. No FAQ. No policy-speak.

---

## Ethical nudges to keep vs. dark patterns to avoid

### Keep (ethical, aligned with user-stated goal)
- **Smart default on tab = "New flights"** — aligns with the modal recovery intent.
- **Pre-filled eligible hotel/meal offer** — surfaces an entitlement the user is already owed; one-tap accept, easy decline.
- **Endowed-progress framing on confirmation** — "1 of 3 steps done: flight rebooked. Next: hotel." Mechanism: endowed progress effect increases completion of the remaining steps without coercion. [recommendation]
- **Loss framing on missed entitlements — only when factually accurate** — e.g., "Hotel voucher available tonight only." Use sparingly; truth is the test.
- **Peak-end design on the confirmation screen** — the last screen disproportionately shapes the user's memory of the whole disruption (peak-end rule). Invest in a clear recap, a calm tone, and a path forward. This is where trust is rebuilt.

### Avoid (dark patterns or proximate to them)
- **Confirmshaming** — e.g., "No thanks, I'll figure it out myself" on declining a recovery option. Don't do it.
- **Manipulated urgency** — countdowns / "act now" on inventory the user can't verify. If you must show a hold timer, only show it once the user has actively held a seat.
- **Forced continuity** — auto-rebooking a flight if the user closes the screen. The "do nothing" path must not silently commit them to a choice.
- **Roach motel** — the current FAQ-hidden hotel is exactly this pattern. Fix it.
- **Drip pricing / hidden cost** — surfacing fare difference at the last step, after the user has committed. All costs must appear on the option card itself.
- **Asymmetric friction on the option the airline prefers** — e.g., making "Travel credit" one tap and "Rebook on new flight" three taps. All recovery options should be roughly equal-effort to select.

---

## Experiment ideas

Each experiment names the behavioral mechanism, the hypothesis, the primary metric, a guardrail metric, and an exit rule. No fabricated effect sizes.

### Experiment 1 — Default tab
- **Mechanism:** Default effect / status-quo bias.
- **Hypothesis:** Changing the default tab from "Travel credit" to "New flights" will increase successful self-service rebookings without increasing regret-driven reversals.
- **Primary metric:** Share of disruption sessions that end in a confirmed rebooking on the same trip dates.
- **Guardrail metrics:** (a) reversal / change-of-mind rate within 24h; (b) inbound call rate per disruption; (c) share of users who explicitly select "Travel credit" (we want this to stay non-zero — it's a legitimate option for some users).
- **Exit rule:** Stop and revert if guardrail (a) or (b) moves in the wrong direction beyond a pre-registered threshold, OR if (c) collapses to near-zero (signal that we've made credit too hard to find, not just non-default).

### Experiment 2 — Hotel entitlement surfacing
- **Mechanism:** Friction removal + loss aversion (avoid out-of-pocket payment the user is owed back).
- **Hypothesis:** Surfacing eligible hotel/meal entitlements as an in-flow card (vs. FAQ) will increase claim rate among eligible users and reduce post-trip refund / complaint volume.
- **Primary metric:** Hotel-voucher claim rate among eligible users.
- **Guardrail metric:** Post-trip refund-request rate AND CSAT/trust score on the disruption flow (we want both to move favorably — a claim-rate lift with a CSAT drop would suggest we're surfacing too aggressively or auto-claiming).
- **Exit rule:** Revert if eligibility-mismatch reports (users claiming who weren't eligible) rise materially, indicating we're confusing the eligibility communication.

### Experiment 3 — "Recommended" badge with explained reason
- **Mechanism:** Reduce reactance via transparent rationale.
- **Hypothesis:** Replacing the unexplained "Recommended" tag with a labeled reason (e.g., "Earliest arrival in your original window") will increase selection of the recommended option AND increase post-selection confidence.
- **Primary metric:** Selection rate of the labeled option.
- **Guardrail metric:** Post-rebook confidence rating (single Likert on confirmation screen) — selection lift without confidence lift would suggest we've made it more persuasive without making it more trustworthy, which is the dark-pattern direction.
- **Exit rule:** Revert if confidence rating drops vs. control.

### Experiment 4 — Fare-difference framing
- **Mechanism:** Anchoring + loss-aversion framing.
- **Hypothesis:** Showing fare difference as "same fare as your original ticket" / "+$84 vs. original" (instead of "$0" / "+$84") will reduce the bias toward the $0-anchored flight when it's a worse fit (e.g., later arrival, more stops).
- **Primary metric:** Distribution of flight selection across the three options, conditional on user-stated arrival need.
- **Guardrail metric:** Total revenue per recovery (we want to confirm this isn't a stealth revenue play — we should accept neutral or modest revenue effect in exchange for fit-to-need).
- **Exit rule:** Revert if users report increased confusion about what they're paying (qual signal from a 1-question post-flow survey).

### Experiment 5 — Peak-end confirmation recap
- **Mechanism:** Peak-end rule + endowed-progress framing.
- **Hypothesis:** Replacing the current "Trip updated / Done" confirmation with a structured recap (new flight, hotel status, baggage, check-in, what-if-this-changes path) will improve recalled-experience CSAT and reduce post-confirmation calls.
- **Primary metric:** Post-disruption CSAT measured 24–48h later.
- **Guardrail metric:** Call rate in the 24h after confirmation.
- **Exit rule:** Revert if longer confirmation page measurably reduces completion (users bouncing before reading) — but expected effect direction is the opposite.

---

## Behavioral principles referenced (by name, no invented studies)

- **Default effect / status-quo bias** — pre-selected options are disproportionately chosen, especially under cognitive load.
- **Ambiguity aversion** — users disengage from choices whose consequences they can't predict; they seek a human.
- **Loss aversion** — losses (or framings as losses, e.g., "+$84") loom larger than equivalent gains.
- **Reactance** — when users feel steered, they push back, sometimes against their own interest.
- **Anchoring** — the first option / price shown becomes the reference point for all others.
- **Endowed progress** — progress visibly started increases likelihood of completion.
- **Peak-end rule** — the most intense moment and the ending disproportionately shape memory of an experience.
- **Hyperbolic discounting** — relevant if we later add "schedule a callback" vs. "wait now" choices; not central to this flow.

---

## Labels key

- `[observed from brief]` — directly stated or shown in the input doc
- `[inferred]` — reasoned from behavioral principles applied to the observed design
- `[assumption]` — placeholder until ux-researcher-2 confirms with data
- `[recommendation]` — proposed change owned by behavioral or shared with peer roles
