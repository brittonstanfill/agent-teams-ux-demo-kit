# Northstar Air — Canceled-Flight Recovery: Final Recommendation

**Prepared by:** Northstar UX Recovery Team — 7 specialists (ux-researcher, info-architect, interaction-designer, content-designer, accessibility-specialist, visual-designer, behavioral-scientist) + team-lead synthesis.
**Source brief:** `demo-inputs/northstar-canceled-flight-brief.md` (fictional scenario).
**Constraints honored:** Mobile-first, ≤5 screens, no invented policies / metrics / quotes.
**Provenance note:** This recommendation is built from the teammate-authored role reports in `demo-output/role-reports/` and the peer messages in `demo-output/peer-messages/`. An earlier lead-written draft of the role reports is preserved at `demo-output/role-reports-draft-lead-written/` for comparison; this run uses the live teammate output.

---

## Pre-Synthesis Snapshot

> Per the master prompt, before the recommendation the lead surfaces (1) each teammate's top 3 findings, (2) the most important tension, (3) which teammate message changed another teammate's recommendation.

### 1. Top 3 findings — by teammate

**UX Researcher** (`ux-researcher.md`)
1. The user does not yet know what happened, what their choices are, or what it will cost. The flow asks them to act before it informs them.
2. The default option ("Travel credit") is misaligned with the dominant user goal (get to the family event tomorrow).
3. The confirmation screen does not close the loop — users leave without an offline-survivable artifact and re-call to "make sure it went through."

**Information Architect** (`information-architect.md`)
1. The entry point destroys information scent before the app ever opens ("Schedule irregularity" is an IA failure, not a tone-of-voice failure).
2. Entitlements (hotel, meal) are filed under an org-chart label ("Other policies") — the classic IA anti-pattern of grouping by team rather than by user question.
3. There is no real confirmation — just a dismissal. The confirmation screen is the artifact a stressed traveler re-opens four times before sunrise, and it must be a structured facts list.

**Interaction Designer** (`interaction-designer.md`)
1. Every state change in this flow must announce itself — the silent "Trip updated" is the canonical failure.
2. Error recovery has to be a first-class set of states (no flights, inventory race, payment declined, network drop, session expired), not edge cases.
3. A two-step commit (Select → Review → Confirm) is the trust-earning interaction, not gratuitous friction — consequences surface before the change, not after.

**Content Designer** (`content-designer.md`)
1. The current copy hides the event behind system-speak. Leading every surface (SMS, page title, H1, link preview) with the event in plain language is the highest-leverage change.
2. Every CTA in the current flow is a verb without a consequence — every button must name the result of the tap. Plain language *is* accessibility.
3. Hotel and meal help need warm-but-honest language that doesn't promise what the brief doesn't authorize ("You may qualify — we'll check now"). Users trust honesty under stress; they punish overpromises.

**Accessibility Specialist** (`accessibility-specialist.md`)
1. The SMS and Screen 1 deny the user the information they need to make a single decision — "Schedule irregularity" + "Your itinerary has changed" violate **WCAG 3.1.5, 3.3.2, 2.4.6**.
2. Hotel and meal entitlements buried in a collapsed FAQ is a **3.3.2 / 2.4.6** failure and a real-world equity harm beyond conformance.
3. "Continue," "Done," and "Recommended" are non-descriptive controls — **2.4.4, 2.4.9, 1.3.1** failures; "Recommended" carries meaning that is not programmatically conveyed.

**Visual / UI Designer** (`visual-designer.md`)
1. This is a stress instrument, not a marketing surface — exaggerate hierarchy, kill decoration. One dominant element per screen.
2. The current system fails on its load-bearing element: the "Recommended" badge. Replace with **text + icon + reason** on a neutral chip — never brand color, never red/green.
3. Status, decision, and help have to coexist on every screen with non-competing z-order — three persistent zones at deliberately different weights.

**Behavioral Scientist** (`behavioral-scientist.md`)
1. The default tab is working against the user's actual goal — default effect / status-quo bias steers a non-trivial share of tired users toward credit when they came to rebook.
2. Hidden entitlements (hotel, meal) are the single biggest trust risk — a roach-motel-adjacent pattern.
3. The flow gives the user no model of "what happens if I pick wrong" — ambiguity aversion predicts disengagement and a call to support.

### 2. Most important tension

**The "persistent Call Northstar support" affordance: trust raiser or call-volume bomb?**

- **Information Architect, Accessibility Specialist, Interaction Designer, Content Designer** all converge on a persistent "Call Northstar" affordance in the same position on every screen (WCAG 3.2.6 Consistent Help). The argument: a *visible* escape **increases** successful self-service because it removes the feeling of being trapped.
- The brief is explicit that the business goal is to reduce calls — **but** the brief is equally explicit that this cannot be achieved by hiding help.
- The IA explicitly anticipates the pushback: *"a visible escape that is never tapped is fine; an invisible escape that drives abandonment is the problem."*
- **Behavioral Scientist** supports the affordance ethically but flags the operational dependency: if call-line capacity isn't sized for it, the affordance becomes performative and erodes more trust than it builds.

Verdict: ship the persistent escape; gate the live experiment on a support-ops staffing check (see Experiment 5).

A secondary tension surfaced cleanly: **two-step commit vs. one-tap rebook** — interaction-designer pre-empts behavioral-scientist's likely friction concern by framing the Review screen as *consequence surfacing* (regret prevention) rather than friction-for-friction's-sake. Behavioral-scientist's report endorses the framing on the choice-architecture side. No remaining team disagreement.

### 3. Cross-agent messages that changed another teammate's recommendation

This is the proof that the team earned its cost. Each row is documented in `demo-output/peer-messages/`.

| Sender → Recipient | Message | What changed |
|---|---|---|
| **ux-researcher-2 → info-architect-2** (`ux-researcher-to-info-architect-2.md`) | "Talk to a human" should be a persistent affordance, not a peer recovery option; family / mobility as filter, not as a front-loaded branch. | IA adopted both: persistent escape on every screen (S1–S5), and mobility / party-size live as filters on S3 (not an early branch). |
| **info-architect-2 → interaction-designer-2** (`ia-to-interaction-designer-2.md`) | 5 screens with conditional skips, no default selection on S2, S3 selection is *held, not committed*, S4 Confirm is the only one-way door, persistent escape across all screens. | Interaction-designer built the entire state matrix around this structure; commit boundary is S4 only; back-out preserves state. |
| **accessibility-specialist → interaction-designer** (`a11y-to-interaction-designer.md`) | Every state change must announce; tabs → segmented control with consequence labels; focus management on screen load; undo as a real state; persistent "Call Northstar" (WCAG 3.2.6). | **Three concrete changes in the interaction model:** (1) tabs dropped entirely in favor of a segmented control, (2) every state row gained a "what announces" + "focus on entry" column, (3) undo is now a named state (not decoration) with explicit announcement model. |
| **accessibility-specialist → visual-designer** (`a11y-to-visual-designer.md`) | Contrast minimums, never color-only, 44pt targets, reduce-motion default, sticky-bottom CTA must not obscure focus, reflow at 320px / 200% zoom. | Visual-designer rebuilt the "Best match" badge from a colored chip to **text + icon + reason** on a neutral chip, and made motion opt-in via `prefers-reduced-motion`. |
| **accessibility-specialist → content-designer** (`a11y-to-content-designer.md`) | Plain language at ~grade 6–8; stand-alone link text; explain badges in words; standby clarity; family/party-aware phrasing; no idioms. | Content-designer adopted the "Orientation → Understanding → Agency → Closure" voice arc, removed idiomatic phrasing, added party-scope copy ("for all 3 travelers"), and inlined the "Recommended" reason. |
| **behavioral-scientist-2 → content-designer-2** (`behavioral-to-content-designer.md`) | Loss-aversion only when factually true; "Recommended" must carry a reason or be dropped; no manipulated urgency / countdowns; fare-difference framed vs. *original ticket*, not vs. $0; peak-end rule for confirmation; no confirmshaming. | Content-designer adopted "Best match" with adjacent reason, reframed cost copy ("Same fare as your original" / "+$84 vs. your original" rather than "$0 / +$84"), and explicitly forbade confirmshaming and countdown copy. |
| **behavioral-scientist-2 → interaction-designer-2** | Inventory-hold communication factually only on Review (not pressure on the choice); standby never default; no "Are you sure?" modals on plain back-out actions. | Interaction-designer's state model already aligned (Step 2 has *no* countdown; Step 3 surfaces the hold as reassurance: "Holding your seat"). Confirmed; no model change required. |
| **visual-designer-2 → accessibility-specialist-2** (`visual-designer-to-accessibility-specialist-2.md`) | Asked accessibility to confirm "Best match" chip is colorblind-safe and status colors hit ratios on light + dark. | Accessibility flagged additional concerns (dark-mode tuning of status colors; focus ring contrast against brand backgrounds), prompting Visual to commit to **dark-mode-tuned status tokens**, not just remapping. |

The two handoffs most likely missed by a single-agent baseline:
- **Behavioral-scientist's fare-difference reframing.** Replacing "$0 / +$84" with "Same fare as your original / +$84 vs. your original" only emerges when someone is sitting in loss-aversion theory long enough to notice that "$0" is an implicit zero anchor on a disruption the user didn't cause. That's a behavioral specialty move.
- **Accessibility-specialist's "tabs → segmented control" pivot.** A single agent would likely fix the *default* but keep the tab pattern. The accessibility specialist named the WCAG case and the segmented-control alternative concretely, and the interaction-designer adopted it whole.

---

## 1. Executive Recommendation

Redesign the canceled-flight recovery flow around four principles, in this order:

1. **Event first, action second.** Lead the SMS, every screen, and every announcement with the actual event in plain language. Replace "schedule irregularity," "itinerary has changed," "Continue," "Done," "View details," "Other policies" everywhere they appear.
2. **No hostile default; no hidden help.** Remove the "Travel credit" pre-selection. Surface hotel and meal entry alongside rebook (not in an FAQ). Use honest, non-promising language ("you may qualify — we'll check now"). Persistent "Call Northstar" on every screen in the same location.
3. **Two-step commit with a 60-second undo.** Select → Review → Confirm. Confirm is the *only* one-way door. Undo within 60 seconds, announced once, with state restoration handled server-side.
4. **Confirmation is a deliverable, not a courtesy page.** Structured facts list (new flight, time, terminal, hotel address, confirmation code, support number), saveable offline, with two onward actions that matter equally — "Save offline" and "Change my recovery."

Non-negotiable guardrails (full lists in §6): every state announces (WCAG 4.1.3), all action labels are consequence-bearing (2.4.4 / 2.4.6 / 3.3.2), 44pt targets, ≥4.5:1 contrast, reduce-motion default, no countdown timers on choices, no pre-checked items that charge the user, no confirmshaming, no celebratory motion on confirmation.

---

## 2. Redesigned Flow (5 screens, mobile-first)

```
SMS → S1 Status → S2 Choose recovery ┬─→ S3 Pick a flight → S4 Add support → S5 You're set
                                     ├─→ (credit/refund) ─────────────────────→ S5
                                     └─→ (standby) ──→ S3 (standby framing) ──→ S4 → S5
```

### S0 — SMS (entry, not counted as a screen)

> Northstar Air: your 6:15 a.m. flight NS482 tomorrow (DEN→LGA) is canceled.
> We're holding rebooking and hotel options for you.
> Tap to see them: [link]
> Or call us: 1-800-NORTHSTAR (open 24 hours).

Three slots: event named → action available → reassurance + fallback. Verified-sender pattern; never the bare word "link."

### S1 — Status & Path

- **H1:** "Your 6:15 a.m. flight to LGA is canceled."
- Plain-language reason ("crew availability") and party-scope sentence ("affects all 3 travelers") when applicable.
- **Options preview** (the part the current Screen 1 lacks entirely): four tappable cards labeled in user-task terms — Rebook on another flight • Get a travel credit or refund • Join standby • Get hotel + meal help.
- **Primary CTA** is one of the above, depending on which the user taps; secondary expander reveals the rest.
- Persistent **"Call Northstar"** at a known anchor; itinerary details collapsed (labeled "itinerary," not "details").
- Focus moves to `<h1>` on load; status announced via `role="status"`.

### S2 — Choose How to Recover

- **H1:** "How would you like to recover?"
- **Stacked cards (no tabs), no pre-selection.** Each card: user-task verb label + one-line consequence + one-line cost/risk signal (only if Northstar's policy permits; otherwise omit cost field rather than fabricate).
- Hotel + meal entry is a **peer card** on this screen, not a child of a tab.
- Persistent "Call Northstar."
- **Branch:** Rebook / Standby → S3 • Credit/refund → S5 (or S4 if entitlements apply) • Hotel-help → in-flow sheet without losing place.

### S3 — Pick a Flight (or "Pick a standby flight")

- Sticky banner: "Canceled: 6:15 a.m. NS482 tomorrow."
- Filter row (collapsed by default): arrival by [time picker] • nonstop only • mobility / accessibility needs • travel party size.
- Flight cards sorted by **earliest arrival to original destination** by default; user can re-sort.
- Each card: depart/arrive + duration • stops with layover airport named • **"Best match" badge with the reason inline** ("earliest arrival, no extra cost") — text + icon + reason, never color-only • fare difference surfaced **only** when Northstar's policy actually charges one, framed vs. the original ticket ("Same fare as your original" / "+$84 vs. your original").
- **Selection is held, not committed.** Back to S2 preserves filter state and selection.

### S4 — Review & Add Support

- **H1:** "Review your changes."
- Old → new diff (date, time, terminal, travelers, baggage).
- Cost block — honest framing: "Cost: $0. No fare difference applies because Northstar canceled your flight" (or, for upgrades, plain explanation).
- **Hotel + meal block**, named in task language. State block honestly says "Hotel and meal help isn't available for this cancellation type" if not entitled — does **not** hide the section.
- **What happens next:** SMS + email confirmation, 60-second undo, support number.
- **Primary CTA: "Confirm rebooking"** — consequence-bearing, the **only one-way door** in the flow.
- Secondary CTA: "Back to flight list" — preserves selection.

### S5 — You're Set

- Live-announced H1 (`role="status"`): "You're set — here's what happens next."
- **Itinerary block** (facts list): flight #, date/time, terminal, gate-or-TBD, travelers, confirmation code, baggage status — copyable.
- **Hotel block** (if added): name, address, check-in window, confirmation code.
- **Save offline action** (PDF / wallet / share) — first-class.
- **Save-this-info actions:** "Text me this info" / "Email me this info" / "Add to calendar."
- **Undo window:** "You can undo this rebooking for the next 60 seconds." Visible countdown, calm color, single start-and-end announcement.
- **Two equally weighted onward actions:** "Save offline" + "Change my recovery" (returns to S2 with current state preserved — important for "plans changed again at 4 a.m.").
- Persistent "Call Northstar" + "We'll text you 3 hours before boarding."

---

## 3. What Each Role Contributed

| Role | Most consequential contribution |
|---|---|
| **UX Researcher** | Named the user's emotional arc — *Orientation → Understanding → Agency → Closure* — that became the spine of the voice and the IA. Demoted "the user is the traveler" to an assumption to validate. Surfaced the offline-survivable artifact as a research-grounded design requirement. |
| **Information Architect** | Replaced tabs with stacked cards on S2; specified the conditional skip from credit/refund to S5; defined the commit boundary at S4 only; identified the entitlement-section as the trust-anchor and named the "honest empty state" requirement. |
| **Interaction Designer** | Built the full state matrix (default / loading / partial / empty / error / success / undo) with announcement + focus columns. Named every error recovery (no flights / inventory race / payment / network / session / double-submit / back-mid-flow). Defended two-step commit *as consequence surfacing*. |
| **Content Designer** | Rewrote every action label as consequence-bearing. Authored SMS, screen-by-screen, error, confirmation copy. Wrote the "we sound like / not like" rules. Held the line on never promising entitlements ("you may qualify — we'll check"). |
| **Accessibility Specialist** | WCAG-cited every blocker by criterion. Pushed tabs → segmented control with consequence labels. Specified the announcement model (`role="status"` polite for routine; `role="alert"` only for blockers). Wrote the assistive-tech narratives that made the failures feel real, not abstract. |
| **Visual / UI Designer** | Translated all of the above into a layout language — three zones, exaggerated hierarchy, semantic color for state only, "Best match" treatment as text + icon + reason, skeleton loaders not spinners, dark-mode tuned status colors, no celebratory motion. |
| **Behavioral Scientist** | Named "Travel credit" default as a dark pattern by mechanism. Reframed fare-difference vs. *original ticket*, not vs. $0. Vetoed manipulated urgency. Wrote the dark-patterns audit and the experiment plan with explicit guardrails for each test. Held the peak-end rule on confirmation. |

---

## 4. Cross-Agent Handoffs That Changed the Answer

The handoffs that moved a design decision (not just polish):

1. **accessibility-specialist → interaction-designer:** *Drop tabs, use a segmented control with consequence labels.* → Interaction-designer dropped the tab pattern entirely. Cascading effects: IA's S2 became stacked cards; content-designer wrote consequence labels into the cards; behavioral-scientist's "no hostile default" goal is achieved structurally instead of via copy.
2. **behavioral-scientist-2 → content-designer-2:** *Fare-difference framing vs. original ticket, not vs. $0.* → Content-designer rewrote the cost block. This change alone substantially reframes how a user perceives the cost of a "good for them, not free" choice during a disruption.
3. **accessibility-specialist → visual-designer:** *Never color-only on the "Recommended" badge; reduce-motion default; dark-mode tuned status colors.* → Visual-designer rebuilt the badge as text + icon + reason on a neutral chip; motion gated on `prefers-reduced-motion`; status tokens duplicated for dark mode.
4. **info-architect-2 → interaction-designer-2:** *Commit boundary is S4 only; everything before is reversible.* → Interaction-designer designed the back-out behavior, the state preservation, and the "Change my recovery" affordance on S5 around this single rule.
5. **ux-researcher-2 → info-architect-2:** *Persistent "Call a human" affordance, family/mobility as filter not branch.* → IA adopted both directly; the persistent escape is now structural, not decorative.
6. **accessibility-specialist → content-designer:** *Family/party-aware phrasing; "Recommended" must carry a reason in words; no idioms.* → Content-designer added party-scope sentences, inlined "Best match" reasons, removed idiomatic phrases.

If a single agent had drafted this on its own, it would likely have produced (a) a credible event-first SMS, (b) a confirmation screen with more facts, (c) a "Recommended" with a tooltip. It is materially less likely to have produced (a) the segmented-control pivot, (b) the fare-difference reframing, (c) the "honest empty state" rule for hotel entitlement, or (d) the back-out preserves state rule on S3. Those are the team's earnings.

---

## 5. Key Tradeoffs and Rejected Alternatives

| Choice we made | Alternative considered | Why we rejected it |
|---|---|---|
| **Stacked cards on S2, no pre-selection** | Keep tabs (current pattern) with "New flights" as default | Tabs hide consequences; *any* default sets up the next dark-pattern fight. Stacked cards force active choice with consequences visible. |
| **Two-step commit (S3 → S4 → confirm on S4)** | One-tap rebook from a flight card | One-tap commits are dangerous for a tired user at midnight; S4 is the regret-prevention layer. Pairs with 60s undo as the safety net. |
| **Persistent "Call Northstar" on every screen** | Hide phone number to push self-service; or contact page | Brief explicitly forbids hiding help; team-wide conviction that visible escape *increases* self-service. Risk: support-ops staffing. |
| **60-second undo window** | Hard commit + "Are you sure?" modal | Modals interrupt; undo respects the decision and provides a graceful out. Falls back to stronger Review screen if undo is infeasible. |
| **"Best match" with text + icon + reason** | Keep "Recommended" colored badge | Unexplained authority labels trip reactance; color-only is a WCAG 1.4.1 fail. The *reason* is the trust signal. |
| **Honest empty state on hotel/meal section** | Hide section when not eligible | Hiding is what created the original "Other policies" trust failure. The mid-stress user needs to know support was checked, not assume it wasn't. |
| **Fare-difference vs. *original ticket***, not vs. $0 | "$0" / "+$84" labels (current) | "$0" is an implicit zero anchor on a disruption the user didn't cause — pure loss-aversion framing that pushes users toward a worse-fit flight. |
| **SMS as Screen 0** (treated as a content surface) | Treat SMS as outside the product | Many users decide in the SMS preview; ignoring it cedes the most important screen. |
| **No celebratory motion on confirmation** | Confetti / motion celebration | Vestibular safety + distress context; static type / icon moment instead. |
| **No countdown timer on the choice screen** | "Hurry, this seat reserved for 4:59" | Manipulated urgency is a dark pattern; reassurance on Review is not. |
| **Pre-checked hotel only when entitled** | Auto-claim hotel for everyone | Auto-applying conditional entitlements and later reversing is worse than offering clearly. Use opt-in with prominence, not opt-out by surprise. |

---

## 6. Accessibility and Trust Guardrails

### Accessibility (non-negotiable)

1. **Every state change announces** (`role="status"` for routine, `role="alert"` only for blockers). WCAG 4.1.3.
2. **Action labels carry consequences.** No "Continue," "Done," "View details," "Other policies." 2.4.4 / 2.4.6 / 3.3.2.
3. **Plain language at ~grade 6–8** across SMS and screens. 3.1.5.
4. **44pt targets, ≥4.5:1 text contrast, ≥3:1 non-text contrast, ≥2px focus rings ≥3:1.** 1.4.3 / 1.4.11 / 2.5.5 / 2.4.7.
5. **Reflow at 320px and 200% zoom without 2-D scroll.** 1.4.10 / 1.4.4.
6. **Reduce-motion default;** any motion respects `prefers-reduced-motion`.
7. **Focus management on screen transitions** (move focus to new `<h1>`). 2.4.3.
8. **No keyboard traps; ESC closes modals; focus returns to trigger.** 2.1.2.
9. **Persistent "Call Northstar" in the same position across screens.** WCAG 3.2.6 (2.2).
10. **Offline backup at confirmation:** SMS + email + saveable artifact on S5.
11. **Undo as an announced state** (single start + end announcement, not per-second).
12. **No CAPTCHA / cognitive-test re-auth.** 3.3.8 (2.2).
13. **Sticky bottom CTA never obscures focused content.** 2.4.11 (2.2).
14. **Honest empty / not-entitled states** — hidden negative states are an accessibility *and* trust failure.

### Trust (non-negotiable)

1. **No defaults that work against the user's stated goal.** No travel-credit pre-selection; no pre-checked items that charge.
2. **No pseudo-urgency.** No countdowns on choices; no "Hurry, X seats left" framing.
3. **No unexplained badges or prices.** "Best match" must carry a one-line reason. "$X" must carry when it applies (and against what reference).
4. **No confirmshaming** on declines.
5. **No celebratory motion** on confirmation; static moment only.
6. **Honest uncertainty.** "You may qualify — we'll check" beats both "guaranteed" and silence.
7. **Reversibility (undo window) is required** for the "no default" + soft-commit pattern to be ethically defensible.
8. **Peak-end discipline:** the confirmation is a deliverable, not a thank-you. It is where trust gets rebuilt for the next trip.
9. **Fare-difference framed against the user's original ticket**, never against a zero anchor.

---

## 7. Experiment Plan

> Each experiment is hypothesis-driven with a primary metric, a guardrail, and an exit rule. No invented numbers. Sequencing reflects risk and operational dependencies.

| # | Hypothesis | Primary metric | Guardrail | Exit rule | Dependencies |
|---|---|---|---|---|---|
| **E1** | Replacing the **default tab "Travel credit"** with **no pre-selection on S2** increases self-service rebook completion without harming credit redemption. | Self-service rebook rate within 30 min of cancellation SMS | Support-call rate; wrong-flight rate; credit-redemption rate | Ship if primary rises with no guardrail regression; revert if calls or wrong-flight worsens. | None — lowest-risk first move. |
| **E2** | **"Best match" with reason** drives higher selection of the best-match flight *and* higher CSAT than "Recommended" without a reason. | Best-match selection rate | "I felt manipulated" survey item; post-trip CSAT | Ship if both metrics non-negative. | Requires content-designer's reason copy templates. |
| **E3** | **Visible hotel / meal entry** on S1+S2 increases eligible-user uptake without flooding ineligible attempts. | Eligible-user hotel-help submissions | Denied-request rate; support-call rate; "I tried but couldn't" survey item | Ship if eligible uptake rises and denial rate doesn't spike. | **Legal / policy review of "you may qualify" phrasing.** |
| **E4** | A **60-second undo window** on S5 reduces "rebook → call to change within 24h" *and* increases self-service confidence. | Rebook-to-support-call rate (24h) | Inventory thrash; user confusion ("did it stick?") | Ship if call rate falls and inventory cost is acceptable. | **Backend reversal feasibility** within 60s window. |
| **E5** | The **persistent "Call Northstar" affordance** reduces total support calls (trust → self-serve). | Support-call rate per cancellation event | Time-to-resolution; "I felt abandoned" survey item | Ship if calls fall; revert if call-line capacity is exceeded. | **Hard gate: support-ops staffing confirmation.** Do not run live until staffing matches expected load. |
| **E6** | A **two-step commit** (S3 select → S4 review → confirm) increases self-service rebook completion vs. one-tap commit. | Flight-card-tap → confirmed conversion | Total time-in-flow; rebook-error escalations | Ship if conversion rises without time/error regression. | None. |
| **E7** | A **fact-list confirmation** on S5 (vs. "Trip updated. Done.") reduces "did it go through?" follow-up calls. | Calls / chats within 24h asking "did it confirm?" | New-screen confusion; bounce rate from S5 | Ship if follow-up calls fall. | None. |

**Suggested sequencing:** E1 + E6 + E7 first (lowest dependency, highest leverage). E2 + E4 next (need design + engineering inputs). E3 + E5 last (need legal + ops sign-off).

**Important:** every experiment must instrument **per-screen** behavior, not just funnel completion, so we can attribute changes to specific design moves — not to the redesign as a whole. (Per ux-researcher.)

---

## 8. Scorecard-Ready Comparison vs. Single-Agent Baseline

Reference: `05-scorecard.md`. Reflective, not declarative — the team only "wins" where it earned its cost.

| Dimension | Single-agent baseline (expected) | Multi-agent team (this output) | Where the team earned its cost |
|---|---|---|---|
| **Breadth of coverage** | Wide; one voice covers most surfaces | Wide; specialist coverage on each surface | Roughly equal. Team does not win on breadth alone. |
| **Depth in specialist domains** | Plausible but generic ("ensure accessibility," "use clear language") | WCAG cited by criterion across the flow; behavioral principles named by mechanism; copy at the slot level with negative examples; state matrix with announcement + focus columns | **Team wins on depth.** Accessibility report cites ~20 specific criteria; behavioral-scientist names mechanisms (default effect, ambiguity aversion, loss aversion, reactance, anchoring, peak-end) rather than waving at "behavioral economics." |
| **Tradeoff resolution** | Often glossed; same author rarely disagrees with themself | Tensions named explicitly (persistent "Call Northstar" risk; undo feasibility; hold feasibility) | **Team wins on naming tradeoffs.** A single agent rarely surfaces the support-ops staffing dependency on a UI affordance. |
| **Cross-domain handoffs** | Implicit | Visible: 7+ peer messages saved as files; ≥6 design decisions changed by them | **Team wins on visible reasoning.** The accessibility → interaction-designer handoff moved "tabs → segmented control" wholesale, a single-author move would have polished the tabs instead. |
| **Dark-pattern detection** | Sometimes caught; often not named as such | Audit table of dark patterns with mitigations; "fare difference vs. original ticket" reframing | **Team wins.** Behavioral-scientist names the "Travel credit" default *as* a dark pattern by mechanism; a generic agent typically improves the default without naming the dynamic. |
| **Risk surface** | Lower variance; few "wild" recommendations | Higher coordination cost; some redundancy between role reports (event-first appears in 5 of 7) | **Team loses on cost / variance.** Redundancy is the price of independence. |
| **Specificity** | Often principle-level | Screen-by-screen copy; per-state announcement + focus; per-error recovery path; WCAG by criterion | **Team wins on specificity.** The IA's slot map fed directly into the content-designer's copy with minimal rework. |
| **Trust / behavioral guardrails** | Likely covered, rarely systematized | Dark-patterns table + behavioral-principles table + experiment plan with per-test guardrails | **Team wins.** The systematization is the deliverable. |
| **Meeting-ready output** | Already in one voice | Synthesis is the lead's job; quality depends on synthesis | Roughly equal *if* the lead does the synthesis well; risk on team is incoherence. |
| **Reproducibility** | Hard to attribute — one author, one chain of thought | Each role report is independently sourceable; peer messages document the handoffs | **Team wins on reproducibility.** A reviewer can follow the chain: who said what, what it changed, where it lives in the file system. |

**Honest assessment.** The team won decisively on (a) depth in specialist domains, (b) tradeoff resolution, (c) cross-domain handoffs that changed decisions, (d) systematized guardrails, and (e) reproducibility. The team did **not** win on breadth, output speed, or coordination cost. A facilitator scoring the demo should say *"Here is where the team earned its cost, and here is where it did not."*

The single design decision most likely missed by a single agent: **dropping tabs in favor of a segmented control with consequence labels** — that came from the accessibility-specialist's lived knowledge of WAI-ARIA tab pattern complexity intersecting with the IA's "no hostile default" stance, and was adopted whole by interaction-designer. The second most likely miss: **the "fare-difference vs. original ticket" reframing** — a loss-aversion move that only surfaces when someone is reasoning from named behavioral mechanisms.

---

## Open Dependencies (must resolve before ship)

1. **Inventory hold technical capability** — can a seat be held for ~5 min between S3 select and S4 confirm? If no, S4 collapses to a quick-confirm pattern with a "may sell out" caveat (interaction-designer's documented fallback).
2. **Undo window backend feasibility** — can a confirmed rebook be reversed within 60s without finance/ops side-effects? If no, replace undo with stronger pre-commit confirmation.
3. **Support-ops staffing** — does the call line have capacity for the predicted volume from a visible "Call Northstar" affordance? Hard gate on E5.
4. **Hotel / meal eligibility source-of-truth** — is the eligibility signal accurate at S1 time? Determines whether S1 can preview "Hotel help available," and whether S2's hotel card is conditional.
5. **Refund vs. travel-credit policy** — does Northstar offer cash refunds for crew-caused cancellations? S2's third card label depends on this. **Will not be invented; flagged for stakeholder confirmation.**
6. **Magic-link auth on SMS deep-link** — is passive re-auth acceptable to security? If not, sign-in becomes its own announced state.
7. **Outbound SMS / email reliability** — S5 promises both as a deliverable. Need ops confirmation of delivery SLA.
8. **Design-system primitives** — does Northstar's existing system define the focus rings, target sizes, reduce-motion handling at the levels listed? If not, accessibility blockers compound.

---

*Prepared by the Northstar UX Recovery Team. Role reports: `demo-output/role-reports/*.md`. Peer messages: `demo-output/peer-messages/*.md`. Lead-written first-draft reports preserved for comparison at `demo-output/role-reports-draft-lead-written/`.*
