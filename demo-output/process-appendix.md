# Process Appendix

## 1. What each role contributed

- **Information Architect** authored the user-job spine, the 5-screen sequence, the per-screen primary decisions and content hierarchies, the copy constraint set (banned phrases, verb+outcome button rule, confirmation summary rule, persistent support link), and the scoped-gap list. The IA report is what the Visual Designer worked from directly — they did not re-read the brief.
- **Visual / UI Designer** authored the prototype in one pass from the IA spec, then ran a single surgical revision pass after both audits. They self-flagged target-size and asymmetry concerns up front, which previewed two of the eventual blockers.
- **Accessibility Specialist** found three blockers: flight cards not keyboard-accessible, focus ring failing non-text contrast on the primary, and target sizes below 44×44px (the help link was the worst at ~20px). They also batched cheap nice-to-haves the designer could apply alongside.
- **Behavioral Scientist** found three blockers: Screen 1 over-anchoring hotel/meal support as a floated offer, Screen 5 rendering pending and confirmed rows identically (hiding a real semantic difference), and Screen 4's confirm button being tappable with no selections made. They named two falsifiers that became core to the experiment plan: "calls hidden not helped" and "entitlement disappointment."

## 2. Handoffs that changed the artifact

- **IA → Visual.** Screen sequence, primary decisions, content hierarchy, copy constraints, and the placeholder-token rule. The artifact's structure (5 screens, three equally-weighted choices, support as Screen 4 not FAQ) all came from this handoff.
- **A11y → Visual.** Three blockers led to: flight cards rewritten as a native radio-group; two-color focus ring on every focusable element; `min-height: 44px` added to filters, toggles, help link, and primary buttons. Cheap nice-to-haves (h-display demoted to h2 for parity, decorative status bar hidden from AT, "Screen N of 5" aria-labels) batched in.
- **Behavioral → Visual & lead.** Three blockers led to: Screen 1 reassurance rewrite; Screen 5 status-pill ("Pending" vs "Confirmed") with new CSS classes; Screen 4 primary disabled until both accept/decline pairs are answered, with helper text near the button.
- **Lead → artifact (render gate).** A late check found `.time-block` / `.when` / `.where` content overflowing their box widths by ~6px at 390px. Container-escape (children outside parent rects) was clean, but `scrollWidth > clientWidth` on inner elements failed the strict gate. Fixed with `min-width: 0` on `.when` / `.where` plus `display: inline-block; max-width: 100%; word-break: break-all` on the `.tok` pills inside the time blocks. Long-token stress test post-fix returned 0 offenders with and without overflow masking.

## 3. One debate and preserved dissent

**Debate**: how strongly to warn about standby risk on Screen 2.

- **Visual Designer position**: a small "Not guaranteed" chip below the title is calibrated — not louder than the choice cards themselves, but asymmetric to the other two paths.
- **Behavioral Scientist position**: the chip and consequence line are honest, but a present-bias user (optimistic about today's chances) can still imagine "they'll just rebook me if standby fails." Add "and no fallback flight is booked" to the consequence line.

**Resolution**: keep the existing chip + consequence in this revision pass (Behavioral named this a "nudge," not a blocker, and the revision budget was one surgical pass). **Preserved dissent**: the Behavioral nudge is converted into a falsifier in the experiment plan — "standby surprise" — so if the data shows users are surprised they did not fly, the copy strengthens next iteration.

## 4. Lead red-team checklist

1. **Strongest opposing design.** SMS-first auto-resolve: send a single SMS with a system-chosen rebook + tap-to-accept-or-change link, skipping the multi-screen browse for the easy 80%. Our design assumes the user needs agency; the opposing design assumes the airline can pick a good default. For a 10:46 PM exhausted user, the opposing design may serve better on time-to-resolution.
2. **Early framing the team anchored on.** "Give the user choice over the recovery path." Embedded in IA job #2 and never seriously re-examined. The opposing "give them an answer they can override" framing was not piloted.
3. **Hidden assumption that would make the recommendation fail.** Eligibility for hotel/meal can be determined synchronously by Screen 4. If it takes 30+ minutes, Screen 4 has no "long wait" design. Converted to a **scoped gap** in the final memo.
4. **Under-modeled user segment.** Frequent / elite-status travelers (fare-class differences, fee waivers, priority standby) and award-ticket / codeshare-interline travelers. Multi-passenger is flagged; elite status is not. Logged as a scoped gap.
5. **Metric that would prove calls dropped by hiding help.** Help-link taps falling alongside call-rate while post-flight contacts rise — or while average call duration rises for the calls that remain. Converted to the **primary falsifier** in the experiment plan.
6. **A frustrated user's complaint quote.** "I picked 'wait for a seat' thinking I'd be moved to a later flight. Nobody told me the day's last flight would leave without me." Reinforces the standby-surprise falsifier.

Items 3 and 5 changed the final recommendation: 3 became a scoped gap, 5 became the primary falsifier (overlapping with the Behavioral Scientist's top falsifier).

## 5. Key tradeoffs and rejected alternatives

- **Three equally-weighted recovery paths vs. recommended default.** Rejected default because the current product's "Travel credit" default was named as a problem in the brief and the Behavioral Scientist flagged default-effect risk. Tradeoff: more cognitive load at Screen 2 for users who would have accepted a sensible default.
- **Hotel/meal as Screen 4 vs. inline on Screen 3.** Chose a dedicated step so the entitlement check is unmissable and the accept/decline decisions are honest. Tradeoff: one more tap, one more screen.
- **Disable Screen 4 primary until selections made vs. preserve "I haven't chosen yet."** Took the disabled-button path. Tradeoff: it costs a fatigued user one extra tap pair; preserved-state would require a real third state through the confirmation summary, which the artifact does not yet design.
- **Standby chip wording.** Kept "Not guaranteed" + current consequence line. Behavioral Scientist's stronger wording ("no fallback flight is booked") preserved as dissent and as a falsifier-driven next iteration.
- **Native radio-group vs. button-list with aria-checked.** Took native radio. Wins on AT compatibility and keyboard semantics; costs some visual customization complexity.

## 6. Compact-slate overhead notes

- Four roles, sequential except for the parallel A11y + Behavioral audit.
- No extra specialist spawned. Creative Director, Content Designer, Interaction Designer, Devil's Advocate, UX Researcher were all skipped per prompt.
- No teammate nudged after their initial brief.
- Lead personally owned: claim-provenance lint, red-team checklist, render proof (including the late `.time-block` CSS fix that no audit role had explicit ownership of).
- One surgical revision pass: 6 blockers + 4 cheap A11y nice-to-haves applied, 0 rejected.
- Coordination overhead was confined to two handoff messages (IA→Visual, audits→Visual) plus the lead's red-team and render proof, not a meeting cycle.
