# 07 — Behavioral Scientist: Choice Architecture, Dark-Pattern Audit, Experiment Plan

Posture: this team has rebuilt a flow whose old failure modes were textbook dark patterns (forced-credit default, hidden entitlements, unexplained "Recommended" badge). My job is to certify those are gone and to refuse to let new ones in through the side door. I work from Thaler & Sunstein's *Nudge* (2008), Kahneman & Tversky's prospect-theory literature (loss aversion, framing), Cialdini's influence taxonomy (social proof, authority), Fogg's B=MAP, and the COM-B model. I do not invent studies.

---

## 1. Choice architecture audit (screen by screen)

| Surface | Choice offered | Default | Framing | Named mechanism | Verdict |
|---|---|---|---|---|---|
| **SMS** | Open app OR call OR ignore | None (read-only) | Fact-first, present tense, "not yet rebooked." Phone number in body, not behind link. | Salience (Kahneman: attention follows what is named first); availability of fallback channel (Thaler/Sunstein "choice architecture" — channel-symmetry) | **Helpful nudge.** Telling the truth without softening verbs is not a nudge; offering equal-weight phone access alongside the deep link is the ethical bar. (observed-from-brief + CW Section 2) |
| **Screen 1 — Status & Stake** | Read the fact, then choose between "See your options" / view itinerary / call | "See your options" is visually primary; call is tertiary; nothing is auto-selected. | Operational header, state line bolds "not yet rebooked." No icon, no apology. | Anchoring (Tversky/Kahneman) on the *fact*, not on a product action. The bold "not yet rebooked" sets the reference point for what counts as progress. | **Helpful nudge.** The visual hierarchy nudges toward self-service, but the phone number is one tap, visible, and not behind an icon. Channel-symmetry holds. (observed-from-prototype lines 745–774) |
| **Screen 2 — Choose Your Recovery (default state per IxD)** | Three paths visible side-by-side; CTA disabled until selection | **No card selected; CTA disabled** (IxD §1: "Three path cards, none selected, primary CTA disabled") | "Pick a path." + per-card consequence copy ("You arrive Wednesday morning…" / "No flight is held…" / "A seat is not guaranteed.") | Simultaneous-comparison framing reduces working-memory load (Miller; Sweller cognitive-load theory — IA cited it by name). Consequence-as-design counters status-quo bias (Samuelson & Zeckhauser 1988) by making the *cost of inaction* legible per option. | **Helpful nudge.** No default = no anchoring bias toward any path. (inferred-from-IxD-spec) **However see §2 for a finding: the prototype as authored violates this.** |
| **Screen 2 — Choose Your Recovery (active state shown in prototype)** | (same) | **Rebook pre-selected**, CTA reads "Continue with rebook." | Same as above. | Default effect (Johnson & Goldstein 2003) — defaults are the single most powerful nudge in choice architecture. | **Borderline → dark-pattern risk** *as currently rendered in the prototype*. See §2.1. |
| **Screen 3 — Pick the flight (Rebook)** | Three flight cards sorted by arrival time | No card pre-selected; CTA disabled until tap (inferred-from-IxD-and-CW; prototype renders CTA "Confirm 7:10 a.m. flight" but this is the post-tap state) | Arrival time at 28px is the load-bearing anchor; "No charge" right-aligned; party-status hairline-separated. No "Recommended" badge. | Anchoring on arrival time (Tversky/Kahneman). Removal of "Recommended" eliminates authority-bias (Cialdini) where the badge had been doing copy work. | **Helpful nudge.** Sort-by-arrival is itself a nudge — see §4.1. The badge is gone. |
| **Screen 4 — Receipt** | Save / share, claim un-claimed entitlements, "Plans changed? Start over," call | No action pre-selected; receipt is read-only | Stamp-and-document register; tabular numerals; tel: link prominent | Endowment effect (Thaler 1980) on the receipt itself — once the user has a confirmation, they treat it as owned and act to preserve it. The screenshotable design exploits this *in the user's favor* (durable proof). | **Helpful nudge.** The receipt-as-asset framing is squarely pro-user. |
| **Entitlements strip** | Tap to view; status visible at all times | Strip is visible by default; no entitlement is pre-claimed | "Hotel and meal support available — Not yet claimed — eligible for tonight" (CW §6) | Salience (Kahneman); availability heuristic (Tversky/Kahneman) — making help visible at decision time, not buried. Mere-exposure (Zajonc 1968) is also operative — but with status copy that's truthful, not promotional. | **Helpful nudge** if and only if eligibility is verified upstream. See §2.5. |
| **Entitlements sheet** | Claim hotel / claim meal / dismiss | No claim pre-selected | Each row carries plain eligibility; ineligible rows render in `--ink-3`, non-interactive, labeled "Not eligible" with a one-line reason (CW §6 ground-transport row) | Loss aversion (Kahneman/Tversky 1979) is *not* exploited — there is no countdown, no "claim before midnight or lose this" framing. The sheet refuses the urgency-manipulation pattern. | **Helpful nudge.** Naming what is *not* available is the trust move. (observed-from-prototype lines 1101–1107) |

---

## 2. Specific dark-pattern risks the proposal MIGHT slip into

### 2.1 The Screen 2 active-state demo (observed-from-prototype, lines 842–875)

The prototype currently renders Screen 2 with the Rebook card already in `.active` (teal-wash, `aria-pressed="true"`) and the primary CTA enabled as "Continue with rebook." IxD §1 explicitly specifies `default`: "Three path cards, none selected, primary CTA disabled." VD intended this as a demo of the active state, not the first-paint default. **Risk:** if engineering interprets the prototype's active demo as the spec, this re-introduces a default-tab dark pattern with stronger steering power than the old Travel-credit default — because the active treatment is visually weightier than a tab. (Default effect: Johnson & Goldstein 2003 organ-donor study.) **Recommendation:** ship with no card pre-selected on first paint. Add a comment in the prototype HTML clarifying that the `.active` class on the first card is a demo of the *selected* state, not the *default* state.

### 2.2 The "Recommended" badge — confirmed dropped, no vestige

Searched the prototype: "Recommended" does not appear. The flight cards use arrival-time anchoring + party-status + "No charge" instead. CW §5 explicitly removes it. Verdict: **clean.** The badge's copy work has been redistributed to logic-visible signals (the consequence line, the party row), which is the right move per Cialdini-vs-transparency tradeoff — authority becomes earned-by-evidence, not asserted-by-label.

### 2.3 "Continue with rebook" / "Continue with credit" / "Continue with standby"

CW §3 specifies the primary CTA label updates to reflect the selected card. **Risk:** the teal-wash on the active card + the path-specific CTA label could create a *commitment-escalation* nudge (Cialdini's commitment & consistency) — the user feels they've already chosen by tapping the card, before they confirm. **Verdict:** acceptable, because the tap is genuinely reversible (IxD spec: re-tapping another card swaps active state, CTA re-labels in 120ms cross-fade), the card carries the consequence line, and the CTA is path-specific *which is itself anti-dark-pattern* — a generic "Continue" would obscure what the user is committing to. **Recommendation:** preserve the path-specific CTA verb. Do not let visual design quietly downgrade to "Continue" in a future iteration; the verb is the consent.

### 2.4 "Plans changed? Start over" affordance (Screen 4)

Placement: tertiary link below the receipt, underlined in teal-ink. CW §7 set the question-mark phrasing deliberately. IxD §5 makes it a non-destructive inline disclosure with two equal-weight buttons ("Keep this trip" / "Start over") and preserves prior entitlement claims. **Risk to audit:** sunk-cost framing (Arkes & Blumer 1985) — a user who has confirmed a flight may feel re-entering the flow is wasteful. **Verdict:** the language and the equal-weight buttons handle this well. The phrase "Plans changed?" externalizes the cause (the world changed, not the user's judgment), which is the right framing to defuse sunk-cost guilt. **Borderline concern:** the link is visually subordinated (tertiary, underlined small). If support-call data shows users are not finding it, the link's weight should rise to secondary, not stay tertiary. (recommendation; measurable — see §5.4.)

### 2.5 Entitlements strip — over-claim risk

CD's framing ("the user should not have to find help; help finds them") plus IxD's `strip-available` default state + the sheet's one-tap "Claim" button creates a structure where claiming is the path of least resistance. **Risk:** a user who is *already home* in Denver and doesn't need a hotel may still tap "Claim" because the strip's continuous presence reads as "do this to complete the flow." That's not a dark pattern against the user; it's a dark pattern against the airline's cost basis, but it also degrades trust because the user later realizes they claimed something they didn't need. **Verdict: borderline.** The mechanism here is endowment-via-default (Thaler) plus action-bias (Patt & Zeckhauser 2000 — people prefer action over inaction under uncertainty). **Recommendation:** add one filter question at the entitlements-sheet level — "Are you traveling tonight from DEN, or already home?" — before the Claim button is enabled for hotel specifically. Frame as a single-tap segmented control, not a modal. This is friction placed *exactly* where it changes behavior (Fogg: ability is the constraint, not motivation), and it protects both sides of the trust contract. (recommendation; CW already has the language scaffolding in the "Eligibility phrasing rule" §6.)

### 2.6 The party-size chip + card-row pattern (IxD §6, third option)

Two redundant signals: a non-dismissible chip ("Showing flights for 3 travelers — change") above the sort row, AND a party-status row inside each flight card. **Risk:** hectoring / signal-fatigue. The user gets told the same thing twice on the same scroll. **Verdict: acceptable, with a tightening.** Redundancy is justified *only* if the two signals do different jobs. The chip's job is *constraint declaration* before the list renders ("we know you're a party of 3"). The card row's job is *constraint resolution per option* ("here is whether this specific flight fits"). That's not redundant — that's anchoring (chip) plus per-option diagnostic (row). **However**, IxD's own fallback ("when party size > 2") is the right shipped behavior — at party size 1 or 2, the chip is chrome and should not render. **Recommendation:** ship IxD's fallback rule, not the "always show" rule. (Mechanism: avoid mere-exposure backfire when the message is not load-bearing.)

### 2.7 Card order on Screen 2 (Rebook → Credit → Standby)

This is itself a nudge. **Verdict: acceptable, see §4.2.**

---

## 3. Trust risks — currency of this flow and what burns it

The currency is **operational honesty under stress**. This flow earns trust by saying true things plainly and refusing softening verbs. Five specific failure modes that would burn it permanently:

1. **Claim-then-retract.** User taps "Claim hotel" in the sheet; the sheet shows success; the receipt later shows "not eligible after all." This is the single highest-stakes failure on the surface. CW §6 already names the rule ("the strip never promises something a downstream surface might retract") — the strip-and-sheet eligibility must be authoritative, not provisional. (recommendation: any provisional state must render as "may apply" *before* claim, never after.)
2. **Receipt that says one thing, agent who says another.** User screenshots the receipt; calls support to confirm a detail; agent reads from a different system showing different data. Burns trust faster than a missing receipt would. (IxD §4 already specifies passing context to the agent — this must be one-source-of-truth, not two.)
3. **"You have not been rebooked yet" appearing on Screen 1 *after* the user has actually been rebooked** (e.g., stale cache, deep link timing). The state line is the load-bearing trust object on Screen 1; if it lies even once, the user never trusts state language on this surface again. (IxD §3 has `link-stale` handling — ratify.)
4. **Held-seat-expired with silent re-charge.** If "Try again" in the held-seat-expired state results in a fare difference the user didn't see, the trust violation is catastrophic. CW already handles this with "No charge" being explicit; the rule must extend to retries — if the re-attempt would now cost money, the CTA must say so before tap.
5. **"Plans changed? Start over" that doesn't actually preserve prior claims.** IxD §5 specifies hotel and meal claims persist across re-entry. If engineering ships a version that re-checks eligibility on re-entry and a previously-claimed hotel disappears, the link becomes a trap (roach-motel-adjacent: easy to enter the second flow, but you lose something on the way). Ratify IxD's spec on preservation.

---

## 4. Ethical nudges — where nudging is justified

### 4.1 Sort default on Screen 3 (sort-by-arrival)

The current default sort is arrival time. UXR A2 calls this an assumption to validate — but treating arrival as the default for an urgent-event scenario is **a justified nudge**. Framing: the user's actual goal is "arrive in time for the family event," and sort-by-price would silently elevate cost-minimization over goal-attainment. **To keep this on the right side of the line:** the sort label "Sorted by **Arrival**" must be visible and tappable to change. (observed-from-prototype line 912: it is.) Mechanism: anchoring (Tversky/Kahneman) on the goal-relevant dimension; defaults (Thaler/Sunstein) chosen to match stated user intent, not airline-internal preference. **Verdict: ethical — meets Thaler/Sunstein's "libertarian paternalism" criterion (the user can change it cheaply, the default reflects their likely goal).**

### 4.2 Order of the three path cards on Screen 2 (Rebook → Credit → Standby)

The order itself nudges. Rebook-first signals "the airline expects to get you there," which is what the user came for. Credit-second is the legitimate alternative; Standby-third is the last-resort. **Verdict: ethical**, with one constraint: IA §1 already specifies the order reverses on second-cancellation (Credit and Standby first). That is exactly the correct behavior — the order tracks the user's mental model, not the airline's preferred outcome. If a future iteration tries to push Credit-first to manage operational load, that crosses the line into the *old* dark pattern. (mechanism: serial-position effect — Murdock 1962 — first item gets disproportionate attention; this should be deliberately deployed to match user goal, not airline incentive.)

### 4.3 No "Recommended" replacement on flight cards

CW removed it; UXR/CD already vetoed re-introducing it. **My position: do not replace it with anything.** Not a star, not a "Best match," not a "Closest to your event." Any badge that's not a literal fact computed from user-set preferences is doing copy work that should be done by data (arrival time is at 28px; "No charge" is right-aligned; party status is on the card). **Verdict: ethical to leave the badge slot empty.** Authority (Cialdini) earned through visible reasoning is durable; authority asserted through a badge is the unexplained-Recommended dark pattern the brief explicitly flagged.

---

## 5. Experiment plan — falsifiable hypotheses

Primary north-star: rebook completion rate (self-service rebook OR credit OR standby committed without a support call within 30 minutes of the cancellation SMS), and entitlement claim rate among eligible users. **But** the team's belief that the new design works is composed of separable claims; each must be testable independently or attribution is impossible.

### H1 — The operational header (fact + state) reduces time-to-first-decision on Screen 2

- **Hypothesis:** users seeing the new operational header on Screen 1 reach a Screen-2 path-card tap in less median time than users seeing a control header ("Your itinerary has changed").
- **Primary metric:** median time from Screen-1 paint to first Screen-2 card-tap.
- **Guardrail:** Screen-1 dwell-then-call rate (users who read Screen 1 and then tap the phone link — we do not want speed at the cost of calls-from-confusion).
- **Exit rule:** ship if median time drops ≥15% and guardrail does not rise ≥20% from baseline. **Falsifying outcome:** median time drops but Screen-1-to-call rate rises ≥20% — kill the change; users are being pushed past a beat they needed.
- **Mechanism tested:** salience + framing (Kahneman/Tversky). What the experiment falsifies if it loses: the team belief that fact-first headers reduce decision latency.

### H2 — Consequence copy on path cards changes which path is chosen (the falsification experiment)

- **Hypothesis:** showing consequence copy under each path label shifts path selection away from whichever path the *old* default-tab favored (credit), toward the path that matches the user's actual situation.
- **Primary metric:** distribution of path selection (rebook / credit / standby) and self-reported post-flow "this matched my goal" score.
- **Guardrail:** post-flow regret-call rate within 48 hours (calls where user wants to undo the chosen path).
- **Exit rule:** ship if path distribution shifts more than 10 percentage points away from credit (the old default) AND regret-call rate does not rise. **Falsifying outcome the team should accept:** if path distribution shifts but regret-call rate rises ≥30%, the consequence copy is *misleading* not *clarifying* — revert and rewrite the consequence lines. This is the experiment that could **falsify a team belief**: consequence copy is currently treated as obviously-good. It is not obviously-good if it shifts users toward paths they later regret.
- **Mechanism tested:** framing (Tversky/Kahneman); making the *cost of inaction* legible (loss-aversion-style framing applied truthfully).

### H3 — Entitlements strip raises claim rate among the eligible without raising it among the ineligible

- **Hypothesis:** the persistent strip raises hotel/meal claim rates for users whose eligibility is verified, without inducing claims from users who don't need or can't use the entitlement.
- **Primary metric:** claim rate per eligible-user (hotel) and per eligible-user (meal).
- **Guardrail (the trust-side metric):** claim-then-cancel rate within 12 hours, and claim-by-already-home-in-DEN-users rate (cross-reference with origin-of-cancellation + user device location). This is the operationalization of §2.5.
- **Exit rule:** ship if eligible-claim rate rises ≥25% from baseline AND guardrail rates stay flat. **Falsifying outcome:** eligible-claim rate rises but claim-then-cancel rate also rises >15% — the strip is generating action-bias claims; add the §2.5 eligibility filter.
- **Mechanism tested:** salience + availability heuristic (Kahneman/Tversky) vs. action-bias (Patt & Zeckhauser).

### H4 — Party-size chip prevents the "family of 4 picks a flight, discovers no 4 seats, calls" failure

- **Hypothesis:** users with party size ≥3 who see the non-dismissible chip + card-row pattern have a lower rate of "flight-chosen-then-call-to-fix-seating" events.
- **Primary metric:** rate of post-confirmation calls citing seating among party ≥3 users.
- **Guardrail:** party-size-3+ rebook completion rate (we don't want fewer calls because users gave up).
- **Exit rule:** ship if the seating-call rate drops ≥30% and party-size-3+ completion rate does not drop ≥5%.
- **Mechanism tested:** anchoring on the constraint before the option list renders.

### H5 — "Plans changed? Start over" placement is sufficient (low-stakes calibration)

- **Hypothesis:** the tertiary-link placement of "Plans changed? Start over" is discoverable enough that users who need it find it within 60 seconds.
- **Primary metric:** time-to-tap on "Start over" among users who later make a change.
- **Guardrail:** rate of support calls where the first agent question is "how do I change my trip again?" — this is the receipt-screen failure mode bleeding into call data.
- **Exit rule:** if time-to-tap median exceeds 90s OR guardrail call-rate is non-trivial, raise the link to secondary-button weight. (Mechanism: availability — the option must be in the user's perception, not just on the page.)

---

## 6. Watch-for signals during rollout

Five patterns that would tell us the design is silently failing despite headline metrics looking good:

1. **Support-call rate flat or down, but call duration up.** Users are reaching agents already mid-flow with confused state. The flow is sending them with worse context, not less context. (Compare against IxD's §4 context-passing spec — engineering may have not implemented it.)
2. **Claim-then-cancel pattern on entitlements within 12h.** Especially on hotel claims from users whose device location is the DEN metro area. This is the §2.5 action-bias prediction; if it appears, ship the eligibility filter.
3. **"Start over" rate elevated on Screen 4 AND a second rebook within 5 minutes of the first.** Users are confirming, immediately doubting, and re-entering. Indicates the confirmation does not deliver the *receipt-trust* the design promised. Dig into which receipt fields users tap first on re-entry.
4. **High Screen-2 dwell + high Screen-2 abandonment (no card tap, exits or calls).** The path cards' simultaneous-comparison frame was supposed to *speed* decision; if it slows and exits, the consequence copy is doing the wrong job. This is the H2-falsifying signal in production. Listen for it.
5. **Receipt screen taps on "Save / share" near zero.** This means users are not treating the receipt as an asset — the trust object the design depends on isn't landing. The flow may be technically working while the long-tail trust currency is not accruing.
6. **Disproportionate failure on screen-reader / 200%-zoom cohorts** (UXR's two-tier-product warning). Headline completion rate looks good because the modal cohort is sighted/default-zoom; the AT cohort is calling at higher rates. Slice metrics by accessibility cohort or the flow is failing the access promise. (recommendation; UXR Section 4 question 6.)

---

## 7. Handoff messages

### To Content Designer

Two language items I want changed (or ratified-with-context) for behavioral reasons:

1. **"Hotel and meal support available — Not yet claimed — eligible for tonight"** on the strip (Screen 1, prototype lines 768–770; CW §6). The phrase "Not yet claimed" is doing two jobs: status (truth-telling) and call-to-action (mild loss-aversion: there's something here you haven't taken). The CTA framing tips toward action-bias for the home-in-Denver edge case I flagged in §2.5. **Recommendation:** keep the line, but pair it with the eligibility filter on the sheet itself (§2.5 friction). Do not soften the line — the issue is on the sheet side, not the strip's copy. **Ratified with that downstream change.**
2. **"Continue with rebook" / "Continue with credit" / "Continue with standby"** (CW §3, after Screen 2 selection). I want to defend these against any future pressure to revert to a generic "Continue." The path-specific verb is the user's consent receipt for the path they tapped. If anyone later asks for a single CTA label to reduce localization cost, I'm a hard no. The verb *is* the anti-dark-pattern.
3. **One language addition I'd request:** the entitlements sheet eligibility filter (§2.5) needs language. Suggested register: "Where are you tonight? — At DEN airport / On the way to a hotel / Already home." One-tap segmented control. Hotel "Claim" enables only on the first two. (You own the words; this is the slot.)

### To Interaction Designer

Three state/affordance items I want re-spec'd for behavioral reasons:

1. **Screen 2 default state — confirm the spec, not the prototype demo.** The prototype renders Rebook pre-selected and CTA enabled. Your spec (§1, `default`) says no card selected, CTA disabled. Add a one-line note on the prototype that the rendered active state is for state-demonstration only, and confirm engineering implements the disabled-until-tap default. This is the single biggest dark-pattern risk in the current artifact, and it is one comment away from being fully neutralized. (§2.1 above.)
2. **Entitlements sheet — add eligibility-gate friction (§2.5).** Currently the sheet's first interactive element is "Claim Hotel." I'd like one tap of friction between sheet-open and Claim-enabled: a single segmented question about user location/state. This is friction *placed exactly where it changes behavior* (Fogg: ability constraint, not motivation constraint), and it protects the trust contract from action-bias claims.
3. **"Plans changed? Start over" — instrument it, don't yet promote it.** Your §5 placement is correct (tertiary inline disclosure). Do not promote to secondary unless H5's guardrail trips. Pre-promotion would over-signal that changes are expected and erode the receipt's settled feel. Hold the tertiary placement; let the data decide if it needs to rise.

---

## Summary (for the team)

**Overall verdict on the flow's behavioral ethics:** the redesign cleanly removes the old flow's dark patterns (credit-default tab, hidden entitlements, unexplained "Recommended" badge) and replaces them with structural truth-telling (consequence-as-design, persistent strip, screenshotable receipt, no badge). Where it introduces new nudges (sort-by-arrival, Rebook-first card order), they are aligned with user-stated goals and reversible at low cost — meeting Thaler/Sunstein's libertarian-paternalism criterion. The flow earns a "ship it" from me, conditional on three fixes.

**Biggest dark-pattern risk flagged:** the Screen 2 prototype renders Rebook pre-selected with the CTA enabled. IxD's spec correctly defines the default as no-card-selected, CTA-disabled. If engineering implements the prototype's demo state as the actual first-paint, this re-creates a default-effect nudge stronger than the old default-tab pattern. One-line fix; high consequence.

**Most surprising unintended nudge:** the entitlements strip's always-on, status-stating presence is great for the right user but creates an action-bias claim risk for the user who is already home in Denver and doesn't need a hotel. The strip's mechanism is salience + availability; the side effect is endowment-via-default. Fix is one segmented-control question in the sheet, not a rewrite.

**Top falsifiable experiment (H2):** consequence copy on path cards is currently treated as obviously good. If the copy shifts path selection but regret-call rate rises, the consequence lines are misleading not clarifying — revert and rewrite. This is the experiment most likely to embarrass the team and most worth running.
