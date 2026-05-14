# 09 — Devil's Advocate: Stress-Test of the Northstar Consensus

*Note: this report was authored by the Devil's Advocate agent and persisted by the team lead — the DA agent's tool set excludes Write, so the lead copied the analysis verbatim from the DA's chat output into this file. No content edits.*

## 1. Steel-man (≤250 words)

At 10:46 p.m., a tired traveler with a family event tomorrow needs three things in order — fact, options, proof — before working memory degrades further. The team's design earns its choices: the operational header refuses apology-theater that the user reads as gaslighting; the side-by-side path cards with consequence copy convert what was a default-tab dark pattern into a forced-comparison the user can scan in one pass; the persistent entitlements strip makes "do I get a hotel" answerable without hunting through FAQs; the screenshotable receipt with `tel:` visible-without-tap closes the trust loop that the old "Done" screen broke. The four-screen IA — Status & Stake → Choose → Confirm → Receipt — eliminates the dead-weight "Continue" interstitial. IxD's two-beat held-seat-expired sequence, sheet focus trap, and localStorage-on-tap selection persistence are correctly defensive without performing competence. BS's three conditional fixes (Screen 2 default disabled, eligibility filter, "Plans changed?" stays tertiary) close the action-bias loopholes. A11y's B1-B8 fixes make the AT path match the visual one rather than degrade to a second-tier experience. CW's "together" call, cut "Why?", and 157-char SMS are defensible by data, not preference. The whole composition reads as one consistent register — *operational honesty filtered through Linear restraint* — and that consistency is itself a trust signal. A proponent reading this should feel: yes, we made the right calls, and we named the conditions under which they're right. (observed-from-reports)

---

## 2. The five attacks I'd run

### Attack 1 — "The happy path is the only path that's been authored"

**One-liner:** The design is a four-card demo of a single canonical scenario (one canceled segment, one booking, one party, one disruption type); the IA's "edge cases" section names harder cases but does not show them designed. (observed-from-reports: IA §6 names connecting itinerary, multi-passenger, second-cancellation; only second-cancellation has CW strings; none have VD mocks)

**Hidden assumption exposed:** that the canonical case is the modal case — that most cancellation events look like NS482-DEN-LGA-one-flight. (assumption)

**Specific failure mode:** A user whose canceled segment is leg 2 of a 3-leg itinerary, or whose travel companion is on a separate booking record, arrives at Screen 1 and the fact line is structurally wrong — "Your 6:15 a.m. flight tomorrow is canceled" doesn't capture "your DEN→ORD leg is canceled but ORD→LGA still operates." The operational header's "fact then state" pattern collapses when "the fact" requires two sentences.

**Plausible scenario:** Maya, 38, returning from a conference. Booking is DEN→ORD→LGA; her partner booked DEN→LGA nonstop on a separate PNR for the same family event. NS482 (her DEN→ORD) cancels at 10:46 p.m. The app's header reads "Your 6:15 a.m. flight tomorrow is canceled." She doesn't know whether her ORD→LGA leg is dead too. She doesn't know whether the rebook will route her partner. She calls. (inferred)

**Lightest falsification:** Pull 50 anonymized recent cancellation events from production and tag: how many fit the canonical "single-segment, single-booking, single-party" frame? If <60%, the canonical case is not modal and the design is overfit. (recommendation)

**Strength: serious.** Not devastating — the IA frame can extend — but the team has not done the extension, and shipping a flow whose happy path is the only authored path is how 80% of disruptions become call drivers. (assumption)

---

### Attack 2 — "Calm authority is condescending to a competent operator"

**One-liner:** The "operational NOTAM" register is built around the leisure-traveler emotional arc (jolted-awake, not-yet-oriented); a business traveler who books five flights a week experiences this register as the airline lecturing them. (observed-from-reports: UXR §2 names emotional state explicitly as "tired, stressed, family event tomorrow"; CD anchor names "the traveler is, at 10:46 p.m., effectively an operator of their own rescheduling problem")

**Hidden assumption exposed:** that the user-state model is unimodal — that all 10:46 p.m. cancellation recipients are in roughly the same cognitive/emotional posture. (assumption / convenient)

**Specific failure mode:** The bold "**You have not been rebooked yet**" and the "Pick a path." h1 on Screen 2 read as *helpful* to Maya; they read as *patronizing* to a road-warrior whose internal monologue is "I know I haven't been rebooked, that's why I opened the app, just show me the 6:30 a.m. ORD seat I can grab." The consequence copy ("You decide later. No flight is held.") is informationally redundant to someone who's done this before. Cognitive overhead added, not removed.

**Plausible scenario:** Devon, 44, management consultant, ~250 segments/year on Northstar. Cancellation SMS arrives during a working dinner. Opens the app, sees Screen 1's operational header, has to scroll past two cards explaining "you decide later, no flight is held" — content they could have parsed from the label alone. They abandon to the airline's website or call their corporate travel desk, because the mobile app's reading-level for power users is *slower* than the unrefined original. (inferred)

**Lightest falsification:** instrument median time-to-first-action on Screen 2 by user segment (>10 segments/year vs. <10/year). If high-frequency users spend >20% longer than low-frequency users at this surface vs. control, the register is taxing the wrong cohort. (recommendation) Alternative: a 5-user moderated session with named road-warriors.

**Strength: suggestive→serious** depending on the high-frequency-user share of disruption volume. If business travelers are 30%+ of disruption events, this is serious. (assumption — unmodeled by the team)

---

### Attack 3 — "Plain-language register is in tension with DOT-mandated refund language"

**One-liner:** US DOT cancellation/refund rules effective late 2024 (observed in industry — I will not invent specific text) require carriers to use specific disclosure language about automatic cash refunds and timeframes; CW's register ("Take $847 in travel credit. Good for 12 months.") may legally need to coexist with a verbatim refund-rights disclosure the team has not designed a slot for. (inferred from public regulatory context; the team's reports explicitly say "do not invent policy" — which means the design has not modeled what required-verbatim text looks like)

**Hidden assumption exposed:** that the team can ship operational honesty without inheriting regulatory verbatim. (assumption / convenient — the brief said "do not invent legal obligations" and the team treated that as "we can defer them"; in production those obligations exist whether the team modeled them or not.)

**Specific failure mode:** Legal review inserts a mandated refund-rights paragraph on the Credit-variant Screen 3, written in mandated regulatory prose ("You are entitled to an automatic cash refund for the canceled flight…"). It contradicts the Credit consequence line ("You decide later. No flight is held."). The user reads both, concludes the airline is hiding a cash refund behind a credit offer, and either (a) calls support to ask for cash, or (b) screenshots the contradiction for social media. The register collapses where the team's plain-language voice butts against required prose.

**Plausible scenario:** Same Maya, post-launch. Picks "Credit" on Screen 2 because the consequence line says "you decide later." Lands on Screen 3, sees the credit terms *and* a regulatory paragraph that says she's entitled to cash. She picks up the phone. The flow's confidence-collapse moves from Screen 4 (old) to Screen 3 (new). (inferred)

**Lightest falsification:** show the current Credit-variant Screen 3 to a single airline regulatory counsel and ask "what verbatim text must appear on this surface for our cancellation type?" If the answer is non-zero words, the design has an unmodeled slot and CW's register needs a co-existence pattern. (recommendation) The team can run this in 48 hours, not 8 weeks.

**Strength: serious.** Not devastating in the prototype phase, but the failure mode is at production launch, where regulatory text arrives non-negotiable. The team has explicitly punted this and called it scope discipline. It is also debt. (observed-from-reports; the brief constraint cuts both ways)

---

### Attack 4 — "Self-cannibalization: the receipt + entitlements strip is a business-economics suicide pact"

**One-liner:** The entitlements strip's salience + the receipt's "Hotel claimed — Marriott DEN Airport, breakfast included" line means hotel claim rates among eligible users will rise — possibly far above the rate the airline's operations and finance modeled before approving the redesign. (inferred from BS §1 strip salience verdict; BS §5 H3 hypothesis explicitly predicts ≥25% claim-rate rise as a success criterion)

**Hidden assumption exposed:** that the airline's business will tolerate a 25% rise in entitlement claims indefinitely. (assumption — the brief says "the business still wants to reduce calls, but not by hiding help"; it does not say "the business will absorb arbitrary cost increases.") (convenient)

**Specific failure mode:** Six months post-launch, ops/finance reviews the claim-rate delta, traces it to the strip, and either (a) silently quietly degrades the strip's prominence ("let's collapse it on Screen 2, users can still find it"), (b) reintroduces eligibility friction not for trust reasons but for cost reasons ("require a 4-hour delay confirmation before hotel claim enables"), or (c) raises the eligibility threshold so quietly that the strip is now broadcasting "Hotel and meal support available" to users whose backend eligibility check returns false. The flow's trust currency collapses because the strip was promising what the system stopped delivering. The team designed for trust; the business will optimize for cost; the design loses.

**Plausible scenario:** Q4 of next year. NPS holds, but hotel voucher spend is up 31% on disruption events. A finance leader asks: "Was this modeled?" No one has the answer. A PM proposes "we'll just hide it on the second screen." The strip pattern survives in name; the strip's promise dies in code. (inferred)

**Lightest falsification:** before launch, pull the airline's last 12 months of voucher spend on disruption events and model the strip-induced claim-rate at +25% (BS H3's exit threshold). If the modeled spend exceeds what finance has pre-approved for this experiment, the team needs explicit ops/finance sign-off on the projected cost — *before* launch, not after the success metric trips it. (recommendation)

**Strength: serious.** This is the attack the design team is least equipped to defend, because it lives in a domain none of the eight roles is responsible for. The Behavioral Scientist named it (§2.5) but framed it as a *user* dark-pattern (action-bias claims); the *business* dark-pattern (the airline will retract trust to manage cost) is not in BS's mandate. (observed-from-reports)

---

### Attack 5 — "The prototype is single-page authored HTML; production is a different system"

**One-liner:** The held-seat-expired focus-move-then-announce sequence, the localStorage-on-tap selection persistence, the sheet inert+focus-trap pattern, the eligibility-state machine on the strip, and the "Plans changed? Start over" preserve-prior-claims behavior are all spec'd in IxD/A11y reports — none of them exist in the prototype's HTML (which has `aria-modal="true"` markup but no JS, broken `aria-controls` references per A11y B6, and no eligibility state machine at all). The design's coherence depends on engineering shipping 100%. They will ship ~80%. The 20% gap is where the trust contract lives. (observed-from-reports: A11y B2, B6 explicitly call out the prototype-spec gap; IxD §1 lists 18 distinct states across surfaces, vs. the prototype's static markup)

*Lead's note: the VD revision pass shipped the sheet focus trap and other A11y B1-B8 fixes inline. The attack still stands on the broader spec set — the held-seat-expired two-beat sequence, the localStorage persistence, the full eligibility state machine — which remain spec-only.*

**Hidden assumption exposed:** that the team's spec rigor will survive an engineering scope-cut. (assumption / convenient — every team that has ever written a spec believes this; almost none survive intact.)

**Specific failure mode:** Engineering ships v1 with: the visual treatment intact, the path-specific CTA labels intact, the screenshotable receipt intact — and: (a) no sheet focus trap (it's "JS later"), (b) Screen 2 with Rebook pre-selected because the prototype showed it that way, (c) the "Plans changed? Start over" link present but the entitlement-preservation logic deferred to v1.1, (d) the held-seat-expired state with neither the two-beat sequence nor the focus-move-then-announce. The flow looks like the design. It behaves like a worse version of the old flow plus a teal accent.

**Plausible scenario:** Sprint-end pressure in eight weeks. The PM cuts "non-visible" tickets to hit the date. The cuts read as reasonable individually; collectively, they remove the load-bearing behavior layer. The flow ships, the visual press release is great, the support-call rate barely moves because the design's coherence was *behavioral*, not visual. (inferred)

**Lightest falsification:** before the synthesis meeting, ask engineering for a confidence-rated estimate (high/medium/low) on shipping each of the 18 IxD states + the 8 A11y blocker fixes in the launch window. If >5 land at "low confidence," the design has a feasibility problem the team has not surfaced. (recommendation) This is a 30-minute conversation, not a workstream.

**Strength: devastating** if the 80% scenario obtains, **weak** if engineering is in the design conversations. The team's reports do not name an engineering counterpart, which is itself signal. (observed-from-reports; inferred)

---

## 3. Where the team is most likely fooling itself

**Belief 1: "Visible debate produced design changes."** I see three named debates in the reports — party-size pattern (UXR/VD/IxD), Screen 2 default state (BS/IxD prototype-vs-spec), and "together" vs. "adjacent" (CW/A11y). Of these, only the party-size debate visibly changed an artifact (IxD's third option). The Screen 2 default debate produced a *recommendation to engineering* (BS handoff), not a prototype change. The "together"/"adjacent" debate produced *ratification of an existing call*. The team is mistaking *rigorous justification* for *productive disagreement*. The justification record is valuable, but the artifact only meaningfully shifted once. (observed-from-reports / assumption)

*Lead's note: the VD revision pass — driven by A11y B1-B8 + BS §2.1 — did materially change the prototype after consensus formed. That's a second artifact-level shift attributable to non-author teammates (A11y and BS). DA's belief-1 critique stands for the pre-revision state; the post-revision state has two clear non-author-driven shifts. Both shifts preserved here.*

**What would change my mind:** show me a second artifact-level shift in the prototype attributable to a teammate other than its original author. If there's only one, the team is producing the *appearance* of dialectic and the *output* of authorship. The process is good; the post-mortem framing of "visible debates" is generous.

**Belief 2: "The behavioral risks are all on the user-protection side."** BS's §2 catalogs six risks; five are user-protective (default effect, action-bias claims, commitment escalation, sunk-cost reframing, hectoring). One — §2.5 — touches on cost, but framed as *user trust* not as *business cost.* No role on the team has a mandate to model the business-economics consequences of the design (Attack 4). The team has internalized that "good for the user = good for the business because calls drop," and that may not be true if vouchers spike. (observed-from-reports)

**What would change my mind:** a single page in the synthesis estimating projected voucher spend at the BS H3 success threshold and confirming ops/finance has signed off on that envelope.

---

## 4. What I would NOT change

These survive the attacks; the team should defend them hard in synthesis.

- **Cut "Why?" on No-charge cards (CW §5).** The strongest counter is "users might want to verify why they aren't being charged." The counter loses: the link's presence creates the doubt it purports to resolve. CW's principled call is correct. (observed-from-reports)
- **No card pre-selected on Screen 2 (BS §2.1, IxD §1 `default`).** The strongest counter is "pre-selection reduces taps for the modal user." The counter loses: it re-introduces the default-effect dark pattern at higher visual weight than the old flow's tab default. The team must ensure engineering implements the *spec*, not the prototype's demo state. Non-negotiable.
- **Screenshotable receipt with tel: visible without tap (CD quality bar, VD §3, CW §3).** The strongest counter is "users have email confirmation, the screen is redundant." The counter loses: UXR's A5 acknowledges email habituation but the receipt's job is the *5-minute* trust object (between confirm and falling asleep), not the *next-day* one. The on-screen receipt closes the abandonment loop the brief identifies. (observed-from-reports)
- **Persistent strip, not a screen (CD move #3).** Survives Attack 4 *as a UX call*; Attack 4 attacks it as a business call. The UX argument for the strip is strong; the business cost-modeling is what needs to be added, not the strip removed.
- **"Together" over "adjacent" (CW/A11y §7).** Survives ESL, TTS, and plain-language scrutiny. The fallback "All 3 seats together" is the right belt-and-suspenders. Defend against late legal pressure to switch.

---

## 5. Recommended pre-mortem

It is November of next year. The redesign is being called a failure. Three plausible stories, ranked by plausibility.

**Story 1 (most likely): "It shipped 80%."** The Attack-5 scenario obtains. Visual layer ships intact, behavior layer ships partially. Held-seat-expired without two-beat sequencing causes a spike in "I tapped and it said no" support calls. Sheet without focus trap fails AT QA in the first month. The "Plans changed? Start over" link works but doesn't preserve entitlement claims, creating a small but vocal group of users who claimed a hotel, started over, and lost it. Support-call rate moves <5%; the press-release version of the design is what shipped, but the trust contract didn't. **Early-warning signal:** ask engineering for state-by-state ship confidence two weeks before launch.

**Story 2: "Voucher spend forced a quiet retraction."** Attack 4 obtains. Claim rate rises 30%+. Finance reads the delta. Six months in, the strip is collapsed on Screens 2 and 3 ("users still find it on Screen 1"). The eligibility check becomes more conservative; the strip displays "may apply" 60% of the time instead of "available." Users who tap learn the answer is often "no." The strip becomes the new "Other policies." **Early-warning signal:** model voucher spend pre-launch at BS H3's success threshold; require finance sign-off on the envelope.

**Story 3: "The register failed the road-warrior."** Attack 2 obtains. Business travelers — disproportionately frequent disruption events, disproportionately call-drivers when they don't self-serve — find the new flow's plain-language register slower than the old one. They abandon to corporate travel desks or to direct-to-call. Headline call rate ticks down because leisure travelers self-serve more; revenue-per-disruption from business travelers degrades because they're routing around the app entirely. **Early-warning signal:** slice metrics by user segment from day one (segments/year, fare class, corporate vs. retail booking).

---

## 6. Revised promotion criterion

Given the attacks, "winner" requires (data, not opinion):

1. **Self-service completion** rises ≥10pp vs. baseline, **and** segmented by user frequency (>10 segments/year and ≤10/year) the high-frequency cohort does not show >20% longer median time-on-Screen-2 (Attack 2 falsification).
2. **Path distribution** shifts ≥10pp from baseline credit-default *and* **regret-call rate within 48h** does not rise (BS H2 exit rule — the consequence-copy falsification).
3. **Eligible-user entitlement claim rate** rises ≥25% **and** **claim-then-cancel rate** within 12h stays flat **and** **modeled voucher spend** at this claim rate is within the ops/finance pre-approved envelope (BS H3 + Attack 4 closure).
4. **AT-cohort completion rate** is within 5pp of the sighted/default-zoom cohort (UXR §4 question 6 — the two-tier-product test). If it lags by >5pp, the design has shipped two products and only one is on the press release.
5. **Canonical-scenario coverage:** for the 50 most recent disruption events post-launch, ≥75% are served without manual edge-case routing (Attack 1 — overfitting falsification). Multi-leg, multi-booking, multi-party events must be either handled by the design or routed cleanly to support, with the routing measured.
6. **Regulatory verbatim coexists with the operational register** on the Credit variant without inducing a call-rate bump on Screen 3 (Attack 3 closure).

If 5 of 6 hit, ship and defend. If 4 of 6 hit, ship with a named gap. If ≤3 hit, the design's coherence claim is unsupported and the team should refuse to call it a win.

---

## Summary

**Strongest steel-man point:** the team converted three textbook dark patterns (forced-credit default, hidden entitlements, unexplained "Recommended") into structural truth-telling (no default, persistent strip, consequence-as-design), and the visual/behavioral coherence of the resulting flow is itself a trust signal at 10:46 p.m.

**Most damaging attack:** the prototype is single-page HTML; production will ship ~80% of the spec. The design's coherence is *behavioral* (sheet trap, two-beat held-seat sequence, eligibility state machine, claim persistence across "Plans changed?") — not visual. If those 18 IxD states and 8 A11y blockers don't all ship, the launched product is "old flow plus teal accent." The team has not surfaced engineering feasibility.

**Team belief most likely wrong:** that visible deliberation produced design changes. Of three named debates, only one (party-size) visibly changed an artifact. The others produced rigorous justification, not dialectic shifts. *Lead's note: the post-DA VD revision pass — driven by A11y + BS — added a second clear non-author shift; belief 1 stands for the pre-revision state.*

**Data that would change my mind:** engineering's state-by-state ship confidence pre-launch; a second artifact-level shift attributable to a non-author teammate; voucher-spend modeling at BS H3's success threshold with ops/finance sign-off on the envelope.
