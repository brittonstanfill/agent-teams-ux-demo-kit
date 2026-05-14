# Behavioral Scientist — Canceled-Flight Recovery Audit

Role: blocking authority over trust, coercion, dark-pattern risk, choice architecture, falsification. This run additionally enforces a strict claim-provenance lint: any unsupported operational promise in user-visible product UI is a BLOCKER.

---

## 1. Summary

- **Total findings:** 14
- **BLOCKERs:** 6 (claim-provenance: **5**; choice-architecture: 1)
- **NEAR-BLOCKERs:** 4
- **NOTEs:** 4
- **Verdict:** Structurally the redesign is a large improvement over the current flow — entitlements surfaced, support visible on every screen, default flipped to "Rebook," refund path no longer buried in a tab. But several flat operational assertions slipped past the placeholder discipline (re-notification, "change your mind," social-proof, "confirmed seat," text-me-this-link), and a social-proof line on the primary card is doing coercive work the brief does not authorize. Ship-blocking until the strings below are tokenized or rewritten.

---

## 2. Claim-provenance lint findings

For each, I cite the exact string, the operational class it falls in, and a placeholder or rewrite. The lint test: is this a flat assertion of an airline operational behavior (a) not in the brief, (b) not styled as `{snake_case_token}`, and (c) not framed as recommendation/assumption? If yes → BLOCKER.

### BLOCKER 1 — Re-notification promise (Screen 4)
- **String:** `"If this flight also changes, we'll notify you on this number and email and re-open these options."` (line 1009)
- **Class:** texting/callback behavior promise + reversibility promise.
- **Why:** Asserts the airline *will* re-notify on a specific channel pair (SMS + email) and *will* re-open the options. Neither the brief nor the IA report states this as policy; the IA explicitly scoped re-disruption as a gap (§4 item 6).
- **Fix:** Replace with a token + neutral framing. E.g.,
  `"If this flight changes, we will contact you via {renotification_channels}. You can re-open these options from {renotification_entry_point}."`

### BLOCKER 2 — Re-notification + reversibility promise (Screen 5)
- **String:** `"We'll text and email this number if your flight is updated again. You can re-open these options here at any time."` (line 1107)
- **Class:** texting behavior promise + reversibility promise + support availability framing.
- **Why:** Same issue as #1, doubled by "at any time," which is a 24/7 availability claim for a self-service path that the brief does not validate.
- **Fix:**
  `"If your flight changes again, we will contact you via {renotification_channels}. Re-open these options: {reentry_path_status}."`

### BLOCKER 3 — Social-proof claim on primary card (Screen 2)
- **String:** `"Confirmed seat on a later flight. Most travelers choose this."` (line 839)
- **Class:** social-proof assertion + (mild) eligibility framing.
- **Why:** "Most travelers choose this" is an empirical claim about user base behavior. Not in the brief. Not tokenized. This is also a coercion lens issue (see §3, dark-pattern): the brief warns against social-proof manipulation, and a fabricated popularity claim on the default option is the exact pattern flagged.
- **Fix:** Drop the second sentence entirely. The primary visual weight already carries the recommendation; "Most travelers" is gilding and unverifiable. Rewrite:
  `"Confirmed seat on a later flight."`
  If the team wants social proof, gate it behind a real metric: `"{rebook_share_among_recent_disruptions}"` with a defined methodology — and even then, I'd argue against it under stress.

### BLOCKER 4 — Reversibility promise (Screen 2 subhead)
- **String:** `"Pick one. You can change your mind on the next screen."` (line 831)
- **Class:** reversibility promise.
- **Why:** Asserts the next screen will let the user reverse this choice. Whether *all three* paths (rebook, refund-or-credit, standby) allow free reversal on Screen 3 / Screen 4 is an operational promise that the brief does not validate, and the IA report does not author the refund branch. The current Screen 3 is rebook-only; the refund and standby branches are scoped gaps.
- **Fix:**
  `"Pick one. You can review this choice before it's final."`
  This keeps the autonomy-restoring signal (which is genuinely good behavioral design) without promising reversibility the system may not deliver in every branch.

### BLOCKER 5 — Process promise (Screen 2 consequence text)
- **String:** `"You won't fly with us on this trip. We'll show you refund vs. credit on the next screen."` (line 847)
- **Class:** process/flow promise (specifies the airline's next-screen content).
- **Why:** Asserts a specific UI behavior that does not yet exist in the prototype — IA §4 item 4 explicitly scopes the refund-vs-credit decision screen *out*. If a user taps this card and lands on a stub, the promise is broken.
- **Fix:**
  `"You won't fly with us on this trip. Refund or credit options will be shown next."` is still a promise. Stronger:
  `"You won't fly with us on this trip. {refund_credit_next_step}"`
  Or rewrite the consequence to describe the *outcome* rather than the *next UI step*:
  `"You won't fly with us on this trip. Refund or credit handled separately."`

### NEAR-BLOCKER 6 — Texting behavior promise (Screen 1)
- **String:** `"Text me this link"` (line 799)
- **Class:** texting behavior promise (implicit: the airline will send an SMS containing this URL).
- **Why:** A button label that promises an SMS action is an operational promise about the texting system's behavior. Not in the brief. However, this is the *label of a user-initiated action*, not a flat assertion about what the airline does — so closer to an affordance than a claim. Borderline.
- **Fix (recommended):** Keep the affordance but neutralize the implicit promise in the surrounding helper text or in the confirmation toast. Acceptable as-is *if* the action is wired and the team is willing to commit to it. If not wired, downgrade to:
  `"Send me this link"` with a follow-up screen that confirms delivery channel.

### NOTE 7 — Computed-label-as-claim (Screen 3 badges)
- **Strings:** `"Earliest arrival"` (line 911), `"Nonstop, closest to original time"` (line 926), `"Later option"` (line 941).
- **Class:** these are *computed* descriptors of dynamic flight cards. They are operational claims *about the specific card* ("this card is the earliest"). If the sort or data changes, the badge content must too.
- **Why this is a NOTE, not a BLOCKER:** the IA report explicitly designs these as reason-strings replacing the brief's unexplained "Recommended" badge. They are bound to the dynamic flight data above them, which is itself tokenized. Acceptable as a pattern.
- **Fix (defensive):** Ensure the badge string is computed server-side from the same data source as the cards, not hardcoded by the UI layer. Document as `{flight_a_reason_badge}` in the data contract even if it renders as plain English.

### NOTE 8 — Implicit channel promises in "Save this trip" (Screen 5)
- **Strings:** `"Add to wallet"`, `"Email a copy"`, `"Text a copy"`, `"Download PDF"` (lines 1081, 1088, 1094, 1101).
- **Class:** affordance labels that imply four delivery channels work. Affordances, not assertions — acceptable, but the team must commit to all four being wired or remove the ones that aren't.

---

## 3. Other behavioral findings

### BLOCKER 9 — Default architecture: visually coercive primary card
- **Where:** Screen 2, `.decision.primary` (line 834).
- **Finding:** The flipped default ("Rebook on another flight" as the dominant card) is the right call per the brief — the user is trying to reach a family event, not optimize a refund. However, the *visual coercion* in service of that default is heavy: black filled card, two-tone treatment, plus social-proof copy (Blocker 3 above), plus the only animated/elevated shadow. Combined, this crosses from "honest default" into "default + thumb on the scale." Under SDT, autonomy support requires that the user *feels* free to choose; right now the other two options look like rejected drafts.
- **Why blocker:** Aggregated, this is asymmetric friction — easy to rebook, visually harder to choose refund — which is exactly the dark-pattern the brief warns against ("not pushing users into worse choices"). For a user whose best option *is* a refund (e.g., the family event is canceled too, the user is in DEN home base), the design is steering them away from their own goal.
- **Fix:**
  1. Remove the "Most travelers choose this" line (Blocker 3).
  2. Keep the rebooking card visually primary but lighten the contrast — same accent treatment, not full inverted black. Refund and standby cards should be *quieter than rebook, not visually rejected.* Specifically: remove dashed border on standby; treat refund and standby as solid but unaccented cards.
  3. The "primary" weight should come from order + accent, not from inverting the entire card.

### NEAR-BLOCKER 10 — Step counter says "Step 1 of 4" on a 5-screen flow
- **Strings:** `"Step 1 of 4"`, `"Step 2 of 4"`, `"Step 3 of 4"`, `"Step 4 of 4"`, `"Confirmed"` (lines 749, 826, 887, 978, 1039).
- **Finding:** The progress count tells the user there are 4 steps. There are actually 5 screens in the prototype. Either the prototype is double-counting one screen, or the step counter is wrong. Under endowed-progress framing, a wrong progress count corrodes trust — the user reaches "step 4 of 4," expects to be done, gets another screen.
- **Why near-blocker:** This is a behavioral falsehood (the count), but not an operational promise about airline behavior. Still corrodes trust at the exact moment the design is trying to build it.
- **Fix:** Audit the count. If Screen 1 is "context before choice" and Screen 5 is "confirmation," the standard pattern is to call the visible steps 1–3 (choose / pick / review) and treat Screens 1 and 5 as bookends without a step number. Or change to "Step 1 of 5" through "Step 4 of 5" with Screen 5 as "Confirmed." Pick one model; current state mixes them.

### NEAR-BLOCKER 11 — Entitlement visibility good, but no eligibility-unknown state authored
- **Finding:** Screens 1, 4, 5 surface `{hotel_entitlement_status}` and `{meal_entitlement_status}` as tokens. Good. But the visual treatment (warm-toned hero module) is set up to *imply coverage*. If `status = not eligible` or `status = unknown`, the warm tone visually contradicts the data.
- **Why near-blocker:** This is the IA's flagged risk (IA report §6.3). Without a clear "not eligible" or "checking" visual state, the warm module either over-promises or shows a confusing empty state. The brief is explicit: "do not invent legal obligations… compensation rules" — the visual chrome is currently doing that work even though the strings are tokenized.
- **Fix:** Visual Designer must author at least three states for the entitlement module: eligible (warm), not eligible (neutral, plain), unknown/checking (neutral with explanatory string `{eligibility_check_status}`). Default visual cannot be the eligible state.

### NEAR-BLOCKER 12 — Support visibility on every screen — good, but `tel:{support_phone}` is a hard commit
- **Finding:** Every screen ends with `<a href="tel:{support_phone}">`. The token discipline is correct. But: the action verb ("Call Northstar support") implies a phone call is the support modality. The brief flags hotel/meal entitlements as low-trust failure modes; the IA scopes chat/callback out (IA §4 item 5). If support is *only* call-based, the design is back to the current failure mode (calls).
- **Why near-blocker:** Not a claim-provenance issue (the phone is tokenized). It's a falsifiability concern: the design's goal is "reduce calls without hiding help," but the only visible help affordance routes to a call.
- **Fix:** Add a second support modality token: `{support_channels}` rendering as "Call or message us" with channel-specific affordances behind it. If the only available channel is phone, the brief's reduce-calls goal is structurally unachievable here.

### NOTE 13 — Tone at 10:46 p.m. is well-pitched
- The eyebrow ("Trip update"), neutral status header, single reason pill, and warm-but-quiet entitlement module are appropriate for a tired, stressed mobile traveler. No alarm bars, no red banners, no countdown timers, no urgency manipulation. This is good. Keep it.

### NOTE 14 — No coerced urgency or fake scarcity detected
- I checked for countdowns, "only 2 seats left," "act in X minutes," banner alarms. None present. Continue this discipline through copy review.

---

## 4. Falsifiers — what would prove the design is hiding help to reduce calls

The brief tension is real: reduce calls AND don't hide help. The design has to be measured against *both*. I propose four falsifiers — if any of these come back true in the experiment, the design has slid toward "hiding help":

1. **Falsifier A — Call-suppression-without-recovery.** Compare two cohorts (current flow vs. redesign). If the redesign reduces calls *and* reduces successful self-service completion (rebooked + entitlements claimed), the call drop is suppression, not resolution. Specifically: if `(completed_recovery_redesign / sessions_redesign) <= (completed_recovery_control / sessions_control)` while calls dropped, that is evidence of hiding help. Minimum sample: ~400 disruption sessions per arm to detect a 5pp completion delta at alpha 0.05.

2. **Falsifier B — Entitlement claim rate.** If hotel/meal *eligibility shown* on Screen 1 stays roughly constant cohort-to-cohort but *entitlement claim rate* (downstream — did the user actually claim the hotel?) does not increase versus control, the surfacing is decorative, not behavioral. Track: `claims_filed / sessions_where_status_eligible`. Expected direction: up. If flat or down, the warm module is theatre.

3. **Falsifier C — Refund-path completion under flipped default.** If the redesign's refund-or-credit selection rate drops more than the rebook rate rises (i.e., users who *should* refund are getting absorbed into rebooking), the new default is steering, not helping. Compare distribution of (rebook / refund / credit / standby) vs. control. A healthy outcome: rebook share rises, refund share stays roughly stable, standby share drops. An unhealthy outcome: rebook share rises and refund share falls.

4. **Falsifier D — "Need a human?" tap rate by screen.** Track the per-screen rate of taps on the support affordance. If Screen 2 (the choice screen) has a *higher* support-tap rate than the current flow's equivalent point, the design is *not* successfully self-serving the decision and the call reduction is coming from screens 3–5 friction, not from genuine confidence. Expected direction: Screen 1 support-tap rate should fall (entitlements answered the question they would have called for); Screen 2 should hold or fall (the options are now legible); Screen 5 should fall (no need to call to ask "did it work").

Combined, A + B together are the strongest test: did successful recovery + entitlement claims rise while calls fell? If yes, the design works. If calls fell but recovery and claims did not rise, the design is hiding help.

---

## 5. Handoff — ordered fix list

For the Visual Designer and lead, in priority order. Items 1–6 are BLOCKERs that must be resolved before this prototype ships for stakeholder review.

1. **Tokenize re-notification promises** on Screen 4 (line 1009) and Screen 5 (line 1107). Replace flat "we'll notify you on this number and email" with `{renotification_channels}` and remove "at any time."
2. **Remove social-proof claim** "Most travelers choose this" (Screen 2, line 839). No replacement needed; the visual primary already does the work.
3. **Soften reversibility promise** "You can change your mind on the next screen" (Screen 2, line 831). Replace with "You can review this choice before it's final."
4. **Tokenize process promise** "We'll show you refund vs. credit on the next screen" (Screen 2, line 847). Replace with `{refund_credit_next_step}` or rewrite to describe outcome, not UI step.
5. **Rebalance Screen 2 visual hierarchy.** Keep "Rebook" as visual primary but reduce the inverted-black treatment; refund and standby should read as alternative options, not rejected drafts. Remove dashed border on standby.
6. **Fix the step counter.** Decide: is this a 4-step or 5-step flow? Make Screens 1–5 internally consistent.
7. **Author "not eligible" and "unknown" visual states** for the entitlement module (Screens 1, 4, 5). Default visual cannot be the eligible state.
8. **Decide on a second support modality** or scope it out explicitly. If "Call Northstar support" is the only support affordance, document that as a known limit against the brief's reduce-calls goal.
9. **Confirm "Text me this link" is wired.** If not, downgrade to "Send me this link" with a channel-picker.
10. **Confirm Screen 5's four save channels are wired** (wallet, email, text, PDF). Remove any that aren't.

Ethics check rolled up: would the user thank us in 6 months? After fixes 1–6, yes — they got to the family event, they knew their entitlements, they have a record. Without fixes 1–6, no — the design is making promises the airline did not authorize, and the social-proof line is steering a tired traveler at 10:46 p.m. with a fabricated statistic. That is a manipulation, not a nudge.

---

*End of audit.*
