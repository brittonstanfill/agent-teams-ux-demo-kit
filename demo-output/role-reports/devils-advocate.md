# Devil's Advocate — Canceled-Flight Recovery

## 1. Steel-man the consensus

The team is solving for a tired, mobile-only traveler at 10:46 p.m. whose system-1 cognition dominates and who currently abandons the flow to call support. A held seat with an explainable "why" (earliest confirmed, no fare change) converts an adjudication into a decision; it answers the user's silent first question ("am I getting home?") before asking anything of them. Entitlements move from a buried FAQ to a peer screen so users don't pay out of pocket. Standby is demoted because it is not an equivalent commitment to confirmed rebooking. Concierge tone, one decision per screen, and a calm summary screen close the loop. The design replaces equivalence-framing with informed defaults, and it does so without removing access — the escape hatch is one tap, and the held seat is preserved during browsing. [inferred from role reports]

## 2. Strongest opposing position

**Radical transparency, peer comparison, no defaults.** A thoughtful adversary would argue: the held seat is paternalism dressed in moss green. The team has decided *for* the user — and called it concierge service — when the user's actual job is to evaluate tradeoffs they alone can weigh (does the nonstop matter? am I willing to overnight? can I expense a hotel and skip the voucher?). Show all three confirmed options as peer cards on Screen 1, with arrival deltas, stop counts, and a one-sentence rationale on each. Surface "we recommend X because earliest confirmed" as a sortable signal, not a pre-commitment. The IA's "side-trip" framing is itself a bias mechanism: by making the held seat the home and alternatives the detour, the team has architected silent acceptance. A peer-card design respects autonomy, scales to multi-passenger / refund-seeking / upgrade-eligible users without conditional logic, and survives an angry tweet ("Northstar pre-booked me onto a 1-stop without my consent"). The behavioral scientist has already named the mechanism that produces this risk (status-quo + endowment + cognitive scarcity) — they just refused to follow it to its conclusion. [recommendation, contrarian-framed]

## 3. Hidden assumptions the team is making

- **A1 — "Tired user wants to be guided."** [assumption] UX Researcher §4 lists this as a load-bearing assumption and proposes a 5-user moderated test; the team has *not yet run that test* and is shipping the design that presumes the answer. A subset of tired users are more skeptical, not less — they read pre-selection as a sales move and want full disclosure. If 20–30% of users are in this disposition, the held-seat default actively erodes trust for them.
- **A2 — "No fare difference during recovery" assumes same-class same-day rebook.** [assumption] No one models the upgrade-eligible user (elite status, paid-up class) whose held seat may *downgrade* them silently, or the user who would happily pay a fare diff for a nonstop and now cannot see that lever. Suppression is honest for the modal user and dishonest for the high-value tail.
- **A3 — Held-seat pattern handles single-passenger bookings only.** [assumption] IA references one seat singular. Family of four, business pair on one PNR, lap-infant case — none modeled. Holding *one seat* on a family PNR is a footgun: either the system holds four (where does it find them?) or it holds one and silently splits the party. Accessibility specialist flagged this — the team has acknowledged and deferred it. Deferring it means shipping a flow that breaks at the *exact* user state the brief calls out ("traveling with family").
- **A4 — User wants to rebook on Northstar at all.** [assumption, untested] Travel-credit is demoted to a chip and "refund seeker" is not a modeled user path. Some users at 11 p.m. have decided Northstar failed and want their money back, period. Burying the refund/credit path behind a filter chip on Screen 2 — which they must first opt into by tapping "See other options" — is a friction wall, not a side door. The brief explicitly says "do not push users into worse choices"; pushing a refund-seeker through two screens of rebooking-flavored UI is exactly that.
- **A5 — Concierge tone translates.** [assumption, WEIRD-leaning] "Tonight's covered, if you need it" assumes a low-power-distance reader who accepts familiar warmth from a corporation. For users from higher-power-distance cultures or markets where airlines are addressed formally, this can read as evasive or unprofessional. The serif declarative H1 also assumes a left-to-right Latin reading culture; the team has not modeled RTL, CJK line-height, or non-Latin numeral rendering for `tabular-nums`.
- **A6 — SMS-first is reliable enough to be load-bearing.** [assumption] Confirmation, gate updates, hotel address, and recovery-from-disruption all route through SMS in the content designer's notification stack. In regions with poor SMS deliverability, MVNO carriers, or users on Wi-Fi-only devices, this is a single point of failure. Screen 4's hotel value says "Confirmation sent by text" — if the text never arrives, the user has no destination on their confirmation screen.
- **A7 — Network is available to load the prototype itself.** [assumption] The team has built an offline action on S4 but not an offline entry. A user with one bar at 10:46 p.m. who taps the SMS short-link and waits 15 seconds for a held-seat card may abandon before the prototype's hero loads. Real-world: low-bandwidth users see a blank atmospheric gradient and bounce.

## 4. Predicted failure modes (pre-mortem)

**FM-1: The silent-accept user who later regrets.**
*Who:* solo business traveler with elite status, woken by SMS, taps "Keep this seat" within 8 seconds.
*Why this design fails:* status-quo + endowment + cognitive scarcity push them past comparison. The 9:55 a.m. nonstop would have served them better, but Screen 1's lede doesn't surface it strongly. They land tomorrow afternoon at LGA via ORD instead of nonstop, miss the morning meeting, and blame Northstar.
*Leading indicator:* support-ticket theme "I didn't know there was a nonstop" or "your app picked the wrong flight"; analytics: S2-view rate <15% combined with elevated post-arrival CSAT-decline among held-seat-accepters. [inferred]

**FM-2: The multi-passenger PNR shatter.**
*Who:* parent on a 4-pax PNR traveling to the family event the brief literally names.
*Why this design fails:* one held seat, four humans. Either the system silently splits the family (catastrophic), the held-seat affordance vanishes (now the user gets a different flow they've never seen, undermining the design's consistency promise), or the seat is "held for the party" with no clarity about whether they're adjacent. Screen 4's "Forward to family" tile reads as cruel if the family is on the same PNR.
*Leading indicator:* support-ticket spike around "split from my kids," "different flights for my party"; voucher-claim rate divergence between solo-pax and multi-pax bookings.

**FM-3: The refund-seeker forced through rebooking.**
*Who:* business traveler whose meeting was canceled by the disruption itself — they don't need to fly anymore.
*Why this design fails:* Screen 1 offers "Keep this seat" or "See other options." Neither says "I don't want to fly." The user taps "See other options," sees a flight list, then has to spot a filter chip labeled "Take credit instead," tap it, dismiss a confirm dialog. Four taps and a confirm to express "refund please." They call support.
*Leading indicator:* support-call rate among users who reached S2 and bounced without selecting a card; "Take credit instead" chip tap-rate vs. its actual desired-outcome population.

**FM-4: The eligibility-overclaim blowback.**
*Who:* a user whose specific cancellation cause (weather, ATC, force majeure) does not, in their jurisdiction or fare class, entitle them to a hotel.
*Why this design fails:* S3 H1 "Tonight's covered, if you need it." renders unconditionally in earlier drafts; the visual designer has now authored both states, but the conditional must actually be wired to a server signal at ship. If the toggle is missing, the user taps "Book a hotel for me," gets an inline error, and the design's central promise — that entitlements are surfaced honestly — is broken at the worst moment.
*Leading indicator:* complaint theme "you said it was covered"; ineligible-user claim-attempt rate; CSAT divergence between eligible and ineligible support-screen completers.

**FM-5: The SMS-broken user marooned on Screen 4.**
*Who:* user on a low-deliverability carrier whose hotel confirmation SMS never arrives.
*Why this design fails:* Screen 4 says "Confirmation sent by text" *instead of* the hotel name. Accessibility specialist flagged this for SR users; the same failure mode applies to anyone whose SMS app crashed, who's on a Wi-Fi-only iPad, or who's roaming internationally. The summary screen — the *only* artifact the user sleeps on — has no destination.
*Leading indicator:* support calls in the 11 p.m.–1 a.m. window with theme "where's my hotel"; SMS delivery telemetry vs. hotel-address-lookup rates in the app.

## 5. Biases the team is likely falling into

- **Solution attachment to the held-seat pattern.** Every role report reinforces the same architectural choice — no one in the room is structurally tasked with imagining the design where it doesn't exist. *Corrective:* redesign Screen 1 as a peer-card layout once, just to feel the negative space.
- **Aesthetic anchor pulling decisions.** The CD's "Things 3 × Apple Health × hotel concierge" anchor is doing real work — too much of it. "Serif H1 over sans" and "no Recommended badge — the card *is* the recommendation" are aesthetic theory applied to behavioral questions. Each may be right, but the team is not running a falsification test on whether the anchor is *helping the user* vs. *flattering the designer*. *Corrective:* read the S1 H1 aloud in a phone-notification preview at 1.5x — does the serif still feel "concierge" or "marketing copy"?
- **WEIRD-and-solo-traveler overfitting.** Family of four, refund-seeker, elite-status, international-user, RTL-reader, low-bandwidth-user — none are first-class citizens in the role reports. The imagined user is consistently solo, English-reading, US-domestic, smartphone-equipped, on cellular at 10:46 p.m. with a charged battery.
- **Confirmation bias within the run.** No role report says "I disagree with the held-seat premise." The behavioral scientist comes closest (Risk 1) and then proposes a one-line lede tweak as the fix. This is the room talking to itself.

## 6. What would change the team's mind

- **On the held-seat default (FM-1, A1):** Run a moderated 5-user mobile session at the user-researcher's protocol. *If >25% of users in that session accept the held seat without exploring alternatives and post-session say "I didn't know there was a nonstop" or "I would have wanted to see the others first," the design has under-served choice-overload-skeptical users. If <5% of users exhibit any silent-accept regret AND held-seat-accepters self-report high confidence, the default is doing the work intended.* Falsifiable.
- **On multi-pax (FM-2, A3):** Mock a 4-pax PNR variant of S1 and walk a parent through it. *If the parent cannot answer "are we sitting together?" within 10 seconds of seeing S1, the single-pax design is shipping a known break to the brief's named user state.* Falsifiable.
- **On eligibility-overclaim (FM-4, A5):** The visual designer has now authored both states; before ship, the team must specify the server signal that toggles the H1. *If the team cannot specify it, the H1 is a promise the system cannot keep. If they can, ship and watch ineligible-user complaint-rate.* Falsifiable.

## 7. Two specific recommendations

**Revise: Screen 1 lede must surface the next-best alternative inline, not behind a tap.** The visual designer has now added "Other flights include a nonstop arriving 4:18 p.m." per the BS recommendation — good. Make this a conditional render, not a static line: it should fire only when a same-day alternative within ~1 hour exists AND is meaningfully different (nonstop vs. stop, or earlier arrival). Otherwise it becomes a generic line that retrains the eye to skip it. This is the smallest single change that defends the held-seat default from becoming a silent override. [recommendation]

**Accept-with-instrumentation: ship the held-seat pattern only if S2-view-rate, multi-pax-PNR-fall-through-rate, and ineligible-hotel-tap-rate are instrumented before launch.** Specifically: (a) log `S1_accept_without_S2_view` as a primary metric and alert if it exceeds ~85% in the first cohort [assumption-level threshold, calibrate with analytics]; (b) tag every multi-pax PNR session and watch completion-rate divergence from solo-pax; (c) log every hotel-tap against server-side eligibility and alert on ineligible-tap-rate over baseline. Without instrumentation, the team is shipping a behavioral intervention with no falsifier. [recommendation]

## Concessions (where the team's reasoning is strong)

- **Demoting standby to a filter chip is right.** Equivalence framing was the original sin of the three-tab picker; standby and confirmed rebooking are not commensurable choices.
- **Surfacing entitlements before commit is right.** This is the single highest-leverage move in the redesign and defeats the sunk-cost trap the original flow created.
- **Killing the fare-difference badge during recovery is right** for the modal user. The upgrade-eligible exception (A2) is a real but small risk, and the gain for the modal user outweighs it — *provided* the upgrade-eligible path is not silently closed off, which the team has not yet specified.

## What would change my mind

Three things, ranked: (1) evidence from 5 moderated mobile sessions that the held-seat default produces *informed* acceptance, not silent acceptance, across at least one skeptical-disposition user; (2) a designed-and-reviewed multi-passenger PNR variant of Screen 1 that handles the family-of-four case without silently splitting the party; (3) the conditional-render eligibility gate on S3's H1 wired to a real server signal at ship, not left as authored state-variants. If all three land, the pattern earns ship. If any one is deferred to "v2," the design ships a promise it cannot keep.
