# Process Appendix — Canceled-Flight Recovery

This appendix captures *how* the recommendation was produced: what each role contributed, which messages between specialists changed the artifact, which debates ran, what dissent was preserved, and what stress-test the consensus survived.

It is intentionally separate from the meeting-ready memo so a first-read reviewer can absorb the design without process detail.

## 1. What each role contributed

- **Creative Director** — anchored the aesthetic and quality bar before any authoring: "concierge at 11 p.m." (Things 3 × Apple Health × hotel concierge). Set explicit pushback lines for the run and signed off the visual authoring with two filed nits.
- **UX Researcher** — produced the user spine ("understand → decide direction → secure tonight → leave with confidence"), the five silent questions, three inferred emotional states, and five load-bearing research assumptions, each falsifiable in a 5-user moderated mobile test.
- **Information Architect** — proposed the 4-screen flow (Held-Seat Offer → Other Flights → Tonight's Support → You're Set), demoted standby to a filter chip, gave the held-seat default an explainable reason ("earliest confirmed arrival, no fare change"), and moved entitlements out of the FAQ into their own screen.
- **Visual / UI Designer** — authored the HTML prototype from a clean canvas with the anchor in hand. Set design tokens, three component specs (Held-Seat Offer card, Support card, Status strip), and named three places the safe choice was rejected (no "Recommended" badge, serif H1 over sans, no fare-difference anywhere on Screen 2).
- **Interaction Designer** — specified state machines per screen, the full held-seat mechanic (preservation during browse, expiry without a visible timer, cascading-cancel), five error and recovery paths, and microinteractions. Confirmed IA's pinned-card pattern and augmented it with a bottom-of-list "Back to the held seat" link.
- **Content Designer / UX Writer** — wrote a banned-word list, the new SMS, screen-level copy that answers each silent question in one declarative sentence, error/state strings for the five error cases, and four notification templates. Named three explicit tradeoffs between honesty and warmth.
- **Behavioral Scientist** — mapped choice architecture per screen with named mechanisms (status-quo bias, endowment, ambiguity aversion, anchoring, peak-end), ranked three trust risks with watch-for signals, named four places the team got it right behaviorally, and proposed three falsifiable experiments with guardrails and kill rules.
- **Accessibility Specialist** — found four blockers (bare "Continue," missing landmarks/heading hierarchy, non-interactive flight cards, chips with no `aria-pressed`), redlined teammate contrast pairs and dialog/chip semantics, audited each screen for keyboard and SR paths, and named three cognitive-AT compounding risks.
- **Devil's Advocate** — stress-tested the consensus: steel-manned it, built a peer-card opposing position, named seven hidden assumptions, predicted five failure modes, named the biases active in the run, and made two specific recommendations (revise S1 lede for transparency; accept-with-instrumentation).

## 2. Cross-agent handoffs that changed the answer

These are the messages between specialists where a teammate's input materially changed the artifact, not just the report.

| From → To | What changed |
|---|---|
| UX Researcher → IA | "Do not carry over the three-tab picker; secure-tonight must surface before commit." → IA's 4-screen spine; entitlements got their own screen (S3) instead of an FAQ. |
| UX Researcher → Content | "Kill 'schedule irregularity' and 'your changes have been applied.'" → Content's banned-word list and SMS rewrite ("canceled — crew availability"). |
| IA → Content | "Held-seat explainer ≤14 words, no 'Recommended.'" → "Earliest confirmed seat tomorrow, same fare." (6 words, *confirmed* doing the trust work "Recommended" was failing to do). |
| IA → Interaction | "Does pinned card on S2 hold up?" → Interaction kept pinned card *and* added a bottom-of-list return link (rescues users who scrolled past); rejected sticky footer (collides with SR landmarks). |
| Visual → Creative Director | Sign-off request on serif H1, equal-width secondary, honest-disabled bag card. → CD signed off all three with nits filed in the appendix. |
| Visual → Accessibility | Contrast pairs, touch targets, focus rings. → A11y confirmed most pairs; named Ink-3 (#9A9087) failing 1.4.3, recommended darkening to #857B70 and bumping btn-small from 40 → 44 px. |
| Accessibility → Visual (B1–B4) | Four ship blockers. → Visual revised the HTML surgically (real `<button>` flight cards with composed names; `aria-pressed` on chips; single `<main>` per screen; "Confirm tonight's plan" replacing bare "Continue"). |
| Behavioral Scientist → Content | "S3 H1 makes a categorical claim before policy is confirmed — render conditionally." → Both H1 variants ("Tonight's covered, if you need it." / "Help available tonight.") authored as state-variants in the prototype. Server signal required at build. |
| Behavioral Scientist → Interaction | "Swap-dialog button valence makes Keep heavier than Switch — neutralize." → Dialog primary names the alternate flight; safe option demoted to neutral ghost "Not yet"; default-focused on the safe option per Accessibility's loss-aversion concern. |
| Behavioral Scientist → Visual (via lead) | "S1 lede should surface a real alternative when one exists." → Single transparency line authored under the held-card "why": "Other flights include a nonstop arriving 4:18 p.m." |
| Content → Accessibility | Heading levels, button label rules, SMS short-link concern. → A11y confirmed reading order, ruled the visible labels are the accessible names (drop redundant `aria-label`), recommended SR-pronunciation testing of "a.m." periods. |

## 3. Debates that ran and their resolutions

### Debate 1 — Held-seat default vs. peer-comparison transparency

*Specialists involved:* Behavioral Scientist (challenge); Information Architect, Visual Designer, Content Designer (defend); Devil's Advocate (strongest opposing position); UX Researcher (untested).

- **Position A (team consensus):** The held seat is the right default for the tired, mobile-only modal user at 10:46 p.m. The escape hatch ("See other options") is one tap; the held seat is preserved during browsing; the user can switch with one confirm dialog.
- **Position B (Behavioral Scientist):** The default is too powerful. Status-quo + endowment + ambiguity aversion at high cognitive load mean some users will silently accept the held seat without comparing — *not because they preferred it but because comparing required active reasoning at 11 p.m.* Mechanism is established and load-bearing.
- **Position C (Devil's Advocate, dissent preserved):** "Radical transparency, peer comparison, no defaults." Show all three confirmed options as peer cards on Screen 1 with arrival deltas. The held seat is paternalism dressed in moss green; the IA's "side-trip" framing is itself a bias mechanism.

**Resolution.** Ship the held-seat default *with* the Behavioral Scientist's S1 transparency line ("Other flights include a nonstop arriving 4:18 p.m.") as a conditional render, plus Experiment 1 instrumentation (`S1_accept_without_S2_view` rate, post-arrival CSAT among accepters, kill rule on CSAT drop). The Devil's Advocate's peer-card position is preserved as the falsification path: if E1 shows silent acceptance dominates and CSAT drops, the team has to redesign toward peer comparison.

**What did not happen.** The dissent was not flattened into "everyone agreed the held seat is fine." The DA's position is named in the recommendation as the v2 redesign trigger if the experiment fails.

### Debate 2 — S3 H1 "Tonight's covered, if you need it." (overclaim risk)

*Specialists involved:* Content Designer (assert); Behavioral Scientist (qualify).

- **Position A (Content Designer):** "Clarity over modesty." The assertive H1 with a qualifying lede is honest enough; protecting Northstar from a soft promise costs the tired user the assurance they need most. Explicitly named as tradeoff #3 in the role report.
- **Position B (Behavioral Scientist):** The unconditional assertion crosses from honest framing toward overclaim when eligibility is server-determined. A user without entitlement reads coverage as guaranteed, gets an inline error, and trust collapses at the worst moment.

**Resolution.** Conditional render. Visual Designer authored both states in the prototype; the recommendation makes the server signal a ship requirement. Content Designer's voice and warmth preserved in both branches.

### Debate 3 — Swap-dialog button valence on Screen 2

*Specialists involved:* Content Designer (initial); Behavioral Scientist (challenge); Interaction Designer (re-spec); Accessibility (default-focus concern).

- **Initial position:** Primary "Switch flights" / ghost "Keep my held seat." Standard pattern.
- **Behavioral Scientist:** Primary names the change, ghost names the status quo, dialog adds friction asymmetry — users who *prefer* the alternate face two cognitive hurdles to act on it.
- **Accessibility:** Independently flagged that under cognitive load, the default-focused button should be the safer one (loss-aversion protection).

**Resolution.** Primary names the alternate flight ("Switch to the 9:55 a.m. nonstop"). Ghost is neutral ("Not yet"). Default focus is the ghost, protecting users who tap before they read. Both concerns satisfied without re-introducing the original asymmetry.

### Debate 4 — Multi-passenger PNRs (the unresolved one)

*Specialists involved:* Accessibility Specialist (raised inclusively); Devil's Advocate (raised forcefully); no team resolution.

- **Accessibility:** Family of four, "Forward to family" reads cruel if the family is on the same PNR; held seat (singular) misleading.
- **Devil's Advocate:** This is FM-2 — held seat as singular UI vs. multi-pax PNR is a footgun. The brief explicitly names the user as "traveling with family."

**Resolution.** Named as a deferred risk in §4 of the final recommendation, not buried. The prototype ships the solo-pax case; the v2 must mock a 4-pax variant of S1 before broader rollout. The team chose not to ship a hand-waved family screen in this pass; that was the honest call and is preserved as a known gap rather than a silent omission.

## 4. Key tradeoffs and rejected alternatives

- **Held-seat default vs. peer-card transparency** — chose held-seat with transparency-line + instrumentation. Rejected peer-cards because they re-introduce the adjudication burden that the brief specifically calls out as the failure mode of the current 3-tab picker.
- **Serif H1 vs. sans H1** — chose serif at 30/27 px, weight 500, -0.01em tracking. Rejected sans because it would have read efficient where deliberate was the bar. CD signed off; the call is overturned only if a moderated test shows the serif reads as marketing copy rather than concierge.
- **Equal-width secondary vs. hairline-link secondary** — chose equal-width hairline-outline secondary. Rejected hairline link because it would have hidden the peer affordance. Rejected button-equal-weight because it would have undercut the held-seat path. Visual hierarchy carries the choice; button geometry doesn't.
- **Fare difference shown vs. suppressed during recovery** — suppressed. Rejected showing it because of loss-aversion misframing during disruption. Upgrade-eligible exception is named as a known gap.
- **Standby as peer tab vs. filter chip** — chose chip. Rejected peer treatment because standby is not commensurable with confirmed rebooking.
- **Countdown timer on the held seat** — rejected entirely. Counters spike anxiety at 11 p.m. and contradict the concierge anchor. Expiry communicated only through state change with a soft T-2min "still here?" inline note.
- **Sticky-footer return to held seat vs. pinned card + bottom link** — chose both pinned + bottom link. Rejected sticky footer because it collides with browser chrome and SR landmarks.
- **S3 H1 unconditional vs. conditional** — chose conditional. The Behavioral Scientist's harm framing won the call; Content Designer's clarity argument shaped the voice of both branches.

## 5. Scorecard-ready comparison setup (without reading the baseline)

The following are recorded for the eval phase without having opened any prior output:

- **Artifact type produced:** authored HTML prototype (`demo-output/prototype/index.html`) + meeting-ready recommendation (`demo-output/final-recommendation.md`) + this process appendix. Matches the comparison artifact type the baseline run will produce.
- **Word count of meeting-ready memo:** ~860 words, within the 900-word target.
- **Screens shipped:** 4 (under the brief's 5-screen cap). Plus one state-variant of S3 visible in the HTML for the eligibility-pending branch.
- **Specialist roles run:** 8 (Creative Director, UX Researcher, Information Architect, Visual Designer, Interaction Designer, Content Designer, Behavioral Scientist, Accessibility Specialist) plus a Devil's Advocate stress-test pass.
- **Cross-agent handoffs that changed the artifact:** 11 documented in §2 above.
- **Documented debates:** 4 (held-seat default vs. peer-comparison; S3 H1 overclaim; swap-dialog valence; multi-pax PNRs unresolved).
- **Dissent preserved:** Yes — DA's peer-card position is recorded as the experimental falsifier; the multi-pax gap is named as a deferred risk rather than absorbed into "v2 someday."
- **Accessibility blockers found:** 4 (B1–B4); all resolved in the revised prototype. 5 should-fixes named; 4 addressed in the revision (Ink-3 contrast, btn-small target size, reduced-motion guard, dialog default-focus).
- **Behavioral risks named with watch-for signals:** 3 ranked with mechanisms, harms, leading indicators, and fixes.
- **Falsifiable experiments shipped:** 3 with primary, guardrail, and kill rules.
- **Invented data:** none. Specific flight times, codes (NS482 → NS612, 7:10 a.m., 9:55 a.m. nonstop, 4:18 p.m. arrival) are illustrative scenario data consistent with the brief; no compensation amounts, no laws, no quotes, no research statistics.

## 6. Devil's Advocate stress-test summary

The DA pass surfaced five risks the team did not fully address:

1. **The silent-accept user who later regrets** — the held-seat default's mechanism (status-quo + endowment + cognitive scarcity) can produce acceptance without informed comparison. Partially addressed by S1 transparency line + E1 instrumentation; will need to clear E1's kill rule to ship at scale.
2. **The multi-passenger PNR shatter** — singular held-seat UI vs. family-of-four reality. *Unresolved.* Named as a deferred risk and a v2 build requirement.
3. **The refund-seeker forced through rebooking** — "Take credit instead" is a chip on S2 reached via "See other options," requiring 3+ taps. Partially mitigated by the chip's prominence in the filter row, but the path is still rebooking-flavored. Named as a v2 entry-point question.
4. **The eligibility-overclaim blowback** — S3 H1 unconditional categorical claim. Resolved by conditional render and authored both states.
5. **The SMS-broken Screen 4 user** — hotel "Confirmation sent by text" instead of the hotel name. Partially addressed by including hotel name and address inline; SMS-fallback path still needs build review.

Two recommendations the DA made were directly absorbed: (1) S1 transparency line for the next-best alternative was authored into the prototype; (2) accept-with-instrumentation is the framing of §4 in the final recommendation (`S1_accept_without_S2_view` logging, multi-pax tagging, ineligible-claim-rate alerting).

Biases the DA named as active in this run: solution attachment to the held-seat pattern; aesthetic anchor pulling decisions; WEIRD-and-solo-traveler overfitting; confirmation bias within the run. These are accurate; they are recorded here so the next iteration knows where to push.
