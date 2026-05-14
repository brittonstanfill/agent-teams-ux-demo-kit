# Behavioral Scientist — Canceled-Flight Recovery

## Header

- **Role:** Behavioral Scientist.
- **Scope of authority (blocking):** trust floors, coercion, dark-pattern risk, choice architecture, framing, falsification.
- **Out of scope:** visual styling, code, accessibility tree (separate audit), copy authorship.
- **Method:** I read the brief, the user-job spine in 01, and the rendered prototype HTML end-to-end. For each screen I asked: (a) what is the user thinking/feeling at 10:46 PM, (b) what does the design *invite* them to do, (c) what does it *steer* them away from, (d) would they thank us in six months. I name behavioral concepts (loss aversion, defaults, choice overload, salience, social proof, present bias) only where I can point to the artifact element activating them. Labels: **observed in artifact / inferred / assumption / recommendation.**

---

## Trust-floor findings

I separate **blockers** (would compromise trust floors or look like a dark pattern at audit) from **polish** (smaller, ship-with).

### Blockers — none in the current prototype

I went looking, screen by screen, for the dark patterns the brief identifies in the legacy flow. The prototype clears each one:

1. **Cause framing is honest.** *(observed in artifact, Screen 2)* The event block reads "Cause: crew availability — not weather." This actively rebuts the most common user assumption that delays are weather-driven and out of the airline's hands. The negation ("not weather") is the right move: a stressed user under self-protective bias will hear "schedule irregularity" or "operational issue" as code for "not our fault." Calling crew explicitly is a costly signal of honesty and a meaningful trust floor. **No change required.**

2. **Refund as honest dead-end, not hidden roach-motel.** *(observed in artifact, Screen 3)* The refund note explicitly says refunds aren't in this flow and routes the user to Talk to someone. This is the single most important anti-dark-pattern move. A flow that offers credit but quietly denies refund-seekers a path is, by definition, a roach motel. Naming the limit out loud — with the channel that *can* solve it — converts a hidden dead-end into a visible one. *(recommendation: keep this verbatim; do not let copy review soften "Refunds aren't handled in this flow" into "Refunds may be available" — softening is what creates the dark pattern.)*

3. **Hotel and meal support is a peer card, not a footnote.** *(observed in artifact, Screen 3)* It sits as the fourth path card with the same visual weight as rebook/standby/credit, and it is also referenced in the Screen 2 reassurance line ("we can help cover tonight's stay and food") and again on the Screen 5 confirmation block. Hiding entitlements is the most damaging failure mode the brief names. This design surfaces support at three independent entry points without overselling specifics. **No change required.**

4. **Standby ambiguity is broken.** *(observed in artifact, Screen 3)* "Try standby on an earlier flight — No confirmed seat. You wait at the gate and may not get on." The consequence sentence does the trust work. Standby is the highest-harm label in the flow (a user who picks it thinking it's a confirmed seat has been harmed by us); this copy is non-negotiable and is in. **No change required.**

5. **No default selection on Screen 3.** *(observed in artifact)* The lede on Screen 3 explicitly states "Nothing is selected yet — you're in charge." This neutralizes the legacy flow's coercive default-to-credit, which favored the airline at the user's expense. Defaults are the strongest behavioral lever in the choice architecture; the prototype declines to use it. **No change required.**

6. **No "Recommended" badge anywhere.** *(observed in artifact, Screen 4)* The three flight cards are differentiated only by factual labels ("earliest option," "fare difference," "latest tomorrow"). The legacy "Recommended" tag on the 7:10 AM card has been dropped. Anchoring without explanation is a dark pattern; transparent meta-labels are not. **No change required.**

7. **Talk-to-someone is persistent, not buried.** *(observed in artifact)* The "Need a human?" link sits in a footer on every screen, and Screen 2 also exposes it as a secondary CTA at peer weight to "See my options." This is the strongest single guardrail against the failure mode "we reduced calls by hiding help." **No change required.**

8. **No manufactured urgency or scarcity.** *(observed in artifact)* I scanned for "only X seats left," countdown timers, "act now," or red banners on the rebooking cards. None present. A 10:46 PM canceled-flight user already has enough urgency; manufactured scarcity here would be predatory. **No change required.**

9. **Loss frame is used honestly, not coercively.** *(observed in artifact, Screen 2)* The Screen 2 event block is alert-styled (amber stripe, warning icon) — that *is* a loss frame. But it frames the **factual loss** ("your flight is canceled"), not a manufactured loss to push a choice ("you'll lose this fare if you don't act in 10 minutes"). Honest loss framing is appropriate at the trust-floor; coercive loss framing on the choice cards would not be. The prototype keeps loss framing on the event and switches to neutral/gain framing on the choice cards (e.g., "Same fare," "Keep the value of your ticket"). That's the right asymmetry. **No change required.**

### Polish (ship-with, not blocking)

These are real but they would not, in my judgment, fail a dark-pattern audit. I list them so the lead can adopt or reject.

- **P-1 Fare-card visual asymmetry.** *(observed; recommendation)* Screen 4's 7:10 AM card uses `btn-primary` (filled brand color); the other two use `btn-secondary` (outline). Filled-vs-outline is a real salience cue. Defensible because 7:10 AM is the **only same-fare earliest flight** — a factual reason exists — but the prototype does not state that justification next to the visual emphasis. **Recommendation:** add one short line on the 7:10 AM card explaining *why* it's primary-styled (e.g., "earliest same-fare option"). Without that, we're anchoring without a stated reason — the same pattern we dropped "Recommended" to avoid. Low severity because the meta-row already says "earliest option," but the visual weight is doing work the copy isn't fully accounting for.

- **P-2 Family/party-size mention is text, not affordance.** *(observed; recommendation)* Screen 2 says "Traveling with others on this trip? They'll appear on the next screen so you can rebook everyone together." On Screens 3 and 4 I see no party-size indicator. A stressed family-event traveler scanning fast may not believe the next screen will surface the rest of the party. **Recommendation:** Screen 3 or 4 needs at least a placeholder "Rebooking for `{party_size}` travelers" line, even if it's a token. Otherwise the Screen 2 promise reads thin. *(Information Architect already flagged this as a scoped gap; I'm restating it as a behavioral trust risk, not just an IA gap.)*

- **P-3 "+ $84" framing.** *(observed; recommendation)* Screen 4 second card shows "+ $84" — loss-coded language ("difference," "more"). This is honest, but on a tired user it lands as a penalty. Defensible because $84 *is* a cost, but the team could consider neutral framing ("nonstop, $84") to remove the implied judgment. Low severity; leaving as-is is also defensible because making it easier to choose the paid option would be the opposite dark pattern. I lean toward **keep as-is.**

- **P-4 Screen 5 "Send me a copy" is primary; "If plans change" is secondary.** *(observed)* This is correct prioritization (save-the-receipt is the durable behavior), but I want to flag that the "plans change again" path must remain easy to find on return visits, not just on first confirm. Already supported by Talk to someone in the footer. **No change required**, noted for instrumentation.

- **P-5 SMS bubble caption is good, slightly over-long.** *(observed)* "Sent from a no-reply line. If anything looks off, call the number on the back of your boarding pass or your card." This is anti-phishing trust-floor copy and I support it. Polish: it competes with the action link. Could be smaller/quieter. Not blocking.

---

## Choice-architecture review

I'll walk the four decision moments in order.

### Moment 1 — SMS trust gate (Screen 1)

- **User state:** tired, possibly suspicious it's a scam, possibly hasn't internalized the flight is gone.
- **Architecture:** plain-language event, named airline as verified sender, cause stated, link is the only action.
- **Behavioral read:** **good.** The bubble is doing acknowledgment first (System 1 needs to land before System 2 can choose). The "verified sender" cue, plus the anti-phishing caption, addresses the rational distrust a 10:46 PM message provokes. *(inferred from artifact + behavioral first-principles)*

### Moment 2 — Acknowledge & orient (Screen 2)

- **User state:** confirming reality; checking they're not stranded.
- **Architecture:** event statement → reassurance ("you have options, and we can help cover tonight's stay and food") → factual block → CTAs.
- **Behavioral read:** **good.** Reassurance precedes choice. The Fogg model is relevant here: this screen prepares **motivation** ("you're not alone in this") and **ability** ("the next tap shows your options") before the prompt ("See my options"). If we had jumped straight from the event to a four-card choice list, we'd have skipped the reassurance step that converts panic into deliberation. *(inferred)*
- **One thing I'd push on:** the secondary CTA "Talk to someone" sits at peer weight to "See my options." This is intentional and correct — we are *not* hiding the human path — but it does mean some users will skip self-service entirely on this screen. That's a feature, not a bug, **but it must show up in the measurement plan** so we don't post-hoc rationalize a call-volume increase. *(recommendation, see Experiment plan.)*

### Moment 3 — Choose your path (Screen 3)

- **User state:** comparing four behaviors under cognitive load.
- **Architecture:** Rebook → Standby → Credit → Hotel/Meal, plus refund-as-dead-end note.
- **Behavioral read:** **good with one observation.**
  - Order matters. Rebook is first because it is the dominant user goal (the brief says people are abandoning to *call*, which is overwhelmingly to rebook). Standby second forces the user to encounter "No confirmed seat" before they encounter Credit, which prevents standby-as-default-rebook confusion. Credit third (de-prioritized vs. legacy, which defaulted it). Hotel/Meal fourth as a peer not a footnote.
  - Four cards is at the edge of choice overload but acceptable because each is a distinct behavior, not a feature variant. *(assumption: users are choosing **between behaviors**, not optimizing within a behavior — that's why four is okay where four flight cards might not be.)*
  - The refund-note placement *after* the cards is the right choice. If it were a fifth card, it would imply refund is in the flow. As a note below, it functions as "you have one more option, here's how to get it" without overpromising. *(recommendation: do not promote to a card later.)*

### Moment 4 — Pick a flight (Screen 4)

- **User state:** picking a specific time; arrival-time-anxious if family event.
- **Architecture:** three time-ordered flight cards, fare delta visible, one primary-styled CTA on 7:10 AM, two secondary on the others.
- **Behavioral read:** **mostly good; see P-1 above.** Time-ordered is correct (default sort is the strongest anchor; chronological is least loaded). Fare delta is visible but not headlined. **The primary/secondary styling of the choose-this-flight buttons is the one architecture detail that earns scrutiny** — it nudges toward 7:10 AM without naming why. P-1 above proposes the fix.

### Moment 5 — Confirm & save (Screen 5)

- **User state:** seeking proof, wanting to put the phone down.
- **Architecture:** confirmation banner → restated flight → summary block → tonight's logistics → save-a-copy CTA → "if plans change again" secondary → persistent Talk-to-someone.
- **Behavioral read:** **good.** Peak-end rule applies here: the *end* of the recovery experience shapes the memory of the whole thing. Ending with "we won't leave you stuck" and a saved-receipt action — not "Done" — is the right end-frame. The legacy "Done" button was a peak-end failure because it left the user with no proof, no fallback, and no logistics confirmation. *(inferred from brief vs. observed in artifact.)*

---

## Dark-pattern audit (explicit checklist)

For each well-known pattern, I name what I looked for and what I found.

| Pattern | Looked for | Found |
| --- | --- | --- |
| Forced continuity | Auto-enrollment, opt-out billing, locked-in credit | None observed. Credit is opt-in, refund channel named. |
| Confirmshaming | "No thanks, I don't want to save money" style decline copy | None observed. CTAs are neutral. |
| Roach motel | Easy in, hard out (e.g., easy credit acceptance, hidden refund) | Mitigated by the refund dead-end note on Screen 3 and Talk-to-someone persistence. |
| Manufactured urgency | Countdowns, "X seats left," red flash messaging | None observed. |
| Drip pricing | Fare delta revealed late | Fare delta on the card on Screen 4, not after selection. Honest. |
| Hidden cost | Fees revealed in Screen 5 that weren't visible on Screen 4 | None observed. Summary block uses confirmation/baggage tokens, not surprise fees. |
| Disguised ad / recommendation | "Recommended" badge with hidden interest | Dropped. P-1 flags residual visual-weight question on 7:10 AM. |
| Friend-spam / social proof | "12 people just booked this flight" | None observed. |
| Decoy pricing | Third option designed to make a target look better | The 2:40 PM card is the only paid option, framed honestly. Not a decoy structure. |
| Hidden support / help | Phone/chat buried behind FAQ | **Inverted.** Talk-to-someone is on every screen at peer weight on the entry screen. |

**Net:** I find zero blocking dark patterns in the current prototype. The IA spine and the visual execution both held the trust line.

---

## Loss vs. gain framing — explicit check at 10:46 PM

A tired stressed user at 10:46 PM is in a **loss-averse, present-biased state** *(inferred from context)*. They will over-weight immediate certainty (bed tonight, a confirmed seat tomorrow) and under-weight long-term value (credit for a future trip).

- The prototype puts certainty-yielding actions (Rebook, Hotel/Meal) **first and visually peer** to the deferred-value action (Credit). That is the correct response to present bias: don't fight it, design with it. *(recommendation: do not re-order to put Credit higher in any future iteration; that would exploit present bias instead of respecting it.)*
- The Confirm screen ends on a gain frame ("Booked. A copy is being sent…") not a loss frame. Correct for peak-end.
- The single loss frame (Screen 2 event block, amber/warning) is reserved for the **factual event** and is not used to coerce a choice. That asymmetry is the design's most important behavioral discipline.

---

## "Reduced calls by hiding help" — risk assessment

The brief is explicit: "The business still wants to reduce calls, but not by hiding help." The lead must run this red-team question personally; I will give my read.

**My read: the prototype is structurally protected against this failure mode** because:
1. Talk-to-someone is **on every screen**, in a stable footer location, with peer weight on Screen 2.
2. The refund note **explicitly routes to Talk-to-someone**, meaning the design proactively *creates* calls for the use case that should call.
3. The hotel/meal path is **inside self-service**, so users who would otherwise call to confirm "do I get a hotel?" can resolve it in-app — which is good-call-reduction, not hidden-help-call-reduction.

**The risk that remains** is instrumentation, not design. If we only measure total call volume and it drops, we can't tell whether we reduced legitimate distress calls (good) or suppressed refund-seekers and family-rebookers (bad). **That is why the experiment plan below puts a refund-seeker-and-complex-case call-share guardrail at peer status with the primary metric.**

---

## Experiment plan

### Hypothesis

A flow that (a) opens with honest cause and reassurance, (b) presents four recovery behaviors as peer choices with no default, (c) surfaces hotel/meal support as a peer card, and (d) names refund as an explicit dead-end to a human will increase successful self-service recovery **without** suppressing the user segments who should reach a human.

### Primary metric

**Successful self-service recovery rate within 30 minutes of SMS tap**, defined as: user reaches Screen 5 (or equivalent confirmed end-state) for one of {rebook confirmed, standby joined, credit accepted, hotel/meal support added} **without** abandoning to call or web-search.

- **Direction:** up.
- **Expected effect:** I will not invent a number. The team should pre-register a minimum detectable effect based on legacy baseline; without that baseline I won't fabricate a target. *(assumption: legacy baseline is measurable; if not, this experiment is not ready to run.)*
- **Interpretation:** an increase here is *necessary but not sufficient*. It must be paired with the guardrails below to be trustworthy.

### Secondary metrics

1. **Per-path distribution of recovery completions** (rebook vs. credit vs. standby vs. hotel-only). Reading the *shift* in distribution is more informative than the headline rate. If credit completions go up while rebook completions stay flat, that's a different story than if rebook goes up and credit stays flat.
2. **Time-to-first-decision** (SMS tap → first path-card click on Screen 3). A reduction signals improved comprehension, not just compliance.
3. **Hotel/meal support adoption rate** among eligible users. *(observed problem: legacy hides this; the test is whether surfacing it as a peer card actually increases use.)*
4. **Screen 5 confirmation save-a-copy rate**. Proxy for peak-end satisfaction and offline-backup trust.
5. **Return-to-flow rate within 24 hours** (user re-opens the flow after first confirm). Could indicate things are going well (checking details) or going badly (re-opening because they don't trust the outcome). Cross with calls.

### Guardrail metrics (must catch the "hidden help" failure mode)

These are the metrics that would *invalidate* a headline win. Any of them moving in the wrong direction means the design failed even if the primary metric is up.

1. **Call rate among refund-seekers** (segmented). If we can detect refund-intent (e.g., user clicks Talk to someone from the refund note, or post-call topic tagging shows refund), this group's call rate **should go up or stay flat**, never down. A drop here means we hid the refund path or made it feel discouraged. *(This is the single most important guardrail.)*
2. **Call rate among multi-passenger / family bookings**. If complex cases call less *without* completing self-service more, we've suppressed them. *(observed scoped gap from IA.)*
3. **Post-trip CSAT or one-question trust score** ("Did Northstar treat you fairly during the cancellation?"). If self-service goes up but trust goes down, we won. The user lost.
4. **Reversal/complaint rate within 7 days** (refund disputes, chargeback initiation, social complaints about the recovery flow). Lagging indicator. Critical.
5. **Hotel/meal support claims via call channel** that *could* have been resolved in-app. A spike here means users didn't believe the in-app offer was real — a trust failure even though the design surfaced it.
6. **Total call volume**, by topic. **Not** as a success metric — as a guardrail to be read *alongside* topic distribution. A drop in total calls with a flat refund-call rate is good. A drop in total calls with a drop in refund-call rate is suspect. *(This is the metric that would prove the flow reduced calls by hiding help, which is the question the red-team checklist explicitly asks.)*

### Falsifiers (any one of these means the design failed, regardless of primary metric)

- **F-1 (primary falsifier):** Refund-seeker call rate drops by a non-trivial margin while total recovery completions rise. Means the dead-end note suppressed refund-seekers instead of routing them. The design failed the trust floor.
- **F-2:** Hotel/meal adoption in-app rises but hotel/meal-related call volume also rises. Means users don't trust the in-app offer is real — they confirm by calling.
- **F-3:** Trust score (CSAT or equivalent) drops even though self-service rate is up. Means we built a more efficient bad experience.
- **F-4:** Standby-pick rate climbs sharply and standby-related complaints rise. Means the "No confirmed seat" consequence sentence is not landing visually and users are picking standby thinking it's a confirmed rebook.

### Minimum experimental discipline

- **Pre-register the primary and guardrails before launch.** Post-hoc metric selection is the most common way to ship a dark pattern without realizing it. *(recommendation, non-negotiable.)*
- **Run for at least two operationally distinct disruption events** (e.g., one crew, one weather, one mechanical) before declaring a win. A flow that works for crew cancellations may fail for weather-IRROPS where the airline owes less. *(recommendation, scoped gap.)*
- **Segment by user state:** mobile-only, family bookings, screen-reader, low-bandwidth. Headline rates can hide segment failures. *(handoff to research/analytics, but the experiment plan must require it.)*

---

## Notes for the lead / final memo

- I find **zero blocking dark patterns** in the current prototype. The IA spine held; the visual execution carried it through. The team did not need to ship a coercive flow to meet the business goal, and the artifact proves it.
- **The single biggest residual trust risk is instrumentation, not design.** If this ships without the refund-seeker call-rate guardrail at peer status with the primary metric, a quiet failure mode (suppressing refund-seekers and complex-case callers) becomes invisible. **The memo experiment plan must name the guardrail explicitly.**
- **One polish item I'd ask the visual designer to consider** is P-1 (the 7:10 AM card's primary-styled CTA is doing salience work the copy doesn't fully justify). It's not a blocker; the meta-row "earliest option" partially earns the emphasis. If revision time exists, surface the *reason* for the emphasis next to the visual signal so we're anchoring transparently.
- **The refund-as-dead-end note on Screen 3 is the single design move I'd most want preserved through future copy reviews.** It is the strongest anti-dark-pattern in the flow. Softening it ("refunds may be available," "in some cases") would convert a visible honest dead-end into a hidden one. Hold the line.
- **Peak-end is doing real work on Screen 5.** Ending on "we won't leave you stuck" plus a save-a-copy CTA, instead of "Done," is the difference between a recovered trust relationship and a remembered ordeal. Do not let a future trim cycle replace "If support isn't showing as added in 10 minutes, tap Talk to someone — we won't leave you stuck" with "Contact support if needed." The current copy is doing the trust work; the trimmed version would not.
- **Falsifier to feature in the memo:** F-1 (refund-seeker call rate dropping while total completions rise). That is the test the lead's red-team checklist is implicitly asking for — "what metric would prove the flow reduced calls by hiding help" — and the memo should adopt it explicitly.

---

## Claim labels — summary

- **Observed in artifact:** cause framing on Screen 2, refund dead-end note on Screen 3, hotel/meal as peer card, standby consequence line, no default selection on Screen 3, no "Recommended" badge, persistent Talk-to-someone, no manufactured urgency, primary/secondary CTA styling on Screen 4, save-a-copy CTA on Screen 5, party-size mention on Screen 2 with no follow-through affordance on later screens.
- **Inferred:** user state at 10:46 PM (loss-averse, present-biased, suspicious); legacy pattern decoded from brief (default-to-credit, hidden support, "Recommended" anchoring); peak-end relevance on Screen 5; Fogg motivation/ability/prompt sequencing on Screen 2.
- **Assumption:** legacy baseline call rate is measurable for primary metric; refund-intent and family-booking segments are detectable in production analytics; the experiment can run across more than one disruption type.
- **Recommendation:** preserve refund dead-end copy verbatim; consider P-1 (justify the 7:10 AM card emphasis with a stated reason); add party-size token affordance to Screens 3 or 4; pre-register guardrails including refund-seeker call rate; do not declare win on primary metric without trust-score and complaint-rate guardrails reading clean.
