# Process Appendix

## 1. What each role contributed

**Information Architect.** Set the user-job spine (understand → choose → get support → leave with confidence) and the five-screen sequence. Established the SMS rewrite, the no-pre-selection rule on S2, the "support as peer block on S4, teaser on S1/S2" structural move, the labelled-button copy inventory, and a labelled-claim discipline (observed / inferred / assumption / recommendation) carried through the whole run. Named scoped gaps the design could not resolve from the brief alone: cash refund (no policy), session resumability, image-light render mode, multi-passenger seating data.

**Visual / UI Designer.** Authored the prototype HTML from a clean canvas. Established a restrained token system (one accent, two type weights, structural whitespace), built five stacked screens that resolve to one column at 390px and a vertical document on desktop, used color only for state (canceled, confirm, caution) and never as decoration, and refused to chrome every paragraph. Held the line on no invented data — every dynamic field is `{system-supplied}`. Ran the responsive proof at top level before sealing.

**Accessibility Specialist.** Audited the prototype with blocking authority. Returned 5 BLOCKERS, 8 SHOULD-FIX, 6 NICE-TO-HAVE. The most consequential finding was the broken `role="list"` + `role="listitem"` pattern on `<button>` elements on the two highest-stakes decision screens (S2 option cards and S3 flight cards), which would have made the choices announce as passive list items to screen-reader users. Also caught: no flight-button accessible name; 40px tap targets on support toggles; `role="status"` on a static banner that would double-announce; consistency floor (3.2.4) violated by mixed agent-affordance labels.

**Behavioral Scientist.** Audited with blocking authority. Returned 2 BLOCKERS, 5 SHOULD-FIX, 3 NICE-TO-HAVE. The most consequential finding was an invented entitlement claim on S5 — the prototype was asserting "Hotel and meal support confirmed where the system says you qualify" regardless of whether the user actually opted in. The second blocker was a commitment-clarity failure on S4: the primary button read "Confirm new flight and support" even when the user had not opened the support items, writing a check the toggle UX could not verify. Also defended the design's pro-user nudges (no pre-selection, persistent agent path, reasoned badges) and proposed the primary falsifier: 24-hour follow-up call rate among self-service completers.

## 2. Handoffs that changed the artifact

- **IA → Visual Designer.** The IA's section-6 punch-list (screen-by-screen content blocks, button labels, NOT-list) was built from directly. The "support as peer block on S4" structural call changed how the prototype was composed — without it, support would have stayed in a footer.
- **A11y → Visual Designer.** All five blockers translated to specific HTML changes: role-attribute removals, group-landmark + heading wrappers, sentence-form `aria-label`s on flight cards, tap-target heights, removal of `role="status"`. Plus shipped SF2/SF3/SF5/SF7/SF8 in the same surgical pass.
- **Behavioral → Visual Designer.** S5 invented-confirmation language was deleted and replaced with a conditional render pattern (visible `data-render` annotations, an HTML comment naming the rule, and a single neutral example item). S4 primary button copy became dynamic ("Confirm new flight" → "…and hotel" → "…and hotel + meal") and a commit-hint line was added under the button row. Travel-credit consequence copy was extended to name the give-up plainly without inventing policy.
- **Behavioral → final recommendation.** The 24-hour follow-up call rate became the primary falsifier in the experiment plan. Behavioral's measurement-plan table (section 10 of their role report) seeded the guardrail set.

## 3. One debate and preserved dissent

**Debate: Behavioral Blocker 2 — fix path for S4 commitment ambiguity.**

The conflict was concrete. The prototype's S4 primary button read "Confirm new flight and support" — a conjunction that implied the user had reviewed support, even when the support toggles had not been opened. Behavioral named this as a commitment ambiguity that exploits fatigue.

**Position A (Behavioral's preferred fix, taken):** dynamic button copy. The button defaults to "Confirm new flight" and grows to "Confirm new flight and hotel," "…and meal," or "…and hotel + meal" as the user opts in. The button names exactly what was authorized. Anchored in the IA's named-commitment principle.

**Position B (Behavioral's fallback, partially preserved):** keep the conjunctive "Confirm new flight and support" copy but make the toggle state visually unambiguous (Added / Not added pills) and add an explicit "Reviewed — not needed" affordance the user must touch.

**Resolution.** We shipped Position A. The Visual Designer also kept the "Added"/"Not added" pill pattern from Position B as a composing signal — pills tell you the toggle state; the button copy tells you what you are about to commit to.

**Preserved dissent.** Position B is simpler to implement (static copy, no dynamic template) and matches users' learned expectation that button labels do not mutate. A user demonstrating the prototype to a colleague who looks away may not notice the button has changed text. Position A's win is honesty about commitment; Position B's win is predictability. The dissent is real, and if the A/B telemetry shows users mis-pressing the dynamic button or hesitating on it, Position B becomes the rollback target — not the legacy "Continue."

## 4. Lead red-team checklist (run personally; not delegated)

**Q1. What is the strongest opposing design that does not use this flow?**
A single-screen "auto-recovery" card: the airline picks the highest-confidence rebooking, auto-applies hotel support if eligible, and asks "Yes, do this" or "No, show me options." It minimizes taps and acknowledges that Northstar caused the disruption, so Northstar should absorb the decision burden. Weakness: it removes user agency for the segment whose actual job is "get to a specific event" — for them, the auto-pick is often wrong. We rejected the auto-recovery model but borrow from it: defaults are aligned with the most-common user job (earliest arrival), and the back-out cost is low.

**Q2. Which early framing choice is the team anchoring on?**
The frame "the user wants to self-serve." That frame may be wrong at 10:46 p.m. for some users — fatigue + caregiving + agency depletion can mean the right answer is "an agent calls *you*." The persistent agent affordance partially compensates, but does not refute the anchor.

**Q3. What hidden assumption would make the recommendation fail?**
Two:
(a) That users have bandwidth and trust to load the recovery page at all. If the SMS link is the failure point (deep-link auth, captive-WiFi captive portal, low-bandwidth render), the redesign behind it is invisible.
(b) That hotel/meal *eligibility* is materially common. If most disrupted users are not eligible, the support surfacing buys honesty but not entitlement — and the metric ("support uptake among eligible users") may be a small denominator.

**Q4. What user segment is under-modeled?**
Refund-seekers (no policy path designed); unaccompanied minors (off this surface entirely); multi-leg international with downstream-visa or connection failures; non-English speakers (English-only prototype); first-time fliers who do not know what "standby" means even with the corrective copy. The first two are named in the final recommendation as scoped gaps.

**Q5. What metric would prove the flow reduced calls by hiding help?**
24-hour follow-up call rate among self-service completers, segmented by call topic. If call volume drops and follow-up calls rise with topics dominated by "I didn't know I could ask for X," the redesign reduced calls by salience suppression. This became the primary falsifier in the experiment plan.

**Q6. What would a frustrated user quote in a complaint if this shipped?**
"The app made me pick a flight, but never told me I could get a refund."
"I confirmed and it said I was rebooked, but no one told me about a hotel until I got to baggage claim."
"I clicked the flight to read more, and it committed me without asking."
"It said the support button text would 'update' — I didn't see it update so I didn't think anything was added."
The first quote drove the explicit "cash refund" scoped gap. The fourth shaped the preserved dissent in section 3.

**Conversion to recommendation:** Q5's answer is the primary falsifier in the experiment plan. Q4's refund-seeker and non-English-speaker observations are scoped gaps named in the final recommendation. Q6's fourth quote is the rollback signal for the Position-A-vs-B preserved dissent.

## 5. Key tradeoffs and rejected alternatives

- **Five screens vs. one consolidated screen.** Considered collapsing S3 and S4 into a single "pick + review" surface to reduce taps. Rejected: at 390px the combined block fails the above-fold test for the support panel, which is the load-bearing trust move.
- **Tabs vs. peer cards on S2.** Rejected tabs because tabs hide siblings and re-introduce the pre-selected-default failure mode from the current flow.
- **"Recommended" badge.** Rejected as a bare label; allowed only as a reasoned label ("Earliest arrival," "Nonstop," "No extra cost").
- **Auto-applying hotel support if eligible.** Rejected — opt-in is required because eligibility is not the same as user need (e.g., user is being picked up by family).
- **Pre-commit summary block on S4 (Behavioral NH3).** Rejected for this iteration because the S4 stack already shows flight summary, support pills, and "What changes" above the commit button; adding a separate review block would push primary below the fold at 390px. The dynamic button copy carries the pre-commit-clarity job.
- **Countdown / urgency UI.** Never introduced. The user already has urgency; the app should not add to it.
- **Social-proof badges ("most travelers picked this").** Never introduced.

## 6. Compact-slate overhead notes

**Slate used:** four teammates — IA, Visual Designer, Accessibility Specialist, Behavioral Scientist. No Creative Director, no Content Designer, no Interaction Designer, no Devil's Advocate spawned. Lead ran the red-team checklist personally.

**What the four-role slate did well:**
- Distinct lenses on distinct artifacts. No teammate overlap; every role report changed the artifact.
- Audits in parallel after a single authored draft kept wall time tight.
- One surgical revision pass absorbed both audits cleanly.
- Lead personally ran the red-team checklist; one answer (Q5) became the primary falsifier in the final recommendation, and two answers (Q4, Q6) seeded scoped gaps and the preserved dissent.

**What the four-role slate paid for in absence:**
- No dedicated Content Designer. Copy work was distributed: IA wrote the SMS rewrite and button-label inventory; Behavioral wrote the travel-credit consequence copy; Visual Designer drafted screen copy from the punch-list. Result is consistent but the *voice* polish a content designer brings is missing — some lines (the support-link lead, the commit-hint) could be tightened by half.
- No dedicated Interaction Designer. Two runtime behaviors are flagged as engineering assumptions rather than designed: S3 → S4 non-destructive back, and S4 dynamic button-copy state transitions. If a Position-A-vs-B telemetry signal goes the wrong way, the absent specialist is the gap.
- No Devil's Advocate. The lead's red-team substitute caught the Q5 falsifier and the Q4 scoped gaps. It probably missed at least one steel-manned opposing-design argument that a dedicated DA would have surfaced.

**Lead-time overhead notes.**
- IA → Visual Designer handoff: clean, no nudges required.
- A11y and Behavioral audits ran in parallel; no coordination friction.
- Surgical revision pass needed one consolidated brief from the lead (which audit items were blockers, which SHOULD-FIX to ship, which to defer with reason).
- One teammate (Visual Designer) was nudged with a defer-or-ship list for the SHOULD-FIX items. No teammate had to be redirected mid-task.
- No extra specialist was spawned. If the run had spawned one, it would be recorded here as an escalation and the run would be scored against the lean slate.

**Failure modes the slate did not catch (named for the next loop).**
- Constraint-integrity walk in the *original draft* missed the S5 invented-confirmation language. Behavioral caught it on audit, not Visual Designer in self-review. A pre-audit lint or an authoring-time checklist could catch invented entitlement claims before they reach an audit pass.
- Refund-seeker as a first-class option card was not designed (kept as scoped gap). If the user research disposition is that refund-seekers are a major segment, the four-role slate plus the brief was insufficient to address it.
