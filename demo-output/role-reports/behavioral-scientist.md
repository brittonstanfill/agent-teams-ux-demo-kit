# Behavioral Scientist Report — Canceled-Flight Recovery

Scope: behavioral and trust audit of the five-screen prototype. Blocking authority on choice architecture, coercion, dark-pattern risk, and falsifiability.

---

## 1. Audit method

Framework stack applied:

- **Fogg Behavior Model (B = MAP)** — for each target behavior in the flow, ask: is Motivation, Ability, or Prompt the binding constraint? Most disruption-recovery flows fail on Ability (the user can't find the option) or Prompt (the screen doesn't ask the right question at the right moment), not Motivation.
- **Choice architecture audit** — for every screen, list the visible options, the default(s), the cost of each path, and whether any path is harder to take than its peers. Flag friction asymmetry where backing out costs more than committing.
- **Dark-pattern catalog sweep** — forced continuity, confirmshaming, roach motel, hidden costs (drip pricing), manipulated urgency / scarcity, sneaky default consent, hidden cancellation paths, euphemized denials.
- **Trust-under-stress filter** — every copy block read as a tired person at 10:48 p.m.: would I trust this, or does it smell like marketing?
- **Falsifiability test** — for the redesign's headline claim ("fewer support calls"), what observation would prove the redesign hid the call button rather than helped?

Target behaviors I audited against:

1. Read the cancellation status correctly within 10 seconds of opening the link.
2. Pick a recovery path (rebook / refund / credit / standby) that genuinely matches the user's situation, not the one the screen steers toward.
3. See and act on entitlements (hotel, meals) the user qualifies for, without hunting.
4. Reach a human within two taps if the self-service path doesn't fit.
5. Leave the flow with an offline-readable summary of the next 24 hours.

Behaviors I am *not* auditing: visual aesthetics (visual designer's domain), accessibility scaffolding (accessibility specialist's domain), policy correctness (legal / content owners).

---

## 2. BLOCKERS

These must change before sealing. Each has a behavioral mechanism, location, fix, and severity.

### B1. Pre-selected flight on Screen 3 is a steered commitment, not a view default

- **Behavioral risk**: a tired user under decision fatigue is anchored to the option already marked "Selected." This isn't a filter view preference (which can defensibly be pre-set) — it's the actual recovery commitment the user is about to confirm. Pre-selecting a specific flight collapses an active choice into a passive accept. This is the classic *forced default* dark-pattern shape, and Screen 2's "no default option" rule loses its meaning if Screen 3 quietly re-introduces a default at the next step.
- **Exact location**: Screen 3 (Decide the details), middle flight card. `role="radio" aria-checked="true" aria-pressed="true"` on the 2:40 p.m. nonstop. The visible "Selected" mark and `--action-100` tinted background reinforce the default visually.
- **Mechanism of harm**: anchoring + status-quo bias under fatigue. Once a default is shown as "Selected," the cost of choosing differently is no longer "pick one of three" — it's "deviate from what the system already chose for you." Under stress, users accept system defaults at substantially higher rates than they would have chosen the same option from a neutral list. The business reads this as "satisfaction with the recommendation"; the user often experiences it as "I just took what was offered because I was tired."
- **Required fix**: ship Screen 3 with **no flight pre-selected**. All three `aria-checked="false"` / `aria-pressed="false"`. The primary "Review and confirm" button stays disabled (or surfaces a "Pick a flight first" affordance) until the user actively picks one. Sort by earliest arrival is fine; visual emphasis on one card is not. Apply the same rule the recovery-options screen already follows: force an active choice when the choice has consequences.
- **Severity**: blocker. This is the single largest dark-pattern risk in the flow and directly contradicts the "no default selection on Screen 2" rule that the rest of the team committed to.

### B2. Scarcity cue ("Only 3 seats left") sits on the pre-selected flight and amplifies coercion

- **Behavioral risk**: scarcity framing is a legitimate signal when it reflects real inventory and is shown neutrally. It becomes coercive when it appears (a) only on one option, (b) on the option the system has already pre-selected, and (c) at the moment of commitment. The combined effect is "the screen has chosen for you AND the choice is running out." That is manufactured urgency in everything but name.
- **Exact location**: Screen 3, middle flight card, `<span class="seats">Only 3 seats left</span>`, rendered in the `--notice` hue.
- **Mechanism of harm**: loss aversion stacked on top of status-quo bias. The user already has to overcome the pre-selection (B1); now backing out also feels like losing a scarce resource. Even if the seat count is true, the *placement* converts a fact into a pressure cue.
- **Required fix**: two acceptable paths. Either (a) remove the seats-remaining cue entirely from the disruption-recovery context — fare and inventory pressure don't belong in a flow where the carrier caused the disruption; or (b) keep it but apply it neutrally to every flight where it's true, never only on the pre-selected one, and pair it with a non-scarcity neutral fact for any flight where seats are plentiful. My recommended path is (a): in a cancellation flow caused by the airline, seat scarcity on rebook options is the airline's problem, not a signal we should be passing to the user as urgency.
- **Severity**: blocker if shipped alongside B1; high-severity recommendation if B1 is fixed and the cue is moved off the (no-longer-default) selection. Either way, the *combination* of pre-select + scarcity on the same card must not ship.

### B3. Support consent checkbox is pre-checked on Screen 3 with unstated terms

- **Behavioral risk**: the toggle "Yes, include any support I qualify for" is pre-checked with `<input type="checkbox" id="accept-support" checked />`. Pre-checked consent boxes are dark-pattern shaped *by default*, even when the underlying offer is good for the user. The shape teaches users that the airline pre-checks things on their behalf, which erodes trust the next time something less benign is pre-checked.
- **Exact location**: Screen 3, `.toggle-row` block inside `.support-block`.
- **Mechanism of harm**: this one is subtle because the consent is pro-user (enrolling you in entitlements you're owed). But the *pattern* of pre-checked consent normalizes the same pattern for non-benign cases (marketing opt-ins, paid add-ons). Two failure modes: (a) regulatory / trust risk if any downstream item the user "qualifies for" carries a cost or commitment the user didn't see; (b) the explainer "You can decline specific items on the next screen" pushes the real consent moment one screen further, which means a tired user who taps Confirm has consented to a bundle they never saw itemized.
- **Required fix**: invert the model. The default state is the system *will* check eligibility (no consent needed for eligibility checking — it's part of the recovery). The consent moment moves to Screen 4 (Review and confirm), itemized: "Hotel support — accept / decline," "Meal support — accept / decline." Each item presented as a clear active choice on the review screen with the specific entitlement named (even if the value is "to be confirmed"). Remove the pre-checked checkbox from Screen 3. The support block stays; the consent gate moves.
- **Severity**: blocker. Pre-checked consent is a named dark pattern and should never ship even when the intent is benign. The fix is structural, not cosmetic.

### B4. "Sorted by earliest arrival" plus a pre-pressed "Arrive by 3 p.m." chip pre-commits the user's arrival constraint

- **Behavioral risk**: the filter chip "Arrive by 3 p.m." is rendered pre-pressed. Combined with the sort ("Sorted by earliest arrival"), the screen presents a specific arrival-time goal as the user's goal — but we don't actually know the user's required arrival time. The brief says they're "trying to get to a family event the next day"; that doesn't fix a specific clock time. Pre-asserting "by 3 p.m." silently filters out flights that may be perfectly acceptable to the user.
- **Exact location**: Screen 3, `.filter-chip` with `aria-pressed="true"` on "Arrive by 3 p.m."; companion meta line "Sorted by earliest arrival. 3 flights match."
- **Mechanism of harm**: choice-set manipulation. Pre-applied filters narrow the visible choice set without the user actively narrowing it. Even if the user can toggle the chip off, framing effects mean most users will accept the filtered set as "the available flights" rather than "the available flights matching a guess the system made about my schedule." A 6:30 p.m. flight that the system filtered out as "too late" might be the user's actual preference.
- **Required fix**: ship Screen 3 with **no filter chip pre-pressed**. Show all three flights, sorted by earliest departure (most-recoverable first). Let the user apply filters actively. Alternative: if a pre-applied filter is judged essential for cognitive load reasons, the screen must show "All flights" as a visible chip option and announce on load "Showing all flights — tap a filter to narrow" so the user knows the choice set hasn't been pre-narrowed. My recommendation is the first path: no pre-pressed filter.
- **Severity**: blocker. This interacts with B1 — together they form a steered funnel: pre-filter the choice set, then pre-select the choice. Either alone is bad; together they are a forced default with extra steps.

### B5. SMS rewrite (per IA spec) must explicitly name "refund" — verify content-designer carries this through

- **Behavioral risk**: the IA spec for the entry SMS requires naming refund as one of the options explicitly. If the SMS is silent on refund and only says "see your rebooking and support options," users who want a refund will call rather than tap. That is exactly the "we reduced calls by hiding help" failure mode, displaced one channel upstream.
- **Exact location**: SMS copy is owned by content-designer; not visible in the prototype HTML. Flag for sign-off: SMS must name *all four* recovery paths or at minimum name "refund" alongside "rebooking" and "support."
- **Mechanism of harm**: choice availability framing. If the user doesn't know refund is an option in the link, they treat the link as a rebooking funnel and bypass it.
- **Required fix**: SMS copy must explicitly mention refund and travel credit as available options in the link, not just "rebooking and support."
- **Severity**: blocker on the SMS deliverable, not on the prototype HTML. Sign-off depends on content-designer confirming.

---

## 3. RECOMMENDATIONS

Worth considering. Not blocking.

### R1. "Plans changed again?" link on Screen 5 is the right idea but underweighted

- The link sits as small `.meta-line` text below the offline-summary card. Behaviorally, the "what if it breaks again" path is the second-most-likely high-anxiety moment after the original cancellation. Consider promoting this to a labeled section ("If your plans change") with the link as a clearly weighted secondary action, not as inline meta-text. This reduces the chance that a user whose plans change a second time calls in panic because they don't remember the recovery flow accepts re-entry.

### R2. "Confirming releases your original 6:15 a.m. seat" is good — make sure the same honesty applies to refund and credit variants

- Visual designer added a useful sentence on Screen 4 about the irreversible step. Refund and credit paths have analogous irreversible moments ("Confirming starts the refund and you cannot rebook on this booking" / "Confirming converts the fare to credit and the original seat is released"). When those variants ship, the same naming-the-irreversible-step pattern should apply, written by content-designer.

### R3. Screen 2 support row is well-placed; the "see support on the next screen" promise must hold

- The support-row link reads "Support is listed on the next screen, not hidden in a FAQ." That's a trust-load-bearing promise. On every Screen 3 variant (rebook, refund, credit, standby), the support block must appear at the same vertical position and use the same heading ("Tonight's support"). If the refund variant relegates support to a footer or removes it because "you've already canceled," the trust contract breaks. Confirm with IA + content-designer that all four Screen 3 variants render the support block in the same position.

### R4. "Change" link on the recap chip (Screen 3) and on each row of Screen 4 needs target-size and prominence verification

- Behaviorally, "undo / back out" must be at least as easy as "commit forward." The Screen 3 recap chip's "Change" link is rendered as `.link-btn` with `style="min-height:auto; padding: 0;"` — that override drops it below the 44px target. Flag for accessibility specialist, but it's also a behavioral concern: friction asymmetry favors commit when undo is harder to tap. Either remove the inline style override or make undo affordances reach the same target size as the primary action.

### R5. "Save as image" on Screen 5 is the offline artifact — verify it actually works in the live build

- Behaviorally, an offline summary the user *thinks* they saved but didn't is worse than no save button at all (false sense of security; user discovers it at the airport). The prototype shows the button but doesn't wire the screenshot. The shipped version must either actually generate a saveable artifact or rename the action to something that matches what it does ("Email me this summary," "Send to my phone").

### R6. The "5G / 10:48" status-bar chrome is decorative and aria-hidden — fine for the mockup, remove from production

- Not a behavioral risk in the prototype, but production code shouldn't fake a phone-OS status bar inside the web view. It can mislead users about whether they're in a Northstar app or a Northstar web page, which subtly affects trust calibration ("I thought this was the app; why does it not work offline?"). Flag for whoever ships this.

---

## 4. Answer to Visual Designer's pre-pressed filter chip question

Visual designer asked whether a pre-pressed "Arrive by 3 p.m." filter chip on Screen 3 is acceptable as a view default, given that Screen 2 ships with no default recovery option.

**My judgment: not acceptable as currently designed. A pre-pressed filter chip *is* materially different from a pre-pressed commitment option, but in this specific case the difference doesn't save it — and it interacts with the pre-selected flight card (B1) to form a worse problem than either alone.**

Reasoning:

1. **Filters as view preferences vs. choices as commitments.** Visual designer is right that filters are not commitments. A pre-pressed filter on a retail site ("In stock only") is defensible because it reflects a goal the user almost certainly shares (don't show me things I can't buy). A pre-pressed filter on Slack ("Unread only") is defensible because it matches the user's clear ask. So the category distinction is real: a view default can be acceptable where a commitment default is not.

2. **But this specific filter asserts a fact we don't have.** "Arrive by 3 p.m." is a guess about the user's schedule. The brief gives us "tired, mobile-only, family event the next day." It does not give us "must arrive by 3 p.m." A morning rehearsal, an afternoon ceremony, an evening dinner, a flexible visit — all consistent with "family event tomorrow." Pre-pressing a filter that asserts an arrival-time goal manufactures a constraint the user didn't state, and that's choice-set manipulation regardless of intent.

3. **The interaction with the pre-selected flight card is the real problem.** If Screen 3 had no pre-selected flight and the filter chip merely re-ordered or de-emphasized the visible set, I would still flag it but call it a recommendation, not a blocker. As shipped, the filter narrows the choice set AND a specific option inside that narrowed set is pre-selected AND that option carries a scarcity cue. Three nudges in the same direction stop being "helpful defaults" and start being "the system has decided for you." That funnel is what dark-pattern audits catch.

4. **The safe alternative is honest scaffolding, not removal.** I'm not asking for a filter-free screen — filters help. The fix is: ship with no chip pressed, show all matching flights, and surface the filter affordances clearly so an active user *can* narrow. If you want to pre-suggest filters, do it as a labeled suggestion ("Many travelers narrow by direct flights — tap to apply"), not as a state the user has to actively un-press.

**Concrete recommendation to visual designer**: change `aria-pressed="true"` to `aria-pressed="false"` on the "Arrive by 3 p.m." chip, and remove the visual pressed state. Keep the chips, the sort, and the filter row. Combined with the B1 fix (no pre-selected flight), the screen becomes an honest list with optional refinement, not a steered funnel.

---

## 5. Falsifiers for the experiment plan

The redesign's headline business claim is "fewer support calls without hiding help." Any experiment plan that only measures call volume can declare victory while having shipped a dark-pattern win. Below are the signals that would prove the redesign cut calls by *hiding* help, not by *providing* it. These must be in the measurement plan or the experiment is non-falsifiable.

### F1. Call-reduction-by-hiding-help (the headline falsifier)

- **Hypothesis under test**: the redesign reduces support calls because the flow resolves the user's job, not because the call affordance is harder to find.
- **Falsifying signal**: call rate drops AND any of the following:
  - Call attempts via web-to-call link drop *less* than total calls (would suggest users couldn't find the link but still wanted to call by other means).
  - User-reported satisfaction post-flow drops or stays flat while calls drop (would suggest users gave up rather than got help).
  - The rate of users who complete the flow then call within 24 hours rises (would suggest the flow falsely closed the loop).
  - Time-to-call among users who do call increases significantly (would suggest the affordance got harder to find).
- **Minimum sample**: enough to detect a 10% relative change in the secondary signals at 80% power, not just the primary call-rate change. If the experiment is only powered to detect the call-rate change, the falsifier is operationally invisible.

### F2. Refund-suppression falsifier

- **Hypothesis under test**: the four recovery paths are genuinely peer options.
- **Falsifying signal**: refund-selection rate in the redesign is *lower* than in the legacy flow, while the population's underlying preferences haven't changed. Specifically:
  - Compare refund-selection rate by user segment (e.g., users with no future booked travel — who have the least reason to want credit). If that segment shifts toward credit in the redesign, suspect choice steering.
  - Among users who call after starting the flow, what fraction ask for a refund? If that fraction rises relative to legacy, the in-flow refund door is functionally narrower than it looks.
- **Why this matters**: the easiest dark-pattern win here is making credit slightly more visible than refund. Numbers will reward it. Trust will pay for it later.

### F3. Standby-misunderstanding falsifier

- **Hypothesis under test**: "Not guaranteed" framing prevents users from mistaking standby for confirmed rebooking.
- **Falsifying signal**: among users who select standby (when it's available), the rate of follow-up calls within 12 hours that include the phrase "I thought I was booked" (or equivalent in transcripts) is non-zero. Even a 5% rate is a failure of the framing.
- **Method**: light-weight transcript tagging on standby-path callers, not a full study.

### F4. Support-block "Not eligible" honesty falsifier

- **Hypothesis under test**: users who are not eligible for hotel/meal support can clearly see they're not eligible.
- **Falsifying signal**: among users who reach Screen 3 in a "not eligible" state, the rate of calls referencing hotel or meals is *not lower* than legacy (or the rate of users who later submit out-of-pocket reimbursement requests is *higher*). Both signals would mean the not-eligible state is functionally invisible.
- **Method**: instrument the "not included" state separately. Track downstream reimbursement requests by users who saw this state.

### F5. Time-to-first-decision pressure falsifier

- **Hypothesis under test**: the redesign reduces decision time because the choice is clearer, not because the screen creates urgency.
- **Falsifying signal**: time-to-decision drops AND the rate of users who reverse their decision via "Change" or call back within 1 hour rises. That pattern would indicate users decided faster but worse, which is what manufactured urgency produces.
- **Method**: instrument the "Change" link clicks on Screens 3 and 4 specifically. Track them as a quality signal, not just an interaction signal.

### F6. Multi-channel cross-leak

- **Hypothesis under test**: calls dropped because users self-served, not because they switched channels.
- **Falsifying signal**: drops in call volume offset by rises in chat, social, or email-to-support volume of equal or greater magnitude. If total support contact volume across channels is flat or rising, the redesign moved the workload, not reduced it.
- **Method**: measure total contact volume per disruption event, not call volume alone. This must be in the dashboard from day one or the experiment will look better than it is.

---

## 6. Sign-off conditions

I will sign off on this prototype when:

1. **B1 is fixed**: Screen 3 ships with no flight pre-selected. All three flight cards in neutral state. Primary CTA disabled (or otherwise gated) until user actively selects.
2. **B2 is fixed**: the "Only X seats left" scarcity cue is removed from the disruption-recovery rebook context, or (less preferred) is applied neutrally to all flights where true and never only to the pre-selected one. Combined with B1, the simplest fix is just remove it.
3. **B3 is fixed**: the support-acceptance pre-checked checkbox on Screen 3 is removed. Consent moves to Screen 4 as itemized, actively-chosen acceptances per support item.
4. **B4 is fixed**: the "Arrive by 3 p.m." filter chip ships in the un-pressed state. All filters render as available, none pre-applied. The "Sorted by earliest arrival" framing can stay if the chip is unpressed.
5. **B5 is confirmed**: content-designer confirms the SMS names refund and travel credit explicitly, not just rebooking and support.
6. **The experiment plan includes falsifiers F1, F2, and F6 at minimum**, with the instrumentation lined up before launch. F3, F4, F5 are recommended but not blocking sign-off — they can be added in the first iteration cycle.

Until B1 through B4 are addressed in the HTML and the experiment plan reflects F1, F2, F6, my verdict is **block-until-revised**.

Recommendations (R1–R6) are advisory. Sign-off does not depend on them, but I'll note any that ship un-actioned in the post-mortem.

**Ethics check applied to the as-shipped prototype**: would the user thank us in six months? Mostly yes — the bones are honest. The hidden-call-button trap is avoided, support is visible, refund is a peer option, standby is correctly framed. The blockers above are the four places where good intentions slid into steering. Fix them and this is a flow a stressed traveler will trust the second time they're stuck at 10:48 p.m. — which is the only kind of trust worth optimizing for.
