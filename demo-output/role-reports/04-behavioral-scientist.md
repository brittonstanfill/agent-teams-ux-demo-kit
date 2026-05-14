# Behavioral Scientist Report — Canceled-Flight Recovery Prototype

Labels: **[OBSERVED]** observed in the prototype HTML, **[INFER]** inferred from prototype + IA spec, **[ASSUME]** my working assumption, **[REC]** recommendation.

Scope: trust, coercion, choice architecture, dark-pattern risk, falsification. I have blocking authority on these. I am not auditing accessibility, contrast, focus order, or markup correctness — that is the Accessibility Specialist's lane.

---

## 1. Summary

The prototype's behavioral posture is honest. Choice architecture on Screen 2 treats Rebook, Refund-or-Credit, and Standby as visually equivalent affordances; standby's "Not guaranteed" caveat is calibrated (present, not melodramatic, not hidden). Screen 4 surfaces hotel and meal support as separately decidable accept/decline rows with no pre-checked state, and explicitly handles the "we don't know if you qualify" case via a status token and a banner. "Talk to a person" appears in a persistent footer on all five screens. Placeholders are honored throughout; no invented dollar amounts, hotel names, phone numbers, voucher values, or operational facts. **[OBSERVED]**

Top three behavioral risks:

1. **Screen 1's reassurance line ("if your case qualifies — a place to sleep tonight and a meal credit") risks anchoring an expectation that may be denied on Screen 4.** Loss aversion makes a denied expectation feel worse than never having been mentioned. The IA's stated rule ("no promise of specific entitlement") is technically respected, but the framing primes the user. This is a **blocker**. **[OBSERVED]**
2. **The "Talk to a person" link is styled identically to body link weight on all five screens but sits *below* the primary CTA, separated by a hairline border.** On a short mobile viewport — especially Screen 3 with three flight cards, a filter bar, a primary button, *and* a dashed variant-sketch — the help footer is reachable but visually deprioritized. The business risk: a metric like "calls per recovery" could drop simply because help became one extra glance further away. **Non-blocking nudge**, plus a falsifier. **[INFER]**
3. **Screen 5's confirmation card displays "Hotel: `{hotel_status}`" and "Meal credit: `{meal_status}`" as token cells with no visible distinction between "confirmed" and "pending."** The IA's confirmation rule required a literal "we'll send this when it's ready" state to be visible. The HTML defers that to runtime token content; the prototype itself does not demonstrate the pending state. This is a **blocker** because a downstream engineer can read the prototype and ship a UI that says "Hotel: pending" in the same grey body text as "Hotel: Confirmed at Hotel X" — flattening a real semantic difference. **[OBSERVED]**

---

## 2. Blockers (Visual Designer must address in revision pass)

### B1. Screen 1 reassurance overpromises before eligibility is known

**Location.** Screen 1, `<p class="p">` second paragraph:

> "We'll help you arrange a new flight, and — if your case qualifies — a place to sleep tonight and a meal credit. You'll see what you qualify for on a later step."

**What's wrong (behavioral).** The conditional clause ("if your case qualifies") is *grammatically* hedged but *cognitively* foregrounded — by Gricean implication, mentioning a hotel and meal credit at this moment, when the user is most stressed, primes expectation. If Screen 4 later returns "not eligible" the user experiences this as a *loss*, not a non-grant. Loss aversion is roughly twice as motivationally weighty as gain. The downstream effect is the call we are trying to *avoid* ("you told me there was a hotel"). **[INFER]**

**Why it's a trust problem.** The IA's anti-promise rule is honored on the page, but the *order of mention* manufactures an implicit promise. Trust is calibrated against what the user *takes away*, not what the legal text says.

**Exact fix (copy).** Reframe so eligibility is presented as a *process* the airline runs on the user's behalf, not a benefit list the user is shown and may not receive:

> "We'll help you book a new flight. If tonight's stay or a meal credit applies to your case, we'll show you on the support step."

Order matters: lead with the flight (which is guaranteed), then describe support as a check we will run, not as an offer that is being conditionally made. **[REC]**

### B2. Screen 5 hotel/meal rows do not visually distinguish "confirmed" from "pending"

**Location.** Screen 5, summary card:

```
<div class="summary-row">
  <span class="k">Tonight</span>
  <span class="v">
    Hotel: <span class="tok">{hotel_status}</span><br/>
    Meal credit: <span class="tok">{meal_status}</span>
  </span>
</div>
```

**What's wrong (behavioral and trust).** The IA's confirmation rule (Section 3, "Confirmation rule") required that any row without a definitive value display a literal pending-state message ("we'll send this when it's ready") rather than render as if confirmed. The prototype delegates the entire distinction to a token. A token like `{hotel_status}` could render as "Confirmed at `{hotel_name}`" or as "We're still working on this — we'll text you within the hour" — and in the prototype both render in identical neutral grey type, inside the same row, with no visual cue that one is a settled fact and the other is a promise. **[OBSERVED]**

A user who saves this page offline and arrives at the airport to discover their "Hotel" status was the in-progress version is the exact "frustrated complaint quote" the red-team check is supposed to catch.

**Why it's a trust problem.** Peak-end and confirmation honesty principles: the end-state of the recovery flow is what the user remembers. If the confirmation looks identical for "done" and "in progress," the design has hidden a state distinction inside a label — a sneaking pattern, even if unintentional.

**Exact fix (hierarchy + copy).** Add a visible status badge to any row whose status is not "Confirmed": e.g. a small pill in the existing `state-warn` palette reading "Pending — we'll text you" placed inline with the value. The prototype should demonstrate the *pending* visual state explicitly, not just a happy-path token. The Visual Designer can show this either as a second variant of the summary card or by having the prototype's hotel row render in pending state and the meal row in confirmed state, so both designs are visible. **[REC]**

### B3. Screen 4 "Decline" toggle is visually equivalent to "Accept" — verify it does not become the path of least resistance

**Location.** Screen 4, `.offer .actions` toggle pairs (hotel row and meal row):

```
<button class="toggle" aria-pressed="false">Accept</button>
<button class="toggle" aria-pressed="false">Decline</button>
```

**What's wrong (behavioral).** Both toggles start in `aria-pressed="false"`. There is no default. This is correct as far as it goes — there is no pre-checked accept (no sneaking-in) and no pre-checked decline (no coerced refusal). But: the primary button "Confirm tonight's plan" can be tapped while *both* toggles remain unselected. **[OBSERVED]** A fatigued user, faced with two unanswered binary choices and a salient primary CTA, will most often tap the primary and move on. The behavioral outcome of "no selection + confirm" is ambiguous from the prototype alone — it could mean "I'm undecided" or "I implicitly declined" depending on backend interpretation. If the system treats no-selection as decline, the design has manufactured a low-friction refusal of an entitlement the user may actually want.

**Why it's a trust problem.** Default abuse, even by omission. The most common behavioral outcome here is "user did not engage" and the design must define what that means in a way that does not silently strip an entitlement.

**Exact fix.** Either (a) make the primary button disabled until both rows have an Accept or Decline selection, with helper text "Choose for each row to continue," OR (b) treat unselected as "needs follow-up" and have the confirmation explicitly say so, e.g. "We'll text you about the hotel — you didn't choose yet." Option (a) adds friction at the right cognitive moment; option (b) honors user inaction without converting it into a binding decline. Either is acceptable; pick one and make it visible in the prototype. The Accessibility Specialist must co-sign whichever is chosen. **[REC]**

---

## 3. Non-blocking nudges (would strengthen, not gating revision)

### N1. Standby's warning could be calibrated more honestly with one extra word.

The "Not guaranteed" badge plus consequence line ("Not a confirmed seat. You may not fly today.") reads as honest — neither hidden nor melodramatic. **[OBSERVED]** A small refinement: replace consequence line with "Not a confirmed seat. You may not fly today and there is no fallback flight booked." The current phrasing leaves a present-bias user (who is optimistic about today's chances) free to imagine that if standby fails, "they'll just rebook me." Naming the absence of fallback closes that gap. **[INFER]**

### N2. Screen 2's three choice cards have identical visual weight — confirm "Refund or travel credit" wording does not stigmatize refund.

The middle option reads "Get a refund or travel credit — Cancel the trip. Money back or credit, you choose on the next screen." **[OBSERVED]** Word "Cancel the trip" is honest but slightly negatively charged compared to "Confirmed seat" and "Wait for a seat." Suggest: "Get a refund or travel credit — End this trip and get your money back, or take credit toward a future trip." This frames refund as an outcome (money back) rather than as a destruction (cancel). The IA's "the brief flagged refund being pushed away from" concern is best answered by making refund read as a complete and dignified option, not by giving it equal pixels alone. **[REC]**

### N3. The "Talk to a person" link at the bottom of every screen could be promoted to read-once-and-remember, not link-every-time.

Currently the link appears five times, always at the bottom of the screen, always identically styled. A user scanning quickly may stop seeing it (banner blindness). Without changing visual weight, vary the lead-in slightly so it is occasionally re-noticed — Screen 5 already does this ("Plans changed again? Talk to a person."). Consider similar small variation on Screen 4 ("Eligibility unclear? Talk to a person.") so the link is responsive to the screen's specific failure mode rather than generic. **[INFER]**

### N4. The conditional support banner on Screen 2 is well-worded; one tighten.

> "Tonight's hotel and meal support may be available. We'll show what you qualify for after you pick a path."

"may be available" is correctly hedged. **[OBSERVED]** Worth verifying with Content / Legal: "after you pick a path" risks reading as "you must commit before knowing." It does not, in fact, lock the user in — Screen 2's choices are not legally binding — but the phrase could be tightened to "we'll check what applies once you tell us how you want to recover, and you can still change your mind." **[REC]**

---

## 4. Falsifiers — metrics to test for the experiment plan

If the redesign ships and we only measure "calls per recovery decreased," we have not proven the redesign worked for users. Calls can drop because help was buried. The experiment plan must include metrics that *would* falsify a naively positive read.

1. **Help-link reach rate.** % of recovery sessions where "Talk to a person" was tapped *or* the user successfully completed the flow without calling later. If call volume drops AND help-link taps drop AND post-completion call volume rises (users calling after they leave the app), the design hid help; the gain is fake. Minimum useful sample: enough recoveries to detect a 15% relative shift in tap rate. **[REC]**

2. **Entitlement-grant rate vs. denial complaint rate.** Of users who got "may be available" messaging on Screen 1/2, what % were ultimately granted hotel or meal support on Screen 4? Of users who were *denied*, what % filed a complaint, called, or rated the experience negatively in the 7 days after? A reframed Screen 1 (per B1) should reduce denial-complaint rate without reducing grant rate. If grant rate is below ~70% in the target population, blocker B1 is doubly important — we are setting up loss aversion at scale. **[REC]**

3. **Standby commitment regret.** Of users who pick Standby on Screen 2, what % subsequently call support, switch to Rebook, or rate the experience poorly? Standby is the riskiest choice; if completion rate on Standby is high but downstream satisfaction is low, the design has made it *too easy* to pick a worse option. **[REC]**

4. **Confirmation-state confusion.** Of users who reach Screen 5 with at least one pending status (hotel or meal), what % subsequently call support to ask about that item? If this rate is high, blocker B2 was not adequately resolved — the "pending" state still reads as "done." **[REC]**

5. **No-default abandonment on Screen 4.** Of users who reach Screen 4, what % tap "Confirm tonight's plan" *without* having selected Accept or Decline on either row? This is the metric that proves or disproves blocker B3. **[REC]**

---

## 5. Verified clean

Items I audited that look behaviorally honest:

- **No "Recommended" bare label** anywhere in the prototype. Reason chips ("Earliest arrival," "Closest to original time") carry their own justification — defensible anchoring, not coercive recommendation. **[OBSERVED]**
- **No pre-checked accept** on hotel or meal entitlements. Both toggles start `aria-pressed="false"`. **[OBSERVED]**
- **No pre-selected default** on Screen 2's three recovery paths. The user must pick. **[OBSERVED]**
- **Standby is not buried.** It is the third card, not collapsed under an FAQ. The "Not guaranteed" badge is calibrated (small chip, present, not flashing red or pulsing). **[OBSERVED]**
- **No invented operational facts.** Grep confirmed: no dollar amounts, no hotel chain names, no phone numbers, no specific voucher values, no credit-expiration windows, no eligibility promises. All concrete values are `{placeholder_tokens}`. **[OBSERVED]**
- **"Talk to a person" is reachable on every screen** including Screen 1 (before any decision), Screen 3 (during selection), and Screen 5 (after completion). It is not gated behind a successful path. **[OBSERVED]**
- **No urgency manufacturing.** No countdown timers, no "limited availability" red text on flight cards, no "only X seats left" social-proof scarcity. Tone is calm. **[OBSERVED]**
- **No confirmshaming.** The "Decline" button reads simply "Decline" — not "No thanks, I'll figure it out myself." **[OBSERVED]**
- **No forced-continuity or roach-motel pattern.** The user can decline support, can pick refund (vs. being trapped in rebook), and Screen 5 provides a re-engagement path ("Plans changed again?"). **[OBSERVED]**
- **No false equivalence.** Standby is visually equal in weight but explicitly labeled non-equivalent in consequence. The design distinguishes "equal as a choice" from "equal in outcome." This is the correct calibration. **[OBSERVED]**
- **No marketing, loyalty pitch, or upsell** on any screen. **[OBSERVED]**
- **Screen 5 names the outcome ("You're rebooked to {destination_city}")**, not a generic "Trip updated." This honors the IA's confirmation-naming rule and avoids the dark pattern of pretending an ambiguous result is a success. **[OBSERVED]**

---

## 6. Handoff to Visual Designer and lead

**Three blockers — required in revision pass:**

1. **B1** — Rewrite Screen 1's second paragraph so hotel/meal support is described as a *check we will run*, not an offer being mentioned. Removes the loss-aversion anchor. *Copy change only.*
2. **B2** — Make the Screen 5 summary card visually demonstrate the *pending* state distinct from the confirmed state. Either render one of the summary rows in pending visual style in the prototype, or add a status badge component to any non-confirmed row. *Markup + visual change.*
3. **B3** — Either disable "Confirm tonight's plan" until both Screen 4 toggle rows have a selection, or explicitly handle the no-selection state in the confirmation. Pick one and show it in the prototype. *Interaction + copy change.*

**Four nudges — strengthening, non-blocking:**

- N1 — Tighten standby consequence line to name absence of fallback.
- N2 — Reframe refund-or-credit consequence line away from "Cancel the trip."
- N3 — Vary "Talk to a person" lead-in once or twice per flow to defeat banner blindness.
- N4 — Optional tighten on Screen 2 support banner.

**For the lead — five falsifiers to feed the experiment plan:**

- Help-link reach rate (paired with post-completion call rate). The single most important falsifier — proves the business goal didn't reduce calls by hiding help.
- Entitlement grant vs. denial-complaint rate.
- Standby commitment regret.
- Confirmation-state confusion (validates B2).
- No-default abandonment on Screen 4 (validates B3).

**For the lead — debate seed.** If there is one unresolved conflict worth debating, it is Screen 1's reassurance line (B1). The Information Architect's spec told the Visual Designer to "reassure" without promising; the Visual Designer wrote a sentence that hedges legally but anchors cognitively. That is exactly the kind of behavioral question the team should resolve in writing, with a preserved dissent if Content / IA prefer the current phrasing.

---

## Ethics check — would the user thank you in 6 months?

For the design as currently shipped: **mostly yes.** The user is given honest options, no surprises in the choice architecture, a reachable human, and a confirmation that names what was decided. The three blockers above are the difference between "mostly yes" and "yes." Each one is a small honesty improvement that a user would not consciously notice on the happy path, but would feel acutely on a bad path — denied entitlement, pending hotel, accidentally-declined meal credit. Those bad paths are exactly when trust is built or burned. **[REC]**
