# Process Appendix

## 1. What each role contributed

- **Information Architect.** Built the user-job spine (Understand → Orient → Choose → Get support → Confirm and carry), bounded the redesign to five screens, wrote per-screen content order and copy constraints, drafted the SMS rewrite, and named the scoped gaps (multi-passenger split decisions, connecting itineraries, special-assistance passengers, deep-link authentication, real-time inventory race, jurisdictional compensation). Made refund a peer recovery option, pulled support out of the FAQ basement, required an offline-readable summary on Screen 5.
- **Visual / UI Designer.** Authored the single-file HTML prototype with five stacked phone-frame mockups that strip their chrome below 420px so content reaches the edges, applied a restrained palette (warm neutrals, deep forest green for action), wired accessibility scaffolding (landmarks, headings, focus states, ARIA), and performed one surgical revision pass to clear every blocker raised by A11y and Behavioral. Held the responsive contract.
- **Accessibility Specialist.** Audited the HTML against WCAG 2.1 AA and 2.2 success criteria. Filed 10 blockers and 15 recommendations across keyboard focus, landmarks, heading hierarchy, live regions, radiogroup pattern misuse, target sizes, and hidden-from-AT consequence labels. Provided a "what this feels like for the user" narrative per blocker. Cleared sign-off after revision.
- **Behavioral Scientist.** Audited choice architecture, dark-pattern risk, and falsifiability. Filed five blockers, naming a steered-funnel pattern on Screen 3 (pre-selected flight + scarcity cue + pre-pressed arrival filter) plus a pre-checked support consent. Authored falsifiers F1–F6 for the experiment plan, including the headline "calls dropped because help got hidden" guardrail.

## 2. Handoffs that changed the artifact

1. **IA → Visual Designer (Section 6 of IA report).** Numbered screen sequence + primary decision + content order + copy constraints. Visual Designer authored every screen directly from this; it set the bones.
2. **A11y → Visual Designer (10 blockers).** Specifically: focus rings became two-tone, five `<main>` elements collapsed to one, six `<h1>`s collapsed to one, the Screen 1 live-region claim was removed (it would not have fired), flight-card ARIA dropped `role="radio"` for a single-select toggle group, the disabled standby card's "Unavailable" was un-`aria-hidden`, recap-chip and Screen 4 Change links were converted to button elements with the 44px floor, and the filter result-count was wired as a live region.
3. **Behavioral → Visual Designer (4 in-HTML blockers).** Specifically: no pre-selected flight on Screen 3 (primary CTA gated), the "Only 3 seats left" cue was removed entirely, the pre-checked support consent on Screen 3 was removed and rebuilt on Screen 4 as itemized Accept/Decline pairs, and the "Arrive by 3 p.m." filter chip ships un-pressed.
4. **Behavioral → Lead (falsifiers F1, F2, F6).** Folded directly into the experiment plan as the falsifier guardrail and the named secondary metrics.
5. **Lead red-team → final recommendation.** Added the "post-completion call rate within 24 hours" metric and the "at-the-airport-already" segment to the scoped gaps.

## 3. One debate and preserved dissent

**Debate.** Visual Designer's view-default reasoning vs Behavioral Scientist's choice-architecture concern on Screen 3.

- **Visual Designer's position.** A pre-pressed "Arrive by 3 p.m." filter chip is a *view preference*, materially different from a pre-selected commitment option. View defaults can be acceptable when they reflect a goal users plausibly share, the way "In stock only" is acceptable on a retail site.
- **Behavioral Scientist's position.** That category distinction is real, but this specific filter asserts a fact we do not have. The brief gives us "family event tomorrow," not "must arrive by 3 p.m." Worse, it stacked with a pre-selected flight and a scarcity cue on the same card — three nudges in the same direction stop being helpful defaults and start being a steered funnel.
- **Resolution.** Filter ships un-pressed. All flights shown by default. The user actively narrows.
- **Preserved dissent.** The category distinction the Visual Designer raised is legitimate. View defaults are appropriate when they reflect a clearly stated user goal. The team should not generalize this decision into a blanket "no pre-pressed filters ever" rule; the next surface that asks the question may have evidence we lacked here.

A second smaller artifact-changing disagreement was resolved cleanly without rising to debate: the IA originally placed the support accept/decline decision on Screen 3 ("Tonight's support" block with a consent toggle). The Behavioral Scientist's B3 fix moved the consent moment to Screen 4 as itemized Accept/Decline per support item. The Screen 3 support block stayed as informational disclosure. Resolution adopted; the IA's "support visible, never collapsed" principle is preserved with consent relocated.

## 4. Lead red-team checklist

1. **Strongest opposing design.** Skip the menu entirely: auto-rebook the traveler onto the next equivalent flight (same origin/destination, within four hours, same cabin) and text the new boarding pass at 10:46 p.m. with a 30-minute decline window. Collapses five screens into one passive event for the majority who would have picked the recommended flight, eliminates decision fatigue at the worst moment, and treats the menu as the exception flow. Worth piloting as a Phase 2 against this design.
2. **Early framing we are anchoring on.** "Self-service is the primary remedy." The brief gave us this anchor and we accepted it. A hybrid — auto-rebook with a human-callback offer — was never compared.
3. **Hidden assumption that could fail the recommendation.** That hotel and meal eligibility can be determined fast enough and accurately enough to render on Screen 3 with honest states. If the eligibility backend is slow or unreliable, "Tonight's support is loading…" replaces the trust gain with new ambiguity.
4. **Under-modeled user segment.** The traveler who is at the airport when the cancellation hits. They have a 30-minute time horizon, different support needs (transportation, lounge, claimed baggage), and the prototype assumes a slower at-home cadence.
5. **Metric that would prove the flow cut calls by hiding help.** Post-completion call rate within 24 hours rising while raw call rate falls — the flow falsely closed the loop. Paired with cross-channel contact volume (chat + email + social) staying flat or rising. Both are now in the experiment plan as falsifier guardrails.
6. **A frustrated user's complaint quote.** *"I tapped through five screens at midnight and confirmed everything, then got to the airport and they told me I wasn't actually rebooked — I was on standby. The app said 'You're set.'"* This is the standby-misread failure mode the Behavioral Scientist's F3 was designed to detect. Standby's "Not guaranteed" framing is now front-loaded on Screen 2 and repeated on Screen 5's variant copy.

Converted to the recommendation: question 5 added the post-completion call rate metric as a falsifier; question 4 added the "at-the-airport-already" segment to the scoped gaps.

## 5. Key tradeoffs and rejected alternatives

- **Five screens vs. condensed two-screen flow.** Rejected condensed flow because Screen 3's path-specific content (rebook filters, refund summary, credit terms, standby framing) and the always-present support block cannot honestly fit alongside the Screen 2 option chooser. Compressing them would re-hide entitlements.
- **Sort by earliest arrival vs. unsorted list.** Kept earliest-arrival sort because it matches the disruption-recovery job (get there) without asserting a specific arrival-time goal. Filter chips are un-pressed; the sort is not.
- **Pre-checked "include support I qualify for" toggle on Screen 3.** Rejected. Pre-checked consent normalizes a pattern that is dark-pattern shaped even when the underlying offer is benign. Consent moved to itemized Accept/Decline on Screen 4.
- **Showing fare-difference dollar amounts during disruption rebooking.** Rejected. The airline caused the disruption; surfacing fare deltas on rebook cards introduces drip-pricing in a recovery flow.
- **"Recommended" badges.** Rejected unless paired with a one-line stated reason. Brief flagged the current "Recommended" label as unexplained.
- **Auto-rebook with decline window (red-team alternative).** Held for Phase 2 evaluation. Not built into this prototype, but named in the appendix so the next iteration can compare.

## 6. Compact-slate overhead notes

- **Team size.** Four teammates plus a lead. No Creative Director, Content Designer, Interaction Designer, or Devil's Advocate were spawned. The lead ran the red-team checklist personally.
- **Sequence.** IA → Visual → (A11y ∥ Behavioral) → Visual revision → Lead red-team → Synthesis. Audits ran in parallel; this saved roughly one teammate-turn vs. serial.
- **Handoff count that changed the artifact.** Five (IA→VD initial author; A11y→VD; Behavioral→VD; Behavioral→Lead; Lead red-team→memo).
- **Visual Designer nudges.** Two: (1) the post-audit surgical revision pass, which is part of the spec; (2) none required for the render gate — the lead's render check at 320/360/390/desktop returned zero offenders, and an initial visual-clipping suspicion was traced to a Chrome-headless macOS scrollbar-reservation artifact rather than real overflow. No second revision pass was needed.
- **Where the lean slate (six roles) would have added value.** A Content Designer would have owned the SMS copy, the per-screen microcopy variants, and the per-variant Screen 3 path-specific strings; this run left those as constraints rather than finished strings. An Interaction Designer would have hardened the radiogroup-vs-toggle decision earlier and could have specified arrow-key keyboard behavior for a real radio pattern. Neither absence prevented sealing; both would have raised polish.
- **Where the lean slate would have added cost without value.** A Devil's Advocate role would likely have duplicated the lead's red-team checklist. A Creative Director role for this artifact type (utility flow, restrained palette) would have added taste pressure without changing decisions.
- **Net.** The four-role slate produced a sealed, audited, render-checked artifact and a meeting-ready memo. Coordination overhead was visibly lower than a six-role run would have produced. The cost was less microcopy polish and no separate adversarial pass; the lead-owned red-team checklist absorbed the latter.
