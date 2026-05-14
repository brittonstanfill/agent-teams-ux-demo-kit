# Process appendix

## 1. What each role contributed

**Information Architect** — set the 5-screen spine: Cancellation Notice → Recovery Options → Choose a Flight → Support & Confirm → Confirmation & Plan. Named copy constraints (use "canceled" not "schedule irregularity"; Standby explicitly "not a confirmed seat"; no fare-difference during disruption recovery). Identified scoped gaps for family/multi-passenger, low-bandwidth, refund-seeker, and support visibility. Defined which user-visible values must be `{system-supplied}` tokens vs. brief-derived.

**Visual / UI Designer** — authored a single self-contained HTML prototype: restrained neutral canvas, one accent (deep indigo), system font stack, 4pt grid, mobile-card frames on a desktop walkthrough. Rendered the SMS as a dark-bubble "received text" block above the H1 to acknowledge the user's actual late-night entry point. Treated every `{system-supplied}` token as a visible, monospaced, contrast-clearing pill so reviewers and screen-reader users encounter the same placeholder in the same place.

**Accessibility Specialist** — audited the prototype against WCAG 2.1 AA. Returned 5 blockers (multiple-h1 page, pressed-filter focus-contrast fail, duplicate `id="footer-support"` with self-referential link, ambiguous SMS aria-label, mismatched flight-card accessible names). Walked the page screen-by-screen from a screen-reader perspective and flagged claim-provenance items as a secondary signal for the lead lint pass.

**Behavioral Scientist** — audited choice architecture, dark-pattern risk, trust floor, and claim provenance. Returned 3 blockers — all claim-provenance: the "Rebooking assistance — Included" chip as an unsourced operational promise, untokenized concrete flight values on the confirmation surfaces, and "A copy of this plan has been sent" / "Bag tags reprint there" / "shown in the app" as unsupported assertions. Confirmed the trust floor passes. Produced three falsifiable predictions with primary metrics and invalidators.

## 2. Handoffs that changed the artifact

| From → To | What changed | Where it landed |
|---|---|---|
| IA → Visual | Screen sequence, primary decision per screen, copy constraints (incl. "canceled" word rule), scoped gaps, dynamic-placeholder convention | All five screens in `prototype/index.html` |
| A11y → Visual (revision 1) | Demoted screens 2–5 H1s to H2s and added single sr-only page H1; added `.sr-only` utility; reworded SMS hero aria-label and added sr-only prefix; rewrote 3× flight-card aria-labels to match visible text; resolved duplicate `id="footer-support"` collision; added light focus ring for pressed dark filters | CSS + 5 HTML edits in `prototype/index.html` |
| Behavioral → Visual (revision 1) | Tokenized "Rebooking assistance" eligibility chip for provenance parity; tokenized review-card and Screen 5 hero flight values (`{new flight number}`, `{new departure}`, `{new arrival}`, `{new date}`, `{stops}`); reframed "has been sent" → "We'll send a copy if configured"; replaced "Bag tags reprint there" with neutral check-in instruction; reframed "in the app" → "gate info shown closer to departure"; tokenized baggage row | Screens 4 and 5 in `prototype/index.html` |
| Render-gate → Visual (revision 2) | `.ent` grid collapsed from `1fr auto` to `1fr` so chip drops below label, eliminating 46px row overflow; `.flight-line` gained `flex-wrap: wrap`; `.kv dd` gained `min-width: 0; overflow-wrap: anywhere` and a scoped `white-space: normal` for nested tokens | CSS-only edits in `prototype/index.html` |

Every handoff produced a measurable HTML change; none were absorbed silently by the lead.

## 3. One debate and preserved dissent

**Topic:** Should the Screen 3 "Arrive by" filter render with `aria-pressed="true"` on load?

**Position A (Visual / IA leaning):** Yes — pre-pressing one filter chip telegraphs to the user "filters are active, you can adjust" and gives the chip row a clear visual anchor at first glance. The chip's label "Arrive by" is itself a useful prompt; it invites the user to set an arrival time, which serves the stressed traveler's "I need to get there by X" frame.

**Position B (Behavioral Scientist):** No — a filter that is pressed but bound to no value is theater. It looks like a state without acting like one. In production, screen 3 will read either as "filter is on but I never set a value" (confusing) or "filter is silently filtering based on something I didn't choose" (untrustworthy). The behavioral risk is small in a prototype but real in shipped code.

**Resolution:** Position B for production; flow accepts Position A only for prototype scaffolding. The final recommendation lists this as a scoped gap that must be fixed before scaling: the filter must accept a value before it renders pressed, or it must unpress by default.

**Preserved dissent:** the Visual / IA view that pre-pressing helps first-glance comprehension is preserved as a follow-up question for a usability test (does an unpressed-by-default filter row read as "no filters available" to tired users?). The debate did not flatten into false consensus.

## 4. Lead red-team checklist

1. **Strongest opposing design that does not use this flow.** A single-screen triage card: "Do you need to travel tomorrow, or get your money back?" routes to two narrow flows. Lower cognitive load, but loses the comparison affordance and the entitlement-visibility moment. Likely raises support calls; would not solve the brief's stated user goal of "leave with confidence about what happens next." This flow's defense: comparison + entitlements visible at one decision point.

2. **Early framing the team is anchoring on.** That the user opens the SMS link and is then in a *flow*. A real user may scroll, hesitate, switch apps, or call before reaching Screen 2. The flow assumes intent persists across screens — measurable, but not assumed.

3. **Hidden assumption that would make the recommendation fail.** That `{system-supplied}` tokens will be wired in production. If the tokens ship as-is, users see literal braces and the prototype's claim-provenance integrity becomes a UX failure. Mitigation: token rendering is a launch blocker, not a polish item.

4. **Under-modeled user segment.** Multi-passenger / family travelers. The current flow scopes them to a single filter input and a "coming soon" muted line. A traveler rebooking three people on different fare classes will hit the limits of the single-flight selection model. Surfaced as a scoped gap; not solved.

5. **Metric that would prove this flow reduced calls by hiding help.** Calls down + refund rate down + social/complaint mentions of "couldn't get a refund" up. The flow ships only with the trust-floor invalidator: if calls down ≥30% but refund rate down ≥15%, the suppression hypothesis is confirmed and the flow reverts. Without that invalidator, "calls went down" alone is unsafe success.

6. **Frustrated-user complaint quote if this shipped broken.** *"It said my plan was sent but I never got it, and the flight times in the confirmation didn't match what I actually picked."* — the exact failure mode the behavioral audit's Blocker 2 and Blocker 3 fixes were designed to prevent. Watch-for signal: any post-disruption review or social mention containing "didn't send" or "didn't match" within the first month after launch.

**Conversion to falsifier in final recommendation:** Answer 5 became Falsifier 1 (hiding-help test, primary metric refund-completion rate, invalidator -15% relative). Answer 4 became a scoped gap in §4.

## 5. Key tradeoffs and rejected alternatives

- **Token-heavy prototype over invented values.** The prototype uses `{system-supplied}` pills wherever the brief is silent. Tradeoff: visually busier than a polished mock with real numbers; pays for itself in claim-provenance integrity and gives engineering an explicit wiring list.
- **Stacked chip-below-label entitlements** (after the render-gate fix). Tradeoff: each entitlement row is ~22px taller. Worth it — the row content now fits the card frame without clipping, and the chip-below pattern de-emphasizes the repetition of identical `{eligibility per booking}` chips that would otherwise dominate.
- **Rejected:** pre-selecting a default recovery option (e.g., Rebook) on Screen 2. Even though defaults improve completion, behavioral integrity required no implicit airline preference.
- **Rejected:** treating "Talk to an agent" as a tertiary opt-out. Demoting human support would have improved call-deflection numerically but violated the trust floor.
- **Rejected:** an Interaction Designer or Content Designer specialist on the slate. The four-role compact slate covered the work; Visual's copy choices stayed within IA's copy constraints, and Behavioral / A11y caught the trust and SR failures that a separate Content / Interaction role would otherwise own.

## 6. Compact-slate overhead notes

- **Coordination cost.** Linear handoff chain: IA → Visual (author) → A11y + Behavioral (parallel audit) → Visual (revision 1) → render-gate audit by lead → Visual (revision 2, CSS-only). Four sequential spawns plus one parallel pair. No teammate stalled or required a nudge.
- **What the smaller slate gave up.** No standalone Interaction Designer for state-machine review (the flow is mostly linear, so loss is limited). No standalone Content Designer for tone calibration (Visual operated inside IA's copy constraints, Behavioral caught the unsupported-promise strings; the gap was covered). No Devil's Advocate — lead ran the red-team checklist personally, which is the experiment's hypothesis.
- **What the smaller slate kept.** Both blocking-authority roles (A11y, Behavioral) and both authoring roles (IA, Visual). The render-gate audit was performed by the lead, which means a different role would not have caught the entitlement-row overflow earlier. Adding an Interaction Designer would not have fixed that — render-gate is render-tool work.
- **Process discipline that mattered.** Forcing every operational claim through a brief-supplied / `{system-supplied}` / recommendation-only triage produced an artifact where engineering knows exactly which strings need wiring and which are static. The cost was four cycles in the prototype (two surgical, two from the audits + render-gate), all small.
- **Estimated wall time** vs. baseline: see `run-metadata.md`. Estimated extra-specialist usage: zero.
