# Process Appendix

## 1. What each role contributed

**Information Architect.** Set the five-screen spine (Status & Cause → Choose Your Path → Pick a Flight → Tonight's Support → Confirmation & Offline Record), promoted refund to a peer of rebook and credit on Screen 2, demoted standby from a tab to an inline rebook option, made support a dedicated screen rather than an FAQ, and wrote the copy constraints that bound everything downstream — plain language, no invented numbers/brands/windows, conditional eligibility framing, sharable confirmation. Labeled scoped gaps for group-split, low-bandwidth offline record, screen-reader specifics, and persistent `Call support`.

**Visual / UI Designer.** Authored the single-file HTML storyboard, mobile-first at 390px with desktop centering, semantic landmarks, a real type/color/spacing system, token pills as visible content, and persistent `Call support` in every screen's header plus a bottom support dock. Did a bounded 390px sanity check (top-level scrollWidth/clientWidth only) before handoff; the strict render proof was lead-owned after audits. Then made one surgical revision pass applying every audit blocker.

**Accessibility Specialist.** Returned 13 blockers and 11 important items against WCAG 2.2 AA: multiple `<main>` elements per document, five `<h1>`s on a stacked storyboard, screen labels marked `aria-hidden`, `role="listitem"` on `<button>`, literal `{token}` strings in the accessible name tree, contrast on `--ink-500` and `--ink-400`, focus ring matching the primary button's blue, filter-chip target size at 36px, and a missing skip-link / storyboard nav.

**Behavioral Scientist.** Returned five blockers and four important items. The top finding: Screen 2's bottom path-agnostic "Find a flight" CTA could roach-motel a refund-tapper into rebook. Also flagged the "Recommended for getting there" badge as anchoring against a refund-seeker's stated goal, the pre-checked Morning filter chip as a silent default, "Continue without support" as confirmshame-adjacent, and "Done" as implying trip closure. Provided four falsification metrics expressed as ratios.

## 2. Handoffs that changed the artifact

- **IA → Visual Designer (pre-build):** refund-as-peer, support-as-own-screen, no fare-difference badges in disruption recovery, no invented numbers. Shaped Screens 2, 4, and the flight-card design.
- **A11y → Visual Designer:** structural HTML rewrite (one `<main>`, one `<h1>`, sections with `aria-labelledby`), `<ul>/<li>` wrapping of path and flight cards, focus-ring fix on `.btn-primary`, contrast bumps on body and route arrows, chip min-height to 44px, storyboard nav with anchor IDs.
- **Behavioral → Visual Designer:** removed Screen 2 bottom CTA; dropped the "Recommended" badge; unchecked the Morning filter; relabeled "Continue without support" → "I have a place to stay tonight" and reordered it below "Talk to someone about tonight"; relabeled "Done — save a copy" → "Save my record"; equalized flight-card button weights; rewrote the Screen 1 banner reassurance line.
- **Lead → artifact (post-audit render proof):** support-dock CSS — added `flex-wrap: wrap` and a `gap` on the link so `Call {support_number}` stops butting against itself or against the left-side text on narrow viewports. `.token` CSS — switched from `word-break: break-word` (which split tokens mid-character) to `overflow-wrap: anywhere` with `max-width: 100%`. Render proof then re-ran clean.

## 3. One debate and preserved dissent

**Debate.** Should the Rebook path on Screen 2 still carry a descriptive label (e.g., "Fastest path to destination") even after the "Recommended for getting there" badge was removed for anchoring? Behavioral wants the visual default plus `aria-current` to do the work silently. Visual designer's instinct was that an honest descriptor helps the 80% case without nudging.

**Resolution.** Keep the silent default. Rebook retains visual weight (blue card, top position, `aria-current="true"`) but no evaluative label. Card description ("Pick a replacement flight. Earliest arrival first.") carries the framing as a fact, not a recommendation.

**Preserved dissent.** Visual designer's call that a neutral descriptive label could improve clarity for the 80% case without harming refund-seekers. Falsifier: run a 2-cell test (label vs no-label) measuring refund-path completion among self-identified refund-intent users.

## 4. Lead red-team checklist

1. **Strongest opposing design.** A "call-first" assistive design that surfaces a live agent as the primary action on Screen 1 with self-service as fallback. Defensible at 10:46 p.m. for a tired traveler. Our bet: plain language + visible call + offline record outperforms hold time.
2. **Early framing we anchored on.** The five-screen storyboard. The brief said "5 or fewer." A 3-screen path (status+choice → pick / refund / credit landing → confirmation) could halve cognitive load. We chose spine fidelity over economy.
3. **Hidden assumption that would make this fail.** That the backend returns cause-and-availability eligibility for hotel/meal support in real time. If post-hoc, Screen 4 promises a check it cannot deliver. → Converted into the scoped gap in §4 of the recommendation.
4. **Under-modeled segment.** Multi-passenger group-split: one refunds, others rebook. The flow assumes one decision per PNR. → Scoped gap.
5. **Metric that would prove calls dropped by hiding help.** Call rate among "not eligible" Screen-4 viewers + opt-out rate among confirmed-eligible users. → Both are in the experiment plan.
6. **Frustrated user quote in a complaint.** *"I tapped Request a refund but the flight cards still came up. The screens still felt like they were pushing me toward rebook even after I picked refund."* → Drove the refund-tap → refund-complete falsifier and the removal of the bottom path-agnostic CTA.

Red-team item #3 (eligibility-backend assumption) became a scoped gap in the final recommendation; item #6 reinforced Behavioral Blocker #1 and Falsifier #1.

## 5. Key tradeoffs and rejected alternatives

- **Rejected:** 3-screen path. Lower cognitive load but collapses the support screen into a sidebar, which the brief explicitly warns against ("hotel/meal are entitlements buried in FAQ").
- **Rejected:** call-first primary action. Optimizes for the worst case at the cost of the 70%+ who can self-serve.
- **Rejected:** showing fare-difference badges on flight cards during disruption recovery. Even small dollar amounts during stress import a purchase frame the brief warns against.
- **Rejected during revision:** keeping the "Recommended for getting there" badge as honest signposting. Behavioral blocker stood; preserved as the debate dissent above.

## 6. Compact-slate overhead notes

Four roles + lead. No extra specialists were spawned. No teammate was nudged. Sequence: IA → Visual Designer (build, bounded 390px sanity check) → A11y + Behavioral in parallel → Visual Designer single surgical revision → lead strict render proof + red-team + synthesis. Coordination cost was low — only one debate was run, only one teammate-message-driven HTML change pattern repeated across audits (audit blockers → revision pass). Lead spent meaningful time on the strict render proof (top-level + no-mask + fixed-container) and one CSS regression-fix on the support dock; that work would have been duplicated, not skipped, on a larger slate.
