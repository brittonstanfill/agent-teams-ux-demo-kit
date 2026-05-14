# Behavioral Scientist — Northstar Canceled-Flight Recovery

**Role:** Behavioral Scientist (choice architecture, trust, ethics, experiment design)
**Scope:** Trust risks, choice architecture, ethical nudges vs. dark patterns, experiment ideas
**Inputs used:** Brief. No invented metrics or studies. Behavioral principles referenced by name only.

---

## Top 3 Findings

1. **The current default ("Travel credit") is a dark pattern even if unintentional.** [observed from brief + recommendation] Defaulting a cancellation user to *give up their flight for credit* exploits status-quo bias and decision fatigue against the user's interest. The product captures revenue (credit retained on the books) at the cost of the user's actual goal (get to the family event). This is the single highest-leverage fix.
2. **"Recommended" without an explanation is a trust accelerant in the wrong direction.** [observed from brief] An unexplained badge from a party that just disrupted the user's plan is asking for trust the user has no reason to extend. Either explain it ("Best match: earliest, no extra cost") or remove it.
3. **The biggest behavioral risk in the redesign is *over-correcting toward the airline's preferred option*.** [recommendation] When we put a "Best match" with a reason and default to "See rebooking options," we are exercising influence. That influence is acceptable *if* it tracks the user's stated goal and is reversible. We must guard against future PMs tuning the recommendation to favor margin or load-balancing instead of user goal.

---

## Evidence Labels

- **[Observed from brief]:** SMS jargon ("schedule irregularity"), default tab is Travel credit, "Recommended" badge unexplained, "$84 fare difference" shown during disruption, hotel/meal hidden in FAQ, "Trip updated/Done" non-detail confirmation.
- **[Inferred]:** Many users abandon and call support [observed]; the abandonment is likely driven by ambiguity and distrust, not by feature gaps.
- **[Assumption]:** Northstar's leadership tolerates ethical-nudge framing and is willing to default toward user benefit, not credit retention.
- **[Recommendation]:** Default to rebook; explain badges; surface entitlements; provide undo; never use time pressure; treat reversibility as table stakes.

---

## Behavioral Principles in Play (named, not invented)

- **Default effect / status-quo bias:** users disproportionately accept the pre-set option. *Implication:* whichever tab/option is default carries enormous influence. The current default ("Travel credit") works against the user's likely goal.
- **Decision fatigue:** at 10:46 p.m. after a disruption, choice quality drops. *Implication:* reduce options per screen, exaggerate hierarchy, make consequences visible.
- **Ambiguity aversion:** under uncertainty, people pull back from action (or call a human). *Implication:* every label that obscures the consequence (Continue, Done, Recommended, Other policies, Schedule irregularity) is a call-to-support generator.
- **Loss aversion:** losses sting more than equivalent gains. *Implication:* avoid framing the cancellation as a *fee* ("$84 fare difference"); frame it accurately as the user's choice to upgrade.
- **Endowment effect:** users feel they "own" their original flight; converting it to a credit feels like loss, not equivalence. *Implication:* the "credit" path needs explicit framing (and should not be default).
- **Anchoring:** the first piece of information dominates judgment. *Implication:* the SMS and Screen 1 headline anchor the entire flow. "Schedule irregularity" anchors confusion; "Your flight is canceled — we're holding options" anchors action.
- **Reactance:** when users feel manipulated, they bail. *Implication:* pseudo-urgency timers, manipulated defaults, and unexplained "Recommended" badges trip reactance and cause the user to disengage or escalate.
- **Trust calibration:** trust is rebuilt by *naming uncertainty honestly*, not by reassuring boilerplate. *Implication:* "We may have a hotel option" beats "we're sorry for the inconvenience."

---

## Choice Architecture Audit (current flow)

| Element | Current | Behavioral diagnosis | Recommendation |
|---|---|---|---|
| SMS subject line | "Schedule irregularity" | Ambiguity aversion → calls; anchoring on confusion | Plain event-first |
| Default tab | "Travel credit" | Default effect against user goal; endowment effect (feels like loss) | Default to rebook; expose credit clearly but secondary |
| "Recommended" badge | Unexplained | Reactance + trust failure | Explain with verifiable reason |
| Fare difference during disruption | Numeric only | Loss aversion + trust failure | Frame: when it applies; when it's $0 |
| Hotel/meal in FAQ | Hidden | Effort barrier + ambiguity aversion | Visible at decision time as named action |
| "Continue" / "Done" | Non-descriptive | Ambiguity aversion → hesitation → bail | Consequence-bearing labels |
| Confirmation | "Trip updated" | No completeness signal; user can't tell if it worked | Itinerary block + undo + offline backup |
| Time pressure on hold | (Unknown — inferred) | Reactance + decision fatigue | Avoid countdown panic on the choice; if hold required, factual statement |

---

## Choice Architecture for the Redesign

### Defaults (the high-leverage levers)

- **Default landing:** rebook is the named primary action, *not* a tab default. (Distinction: the user doesn't land on "Travel credit selected"; they land on "See rebooking options" as primary CTA and "Other recovery options" as secondary.)
- **Default sort on flight list:** "Best match" — earliest acceptable arrival with no extra cost. This is a user-goal-tracking default, not an airline-goal-tracking one. *Guardrail:* the user can re-sort (by price, by arrival time) without losing context.
- **Default "request hotel"** if the new flight is the next morning or later, **off otherwise.** Surface the toggle either way. Do not pre-check things that cost the user money (would be a dark pattern); do pre-check things that *save* them or get them *help* (ethical default).
- **Default communication channel:** outbound SMS + email at confirmation. Both, by default. User can opt out, but the default protects them.

### Framing

- **Loss vs. choice framing of fare difference.** $0 is the default option; $84 is the user's choice to upgrade. Frame it that way, not as a "fee."
- **Reassurance through naming uncertainty.** "We *may* have hotel help available; we'll check while you rebook" reads as trustworthy. "Hotel guaranteed" (if false) destroys trust; "Hotel sometimes available" (corporate hedge) destroys trust differently.
- **Specificity beats reassurance.** "We'll text you 3 hours before boarding" earns more trust than "We'll be in touch."

### Friction (where to add, where to remove)

- **Add friction at the commit step (Screen 3 Review).** The two-step commit is *ethical friction*: it surfaces the consequences before the change. This isn't a dark pattern — it serves the user.
- **Remove friction at the entitlement step.** Hotel and meal help should be one tap, not buried in a FAQ. Friction here serves only the airline.
- **No friction in the form of time pressure on choices.** Inventory holds are stated factually with reassurance, not as a countdown.

### Reversibility

- **60-second undo on rebook** is an explicit trust signal. It says: "we trust you to choose, and we won't trap you." This is the strongest ethical-nudge counter-balance to the "default to rebook" choice.

---

## Trust Risks (where the redesign could *lose* trust)

1. **Recommended → "Best match" framing risks new mistrust** if users feel the "best match" isn't actually theirs. *Mitigation:* the reason text must be verifiable on the card ("earliest, no extra cost"), and the user can re-sort easily.
2. **Persistent "Get help" + always-visible phone number could read as performative.** If users call and the line is busy or hours are wrong, the visible affordance becomes a betrayal. *Mitigation:* honest hours and a backup ("If we don't pick up in 5 min, text HELP to ...").
3. **Hotel "you may qualify" phrasing risks reading as evasive.** *Mitigation:* pair with an action ("We'll check while you rebook") so the user sees motion, not equivocation.
4. **Undo window could feel like a trap** if it's a hold-down-to-confirm gesture or has surprise UI. *Mitigation:* simple labeled button, no timer panic, announced once.
5. **Defaulting to outbound SMS + email could feel intrusive** if the user has notification fatigue. *Mitigation:* allow opt-out, but default protects the user.
6. **Confirmation completeness** is itself a trust risk — if the new flight number / terminal / hotel isn't there, the user assumes the system failed.

---

## Dark Patterns to Avoid

| Pattern | Where it could appear | Mitigation |
|---|---|---|
| Default to credit | Tab default | Default to rebook |
| Hidden costs | Surprise charges at confirm | Cost shown on flight card and on review screen |
| Pseudo-urgency | "Hurry, only 2 seats left!" | State factually if applicable; no manipulated scarcity |
| Forced action | Required choice with no back-out | Back-out path on every screen until commit |
| Confirmshaming | "No thanks, I want to be stranded" | Plain language on all secondary actions |
| Roach motel | Easy to opt in, hard to opt out | Undo + Call support + opt-out of notifications |
| Bait and switch | "Recommended" that serves airline, not user | Explained reason on every "Best match"; default sort by user goal |
| Disguised ad / upsell | "$84 fare difference" framed as required | Framed as user choice; $0 always offered |
| Trick question | "Uncheck this box to *not* opt out of *not* receiving" | Clear single-meaning toggles |
| Cookie-jar entitlements | Hotel buried in FAQ | Hotel as a first-class action |
| Pre-checked upsells | Hotel pre-checked at user expense | Pre-check only things that *help* the user; never things that *charge* |

---

## Ethical Nudges to Keep

1. **Default to rebook** (tracks user goal, reversible).
2. **Default-on outbound SMS + email** at confirmation (protects against device failure).
3. **Default-on hotel suggestion** when overnight (surfaces a benefit the user is entitled to find).
4. **"Best match" sort** (reduces decision fatigue, transparent reason).
5. **Two-step commit** (surfaces consequences before the destructive action).
6. **Persistent "Get help"** (raises the floor of trust; counter-intuitively *may* reduce calls, see experiment plan).
7. **Undo window** (asymmetric ethical signal: airline trusts the user enough to allow reversal).
8. **Honest hours and uncertainty** ("we may have hotel help") (calibrates trust over the long run).

---

## Experiment Plan

> Each experiment has a hypothesis, a primary metric, a guardrail metric, and an exit condition. No invented numbers — just structure.

### Experiment 1 — Default landing

- **Hypothesis:** Defaulting the recovery flow to "rebook" (vs. the current "travel credit" tab) increases successful self-service rebooking *and* reduces support calls without harming credit redemption.
- **Primary metric:** successful self-service rebook rate within 30 min of cancellation SMS.
- **Guardrail metrics:** support-call rate; downstream complaint rate; downstream "rebooked into wrong flight" rate.
- **Cohort:** cancellation users routed to the new flow, randomized 50/50.
- **Exit / decision rule:** stop and ship if primary metric improves with no guardrail regression; stop and revert if calls or wrong-flight rate worsens.
- **Why this is ethical to test:** the current default is harming user goal; we are testing whether the corrected default *also* serves the business.

### Experiment 2 — "Best match" reason

- **Hypothesis:** A "Best match" badge with an inline reason ("earliest, no extra cost") drives higher selection of the recommended flight *and* higher post-trip CSAT than a label-only "Recommended" badge.
- **Primary metric:** selection rate of the recommended flight.
- **Guardrail:** post-trip CSAT and "I felt manipulated" survey item.
- **Note:** if the reason is generated dynamically, the experiment must include a guardrail for *unexplained* "Best match" cases — none should ship without a reason.

### Experiment 3 — Hotel surfacing

- **Hypothesis:** Showing a "Get hotel help" entry on the rebook screen (vs. only in FAQ) increases hotel-help uptake among eligible users *without* over-claiming.
- **Primary metric:** hotel-help requests submitted by eligible users.
- **Guardrail:** denied-request rate (over-claiming proxy); support-call rate.
- **Important:** measure *eligible-user* uptake separately from ineligible-user attempts. If the redesign causes a flood of ineligible attempts, that's a copy / IA failure to fix, not a reason to bury hotel again.

### Experiment 4 — Undo window

- **Hypothesis:** A 60-second undo window after rebook reduces "rebooked, then called to change" volume *and* increases self-service confidence (CSAT).
- **Primary metric:** "rebook → undo" rate, and "rebook → support call within 24h" rate.
- **Guardrail:** any technical cost / inventory-thrash from undo; user confusion ("did my rebook actually stick?").
- **Note:** an undo *increase* is the success signal here, not a failure signal. The hypothesis is that surfacing reversibility makes users *more* willing to commit.

### Experiment 5 — Persistent "Get help"

- **Hypothesis:** A visible, consistently placed "Get help" affordance reduces total support calls (counter-intuitive: trust → self-serve).
- **Primary metric:** support-call rate per cancellation event.
- **Guardrail:** time-to-resolution, CSAT, "I felt abandoned" survey item.
- **Risk:** if the call line is under-staffed, visible affordance may *increase* calls and erode trust. Coordinate with support ops before testing.

### Experiment 6 — Pre-commit review screen

- **Hypothesis:** A Review screen (vs. one-tap commit) increases successful rebooks (fewer abandonments at the "did I just do something wrong?" moment).
- **Primary metric:** completion rate from flight-card-tap to confirmed.
- **Guardrail:** total time-in-flow; "wrong rebook" support escalations.

---

## Handoffs Sent

### → content-designer

**Subject: Ethical framing risks in copy**

Specific risks I'm asking you to scan your copy for:

1. **"Recommended"** anywhere in the flow → must become "Best match" *with* a verifiable reason on the card. (You've done this — flagging so it stays.)
2. **Fare-difference language** → must frame $84 as the *user's choice to upgrade*, with $0 always offered as the default. Not "fare difference" (sounds like a charge for the cancellation).
3. **Hotel "you may qualify"** → I support this. It's honest, not evasive. Pair it with a verb so the user sees motion ("We'll check while you rebook"). Avoid "If eligible" (legal-speak that triggers ambiguity aversion).
4. **No urgency / countdown language on choice screens.** "Hurry," "limited time," "only X seats left" — pseudo-scarcity is a dark pattern. If hold timers must appear, factual statement only.
5. **"Continue" / "Done" / "View details"** must never reappear (label ambiguity = ambiguity aversion). You've handled this.
6. **No confirmshaming on the credit / standby alternates.** "I'd rather have a travel credit" is fine; "No, I don't want to be stranded" is a dark pattern.
7. **Outbound SMS / email confirmation copy** is itself a trust instrument — keep it factual and complete (flight #, time, terminal, code, hotel, support number). Don't add marketing.

### → interaction-designer

**Subject: Choice-architecture risks in flow**

1. **Default landing → primary CTA "See rebooking options"** (not a tab default for "Travel credit"). The default effect is the highest-leverage lever in this flow. Confirm this is how the screen actually behaves.
2. **Default sort = "Best match"**, but the user can re-sort freely without losing selection. Re-sorting should announce ("Showing flights sorted by price") for screen-reader users, per accessibility.
3. **"Request hotel" toggle default:** ON when the new flight is overnight or later; OFF otherwise. Surface either way. Do not pre-check anything that *charges* the user.
4. **Undo window is a real state, ethically required for the "default to rebook" choice.** Removing it weakens the ethical justification for defaulting to rebook.
5. **Inventory hold communication:** *do not* show a countdown timer on Screen 2 ("Hurry, this seat reserved for 4:59!"). If a hold exists, state it factually on Screen 3 ("This seat is held briefly while you review"). The asymmetry matters — pressure on the choice is a dark pattern; reassurance on the review is not.
6. **Two-step commit is consequence surfacing, not friction-for-friction's-sake.** Don't let it become a five-step confirm chain.
7. **No "Are you sure?" modals** on plain back-out actions. Reactance.
8. **Standby framing:** must say "not a guaranteed seat" inline (you and content-designer both agreed). Defaulting to standby = dark pattern; offering standby = fine.

---

## Handoffs Received

| Sender | Message | What changed |
|---|---|---|
| (none direct at write time; integrated brief + IA + a11y from their reports) |  |  |

---

## To Team Lead (status)

**Top 3 findings:** flipping the default from credit to rebook is the highest-leverage fix; explained "Best match" beats unexplained "Recommended"; the undo window is the ethical counter-weight that makes "default to rebook" defensible.

**One tension:** I want the persistent "Get help" affordance highly visible; content-designer and IA agree; but I am worried it could *increase* support calls if the call line isn't staffed for it. This is a business / ops dependency, not just a design choice. Flagging for synthesis.

**Messaged:** content-designer, interaction-designer.
