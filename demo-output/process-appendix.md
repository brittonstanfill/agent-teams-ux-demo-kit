# Process Appendix — Canceled-Flight Recovery Redesign

## 1. What each role contributed

**Information Architect.** Set the user-job spine (acknowledge → orient → choose path → pick option → confirm and save), collapsed the current five-screen flow into a tighter sequence, and named the placeholder discipline that the visual layer had to respect: every dynamic value renders at body weight, never as the visual hero. Established the refund-as-dead-end framing and the family/multi-passenger, low-bandwidth, screen-reader, and refund-seeker scoped gaps.

**Visual / UI Designer.** Authored the HTML artifact and the one surgical revision pass after audits. Implemented the IA spine on a mobile-first stacked card surface — no phone-bezel kitsch — with a restrained four-step type ramp, single warm action color, dynamic-value treatment that inherits body weight, and a persistent "Talk to someone" footer on every screen. Refused to let any token become a visual hero.

**Accessibility Specialist.** Audited against WCAG 2.1/2.2 AA with blocking authority. Found six blockers (heading hierarchy, SMS labelledby target, focus ring contrast, reflow at 320 px, decorative back-arrows being mislabeled as interactive, label-in-name on flight CTAs). All six were applied in the revision pass.

**Behavioral Scientist.** Audited for trust, coercion, dark patterns, and choice architecture with blocking authority. Found zero blockers and five polish items. The single polish item carried into the revision was the unjustified primary-button emphasis on the 7:10 a.m. flight card; all three CTAs are now visual peers. Authored the experiment plan, including the refund-seeker call-rate falsifier that anchors the memo's guardrail metric.

## 2. Handoffs that changed the artifact

- IA → Visual Designer: refund-as-dead-end note, peer-status hotel/meal card, no-default-selected path screen → all built into the prototype.
- Accessibility Specialist → Visual Designer: six blockers → all six applied in revision pass (heading levels, sr-only SMS title, solid focus ring, reflow track, decorative back-arrow chrome, removed mismatched aria-labels on flight CTAs).
- Behavioral Scientist → Visual Designer: 7:10 a.m. CTA parity → applied. Refund-seeker call-rate falsifier → lifted into the final recommendation as the guardrail metric.

## 3. One debate and preserved dissent

**Conflict.** Should the prototype visually disambiguate the standby branch from the confirmed-rebook branch on Screen 4, or is the choice-point copy on Screen 3 ("No confirmed seat — you wait at the gate and may not get on") sufficient?

**Position A (Behavioral).** Standby selection feels equivalent to confirmed-rebook because the resulting flight list looks identical. Production needs a visually distinct standby screen now.

**Position B (IA / Visual / lead).** Splitting standby into its own screen pushes the artifact past the five-screen cap and pollutes Screen 4 with branch logic the prototype does not need to prove. The Screen 3 consequence copy carries the disambiguation work at the moment of choice.

**Resolution.** Position B for the prototype. The disambiguation is named in copy at the choice point and the production split is logged as a scoped gap.

**Preserved dissent (Behavioral).** If A/B testing shows standby selection rate climbing without a matching standby-success rate, copy at the choice point alone is insufficient and the production design must split the visual.

## 4. Lead red-team checklist

1. **Strongest opposing design.** A single "I want help — call me back" SMS deep link, skipping in-app self-service. Faster on a tired user but brittle at scale and slower per-traveler. The proposed design keeps that escape hatch persistent rather than replacing the flow with it.
2. **Anchor framing.** That self-service is the user's default goal. The brief itself says people abandon and call — so the persistent "Talk to someone" link and the refund handoff are load-bearing, not nice-to-have.
3. **Hidden assumption.** That a tired traveler at 10:46 p.m. with possibly low bandwidth can complete four-to-five screens. Mitigation: short content, no animations, every screen self-contained, copy is saveable to email and SMS at the end.
4. **Under-modeled segment.** Multi-passenger / family travelers and travelers needing accessibility assistance during recovery. Named as scoped gaps in the memo.
5. **Metric that proves we reduced calls by hiding help.** Call-rate among refund-seekers dropping. Promoted to guardrail metric in the experiment plan.
6. **Frustrated user quote.** "I tapped through three screens looking for my refund and they pushed me into travel credit." Mitigated by the visible refund-handoff note on Screen 3.

The fifth red-team answer is the one that changed the final memo: it became the experiment plan's falsifier.

## 5. Key tradeoffs and rejected alternatives

- Phone-bezel storyboard chrome rejected. Adds visual decoration that competes with content and risks clipping at constrained viewports without informing the evaluator.
- "Recommended" badge on the 7:10 a.m. flight rejected. Inherits the existing product's unjustified anchor.
- Stacked five-screen layout chosen over a single-screen "everything at once" view to preserve the choice architecture and screen-reader landmark structure.
- Standby kept on the same Screen 4 list rather than splitting into its own screen. Tradeoff named in the debate above.
- Hotel/meal kept as a peer choice on Screen 3 rather than auto-attached. Auto-attach felt like it could mask consent for travelers who prefer to make their own arrangements.

## 6. Compact-slate overhead notes

- Four roles, no escalation. No Creative Director, Content Designer, Interaction Designer, UX Researcher, or Devil's Advocate was spawned.
- One sequence: IA → Visual Designer → (Accessibility ∥ Behavioral) → Visual Designer revision → lead red-team → lead synthesis → strict render proof → seal.
- One debate, scoped to the highest-risk unresolved disambiguation.
- The lead ran the red-team checklist personally.
- The visual-craft gate held: no token dominates a headline, no decorative phone bezels, no polish at the cost of trust floors, no `overflow: hidden` masking layout. Long-token stress probe and mask-off probe both passed.
