# Process appendix

## 1. What each role contributed

**Information Architect.** Set the user-job spine (understand → choose → support → confidence), authored the five-screen sequence with per-screen primary decision and content hierarchy, fixed the brief's two flagged anti-patterns (default = "Travel credit", entitlements buried in "Other policies"), enumerated the 14-name token convention the prototype now uses, and named seven scoped gaps the prototype does not solve (multi-passenger, low-bandwidth, screen-reader specifics, refund-path depth, support-channel selection, re-disruption, baggage). Labeled every claim `[brief]`, `[inferred]`, `[assumption]`, or `[recommendation]`.

**Visual / UI Designer.** Authored the single-file HTML prototype with a restrained palette (ink/muted/paper/surface, one accent), a tightly scoped warm hue reserved for entitlement modules, and a phone-frame layout that stacks vertically at mobile and falls into a responsive 3-/2-column grid at desktop. Made one surgical revision pass against the audits (v2) and one render-gate fix pass (v3) plus a small lead-led wrap fix for narrow viewports.

**Accessibility Specialist.** Audited against WCAG 2.1/2.2 AA. Returned 3 blockers (decision-card ARIA misuse, non-focusable cross-screen targets, doubled confirmation announcement on Screen 5) and 4 near-blockers (token resolution guard, consequence font size, chip target size, sort-button target size). Verdict: fixable in one surgical pass; not a rebuild.

**Behavioral Scientist.** Audited choice architecture, dark-pattern risk, and (uniquely for this run) ran a strict claim-provenance lint. Returned 6 blockers — 5 of them claim-provenance (re-notification promises on Screens 4/5, "Most travelers choose this" fabricated social proof, reversibility promise, refund-screen process promise) and 1 hierarchy concern (the inverted-black primary card crossed from default into coercion when combined with the social-proof line). Proposed 4 falsifiers; one was promoted into the experiment plan.

## 2. Handoffs that changed the artifact

- IA → VD: token convention and screen sequence. Every operational value in the final HTML is now a `{snake_case_token}` because of this handoff. Without it the prototype would have invented hotel names and dollar amounts.
- A11y BLOCKER 1 → VD: replace `<div role="list">` + `<button role="listitem">` with real `<ul><li><button>`. Changed Screen 2's DOM and removed an ARIA misuse that destroyed the button role for screen readers.
- A11y BLOCKER 2 → VD: retarget skip link and all inter-screen CTAs from non-focusable `<figure>` elements to `tabindex="-1"` `<h2>` headings. Changed five `href` values and added `tabindex` on five headings.
- Behavioral BLOCKER 3 → VD: removed "Most travelers choose this." A fabricated social-proof claim is gone from the most-clicked card in the flow.
- Behavioral BLOCKER 9 → VD: rebalanced Screen 2 hierarchy. The primary card moved from inverted-black + social proof to accent-tinted with a small "Primary" label and an accent left-border. Refund and standby read as honest alternatives.
- Behavioral BLOCKERS 1/2/4/5 → VD: tokenized the re-notification strings on Screens 4 and 5, softened the "change your mind" reversibility promise, and removed the next-screen process promise on the refund card. Three of these became `{snake_case_token}` placeholders.
- Lead render-proof → VD: top-level DOM overflow at 390 px viewport. VD applied padding reduction at narrow widths and stacked `.row-item` and `.tonight-row` into column layout. Lead added a small follow-up `flex-wrap: wrap` on `.flight-card .top` and `.flight-card .row` to clear the last narrow-viewport intrinsic-width quirks.

## 3. One debate and preserved dissent

**Conflict:** the visual treatment of Screen 2's primary decision card. The Visual Designer's v1 used a fully inverted (black) primary card to make the flipped default visually unambiguous after the brief flagged the existing "Travel credit" default as wrong. The Behavioral Scientist's audit argued the inverted-black treatment, combined with a fabricated "Most travelers choose this" line, crossed from honest default into asymmetric friction (Blocker 9). The Behavioral position: even after dropping the social-proof line, full inversion treats refund and standby as visually rejected.

**Resolution:** soften the primary card to a light accent tint with a small "Primary" label and an accent left-border, drop the dashed border on standby, and have refund and standby share the same neutral border. Rebook remains visually primary by order, accent, and label — not by inversion.

**Preserved dissent (Behavioral Scientist):** even after softening, the system thumb is on the scale. For a user whose best outcome is a refund (e.g., the family event also canceled), the redesign is still steering them away. The Behavioral position is that Falsifier C in the experiment plan (refund-share must not collapse vs. control) is load-bearing; if it trips, the soft default is still coercive and the team should revisit hierarchy or remove the visual primary entirely.

## 4. Lead red-team checklist

1. **Strongest opposing design that does not use this flow:** an auto-rebook push design — system applies the best-match flight at the moment of cancellation and the SMS is "Keep" or "Change." Removes screen work but also removes traveler agency and surfaces airline-internal "best-match" biases without scrutiny.
2. **Early framing choice the team anchored on:** "5 screens" treated as a budget rather than a maximum. The job spine probably fits in 3 (status + entitlements, choose flight, confirm); using 5 inherits current-flow shape.
3. **Hidden assumption that would make the recommendation fail:** that backend systems can return per-user `hotel_entitlement_status` and `meal_entitlement_status` at SMS-link-open time. The whole top-of-flow value depends on this. Without it, Screen 1 falls back to "check with support," which is the failure mode we are replacing.
4. **Under-modeled user segment:** mixed-eligibility travel parties (e.g., adult plus minor with different entitlement rules). The flow lists passengers but does not branch decision logic by composition.
5. **Metric that would prove the flow reduced calls by hiding help:** call rate falls and entitlement claim rate AND successful recovery rate do not rise. Encoded as the experiment-plan falsifier.
6. **Frustrated-user complaint quote if this shipped as-is:** *"I picked the refund option and it dropped me into rebooking. The screen kept saying I could review my choice before it's final, but there was no path back to refund."* — this points squarely at the refund-or-credit branch being a scoped gap; the design promises a review path the prototype does not author.

Answer 5 was converted into the experiment plan's primary falsifier (call drop without recovery or claim rise). Answer 6 was converted into a known scoped gap surfaced in the recommendation.

## 5. Key tradeoffs and rejected alternatives

- **Five-screen ceiling vs. branch depth.** Rejected adding a sixth screen for refund-vs-credit choice; documented as scoped gap. Trade-off: protects the brief's "5 screens or fewer" constraint at the cost of leaving a real branch under-authored.
- **Inverted-black primary card vs. soft-tint primary card.** Rejected the inverted-black treatment after the behavioral audit. Trade-off: the new treatment is less visually emphatic but defensible as honest default.
- **Static "Recommended" badge vs. reason-string badge.** Rejected the bare "Recommended" badge from the brief's current flow. Trade-off: longer badge text, but the reason is now legible to the user and to a screen reader.
- **Phone-only support vs. multi-channel support.** Rejected designing a chat/callback affordance in this prototype because doing so would require inventing wait times and channel availability. Trade-off: kept the brief's reduce-calls goal structurally constrained; named as a recommendation rather than expanding scope.
- **Single-state entitlement module vs. three-state (eligible / not eligible / unknown).** Rejected authoring all three states in the prototype. Trade-off: the warm-toned module visually implies coverage when status is in fact `{token}`; named as a scoped gap and a next-iteration item.

## 6. Compact-slate overhead notes

This run used four roles. No Creative Director, Content Designer, Interaction Designer, or Devil's Advocate was spawned. The lead ran the red-team checklist personally and the claim-provenance lint personally rather than escalating to an extra specialist. The lint replaces what a Content Designer might have caught for the operational-promise category specifically; the red-team checklist replaces what a Devil's Advocate would have produced as failure-mode pressure.

Three teammate handoffs changed the artifact (IA token convention, A11y blockers, Behavioral blockers). One lead intervention changed the artifact (render-gate fix and a small follow-up wrap fix). The lead-led render gate caught a real horizontal-overflow bug at 390 px the audits did not surface, which suggests the four-role slate still benefits from an out-of-band lead-owned render check rather than expecting Visual Designer self-review to catch viewport regressions.

The compact slate met the run's hypothesis: artifact-level improvement preserved (all behavioral and a11y blockers cleared, claim-provenance lint passes), with the lead taking on red-team and viewport gating personally. No extra specialist was spawned; no nudges were sent during teammate work.
