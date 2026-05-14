# Behavioral Scientist — Northstar Canceled-Flight Recovery

Labels: [O]bserved · [I]nferred · [A]ssumption · [R]ecommendation. Named mechanisms cited; no invented statistics or policy.

## 1. Choice architecture map (per screen)

| Screen | Choice user faces | System default | Mechanism + read |
|---|---|---|---|
| **S1 Held-Seat Offer** | Keep held seat, or see other options | A confirmed seat is pre-selected | **Status-quo bias + endowment effect** — the seat is framed as already *yours* ("Seat held for you"); leaving it now feels like a loss, not a non-gain. Combined with **ambiguity aversion** at high cognitive load (10:48 p.m., dual-process system 1 dominant), the default carries unusually heavy weight. [I, R] |
| **S2 Other Flights** | Switch flights, or return to held seat | Sort = earliest arrival; held seat pinned + return link | **Anchoring** (the held card is the reference point all others are read against) + **default carryover** (the pinned card and bottom return link both preserve the S1 default through the side-trip). Switching requires a confirm dialog → **friction asymmetry** favors keeping the held seat. [O from IA/IxD, I] |
| **S3 Tonight's Support** | Accept hotel, accept meal, decline either | Offered, not opted-in (must tap) | **Honest framing of an entitlement** — opposite of forced opt-in. The "Tonight's covered" H1 leverages **loss aversion** (don't leave coverage on the table) without auto-enrolling. [O brief; R] |
| **S4 You're Set** | None required; optional save/share | All decisions resolved | **Peak-end rule** — the calm, complete recap is the *end* the user will remember; offline/wallet actions provide **endowed progress** ("I have the receipt") that builds trust for the next disruption. [I, R] |

## 2. Top 3 trust risks (ranked)

**Risk 1 — The held-seat default is powerful enough to suppress better choices for some users.**
- Mechanism: **status-quo bias + cognitive scarcity** (Mullainathan/Shafir-style: tiredness narrows the choice set the user actually considers). [I]
- Harm: a user whose true preference is a nonstop arriving 36 min later (the 9:55 a.m. option in the prototype) accepts the 1-stop held seat because deviating requires a confirm dialog and active reasoning at 10:48 p.m.
- Watch-for: in moderated test, ask 5 users post-tap "why did you keep it?" — if >1 says "I didn't really compare" or "I assumed it was the only confirmed one," the default is doing more work than informing. Analytics: ratio of S1-accept vs. S2-visit, and S2-visit-to-switch rate. A very low S2-visit rate (<~15%) [A] is the signal that the default is sticky beyond the design's intent.
- Fix: keep the default, but the *lede* on S1 should make the alternative tangible in one beat. Today's lede ("…so you have time to decide what's right") is reassurance; add ", or a nonstop later in the day" only when one exists. This is the smallest change that defends against silent override.

**Risk 2 — "See other options" is a peer in width but not in weight, and that asymmetry compounds with status-quo bias.**
- Mechanism: **visual salience asymmetry + framing**. Equal width reads as fairness; tinted-card vs. ghost button reads as hierarchy. Both signals are true; the second wins under cognitive load. [I, observed in prototype line 762 vs. held-card weight at 714]
- Harm: users who would benefit from comparison never trigger it. Specifically the user-spine question 2 ("which one is the airline pushing me toward and why?") goes unanswered for those who don't tap.
- Watch-for: S2 entry rate by time-of-day. If late-night entry rate is meaningfully lower than daytime, the visual asymmetry is interacting with fatigue — a fairness problem, not just a conversion problem.
- Fix: do not redesign weight (CD signed off; the card *is* the recommendation per visual designer §4). Instead, on S1 add a one-line *consequence preview* of declining: "Other flights tomorrow include a nonstop arriving 4:18 p.m." — answers the silent question without inflating the secondary button.

**Risk 3 — "Tonight's covered, if you need it" risks implying entitlement before policy is confirmed.**
- Mechanism: **assertion-as-promise framing**. The H1 makes a categorical claim; the lede qualifies *what's* covered but not *whether*. Content designer flagged this themselves (§6, tradeoff 3) and chose clarity over modesty. I agree with the call — *but* the risk is non-zero. [O content-designer §6]
- Harm: a user without eligibility (e.g., weather-driven cancellation in some jurisdictions, or non-policy circumstance) reads coverage as guaranteed and is disappointed downstream — eroding the trust the rest of the flow built.
- Watch-for: support-call rate *after* an S3 decline-then-rebook path; complaint themes about "you said it was covered."
- Fix: gate the H1 string by server-side eligibility. If the server says "eligible," render the current string. If "not eligible" or "TBD," render "Help available tonight" + the same lede. One conditional, same voice. Honest by construction.

## 3. Where the team got it right, behaviorally

1. **No "Recommended" badge.** Banned in content (§1) and rejected visually (visual-designer §4 pushback 1). This avoids **authority bias** weaponized — a labeled "recommendation" creates an opaque endorsement the user can't evaluate. The held-seat card carries its *reasons* ("Earliest confirmed seat. No fare change.") inline — the user evaluates the basis, not the brand. **SDT-positive**: supports autonomy by giving the user the data to choose, not a verdict to obey. [O]
2. **Hotel/meal surfaced up front, not after rebooking.** Defeats the classic dark pattern of **hidden cost / drip pricing** in reverse — instead of hiding fees until commitment, the team surfaces *entitlements* before the user commits time/effort to a path that could foreclose them. Specifically resists the **sunk-cost trap** where a tired user, having "completed" rebooking, declines to re-enter a flow for support. [O brief, IA §1]
3. **Fare difference suppressed during recovery; arrival delta does the comparison.** Brief calls this out, but the behavioral *reason* is that **mental accounting** during disruption is broken — the user is in loss-frame, and a "+$84" tag triggers loss aversion against the better-but-pricier flight, pushing them toward a worse one. Removing fare from comparison reframes the choice on the dimension the user actually cares about tonight (when do I land?). [O brief, visual-designer §4 pushback 3]
4. **Standby as a filter chip, not a peer tab.** Avoids **equivalence framing** that misleads — three equal tabs implied three equal commitments, when standby is conditional. Demoting it reduces **choice overload** for the tired user while preserving access for the rare standby-preferring traveler. (See risk addendum below.) [O IA §3]

## 4. Experiment plan

**Experiment 1 — Does the held-seat default produce *informed* acceptance, or silent acceptance?**
- Hypothesis: adding a one-line alternative preview on S1 lede increases S2 entry without reducing S1 acceptance among users whose held seat *is* their preferred option.
- Primary metric: % of users who view S2 at least once before confirming.
- Guardrail: time-to-confirm (must not balloon — proves we didn't just add deliberation cost without informing); self-reported confidence at S4 ("I picked the right flight" 1–5).
- Exit rule: ship if S2-view rate rises ≥10 percentage points AND guardrail confidence does not drop; **kill** if confidence drops more than 0.3 on the 5-point scale (means we induced regret).
- Mechanism: countering **status-quo bias** with a low-cost **consequence preview**, not by weakening the default.

**Experiment 2 — Does suppressing fare difference change choice quality?**
- Hypothesis: suppressing fare difference on S2 does not increase rate of "wrong fare class" support calls in the 72h post-rebook.
- Primary metric: support-call rate within 72h tagged "fare/upgrade" per rebooked user.
- Guardrail: rebook-completion rate (should not drop — proves we didn't just push users to credit); self-service completion rate.
- Exit rule: ship if fare-related call rate does not rise more than ~1 pp [A] over baseline AND completion rate holds; **kill** if fare-related calls rise materially OR if travel-credit selection rate jumps (signal users felt boxed in).
- Mechanism: avoiding **loss-aversion misframing** during disruption.

**Experiment 3 — Does the explicit hotel entitlement on S3 reduce out-of-pocket spend without inflating false claims?**
- Hypothesis: front-surfacing hotel coverage increases legitimate hotel-voucher claim rate AND decreases post-disruption reimbursement requests.
- Primary metric: hotel-voucher claim rate among eligible users.
- Guardrail: ineligible-user claim attempts (proves the framing didn't *imply* entitlement to those without it); CSAT among the ineligible group (proves the "Help available" fallback per Risk 3 works).
- Exit rule: ship if claim rate among eligible rises and ineligible claim-attempts do not; **kill** if ineligible-attempt complaints rise (means H1 framing was the harm).
- Mechanism: making a real entitlement **salient** rather than relying on user discovery; **anti-dark-pattern** because we lose nothing by surfacing what's owed.

## 5. Standby risk addendum (the question was asked)

Standby-preferring users are a small population [A]. Demoting to a chip is correct *if* the chip is discoverable. Watch: among users who held a flexible/elite fare class, what % engage the Standby chip? If <~5% [A] and qualitative interviews surface "I didn't see standby," reconsider chip prominence for that segment via personalization, not by re-elevating it for everyone. The general principle: **choice architecture should match the population's modal need, with an obvious side-door for the minority.** Currently met.

## 6. Message-to-Content-Designer (verbatim for relay)

> Content — one phrase at risk: **S3 H1 "Tonight's covered, if you need it."** The H1 makes a categorical claim before policy is confirmed; the lede qualifies *what's* covered but not *whether*. You flagged this as a tradeoff (§6.3), and I agree with your direction — but the unconditional assertion is what crosses from honest framing toward overclaim if eligibility is server-determined. Recommend a conditional render: when eligibility is confirmed, ship today's string verbatim; when not confirmed or pending, render **"Help available tonight."** + your current lede. Same voice, same warmth, honest by construction. Second, smaller note: the reassurance footer on S1 says "Hotel and a meal **can be covered** tonight" — that hedge is doing the right work; please mirror that conditional verb on S3 H1 in the un-confirmed branch.

## 7. Message-to-Interaction-Designer (verbatim for relay)

> IxD — the S2 confirm-swap dialog is the right pattern, but its current copy ("Switch flights" / "Keep my held seat" — content §3) makes the *Keep* option behaviorally heavier than the *Switch* option, because the ghost button names the status quo and the primary names the change. Combined with the friction asymmetry of the dialog itself (no dialog on the held-seat path), users who *prefer* the alternate flight face two cognitive hurdles to act on that preference. Recommend: keep the dialog (the swap impact is real and worth surfacing), but neutralize the button valence — primary names the chosen flight ("Switch to the 9:55 a.m. nonstop"), ghost neutral ("Not yet"). One more behavioral request: on S1, when the held seat's *only* advantage is "earliest confirmed seat" but a same-day nonstop exists within ~1 hour, the lede should surface that fact ("Other flights include a nonstop arriving 4:18 p.m.") so users see the real alternative before they're anchored. This is the smallest change that defends the default from becoming a silent override.

---

*Confidence: behavioral mechanisms are well-established and cited by name (status-quo bias, endowment, ambiguity aversion, loss aversion, anchoring, peak-end rule, choice overload, authority bias, sunk-cost, mental accounting, SDT-autonomy, cognitive scarcity, dual-process). All quantitative thresholds in §4 (10pp, 0.3, 1pp, 5%, 15%) are [A] illustrative and need eng/analytics calibration before launch. No specific study citations because none would be load-bearing for this audit. Ethics check: would the user thank Northstar in 6 months? Yes — provided Risk 3 fix ships. Without it, eventually no.*
