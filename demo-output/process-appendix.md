# Process Appendix

## 1. What each role contributed

- **Creative Director.** Set the aesthetic anchor before authoring: calm night-shift dispatcher, dark-mode default, type-led, motion-near-zero, no brand-blue hero, no illustration, no gradient. Named the failure mode to avoid as "polite-airline apology page with sympathy-theater over decision-support." Stated one quality bar: every screen legible, decidable, and acted-on in under 15 seconds by a tired thumb. Did not author surface.
- **Information Architect.** Set the user-job spine (understand → know I still get there → see what the airline will do → pick a path → leave with proof → know how to reach a human). Answered Creative Director's handoff: Screen 1 forces exactly one decision — travel or not. Designed the 5-screen sequence (SMS, Situation+fork, Replacement flights, Confirm+support, Receipt). Treated every operational fact as a system-provided slot. Labeled every claim observed / inferred / assumption / recommendation. Identified four edge cases (family/multi-passenger, low bandwidth, screen reader, refund-seeker) and solved or scoped each.
- **Visual Designer.** Authored the working HTML prototype across both passes. Held the Creative Director's posture and the Information Architect's structure. Surfaced self-flagged risks before audit (focus ring uncertainty, Accept/Decline ARIA state, native iOS select rendering).
- **Accessibility Specialist.** Audited the actual HTML and CSS tokens, computed contrast ratios at documented hex values, and produced six surgical blockers — all applied in one revision pass. Verified the strong choices (real `<button>`, `prefers-reduced-motion`, underlined links, 44 px targets) so they would not regress.
- **Behavioral Scientist.** Audited the trust floor and named-mechanism dark patterns. Confirmed TRUST FLOOR pass with zero blockers. Took a defended position on three contested items (Accept-defaults: ship-as-is; standby row: change; refund-fork weight: ship-as-is). Specified two falsifiable claims with measurable thresholds.
- **Devil's Advocate.** Steel-manned the proposal, named the strongest opposing design (SMS-native + one-page receipt), surfaced six load-bearing hidden assumptions, ran a pre-mortem, named a different fork-comprehension falsifier than the Behavioral Scientist's, and called the team's risk of anchoring on the Creative Director's posture.

## 2. Handoffs that changed the artifact

- **Creative Director → Visual Designer.** "No hero illustration, no brand-color flood, no gradient" kept the prototype out of the brand-template default and into the dispatcher register.
- **Information Architect → Visual Designer.** "Screen 1 forces one fork: travel or not" became the two stacked equal-weight buttons. "Per-traveler eligibility as status" became the per-passenger rows on Screen 3. "Standby is acceptable only when categorically separated" set up the second revision change.
- **Accessibility Specialist → Visual Designer.** All six blockers changed the HTML in the revision pass: primary-button focus ring (token-level), `<h1>` demotion across all screens, anchor → `<button>` for the four primary actions, Accept/Decline → native radiogroup with `aria-live` status node, dashed-border standby flag (non-color differentiation), filter legend rename + `aria-describedby` party-size hint. Skip-link added as recommended.
- **Behavioral Scientist → Visual Designer.** One HTML change: standby row relocated to its own `<section>` with explicit subheader. Zero copy or hierarchy changes. Five instrumentation requirements that flow into the experiment plan.
- **Devil's Advocate → Lead.** SMS-channel alternative recorded as a scoped gap. Fork-comprehension falsifier added to the experiment plan as Exit Rule 3. Anchoring-bias call recorded here so the next loop can ask a different question.

## 3. Two debates and preserved dissent

**Debate 1 — Core choice architecture: web flow vs SMS-native channel.** Devil's Advocate argued the SMS link is the abandonment surface and that a structured SMS thread with a one-page receipt could carry the whole experience. The team's defense: web earns its keep on multi-passenger PNRs, on filter needs (arrive-by, nonstop, party-size), and on per-traveler eligibility differences — exactly the cases the Information Architect promoted to first-class citizens. **Resolution:** keep web. **Dissent preserved:** the team did not justify *why* the default channel is web rather than SMS-with-web-as-escape. Listed as a scoped gap in the experiment plan.

**Debate 2 — Trust on Screen 3: Accept-pre-selected defaults vs neutral.** Visual Designer self-flagged Accept-pre-pressed as a possible coercive default. Devil's Advocate added a pre-mortem ("calls drop, disputes rise"). Behavioral Scientist defended ship-as-is: entitlements are pro-user defaults; neutral defaults would re-raise sludge to claim what the airline already owes. **Resolution:** ship Accept-pre-selected with instrumentation. **Dissent preserved:** autonomy concern and post-confirm-dispute concern are both addressed through the falsifier "post-confirm support-item reversals > 15 % within 24 h triggers a switch to neutral defaults."

## 4. Key tradeoffs and rejected alternatives

- **SMS-native channel as default** rejected for the multi-passenger and filtering cases; preserved as a future-test alternative for single-passenger PNRs.
- **A "Recommended" badge on flights** rejected; brief flags it as a trust-breaker without explanation.
- **Fare-difference shown during disruption** rejected; brief flags it as a trust-breaker.
- **Default to credit tab** rejected; brief flags it as a goal mismatch.
- **A neutral default on support items** rejected; treated as sludge against the user's entitlement.
- **A celebratory checkmark on Screen 4** rejected; sympathy-theater the user does not want at 10:50 p.m.

## 5. Lean-slate overhead notes

Six teammates: Creative Director, Information Architect, Visual Designer, Accessibility Specialist, Behavioral Scientist, Devil's Advocate. **No optional specialist (Content Designer or Interaction Designer) was spawned.** The lean slate held: content fit inside Information Architect and Behavioral Scientist's labeled-claim discipline; interaction fit inside Visual Designer's prototype plus Accessibility Specialist's blocking authority. Two formal debates were enough to surface real dissent without process bloat. The Visual Designer's single surgical revision pass closed every named blocker. No teammate was nudged or restarted.

## 6. Devil's Advocate stress-test summary

The steel-man held: this prototype refuses sympathy-theater, surfaces entitlements as status, co-equalizes refund, and removes every canonical dark pattern named in the brief. The strongest opposing design is SMS-native resolution with a one-page web receipt; it is not adopted but is preserved as a scoped gap. Six load-bearing assumptions are flagged (per-traveler eligibility as a real backend field, real-time held inventory, English literacy, call volume as a UX problem rather than an operations symptom, solo decision-makers, single-device tired-thumb users); each fails the recommendation if false. The fork-comprehension falsifier (Exit Rule 3) is the Devil's Advocate's addition. The named bias risk is anchoring on the Creative Director's posture — the lean team should ask the next loop whether a different aesthetic register (warmer, more guided, or non-web) would outperform on the same user.
