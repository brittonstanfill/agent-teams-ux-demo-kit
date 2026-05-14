# Process Appendix — Northstar Canceled-Flight Recovery

## 1. What each role contributed

**Information Architect** — set the user-job spine (understand → orient → choose → secure support → leave with confidence), the five-screen sequence with one primary decision per screen, the content-hierarchy rule (what happened → what you can do → what we owe you → what happens next), copy constraints (never "schedule irregularity"; buttons name outcomes; never invent operational facts), and the scoped-gap list. The IA's most consequential call: refund and credit must be peers, not parent–child, on Screen 2 and Screen 3.

**Visual / UI Designer** — authored the prototype against the IA spec. Aesthetic anchor: Linear restraint + Things deliberateness, tuned for a tired traveler at 11 p.m. — calm sage/slate palette with one quiet evergreen accent reserved for forward action, amber (not red) for status, system-stack typography in six sizes. Three load-bearing design moves: (a) Standby's structural non-equivalence encoded on multiple channels (dashed container, smaller type, "non-confirmed" divider, warning chip), (b) confirmed-vs-unconfirmed support rows signaled by border style and badge (never color alone), (c) persistent agent affordance in identical shape on every screen, placed after the primary CTA so it never competes.

**Accessibility Specialist** — audited against WCAG 2.1/2.2 AA from a stressed-mobile-screen-reader-user lens. Surfaced two blockers (contradictory ARIA on Screen 2 path radiogroup and Screen 3 flight listbox), six should-fix items (most importantly the contrast of functional small text including Standby's consequence copy), and seven considered-but-acceptable items showing rigor.

**Behavioral Scientist** — audited choice architecture, dark-pattern risk, and self-service vs. call-deflection honesty. Surfaced one blocker (false-reassurance Screen 1 lead copy that would contradict later "Check with agent" rows), five should-fix items (ambiguous endowment on "Confirmed" pre-acceptance, phantom decline affordance, parked "Pending agent" badges, stepper anchoring, pre-pressed sort chip), and named four falsifier metrics that would catch the flow secretly hiding help.

## 2. Handoffs that changed the artifact

- **IA → Visual Designer**: screen sequence, primary decision per screen, content-hierarchy rule, copy constraints, scoped gaps, "honor most strictly" note that no default on Screen 2 and Standby non-equivalence are the two single biggest trust failures of the current flow. Outcome: the prototype shipped with `aria-pressed="false"` on all three path cards, and Standby visually subordinated on four channels (border, type, divider, chip).
- **A11y Specialist → Visual Designer**: drop role=radio/role=listbox on Screens 2 and 3, pick one ARIA model with proper keyboard handling, split contrast tokens, upgrade stepper to spinbutton. Outcome: HTML rewritten with `<fieldset>` + `<legend>` + `aria-pressed` toggle pattern on Screen 2 paths and refund pair; `<fieldset>` + `role="radio"` + `aria-checked` + roving-tabindex with full Arrow/Home/End/Space/Enter keyboard handler on Screen 3 flights; `--ink-2b` token introduced for functional small text; spinbutton semantics on stepper.
- **Behavioral Scientist → Visual Designer and lead**: hedge the false-reassurance lead copy; distinguish pre-acceptance "Available for you" from post-acceptance "Confirmed"; add visible per-row Decline; make Pending-agent badges into routed actions; drop the party-size anchor; un-press the sort chip. Outcome: copy hedged, "Available for you" wording shipped, Decline buttons added, Screen 5 "Resolve with agent" anchor actions wired to `#s5-agent`, stepper defaults to 1, no chip pre-pressed.
- **Visual Designer → lead**: confirmed all blockers fixed and the high-value should-fixes applied; flagged a new risk that Screen 4's three-column row could tighten under long localized strings.

## 3. One debate and preserved dissent

**Conflict:** Behavioral S5 — un-press the "Earliest arrival" chip on Screen 3 to eliminate soft defaults. The fix was applied.

**Position A (Behavioral Scientist, applied):** A pre-pressed chip is still a default. The team's principle is no defaults on choice-bearing surfaces. Un-pressing removes the soft-coercion mechanism cleanly.

**Position B (lead, dissent):** Un-pressing the chip does not change the underlying card order. Flight 1 still renders first and still carries the "Earliest arrival to LGA" criterion label. The visual sort default has not been removed; it has been un-labeled. A user who sees no chip pressed assumes "no sort applied" — but the order they read is still earliest-arrival. This is closer to a hidden default than the original was.

**Resolution:** Keep the chips un-pressed (Position A wins on the explicit-default principle) but acknowledge in the recommendation that the card order itself is a latent default that must be addressed either by (a) surfacing an explicit "Sorted by earliest arrival" line under the H1, or (b) randomizing/round-robining sort under A/B. Falsifier #4 from the Behavioral audit (refund-to-credit ratio) plus a new sort-aware metric ("first-card-selection rate at >2 standard deviations above 1/n") will catch this.

**Preserved dissent:** If first-card-selection rate runs hot post-launch, the team should revisit Position A and either re-introduce a visible sort chip with explicit labeling or break the order with light randomization. Un-pressing the chip without addressing the card-order default trades a visible default for an invisible one.

## 4. Lead red-team checklist

1. **Strongest opposing design that does not use this flow:** A call-first design. The SMS carries a direct callback number plus a phone-tree shortcut ("press 1 if your flight was canceled"), and a one-tap "Call now" button sits at the top of every screen. Thesis: at 11 p.m. on a phone under stress, the strongest service is a human voice in 30 seconds, not five screens of self-service. The opposing design loses on call-volume reduction (the business's stated goal) but wins on user trust, on edge cases (low-bandwidth, screen reader, international, family-with-kids), and on the failure mode where the operational backend can't supply per-passenger entitlement truth.

2. **Early framing choice the team is anchoring on:** The five-screen self-service flow is the right primitive. The brief framed five screens as a ceiling, not a target. We could have proposed a single-page disclosure flow, an SMS decision tree that pre-resolves rebook/refund choice before the app opens, or a hybrid where the app only handles the support layer. We redesigned each existing screen rather than question the screen-by-screen architecture.

3. **Hidden assumption that would make the recommendation fail:** That the operational backend can reliably supply per-passenger entitlement truth at notification time — that "[hotel name from system]", "Available shuttle", and per-row eligibility can be populated with high accuracy. If the system can only sometimes confirm, every support row demotes to "Resolve with agent," and the prototype collapses to an SMS that says "call us."

4. **Under-modeled user segment:** International / non-native-English travelers stranded at a hub. The IA report names language as a one-tap-deep concession; the prototype is English-only. Adjacent under-model: travelers in a delayed-cascade where the original flight wasn't canceled but a connecting flight was.

5. **Metric that would prove the flow reduced calls by hiding help:** Per-screen agent-tap rate trending flat or down across Screens 1–5 while post-flow 24-hour inbound-call volume on entitlement topics (hotel, meals, bags) stays flat or rises. Smoking gun: high "Resolve with agent" tap rate on Screen 5 paired with low actual agent-connection rate within 24 hours — meaning the badge is a parking lot, not a handoff. Behavioral falsifier #2 catches this.

6. **What a frustrated user would quote in a complaint:** *"The app said it would walk me through everything but at the end it just said 'Resolve with agent' for my bags and my meals. I tapped it three times. Nobody called. I waited 45 minutes at the gate before someone helped me."* This is the operational-backend failure mode (red-team Q3) expressed as user pain. It is the single most important falsifier to instrument before launch.

Converted to a scoped gap / falsifier in the final recommendation: red-team Q3 (operational backend reliability) is named as a Layer-0 gate the team must clear before the flow can be considered production-ready, with a corresponding watch-for metric ("Pending-agent resolution rate from Screen 5"). Red-team Q5/Q6 are operationalized as the experiment plan's primary guardrail.

## 5. Key tradeoffs and rejected alternatives

- **Status pip amber, not red.** Red dominates and feels punitive at 11 p.m.; amber matches the "Check with agent" state so severity vocabulary stays consistent. Rejected: red. Defended by the Visual Designer; the word "canceled" carries the meaning, not the chroma.
- **Standby visually subordinated rather than peer-weighted.** The IA report's "equal-weight cards" framing has a real tension with Standby's structural non-equivalence (it is not a confirmed seat). Resolution: Standby remains reachable and labeled but is not visually equivalent. Rejected: pure visual peer treatment, which would have re-created the Travel-Credit default problem under a different skin. Behavioral audit defended this as honest framing, not burial.
- **Refund and credit grouped under one Screen-2 card ("Refund or travel credit") and split on Screen 3.** Rejected: refund as its own top-level Screen-2 card. The IA's call was that "don't fly" is the user-job, with refund vs. credit as a downstream choice. Behavioral audit found peer-on-Screen-3 sufficient; the recommendation flags refund-to-credit ratio as a falsifier so post-launch can validate.
- **Spinbutton stepper rather than yes/no "traveling with family" toggle.** The IA recommended a toggle; the VD shipped a stepper that returns a real party size used by downstream "Seats together" filtering. Trade: small loss in cognitive simplicity for a real downstream affordance.
- **Pending-agent badges as routed actions.** Resolves a Behavioral resolution-gap risk but introduces a second agent-routing affordance on Screen 5. Mitigated by routing both affordances to the same `#s5-agent` target. Rejected: keeping the badge as a label and relying solely on the persistent affordance — would have left the tired user at the end of the flow without a row-specific resolution path.
- **No skip link.** Acceptable for a prototype that presents five screens stacked for audit. Would be required for a production single-screen view.

## 6. Compact-slate overhead notes

- **Four roles total:** Information Architect, Visual / UI Designer, Accessibility Specialist, Behavioral Scientist. No Creative Director, Content Designer, Interaction Designer, or Devil's Advocate spawned. Lead ran the red-team checklist personally.
- **Sequence:** IA spine → VD prototype → A11y + Behavioral audits in parallel (blocking) → VD surgical revision pass → lead red-team → lead synthesis.
- **Handoff count that changed the artifact: 4** (IA → VD spec, A11y → VD blockers, Behavioral → VD blockers + copy, VD → lead final). All four handoffs produced verifiable HTML/copy changes; no handoff was ceremonial.
- **Debates: 1** (sort-order default), preserved with explicit dissent and a falsifier.
- **Specialist depth observed:** Visual Designer named specific aesthetic anchors and CSS tokens; A11y named WCAG criteria, selectors, and screen-reader announcement behavior; Behavioral named dark-pattern mechanisms (false reassurance, ambiguous endowment, phantom affordance, resolution gap, implicit default) and four falsifier metrics. None of the four produced generic UX advice.
- **Coverage trade vs. the lean six-role slate:** No dedicated Content Designer, so the lead carries the calibration call on the Screen-1 hedged copy; the VD and Behavioral both shaped the line but the final string is recommendation-shape, not production copy. No Interaction Designer, so motion, focus-on-route-change, and disclosure animation are out of scope — acceptable here because the prototype has no routing. The biggest visible cost of the compact slate is the absence of a dedicated copy review pass; the biggest visible saving is no coordination overhead from a fifth or sixth role who would have needed their own audit pass.
- **Nudges to teammates:** Lead nudged the Visual Designer once after the audits with a consolidated revision brief (blockers + selected should-fixes). No teammate was nudged to redo work; no role report was edited by another role.
- **Extra specialist spawned: none.** Run is a clean four-role result.
