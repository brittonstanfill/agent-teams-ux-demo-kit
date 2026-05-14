# Final Recommendation — Northstar Canceled-Flight Recovery

**Team:** Northstar UX Recovery Team (clean-room agent-team run)
**Artifact:** Authored mobile HTML prototype at `demo-output/prototype/index.html` + this recommendation memo.
**Register:** *operational honesty filtered through Linear restraint* — set by Creative Director before any teammate authored.

> **Reading order.** Section 1 is the meeting-ready recommendation. Sections 2–5 are how we got there: the flow, what each role contributed, which handoffs changed the answer, the debates that ran. Sections 6–8 are the guardrails (tradeoffs, accessibility, trust, experiment plan). Section 9 sets up the comparison against the single-agent baseline. Section 10 is run metadata + clean-room verification.

---

## 1. Executive recommendation

Ship a four-screen recovery flow plus a persistent entitlements strip plus a rewritten SMS, anchored on **operational honesty**: name the fact, name the current state, show the paths side-by-side with their consequences, and end with a screenshotable receipt that includes the support phone number visible without a tap.

The four moves that earn this recommendation:

1. **Operational two-line header on every screen.** Fact at 28px ("Your 6:15 a.m. flight tomorrow is canceled."), then current state ("You have not been rebooked yet. Three options are ready below."). No apology lede. No illustration. Type is the hero.
2. **Side-by-side stacked path cards with consequence copy as the design.** Three paths visible at once: rebook / credit / standby. Each card carries the consequence — "You arrive Wednesday morning. All 3 seats confirmed, no charge." / "You decide later. No flight is held. Credit good for 12 months." / "You wait at the gate. A seat is not guaranteed." No tabs. No "Recommended" badge. No card pre-selected (CTA disabled until the user picks).
3. **Persistent entitlements strip with live status — never a screen, never an FAQ.** Pinned bottom on screens 1–3, surfaces hotel + meal availability *and* current claim status. On Screen 4 it dissolves into the receipt block as a status row. An eligibility-gate segmented control inside the sheet ("Where are you tonight?") prevents action-bias claims by users who don't need the support.
4. **Screenshotable receipt with `tel:` visible-without-tap.** Stamp + headline + definition list of flight / travelers / confirm code / bags / hotel / meal / support number. Renders from cache offline. Re-entry via "Plans changed? Start over" preserves prior entitlement claims.

**Conditions for promotion (sourced from Behavioral Scientist + Devil's Advocate):**
- Engineering must implement Screen 2 first-paint with no card selected and CTA disabled (the prototype renders an explicit default-state demo above the active-state demo to make this unambiguous).
- The sheet's focus trap, `inert` underlying surface, Esc + backdrop dismiss, and focus-return-to-opener ship in v1 — not "JS later."
- Voucher-spend projection at BS H3's claim-rate threshold (+25%) signed off by ops/finance before launch.
- Engineering returns ≥ "medium" confidence on 15 of the 18 IxD states (see §6 risks).

**Quality bar held against (CD anchor):** a designer reading this prototype cold can name three deliberate moves on first scan — operational header, stacked-path-cards-as-design, persistent strip with status. No Bootstrap tells. No motion theater.

---

## 2. The redesigned flow (4 screens + persistent strip + SMS surface)

### Entry — SMS

> **Northstar Air: Flight NS482, Wed 6:15 a.m. DEN–LGA, is canceled (crew). Not yet rebooked. See 3 options: northstar.app/ns482 or call 1-800-555-0142.**

157 characters. Airline identity first token. The word "canceled," not "schedule irregularity." Current state ("Not yet rebooked") in the body. Deep link **and** phone number — channel-symmetric. (CW §2)

### Screen 1 — Status & Stake

- **Meta:** `NS482 · DEN to LGA · Wed, May 14`
- **Fact (h1):** Your 6:15 a.m. flight tomorrow is canceled.
- **State:** Reason: crew availability. **You have not been rebooked yet.** Three options are ready below.
- **Primary:** See your options
- **Secondary:** View full itinerary
- **Tertiary:** Or call 1-800-555-0142 (`tel:` link, aria-labeled)
- **Entitlements strip** (pinned bottom): Hotel and meal support available — Not yet claimed — eligible for tonight

A second-cancellation variant exists with a reordered state line ("This is the second cancellation on this trip.") and Credit/Standby cards reordered first on Screen 2.

### Screen 2 — Choose Your Recovery

- **Fact (h1):** Pick a path.
- **State:** All three are available right now. Choose what arrives first, what waits, or what cashes out.
- **Three stacked path cards** (no tabs, no default selection, CTA disabled until tap):
  - **Rebook on a new flight** · Earliest: 7:10 a.m. · *You arrive Wednesday morning. All 3 seats confirmed, no charge.*
  - **Take travel credit** · $847 value · *You decide later. No flight is held. Credit good for 12 months.*
  - **Join standby** · Next: 9:55 a.m. · *You wait at the gate. A seat is not guaranteed.*
- **Primary CTA** (after selection, path-specific verb): Continue with rebook / credit / standby — **never** generic "Continue"
- **Tertiary:** Why these three?

### Screen 3 — Confirm the Specific Choice (rebook variant)

- **Fact (h1):** Pick the flight.
- **State:** Sorted by arrival time. Party-size status is on each card.
- **Sort row:** Sorted by **Arrival** · Filters (opens bottom-sheet)
- **Non-dismissible party-size chip** above the sort row: "Showing flights for 3 travelers — change" (renders only for party > 2 per BS §2.6 fallback)
- **Flight cards** with arrival-time at 28px as the load-bearing data point, departure / stops / duration as metadata, **No charge** right-aligned, and a hairline-separated party-status row inside each card (teal dot + "All 3 confirmed together" or warm-rust dot + "Only 2 seats together — Split party?"). Service-animal / bassinet-row accommodation status renders as a second status row when the booking carries that need.
- **Primary CTA** (path-specific): Confirm 7:10 a.m. flight

Credit and Standby variants share the frame. Credit: $847 terms + "Accept credit." Standby: next-flight + queue position + "Add me to standby."

### Screen 4 — Receipt

The screen the current flow refuses to give.

- **Stamp:** NORTHSTAR AIR · TRIP UPDATED
- **Headline:** You're on the 7:10 a.m.
- **Definition list:** FLIGHT, TRAVELERS, CONFIRM (bold; copy-paste-safe), BAGS, HOTEL, MEAL, SUPPORT (visible `tel:` link)
- **Secondary:** Save / share receipt
- **Tertiary:** Plans changed? Start over (opens inline disclosure; preserves prior entitlement claims; returns to Screen 2 with the previously-chosen path marked as history — bone-3 background with a 3px ink-3 left-edge stripe, not teal-wash)

The receipt renders from cache offline.

### Entitlements strip + sheet

- **Strip:** pinned bottom on screens 1–3; carries availability **and** current status ("Not yet claimed — eligible for tonight" / "Hotel claimed — Marriott DEN Airport" / "Support options for tonight — meal credit only" / etc.). Five status variants spec'd by CW §6.
- **Sheet:** opens with focus on `<h2>`, `inert` on underlying surface, Esc + backdrop dismiss, focus returns to opener on close, no auto-close after claim. First interactive element is an eligibility-gate segmented control ("Where are you tonight?") that prevents claim-by-home-traveler.

---

## 3. What each role contributed (top 3 each)

**Creative Director — Anchor & quality bar.**
1. Reference language pinned to *NTSB / FAA NOTAM operational honesty filtered through Linear's restraint*. Explicitly **not** Airbnb warmth, Duolingo encouragement, Headspace softness, or airline marketing gloss. The traveler is, at 10:46 p.m., an operator of their own rescheduling problem.
2. Three moves named *before* authoring: operational header, side-by-side cards with consequence copy, persistent entitlements strip. These are the spine of every later contribution.
3. Held the line on warm bone over white, no illustration, no progress bar, no celebratory confirm, type as the hero. Approved warm-bone and warm-rust at sign-off; carried one open concern about the "Why?" fare-link into synthesis (resolved below).

**UX Researcher — Needs, confidence collapse, assumptions.**
1. Confidence-collapse moment located: Screen 2 (default-tab credit) and Screen 4 (hidden entitlements). The new flow neutralizes both at the structural level.
2. Three jobs-to-be-done in priority order — fact → comparison-with-consequence → receipt-with-proof — converted into a decision order the IA inherited.
3. Risk inventory naming who the design is most likely to fail: party-of-4 trying to sit together, deaf SMS-reliant, ESL traveler, low-bandwidth user, mobility-needs traveler, party-with-infant / service-animal user (the gap A11y later closed with a flight-card status-row variant).

**Information Architect — Structure, sequence, labels.**
1. Settled on 4 screens + persistent strip + SMS entry surface — defended 4 over 5 by collapsing the dead-weight "Continue" interstitial into the options-entry screen. The Receipt screen is the screen the current flow refuses to give and is non-negotiable.
2. "Labels do not explain consequences" failure mode neutralized: every label answers "what happens if I tap this?" — Rebook on a new flight / Take travel credit / Join standby paired with consequence copy in the same visual unit.
3. Edge-case structure for state-line behavior: second-cancellation reorders the cards; multi-passenger booking carries party count in the header; connecting itinerary distinguishes the canceled segment from the rest of the trip.

**Visual Designer — Aesthetic, tokens, components, authored prototype.**
1. Deep ink on warm bone (#1A1715 on #F5F1E8), one desaturated teal accent (#2E6E6B) reserved for active decision only; system-font stack so the artifact works offline; tabular numerals throughout.
2. Authored the full HTML prototype from a clean canvas (not a tuning pass) — the prototype is the executed design, not a description.
3. Party-status row inside each flight card (the contribution that resolved one of the team's three debates — see §5).

**Interaction Designer — State model, microinteractions, recovery paths.**
1. 18 named states across SMS / Screen 1 / Screen 2 / Screen 3 / Screen 4 / strip / sheet. The behavior layer is where the design's coherence lives.
2. Held-seat-expired sequence: announce loss first, pause one beat, announce recovery, then move focus — designed specifically for the user whose attention is fragile (later refined to two beats per A11y §8).
3. Third-option synthesis on the party-size debate: non-dismissible chip + card-row status row, with a fallback rule ("only render the chip when party > 2") that BS ratified to avoid signal-fatigue.

**Content Designer — Voice, SMS, screen strings, errors.**
1. SMS at 157 characters, fact-first, "canceled" not "irregularity," current state ("Not yet rebooked") in the body, deep link **and** `tel:` number — channel-symmetric.
2. Path-card consequence copy length-locked at one line each, finalized verbatim. Path-specific CTA verbs ("Continue with rebook," "Accept credit," "Add me to standby") rather than a single "Continue."
3. Cut the "Why?" link on no-charge cards on principle: the link's presence created the doubt it purported to resolve. CD's standing concern resolved.

**Behavioral Scientist — Choice architecture, dark-pattern audit, experiments.**
1. Screen-by-screen choice-architecture audit naming each nudge's named mechanism (Kahneman/Tversky anchoring, Johnson/Goldstein defaults, Cialdini authority, Thaler/Sunstein libertarian paternalism, Fogg B=MAP). Verdict: helpful nudges throughout, with three conditional fixes.
2. Caught the Screen 2 prototype-vs-spec drift: prototype rendered Rebook pre-selected; spec is no-card-selected-CTA-disabled. One-line fix; high consequence. Triggered the VD revision pass.
3. Five falsifiable experiments with primary metric, guardrail, and exit rule — including H2, the consequence-copy falsification experiment (if path distribution shifts but 48-hour regret-call rate rises ≥30%, revert and rewrite). This is the experiment most likely to embarrass the team and most worth running.

**Accessibility Specialist — WCAG + AT-behavior audit.**
1. Eight concrete blockers / serious risks (B1–B8) with WCAG criterion mapped, user-impact narrative for each blocker, and shippable fixes. Triggered the VD revision pass alongside BS.
2. Sheet pattern spec: `inert` on underlying surface (not just `aria-hidden`), focus to sheet `<h2>` on open, focus return to opener on close, no auto-close after claim, separate `role="status"` live region for status-change diffs (not announcing the entire strip).
3. Identified the accommodation-continuity gap (party-with-infant, service-animal) as the edge user the design was still most likely to fail; specified the fifth status-line variant on flight cards. Shipped in the VD revision pass.

**Devil's Advocate — Stress-test of the consensus.**
1. Steel-manned the team's case at its strongest, then attacked along five axes: happy-path overfit, register-condescends-to-power-users, regulatory verbatim collision, business-economics self-cannibalization, prototype-to-production 80% gap.
2. Pre-mortem with three plausible failure stories ranked by plausibility; "it shipped 80%" is the most likely.
3. Revised promotion criterion (data, not opinion): six measurable hurdles drawn from BS hypotheses + DA attacks. 5/6 = ship and defend; 4/6 = ship with a named gap; ≤3/6 = the design's coherence claim is unsupported.

---

## 4. Cross-agent handoffs that changed the answer

These are the moments where one teammate's input materially changed another teammate's output or the prototype itself. Listed in chronological order.

### Handoff #1 — CD anchor → every teammate (sequenced before authoring)
**Effect:** Set the register *before* authoring rather than after. UXR's "the user is tired, not stupid" voice rule, IA's "no tabs" defense, VD's three deliberate moves, CW's "no apology in headlines" voice rule, BS's mechanism naming — all traceable to the CD anchor. **Without this step, the visible failure mode would have been a 5-screen wizard with a blue gradient and a sad-cloud illustration** — the exact "meeting-template version" the CD named.

### Handoff #2 — UXR → IA (top user needs as decision order)
**Effect:** UXR's three jobs-to-be-done (fact → comparison-with-consequence → receipt-with-proof) became IA's screen sequence. UXR also flagged the party-of-4 failure mode in their handoff, which IA did not solve at the IA layer but **changed VD's flight-card design** at the surface layer (the party-status row inside each card).

### Handoff #3 — CD sign-off on VD's authored direction
**Effect:** CD ratified VD's warm-bone over true white, warm-rust party-size advisory, and the party-status row inside flight cards (siding with VD over UXR's more-aggressive surfacing — see Debate #1 below). CD carried one standing concern into synthesis: the "Why?" fare link must earn its keep with one factual sentence or be cut.

### Handoff #4 — CD's standing concern → CW decision (cut "Why?" link)
**Effect:** CW cut the "Why?" link from no-charge cards entirely, on principle ("the link's presence creates the doubt it purports to resolve"). The factual sentence is preserved in CW §5 for fare-difference cards if they ever ship. **This changed the prototype** — the "Why?" link was removed in the VD revision pass.

### Handoff #5 — VD's three open questions → IxD answers
**Effect:** IxD answered all three (receipt paint together not staggered; history-card 3px ink-3 left-edge stripe; filters in a bottom-sheet with one exception). The history-card spec is a new sub-component VD added in the revision pass.

### Handoff #6 — IxD party-size third option → BS ratification with fallback
**Effect:** IxD proposed the non-dismissible chip + card-row pattern as a synthesis of VD's and UXR's positions. BS ratified the structure but added a fallback: only render the chip when party > 2, to avoid hectoring small parties. Shipped in the revision pass.

### Handoff #7 — A11y B1–B8 + BS §2.1 → VD revision pass (the biggest handoff that changed the artifact)
**Effect:** This is where A11y and BS together materially changed the prototype after consensus had formed. The revision pass shipped 10 must-fixes and 5 should-fixes: active-card non-color affordance, sheet focus trap + `inert` + JS, rule-strong token for inter-card separators, "Why?" link removed, anchor-to-button conversions, party-conflict structural restructure, `tel:` aria-labels, strip aria-labels, Screen 2 default-state explicit demo (resolving the prototype-vs-spec drift BS caught), held-seat-expired non-color affordance, ink-3 darken, accommodation-continuity status-row variant, eligibility-gate segmented control on the sheet, history-caption mixed-case in DOM, path-card aria-labels with "Selected." suffix. **Before this pass, the prototype failed the Layer-0 accessibility floor. After, it passes.**

### Handoff #8 — DA → synthesis (this document)
**Effect:** DA's six promotion criteria appear in §1 as conditions for ship. DA's pre-mortem informs §7 "Risks and what would change our mind." DA's "what I would NOT change" list informs §6 below (defending against late pressure to revert).

---

## 5. Debates that ran (with dissent preserved)

The team produced three substantive debates. Per the runbook, dissent is preserved as part of the artifact.

### Debate #1 — Where does party-size surface?

**Positions (independently authored, no peer-reading until in):**
- **UXR:** Surface party-size at the option-to-flight transition, not behind a filter. "Filter implies the user might want to turn it off. A party of three is not a preference; it's a constraint." (UXR §5, §6)
- **VD:** Party-status row inside each flight card with a colored dot (teal "All 3 confirmed together" / warm-rust "Only 2 seats together. Split party?"). Structural to the card decision, not a filter. (VD §3 component spec)
- **IxD:** Both. Non-dismissible chip "Showing flights for 3 travelers — change" above the sort row, AND VD's card-level row. The chip is constraint declaration before the list renders; the row is constraint resolution per option. (IxD §6)

**Resolution:** IxD's synthesis position wins, with BS's fallback rule applied. **Shipped:** Card-level party-status row + chip above sort row when party > 2.

**Dissent preserved:** UXR's stronger position remains in the record. UXR's view: a filter-shaped affordance — even a non-dismissible one labeled "change" — still reads as optional to some users, and the safer answer would be to ask party-size as a hard precondition at the path-selection step ("Confirm party size before showing flights"). UXR did not insist on this and accepted IxD's synthesis, but the dissent is preserved: **if H4 falsifies (post-confirmation seating-related calls do not drop ≥30% among parties of 3+), revisit UXR's stronger position before iterating on the chip's copy.**

### Debate #2 — Default state on Screen 2 (no-selection vs. pre-selection)

**Positions:**
- **VD (as authored in the original prototype):** Rebook pre-selected, CTA enabled with "Continue with rebook." This was a state-demonstration choice for the prototype — VD's intent was to show the active state visually, not to spec the first-paint.
- **IxD (spec):** No card selected, CTA disabled. First paint is read-only-three-cards; the user picks; only then does the CTA enable. (IxD §1 `default`)
- **BS (audit):** "The single biggest dark-pattern risk in the current artifact." If engineering implements the prototype's demo state as first-paint, this re-introduces a default-effect nudge (Johnson & Goldstein 2003) stronger than the old default-tab pattern — because the active treatment is visually weightier than a tab. (BS §2.1)

**Resolution:** IxD's spec wins. **Shipped:** the VD revision pass renders an explicit "Screen 2 — first paint (no selection, CTA disabled)" surface above the active-state demo, plus an HTML comment on the active demo clarifying that the rendered active state is for demonstration only. Spec is the contract; demo is the visualization.

**Dissent preserved:** none material at this point. The original VD intent ("show the active state to the meeting") is preserved in the original demo block. **Non-negotiable for production:** engineering must implement the spec, not the demo. If a future iteration tries to pre-select Rebook for "ease of use," that crosses back into the dark-pattern the team explicitly removed.

### Debate #3 — "Together" vs. "adjacent" on party-status copy

**Positions:**
- **CW:** "Together" — plain Anglo-Saxon, matches user mental model, passes ESL and TTS pressure tests. Flagged as the riskiest plain-language call on the surface and explicitly asked A11y to pressure-test.
- **A11y:** "Together" — verified at TTS speed; "adjacent" has a hard consonant cluster that compresses at high speeds. ESL traveler concern wins on "together." Fallback if user testing surfaces group-booking ambiguity: prepend "seats" → "All 3 seats together."

**Resolution:** Ratify "together." (A11y §7)

**Dissent preserved (the late-pressure dissent):** legal / policy reviews sometimes prefer "adjacent" for technical precision. A11y's view: do not let a late legal/policy swap "together" for "adjacent." That swap would silently make the flow worse for ESL and TTS users — both protected groups, neither of whom show up in the review meeting. **This is the dissent the synthesis explicitly preserves against future pressure.**

### Bonus dissent — DA's "the team produced rigorous justification, not productive disagreement"

DA's belief-1 critique is preserved: of the three debates above, only Debate #1 visibly changed an artifact pre-revision; Debate #2 produced a *recommendation* (which the VD revision pass then *did* implement); Debate #3 *ratified* an existing call. The team accepts this critique with one amendment: **the A11y B1–B8 + BS §2.1 → VD revision pass (Handoff #7) is the second clear non-author-driven artifact shift.** Belief 1 stands for the pre-revision state; the post-revision state has two material non-author-driven shifts (party-size synthesis + the entire revision pass).

---

## 6. Key tradeoffs and rejected alternatives

### Rejected: 5-screen wizard with progress bar
Why rejected: CD anchor. Progress bars under stress read as the product performing competence. The user is not in a wizard; they are at a decision. The five screens collapsed to four by killing the dead-weight "Continue" interstitial. (IA §1 defense of 4)

### Rejected: tabs on Screen 2
Why rejected: tabs hide two of three options behind a click and force the user to *remember* what was on the unselected tabs to compare. Under stress, working memory degrades (Miller; Sweller cognitive-load theory — IA §3). Stacked cards make the comparison the visible artifact.

### Rejected: a "Recommended" badge replacement on flight cards
Why rejected: BS §4.3. Any badge that's not a literal fact computed from user-set preferences is doing copy work that should be done by data. Arrival time at 28px, "No charge" right-aligned, and the party-status row carry the load without a badge.

### Rejected: auto-claim from the strip
Why rejected: A11y §4 and BS §2.5 both flag this as dangerous. The sheet requires explicit dismissal; the focus-return-to-opener contract is the trust move.

### Rejected: pre-selecting Rebook on Screen 2 for "ease of use"
Why rejected: BS §2.1. This re-introduces a default-effect nudge stronger than the old default-tab. Engineering must implement the spec (no selection, CTA disabled), not the prototype's active demo.

### Rejected: promoting "Plans changed? Start over" to secondary weight
Why rejected: BS §2.4. The tertiary placement is the right pre-launch position. Promote only if H5 data shows users can't find it.

### Accepted with tradeoff: cutting the "Why?" link entirely
Tradeoff: on cards where a real fare difference applies (not in this prototype), the link must return with a real `<button>` and a one-sentence factual disclosure. If policy refuses that sentence, fare-difference framing must be removed from rebook entirely. The "Why?" link cannot be a black box on this surface. (CW §5; preserved in markup as a CSS comment)

### Accepted with tradeoff: four screens, not five
Tradeoff: collapsing the dead-weight "Continue" interstitial means Screen 1 carries both the fact and the entry-to-options affordance. IA defended the call; UXR concurred. The risk (the user is rushed past the emotional beat) is mitigated because the emotional beat is the SMS, and Screen 1's job from that point is operational clarity.

### Accepted with tradeoff: the persistent strip's business-cost exposure
Tradeoff: the strip will raise eligible-claim rates (BS H3 predicts ≥25%). DA's Attack 4 names the business-economics consequence the team has not modeled. **Condition for ship:** ops/finance signs off on the voucher-spend envelope before launch. The team holds the UX call; the business holds the cost call; both must agree.

---

## 7. Accessibility and trust guardrails

### Accessibility floor (Layer-0 gate; non-negotiable)

The prototype now passes the Layer-0 accessibility floor per A11y's audit + the VD revision pass. The non-negotiables for shipped product (A11y §9 to team lead):

1. **The sheet ships with focus trap + `inert` + Esc + return-focus, or it does not ship.** No "we'll add the JS later." A static `aria-modal` markup is a worse experience than no modal at all — it lies to AT users about being a trap. *Shipped in the prototype JS.*
2. **The active path card carries a non-color affordance** (2px teal border + 4px teal-ink left-edge bar). The teal wash is decorative; the bar is what AT and low-vision users actually use. *Shipped.*
3. **Accommodation continuity (infant / service animal) belongs on the flight card** as a status-row variant — not a future ticket. *Shipped on Card 3 of Screen 3 with the bassinet-row example.*
4. **"Together" stays.** Do not let a late legal/policy review swap it for "adjacent." That swap would silently make the flow worse for ESL and TTS users.
5. **The keyboard walkthrough in A11y §3 is the contract.** Final A11y sign-off requires manual VoiceOver + TalkBack pass on iOS Safari and Android Chrome before launch.

Downstream handoffs to engineering (correctly out of prototype scope):
- Production focus-trap implementation matching the prototype's contract.
- Live-region sequencing on held-seat-expired (announce loss, pause, announce recovery, then move focus — two beats, not one).
- 50ms debounce between `aria-pressed` flip and CTA-label change on Screen 2 to prevent announcement overlap on slow TTS rates.

### Trust guardrails (BS §3 + CW §6 + DA Attack 4)

The flow's trust currency is **operational honesty under stress**. Five failure modes that would burn it permanently (each with a rule that prevents it):

1. **Claim-then-retract.** Rule: the strip and sheet never promise eligibility that a downstream surface might retract. "Eligible for tonight" is true only when backend has confirmed eligibility for *this* disruption. Conditional eligibility renders as "may apply" *before* claim, never after.
2. **Receipt vs. agent inconsistency.** Rule: IxD §4 specifies the context passed to the support agent on handoff. The receipt and the agent must read from one source of truth.
3. **State-line lying.** Rule: "You have not been rebooked yet" cannot appear on Screen 1 after the user has actually been rebooked. IxD's `link-stale` state handles this.
4. **Held-seat-expired with silent re-charge.** Rule: if a retry would now cost money, the CTA must say so before tap.
5. **"Plans changed? Start over" that doesn't preserve prior claims.** Rule: IxD §5 specifies hotel and meal claims persist across re-entry. Engineering must implement this; the link cannot be a trap.

### Behavioral nudges (each justified, each reversible at low cost)

- **Sort default on Screen 3 = arrival time.** Justified: the user's stated goal is "arrive in time for the family event." Reversible: "Sorted by **Arrival**" is visible and tappable.
- **Card order on Screen 2 = Rebook → Credit → Standby.** Justified: matches the user's mental model (the user came to get to the family event). Reverses on second-cancellation (Credit and Standby first), which is exactly the right adaptive behavior.
- **No "Recommended" replacement.** Authority earned through visible reasoning, not asserted through a badge.

### Eligibility-gate friction (the one place we deliberately added friction)

BS §2.5 + the revision pass added a single-question segmented control inside the entitlements sheet: "Where are you tonight?" Hotel "Claim" enables only on "At DEN airport" or "On the way to a hotel"; "Already home" disables hotel-claim with a one-line explanation. Friction placed exactly where it changes behavior (Fogg: ability constraint, not motivation constraint).

---

## 8. Experiment plan

Five hypotheses, each with primary metric / guardrail / exit rule. (BS §5)

**H1 — The operational header reduces time-to-first-decision.**
- Primary: median time from Screen-1 paint to first Screen-2 card-tap
- Guardrail: Screen-1-dwell-then-call rate
- Exit: ship if median time drops ≥15% and guardrail does not rise ≥20%; falsifies if median drops but guardrail rises ≥20% (users being pushed past a beat they needed).

**H2 — Consequence copy on path cards changes path selection (the falsification experiment).**
- Primary: distribution of path selection (rebook / credit / standby) and post-flow "this matched my goal" score
- Guardrail: 48-hour regret-call rate
- Exit: ship if path distribution shifts ≥10pp from baseline credit-default AND regret rate stays flat; **falsifies if regret rises ≥30% — revert and rewrite the consequence lines.** This is the experiment most likely to embarrass the team's premise.

**H3 — Entitlements strip raises eligible-claim rate without raising ineligible claims.**
- Primary: claim rate per eligible-user (hotel and meal independently)
- Guardrail: claim-then-cancel rate within 12h; cross-reference with origin-of-cancellation + user device location for the home-in-DEN cohort
- Exit: ship if eligible-claim rises ≥25% and guardrail rates stay flat. **Pre-launch additional gate (per DA Attack 4):** modeled voucher spend at the +25% claim rate must fit ops/finance's pre-approved envelope.

**H4 — Party-size chip + card-row prevents the "family of 4 calls about seating" failure.**
- Primary: rate of post-confirmation calls citing seating among party ≥3 users
- Guardrail: party-size-3+ rebook completion rate (we don't want fewer calls because users gave up)
- Exit: ship if seating-call rate drops ≥30% and completion does not drop ≥5%; **falsifies if seating calls stay flat — revisit UXR's stronger party-size-as-precondition position.**

**H5 — "Plans changed? Start over" placement is sufficient.**
- Primary: median time-to-tap among users who later make a change
- Guardrail: support-call rate citing "how do I change my trip again"
- Exit: if median time-to-tap exceeds 90s or guardrail call-rate is non-trivial, raise the link to secondary-button weight.

### Watch-for signals during rollout (BS §6 + DA §5)

1. Support-call rate flat or down, but call duration up — flow is sending users to agents with confused state.
2. Claim-then-cancel within 12h, especially among DEN-metro device-location users — action-bias claims.
3. "Start over" rate elevated AND a second rebook within 5 minutes — receipt-trust is not landing.
4. High Screen-2 dwell + high Screen-2 abandonment — the consequence copy is misleading rather than clarifying (H2 failure signal).
5. Receipt "Save / share" near zero — users not treating the receipt as a trust asset.
6. AT-cohort completion lags sighted-default by >5pp — two-tier product.
7. High-frequency-user (>10 segments/year) median time-on-Screen-2 >20% longer than low-frequency cohort — DA Attack 2: register condescends to operators.

### Revised promotion criterion (DA §6)

Given DA's stress-test, "winner" requires (data, not opinion):

| # | Criterion | Source |
|---|---|---|
| 1 | Self-service completion +≥10pp AND high-frequency cohort time-on-Screen-2 not >20% longer than low-frequency cohort | UXR §4 + DA Attack 2 |
| 2 | Path distribution shifts ≥10pp AND regret-call rate within 48h stays flat | BS H2 |
| 3 | Eligible-claim +≥25% AND claim-then-cancel stays flat AND modeled voucher spend within ops/finance envelope | BS H3 + DA Attack 4 |
| 4 | AT-cohort completion within 5pp of sighted cohort | UXR §4 + A11y §9 |
| 5 | Canonical-scenario coverage ≥75% of post-launch disruption events; multi-leg/multi-booking/multi-party cleanly routed | DA Attack 1 |
| 6 | Regulatory verbatim coexists with the operational register on Credit variant without inducing a Screen 3 call-rate bump | DA Attack 3 |

5/6 hit: ship and defend. 4/6: ship with a named gap. ≤3/6: refuse to call it a win.

---

## 9. Scorecard-ready comparison against the single-agent baseline

Per the runbook (10-clean-room-experiment-runbook.md), **scoring against the baseline runs only after both runs are sealed**. This team has not opened or read the baseline. This section is the scaffold the scoring pass will use.

| Dimension | Team output (this run) | Single-agent baseline (to be scored) |
|---|---|---|
| Artifact type | Authored HTML prototype (1675 lines, single self-contained file) + 9-section recommendation memo + 9 role reports preserving dissent | TBD — same artifact type per `03-single-agent-baseline-prompt.md` |
| Wall time | ~33 minutes (clean-room run start to commit) | TBD |
| Visible debates with preserved dissent | 3 named debates (party-size, Screen 2 default, together-vs-adjacent), each with positions, resolution, and preserved dissent. Plus DA's belief-1 critique addressed in §5 amendment. | TBD |
| Handoffs that changed the artifact | 8 named handoffs in §4. Two non-author-driven artifact shifts (party-size synthesis; A11y+BS revision pass). | TBD |
| Accessibility blockers caught | 8 (A11y B1–B8); all addressed in the revision pass. Layer-0 floor passes. | TBD |
| Behavioral / trust risks named | 6 dark-pattern risks audited; 3 conditional fixes (BS); 5 falsifiable experiments; 5 trust failure modes with prevention rules; 1 deliberately-added friction point (eligibility gate). | TBD |
| Visual distinctiveness | Three CD-named moves (operational header, stacked-paths-as-design, persistent strip with status). Warm-bone palette, single accent, type-as-hero. No Bootstrap tells. | TBD |
| Decision quality (DA-tested) | Five attacks stress-tested; "what I would NOT change" list defended; pre-mortem with three ranked failure stories; revised promotion criterion (6 hurdles). | TBD |
| Human edits needed before sharing | The final-recommendation.md is meeting-ready; the prototype is meeting-projectable; the role reports are direct artifacts (not summaries) per Anthropic guidance "preserve direct artifacts from teammates." | TBD |

**Scoring note for the lead:** when both runs are sealed, score blind to process per `11-evaluation-system.md` §"Blind Evaluation Workflow." Reveal which output is team vs. baseline only after Layer 1 outcome scoring is complete.

---

## 10. Run metadata + clean-room verification

### Branch and commit
- **Branch:** `experiment/northstar-team-20260514-0059`
- **Starting commit:** `80e8000` (HEAD at run start)
- **Final commit:** *(set by the commit that seals this run; will be `git rev-parse HEAD` after the team-deliverables commit lands)*
- **Main branch:** `main`

### Timing
- **Start (UTC):** 2026-05-14T07:05:34Z
- **End (UTC):** 2026-05-14T07:39:09Z
- **Wall time:** ~33 minutes 35 seconds (lead orchestration + 8 teammate runs + 1 VD revision pass + lead synthesis)

### Model and harness
- **Lead orchestrator:** claude-opus-4-7[1m] (Claude Opus 4.7, 1M context)
- **Teammates:** project-scoped subagent definitions in `.claude/agents/` (copied from `claude-agents/` per the runbook); each spawned via the Agent tool, with messages between agents either passed through the lead's prompts (visible handoffs) or via SendMessage for resumption-based round trips (CD sign-off).
- **Working directory:** `/Users/brittonstanfill/agent-team-experiments/northstar-20260514-0059-team`

### Teammates run (in order)
1. Creative Director — anchor briefing
2. UX Researcher — needs + emotional state (parallel with IA)
3. Information Architect — flow structure (parallel with UXR)
4. Visual Designer — authored prototype
5. (CD sign-off via SendMessage round trip — approved with one standing concern about the "Why?" link, carried into synthesis and resolved by CW)
6. Interaction Designer — state model + microinteractions (parallel with CW)
7. Content Designer — voice + screen strings (parallel with IxD)
8. Behavioral Scientist — choice-architecture audit (parallel with A11y)
9. Accessibility Specialist — WCAG + AT audit (parallel with BS)
10. Visual Designer (revision pass) — A11y B1–B8 + BS §2.1 fixes (SendMessage to original VD agent; consolidated punch list; 15 fixes shipped)
11. Devil's Advocate — stress-test of consensus (parallel with VD revision; DA tool set excludes Write, so lead persisted DA's output verbatim to the role-reports file)
12. Lead — final synthesis (this document)

### Replacements and nudges (per Anthropic's "monitor and steer" guidance)
- **No teammate was replaced.** All eight role agents + the optional Devil's Advocate completed their assigned work.
- **One agent was resumed mid-run:** the Creative Director, via SendMessage, to do sign-off on VD's authored direction. CD signed off with one standing concern about the "Why?" link (resolved downstream by CW cutting the link on principle).
- **One agent was resumed for a revision pass:** the Visual Designer, via SendMessage, to apply the consolidated A11y + BS punch list. 10 must-fixes + 5 should-fixes shipped. Layer-0 floor passes post-revision.
- **One scope nudge:** the lead consolidated A11y's 8 blockers, BS's 3 conditional fixes, and BS's biggest concern (Screen 2 default-state) into a single VD revision pass rather than three separate handoffs — this saved a round trip but is logged here as a coordination decision rather than a teammate failure.
- **One tooling note:** the Devil's Advocate agent type in this kit has Read / WebSearch / WebFetch tools only — no Write. The lead persisted DA's chat output verbatim to `09-devils-advocate.md` with a note explaining the persistence path. This is not a model failure; it is an intentional capability restriction on a contrarian agent, and the workaround is transparent.

### Clean-room checks (pre-run, verified at HEAD `80e8000`)
- `git rev-parse --short HEAD` → `80e8000` ✓ (≥ specified)
- `find demo-output -type f ! -name .gitkeep -print` → empty ✓
- `.claude/agents/` → contains 9 project-scoped role agent definitions ✓ (accessibility-specialist, behavioral-scientist, content-designer, creative-director, devils-advocate, information-architect, interaction-designer, ux-researcher, visual-designer)
- No baseline outputs read by the lead or any teammate during the run ✓
- No prior demo branches read (no `demo/northstar-final-recommendation`, no `demo/single-agent-baseline`) ✓
- No PR #2 inspection ✓
- No screenshots from prior runs read ✓
- Each teammate prompt explicitly forbade reading anything in `demo-output/` beyond its own input set ✓

### Files sealed by this run

```
demo-output/
├── final-recommendation.md   (this document)
├── prototype/
│   └── index.html            (authored mobile prototype; passes Layer-0 a11y floor post-revision)
└── role-reports/
    ├── 01-creative-director.md
    ├── 02-ux-researcher.md
    ├── 03-information-architect.md
    ├── 04-visual-designer.md         (original report + revision-pass addendum)
    ├── 05-interaction-designer.md
    ├── 06-content-designer.md
    ├── 07-behavioral-scientist.md
    ├── 08-accessibility-specialist.md
    └── 09-devils-advocate.md         (persisted by lead from DA chat output; no content edits)
```

### Honest scorecard notes (per the kit's post-mortem improvements)

- The team produced more text than a single agent would have. Whether the text translated to a better artifact is what the scoring pass will determine; this run does not declare a winner.
- DA's belief-1 critique — "visible deliberation produced design changes" — was partially earned and partially over-generous. Of three named debates, only Debate #1 (party-size) directly changed the prototype before consensus formed. Debate #2 (Screen 2 default) changed the prototype *after* consensus, via the revision pass driven by BS+A11y. Debate #3 (together-vs-adjacent) ratified an existing call. The post-revision state is the second clear non-author-driven shift, named in §5.
- The team did NOT produce a separate authored mock for the Credit-variant Screen 3 and the Standby-variant Screen 3. The annotation under Screen 3 names what changes. This is a known and stated gap.
- The team did NOT model voucher-spend at H3's claim-rate threshold. DA's Attack 4 names this gap; §6 lists ops/finance sign-off on the envelope as a condition for ship.
- The team did NOT consult an airline regulatory counsel on DOT cancellation/refund verbatim. DA's Attack 3 names this gap; the 48-hour falsification test is in §7.
- The team did NOT confirm engineering's state-by-state ship confidence. DA's Attack 5 names this gap; the 30-minute pre-launch conversation is in §7.

These gaps are recorded honestly rather than buried.

---

*End of synthesis. The prototype at `demo-output/prototype/index.html` is the executed design. This memo is the case for it.*
