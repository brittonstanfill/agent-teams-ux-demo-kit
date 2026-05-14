# Behavioral Scientist — Northstar Canceled-Flight Recovery

A tired traveler at 10:46 p.m. is in a state of cognitive depletion: limited working memory, low tolerance for ambiguity, high reliance on defaults and salience cues, and prone to satisfice on whatever the screen seems to recommend. Northstar caused this disruption. The behavioral question is not "how do we get them through the funnel" — it is "how do we let a depleted user reach a decision they'll endorse tomorrow morning, without the airline absorbing the difference in their stress."

I audited `demo-output/prototype/index.html` against IA §1–6, VD §1–8, and the brief's no-invention constraint. I limited evidence-gathering to that file and the two upstream reports.

Claim labels used: **[observed]** (read directly from the prototype file), **[inferred]** (a behavioral consequence I read into the prototype without testing it on users), **[recommendation]** (a design call I am making), **[assumption]** (working premise that should be validated).

---

## 1. Top-line verdict

**Ship after blockers fixed.** Two BLOCKERS, both small-surface fixes. Five SHOULD-FIX. The prototype is, on the whole, a careful piece of choice architecture: no pre-selection on S2, no bare "Recommended," persistent agent handoff, named commit buttons, no invented voucher amounts or hotel names. The blockers below are not philosophical — they are specific copy and visual-weight moves that, left in, will erode trust under fatigue.

---

## 2. BLOCKERS

### BLOCKER 1 — Invented entitlement claim on S5 outcome subhead

**Mechanism:** false-default + manufactured-certainty. The outcome subhead states a result the prototype has no basis to claim, and the user has no way to verify in the moment.

**Location:** `index.html` line 1246, S5 outcome block. **[observed]**

> "Tomorrow, 7:10 a.m. from DEN. **Hotel and meal support confirmed where the system says you qualify.** References below."

**The problem:** the prototype reaches S5 unconditionally — there is no branching on whether the user actually added hotel support or meal support on S4, and there is no system signal that they qualify. The S5 confirmed-support panel beneath this subhead then displays *both* hotel and meal as confirmed (lines 1280–1294), with reference numbers. **[observed]** A user who declined one or both, or who was not eligible, sees a confirmation that asserts they are. IA §2 Screen 5 was explicit: "Support confirmation: hotel booked (if so)... If it was offered but declined, do not re-pitch." **[observed from IA report]** This goes further than re-pitching — it asserts a confirmation that may not exist. That is an invented entitlement claim, which is exactly the constraint the brief flags. **[observed: brief lines 99 + 101]**

**Required change:** the S5 outcome subhead and the S5 support panel must both be conditional on the S4 user action and the `{system-supplied}` eligibility flag. Acceptable patterns:
- If the user added neither: the subhead omits the support sentence; the support panel is absent.
- If the user added one: only that one appears; the subhead names only the one.
- If the system returned "not eligible" for an item the user requested: the panel shows that decision honestly with a plain reason, *not* by silently dropping the line.

Until support outcomes are state-driven, the safest minimum is to remove the "Hotel and meal support confirmed where the system says you qualify" sentence from line 1246 entirely, and replace the populated support items on lines 1280–1294 with a single neutral placeholder pattern wrapped in `{if user added support}` — making it visible to reviewers that this section is conditional, not asserted by default. **[recommendation]**

### BLOCKER 2 — Silent commitment on S4 support toggles

**Mechanism:** friction asymmetry + commitment ambiguity. The "Add hotel support" and "Add meal support" buttons read as in-place toggles (per VD §2 they are styled as "secondary commitments inside a card"), but the primary commit button is "Confirm new flight **and** support." The conjunction in the primary button asserts the user has reviewed support; the toggles do not visibly indicate state. A depleted user can press "Confirm new flight and support" without having opened either support item, and the button's copy implies they've handled it. **[observed: button copy line 1225; toggle buttons lines 1200, 1210]** **[inferred: state ambiguity from a static prototype is the right place to flag this before it ships]**

**Required change:** one of the following.
- (Preferred) Change the S4 primary button copy to dynamically reflect what the user actually opted into: "Confirm new flight" (default), "Confirm new flight and hotel," "Confirm new flight and hotel + meal." The user signs for what they did, not for what the button vaguely encompasses. **[recommendation, anchored in Fogg-prompt clarity and SDT-autonomy]**
- (Acceptable fallback) Keep the conjunctive copy, but make the toggle state visually unambiguous on the support items — a clear "Added" / "Not added" status next to the title, and require the user to acknowledge each as reviewed (a small "Reviewed — not needed" affordance is fine; silence-as-consent is not). The button name should not write a check the toggle UX can't verify the user signed.

Either way: the back-button behavior between S4 and S3 must remain non-destructive (IA §2 specified this; the prototype is static so I cannot verify the behavior, but I flag this as a runtime requirement). **[recommendation]**

---

## 3. SHOULD-FIX

### SF1 — "Travel credit" card under-names the give-up

**Mechanism:** present-bias + ambiguity-aversion. A tired user reading "Cancel this trip and use the value toward a future Northstar flight" may not register that *they will not get to the family event tomorrow*. The card's consequence sentence names the trade in airline terms (value → future flight), not in user-job terms (you are not flying tomorrow; the event happens without you). **[observed line 1064]**

**Recommendation:** extend the consequence line to name the user-job give-up. Suggested behavioral target for content-designer to write to: *"Cancel this trip and use the value later. You will not be rebooked, and no flight is held for you. Expires: {system-supplied}."* The expiration field is already wrapped as `{system-supplied}` and that is correct — do not invent a window. **[recommendation]**

### SF2 — The S2 support-link tile is too quiet given its job

**Mechanism:** salience under fatigue. VD §5 deliberately styled the S2 "See tonight's support" link as quieter than the option cards. **[observed VD report]** I see the reasoning — the user's primary job on S2 is to pick a path — but the brief's central failure mode is that *users currently pay out of pocket because support is hidden*. **[observed brief lines 75–78]** A dashed-border row, ink-quiet text, no accent color, no icon (line 1077 in the prototype) is closer to a footer link than a peer prompt under fatigue. **[inferred]**

**Recommendation:** keep it visually subordinate to the three option cards, but lift it above the floor — either add an accent dot/icon mark on the left (matching the visual language of the S1 "Tonight" row), or shift the border from dashed-hairline to solid-hairline so it reads as a real container, not a placeholder. Do not promote it to an option card; do not make it primary. The bar to clear is: a depleted user scanning the screen sees that support exists before they tap into a flight choice. **[recommendation; anchored in salience theory + the brief's load-bearing constraint]**

### SF3 — S1 "Tonight" line is the right idea, wrong placement under the fold risk

**Mechanism:** primacy-recency, viewport fatigue. The S1 stack lists Reason → What this means → Tonight, in that order. **[observed lines 1004–1031]** On a 390px viewport, with the warn-tinted canceled banner taking 80–110px, the "Tonight" row may sit at or below the viewport fold before the primary button. **[inferred from the layout; I did not run a viewport probe but VD §7 reports fit, not fold position]** A user who taps "See my options" without scrolling never sees that support exists tonight.

**Recommendation:** verify on a 390px viewport that the "Tonight" row is visible *above* the primary button without scrolling. If it is not, either (a) move it above the "Reason" row (rationale: under fatigue, a system-supplied reason is less actionable than knowing help is coming), or (b) inline the support teaser into the status banner itself as a one-line addendum. **[recommendation; conditional on viewport measurement]** Defer the actual measurement to interaction-designer/visual-designer — but make it a gate, not a hope.

### SF4 — Sort default is correct *but* the "Change sort" affordance is too quiet to be honest

**Mechanism:** transparency of nudge. VD line 1104 displays `Sorted by **earliest arrival**. <span class="quiet">Change sort</span>`. **[observed]** The phrase "Change sort" is rendered as quiet-gray text with no underline, no button affordance, no icon. A user fighting decision fatigue will read the sentence and assume the sort is fixed. That makes the default a hidden nudge rather than a transparent one. The default itself is defensible (see §5 below); the *visibility of opt-out* is not.

**Recommendation:** style "Change sort" as a clearly tappable link or button — accent color, underline on hover, or a small caret/icon. The behavioral standard for a defensible default is: the user can see, in one glance, that the default is a choice. **[recommendation; anchored in Sunstein/Thaler "publicity principle"]**

### SF5 — S3 cards have no visible "selected" state before commit

**Mechanism:** commitment clarity, peak-end. The S3 flight cards are `<button>` elements that — per IA §2 — tap to advance to S4. **[observed; IA confirms tap → S4]** That's the intended interaction; my concern is the perception. A tired user may not realize that tapping a card *commits to that flight as the selection on S4* — they may tap to "look closer." If S4 is reached and the user did not in fact want this flight, the back-button has to safely return them to S3 with the selection cleared. The prototype is static and I cannot verify this. **[observed: cannot verify from static HTML; assumption: IA's non-destructive-back rule holds]**

**Recommendation:** the tap-to-advance pattern is fine *if* the S3 → S4 transition is reversible without committing, and *if* S3 visually indicates after return that no flight was committed. If either is not the case at implementation, add an explicit "Select" affordance on each card so that "tap" and "commit" are visibly the same action. Co-design with interaction-designer; the behavioral test is whether a user can comfortably back out without anxiety. **[recommendation]**

---

## 4. NICE-TO-HAVE

- **NH1.** The S2 support-link copy "Check what's available before you commit" is a good intentional nudge against commitment-before-information. Keep it. **[observed line 1078]** No change needed; flagging as a defensible nudge worth preserving on future copy revisions.
- **NH2.** The S4 support panel sub-line "Nothing is added until you press confirm." (line 1191) is exactly the right reassurance for autonomy preservation under fatigue. **[observed]** Keep it; consider repeating a version of it next to the primary button.
- **NH3.** Consider adding a small "What you're agreeing to" expandable list above the S4 primary button — a behavioral commitment review that names the flight, support choices, and irreversibility (or lack thereof) in one place. The peak-end heuristic says the moment of commit is the moment users will remember; making it feel transparent rather than rushed is durable trust-building. **[recommendation; low-priority because the current S4 already lays out the same content, but a pre-commit summary reduces buyer's-remorse risk]**

---

## 5. Defensible nudges — places I back the existing call

These are places where the prototype is using influence intentionally and I support the call. Calling them out so that future revisions don't accidentally weaken them under the banner of "neutrality."

1. **No pre-selection on S2 option cards.** **[observed]** Three cards with identical chrome, no badged "recommended" option. The current flow's pre-selected "Travel credit" tab is a textbook default that benefits the airline (no rebooking cost, voucher liability deferred) at the user's expense. Removing it is the single most important anti-dark-pattern move in this redesign. **[observed problem from brief line 51; observed fix from prototype lines 1050–1075]**

2. **Caution-tinted reinforcement on the Standby card.** **[observed line 1073]** Color is reinforcement, not load-bearing — the copy "Standby is not the same as a rebooking. If no seat opens, you stay where you are tonight." carries the meaning. Color attention only nudges a fatigued user to read the line. This is salience used to *protect* the user from a misread, not to steer them. Defensible. **[recommendation: keep]**

3. **Order of option cards: Rebook → Travel credit → Standby.** This *is* a nudge — order anchors expectations. I back it. The user's stated goal (per brief) is to get to a family event tomorrow. Rebooking is the path most aligned with that goal; credit and standby are paths that may serve other goals but require more user judgment. Putting Rebook first matches the dominant user job. It is a defensible nudge because (a) it aligns with user-stated goals, not airline preference, and (b) all three options remain visible and identically weighted. **[recommendation]**

4. **Default sort on S3 = earliest arrival.** IA punted this to me. I defend it. The behavioral reasoning: under depletion, a user will satisfice on the first plausible option. If the default sort puts the option most aligned with the dominant user job (arriving in time for tomorrow's event) at the top, the satisfice path is the supportive path. If the default were "earliest departure" or "cheapest," the satisfice path would diverge from the user's stated goal. The assumption that "arrival time is the dominant job" is anchored on the brief's family-event context **[observed]** and is the right working hypothesis. **[assumption; should be validated post-launch]**. The transparency of the default — "Sorted by earliest arrival. Change sort." — is what makes it a defensible nudge rather than a steer. (See SF4 above for the visibility caveat.)

5. **Reasoned badges only.** **[observed lines 1114, 1131, 1132, 1149]** "Earliest arrival," "Nonstop," "Fare difference {system-supplied}," "No extra cost." Each badge names its reason; none implies airline endorsement. This is exactly the anti-dark-pattern call the brief and IA both made. **[recommendation: hold the line on future revisions; do not let a "Recommended" or "Popular" badge return without a reason.]**

6. **Persistent agent-handoff, never primary.** **[observed]** Present on S1 (line 1036), S2 (line 1084), S3 (line 1162), S4 (line 1231), S5 (line 1308). Always styled as secondary (`btn-secondary`), always reachable without scrolling past a primary CTA. The label varies appropriately to the screen state. This passes the brief's load-bearing test: the redesign reduces calls by giving better self-service, not by hiding the agent path. **[recommendation: hold the line]**

7. **Named commit buttons.** **[observed]** "See my options" (S1), "Confirm new flight and support" (S4, modulo BLOCKER 2), "Save to phone" (S5). Each button states what happens. No "Continue," no "Submit," no "Done." This is good practice and removes a known fatigue trap (button copy that asks the user to predict what comes next). **[recommendation: keep]**

8. **SMS rewrite names the event.** **[observed line 985]** "Your 6:15 a.m. flight NS482 (DEN–LGA) is canceled. You have not been rebooked yet." The "not been rebooked yet" sentence is the key behavioral move — it prevents the false-relief failure mode where users assume the airline handled it. Defensible. **[recommendation: keep]**

---

## 6. Dark-pattern audit — what I did NOT find (and what I checked)

Walked the prototype for each named anti-pattern. Recording absence as well as presence so future revisions don't reintroduce.

| Pattern | Status | Evidence |
|---|---|---|
| Forced continuity | Not observed | No subscription, no auto-renewing voucher commitment. **[observed]** |
| Confirmshaming | Not observed | No "No thanks, I'll pay out of pocket" or similar negative-self framing on opt-outs. **[observed]** |
| Roach motel (hard to back out) | Cannot verify from static HTML | Back-button behavior between S3↔S4 is a runtime concern. **[observed: structural; assumption: IA non-destructive-back rule holds]** Flagged in SF5. |
| Manipulated urgency / fake countdowns | Not observed | No countdown clocks, no "this offer expires in X minutes," no time-pressure language anywhere. The credit expiration field is `{system-supplied}`, not invented. **[observed line 1064]** |
| Drip pricing / hidden costs | Not observed | Fare difference is surfaced with a caution-tinted badge **on the card,** not after commit. **[observed line 1132]** |
| Invented voucher amounts / hotel names / wait times / eligibility windows | **One case found** — see BLOCKER 1. All other dynamic fields use `{system-supplied}` correctly. **[observed throughout]** |
| Pre-filled consent | Not observed on S2 (no pre-selection). One ambiguity on S4 commit-button conjunction — see BLOCKER 2. |
| Social proof manufactured ("most travelers pick this") | Not observed — VD §8 explicitly notes deliberate omission. Keep it omitted. **[observed VD report]** |
| Friction asymmetry (easier to commit than to back out) | Cannot verify from static HTML; flagged in SF5 + BLOCKER 2. |
| Defaults that benefit airline at user's expense | Not observed in the new flow. The previous-flow default of "Travel credit" is the canonical example; the new flow removed it. **[observed comparison: brief line 51 vs. prototype lines 1050–1075]** |

---

## 7. Constraint integrity walk — invented claims

Searched the prototype text for any claim Northstar cannot substantiate. Findings:

| Field | Status | Evidence |
|---|---|---|
| Reason for cancellation | `{system-supplied}` placeholder | Line 1011. **[observed]** Correct. |
| Credit expiration | `{system-supplied}` placeholder | Line 1064. **[observed]** Correct. |
| Hotel partner / address / distance | `{system-supplied}` placeholder | Line 1199, 1285. **[observed]** Correct. |
| Meal credit amount | `{system-supplied}` placeholder | Line 1208, 1292. **[observed]** Correct. |
| Eligibility for hotel/meal | `{system-supplied}` status field | Lines 1197, 1206. **[observed]** Correct in pattern; but see BLOCKER 1 — S5 asserts confirmation regardless of eligibility outcome. |
| Phone number | Not present | **[observed]** Correct — agent handoff is a button, not a hard-coded number. |
| Compensation amounts / rules | Not present | **[observed]** Correct. |
| Flight times (7:10 a.m., 2:48 p.m., etc.) | Hard-coded numbers | Lines 1109, 1111, 1126, etc. **[observed]** These are placeholder-flight examples, not promised data. Acceptable in a prototype. Real wiring must replace these with system data, including the layover stop label which currently uses `{system-supplied}` correctly (lines 1118, 1153). |

**Net:** one invented claim (BLOCKER 1). Everything else respects the constraint.

---

## 8. Edge case: same-night flight + support suppression

The brief's audit question: if the user picks a same-night flight that leaves in 4 hours, does the prototype still surface the hotel/meal support question, or has it been silently suppressed?

**Observed:** the S4 support block (lines 1188–1212) is unconditional in the static prototype. Both "Need a hotel tonight?" and "Need meal support?" items appear regardless of the flight selected. The eligibility status field is `{system-supplied}`, meaning the *answer* may be "not eligible" — but the *question* is still surfaced. **[observed]**

**Behavioral verdict:** correct. The decision of eligibility is the system's; the decision to surface the question is the UX's. If a user picks a same-night flight that boards in 4 hours, they may still need meal support tonight. Suppressing the question to "save them a tap" would be a dark pattern — it would assume eligibility on the user's behalf. The current pattern (always show the question; let the system decide eligibility plainly) is the right call. **[recommendation: do not let this revert to a conditional render.]**

---

## 9. Falsifier — how we would know the redesign is reducing calls by hiding help

The brief's load-bearing constraint is: reduce calls, but not by hiding help. Here are the signals that would tell us the redesign achieved the goal *by suppressing help-seeking* rather than *by enabling self-service*. If any of these trip, we should treat the call-volume reduction as a false win and roll back.

### Primary falsifier — the "stranded user" signal
**Metric:** rate of users who complete self-service (commit on S4) and then call support within 24 hours, segmented by whether they added hotel/meal support.

**Falsification threshold:** if more than ~15% of users who committed self-service call support within 24 hours, *and* the call topic is dominated by "I needed a hotel/meal and didn't realize I could ask," the redesign is hiding help by salience, not by intent. **[recommendation; threshold is a starting hypothesis to be tuned post-launch]**

### Secondary falsifiers
1. **Support uptake drop without policy change.** If hotel/meal support eligibility rates from the system are unchanged, but actual support add-rates on S4 drop relative to a control flow, the new surface is hiding the option behind hierarchy. Watch S4 telemetry: percent of users who *open* a support item vs. *add* it vs. *neither.* If "neither" is dominant for eligible users, support is not visible enough. **[recommendation]**

2. **Agent-handoff rate by screen.** The agent handoff is meant to be visible, not hidden — but visible-and-rarely-used is the success case, and visible-and-frequently-used-on-S4 is a signal. If the S4 agent-handoff button gets disproportionate clicks, users are reaching the commit screen without confidence; the upstream screens (S2/S3) failed.

3. **S2 → S5 fast-path completion time below a threshold.** If users are completing the flow in under ~90 seconds end-to-end at scale, they are satisficing under fatigue. Some of this is fine (the redesign should be fast). But a left-tail of very-fast completions correlates with regret-call follow-ups. Watch the joint distribution of completion-time and 24h-followup-call. **[recommendation]**

4. **Travel-credit selection rate spike without eligibility-loss explanation.** If users start picking travel credit at materially higher rates than the prior flow, despite the default no longer being preselected, check the consequence copy on the credit card (SF1). It may be under-naming the give-up.

5. **Qualitative: post-flow survey free-text scanned for "I didn't know I could…"** If that phrase appears for help paths the redesign surfaced (hotel, meal, agent), the surface is failing salience even when present.

### What a healthy outcome looks like
- Call volume down.
- Hotel/meal support uptake among eligible users stable or up.
- Agent handoff clicks present but flat (a floor of users who *should* call — solo passenger with mobility need, multi-leg international with visa complication — will and should).
- Post-flow trust-survey score (e.g., "I feel I understand what's happening with my trip") materially up.
- No spike in 24h-followup calls.

If call volume goes down and support uptake also goes down without a corresponding eligibility-policy change, *that is the failure mode the brief warned about.* Do not declare victory on call-volume alone.

---

## 10. Measurement plan summary

| Signal | What to track | What it tells us | What invalidates it |
|---|---|---|---|
| Self-service completion rate | % of users who reach S5 from SMS click | Funnel health | High completion + high regret-calls = false win |
| Support uptake (S4) | % of eligible users who add hotel / add meal / decline both | Whether support is surfaced enough | If decline rate is high but post-flow survey shows "didn't realize," surface is failing |
| Agent-handoff rate | Clicks on "Get help from an agent" per screen | Where the self-service surface is breaking | Spike at S4 = commit-confidence failure |
| 24h follow-up call rate | % of S5-completers who call within 24h | The brief's primary falsifier | If high *and* topic ≠ irreducible-complex-case, redesign is hiding help |
| Time-to-commit on S4 | Distribution | Detection of satisficing under fatigue | Very short times + regret-calls = friction asymmetry |
| Trust survey | Single-question post-flow: "Did this feel honest and clear?" | Subjective quality of recovery | Score divergent from objective signals = something we're not measuring |

The smallest experiment that would resolve the load-bearing question: A/B the new flow vs. the legacy flow on irregular-ops events for a 4-week window. Track the six signals above. Decision rule: ship the new flow if call volume drops AND support uptake among eligible users is stable or higher AND 24h-followup-call rate is not higher. If call volume drops but follow-up calls increase, roll back and re-audit. **[recommendation]**

---

## 11. Ethics check — would the user thank you in 6 months?

For each meaningful nudge, applying the "would the user, in clear-headed daylight tomorrow morning, endorse this decision architecture" test.

| Nudge | 6-month thank-you? | Reasoning |
|---|---|---|
| No pre-selection on S2 | Yes | User would not want a default that biased them at 10:46 p.m. |
| Card order: Rebook → Credit → Standby | Yes | Order matches their stated goal (get to the event), and all options remain visible. |
| Default sort = earliest arrival on S3 | Yes (conditional on SF4 fix) | Aligns with their dominant job; transparent change-sort affordance lets them opt out. |
| Caution-tint on Standby copy | Yes | Protects them from a misread under fatigue. |
| Surfacing support before commit | Yes — this is the highest-confidence pro-user move in the design. |
| Persistent agent handoff | Yes | They retain autonomy; the path to a human is always one tap. |
| Named commit buttons | Yes | They know what they're agreeing to. |
| S5 outcome claiming support confirmed (BLOCKER 1) | **No** — they would feel manipulated when they discover the support was not actually confirmed. Hence blocker. |
| "Confirm new flight and support" without verified review (BLOCKER 2) | **Probably no** — if they bypassed support and feel buyer's-remorse, the button copy will read as having claimed an action they didn't take. Hence blocker. |

---

## 12. Open notes for teammates

- **For content-designer:** SF1 (travel-credit copy expansion) and BLOCKER 2 (dynamic commit-button copy) are content moves. The behavioral target for SF1 is to *name the user-job consequence* (not flying tomorrow) without inventing policy.
- **For interaction-designer:** SF5 (back-button safety) and BLOCKER 2 (toggle state) need state-design at implementation. The behavioral target is: a depleted user can press back without anxiety, and the commit button never names an action the toggle UX can't verify.
- **For visual-designer:** SF2 (S2 support-link salience) and SF4 (Change sort affordance) are visual-weight calls. The behavioral target is: a tired user scanning the screen can see, in one glance, that support exists and that the default sort is changeable.
- **For accessibility-specialist:** any friction added per BLOCKER 2 must be accessible. A "Reviewed — not needed" affordance has to be reachable by screen reader without a separate cognitive load. Co-design.
- **For the team lead:** the constraint-integrity walk found one invented claim (BLOCKER 1). I am holding the line on that as a hard block per the brief. The other six items are SHOULD-FIX or NICE-TO-HAVE; if time forces a triage, fix BLOCKER 1, BLOCKER 2, SF1, and SF4 before ship. SF2, SF3, SF5 can land in the next iteration if measured.

---

## 13. Files

- `/Users/brittonstanfill/agent-team-experiments/northstar-20260514-0448-topproof-team/demo-output/role-reports/behavioral-scientist.md` — this report.
- Read-only references: `demo-inputs/northstar-canceled-flight-brief.md`, `demo-output/role-reports/information-architect.md`, `demo-output/role-reports/visual-designer.md`, `demo-output/prototype/index.html`.
