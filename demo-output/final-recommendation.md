# Northstar Trip Recovery — Recommendation

## 1. Executive recommendation

Ship a five-screen mobile-first recovery flow that names the cancellation in plain language, presents three peer-weighted recovery paths with no pre-selection, surfaces hotel and meal support as a peer block at the review screen (not in an FAQ), and confirms only what the user actually committed to. Run a four-week A/B against the current flow on irregular-ops events. Promote only if support-call volume drops **and** support uptake among eligible users holds or rises **and** the 24-hour follow-up call rate does not rise.

The redesign's load-bearing move is structural: hotel/meal support is lifted out of an "Other policies" FAQ and surfaced *before* commitment. That single change is the most defensible answer to the brief's central failure mode — users currently pay out of pocket and call support after the fact.

## 2. Redesigned flow

Five screens, mobile-first. Each names its consequence; none uses "Continue" or "Done."

- **S1 — What happened.** Plain-language status: "Your 6:15 a.m. flight {NS482} {DEN–LGA} is canceled." Reason and "tonight" support teaser, each gated on system-supplied data. Primary: "See my options." Persistent: "Get help from an agent."
- **S2 — Choose how you'll get there.** Three full-width cards — Rebook, Travel credit, Standby — with no pre-selection. Each card names its give-up plainly (credit names "you will not be rebooked"; standby names "not a confirmed seat"). A clearly-affordanced "See tonight's support" link sits below the cards so the user can check support *before* committing.
- **S3 — Pick a flight** (rebook path only). Filter chips, transparent default sort ("Sorted by earliest arrival. Change sort."), full-width flight cards. Badges name their reason ("Earliest arrival," "Nonstop," "No extra cost," "Fare difference applies"). No bare "Recommended."
- **S4 — Review, support, and confirm.** Three peer blocks: new plan, "Tonight's support" (hotel/meal as in-line items with "Added/Not added" pills, eligibility resolved by the system), and "What changes" (baggage, check-in, gate). Primary button dynamically names the commitment — "Confirm new flight," "…and hotel," "…and hotel + meal."
- **S5 — Your updated trip.** Outcome headline names the outcome ("You're rebooked"). Support summary is conditional on what was added on S4; nothing is asserted as confirmed by default. "Save to phone" offline backup, a labeled "My plans changed" re-entry path, persistent agent.

The SMS that opens the flow names the cancellation, the not-yet-rebooked state, and a low-bandwidth "Reply HELP" fallback.

## 3. Accessibility and trust guardrails

**Accessibility.** WCAG 2.1 AA conformance; WCAG 2.2 SC 2.5.8 target-size honored at 44px minimum on every action including secondary toggles. Source order matches reading order on every screen. Group landmark + heading replaces the common-but-broken `role="list"` on `<button>` pattern. Each flight card carries a sentence-form `aria-label`. Skip-to-main link, single `<main>`, consistent agent affordance label, focus-visible across all interactive surfaces, `prefers-reduced-motion` honored, no color-only state. Contrast is AA everywhere, AAA on load-bearing copy.

**Trust.** No invented operational facts. Every dynamic field is wrapped as `{system-supplied}` (voucher amounts, eligibility, expiration, hotel partner, gates, references). The default sort and option order are nudges that align with the stated user job; both are visibly opt-outable. The agent path is reachable on every screen but never primary. S5 cannot assert hotel/meal confirmation the user did not actually request and the system did not actually grant.

## 4. Experiment plan

**Hypothesis.** The redesign reduces support calls without hiding help.

**Method.** A/B the new flow against the current flow on irregular-ops events for four weeks.

**Primary falsifier (from red-team).** **24-hour follow-up call rate among self-service completers**, segmented by call topic. If call volume drops *and* follow-up calls rise *and* topics are dominated by "I didn't know I could ask for X," the redesign hid help by salience and must roll back.

**Guardrails.**

- Support uptake among system-eligible users: must hold or rise.
- Agent-handoff clicks on S4 specifically: a spike signals commit-confidence failure upstream.
- Time-to-commit distribution: a very-short left tail correlated with 24h follow-up calls indicates satisficing under fatigue.
- Post-flow trust survey ("Did this feel honest and clear?"): must hold or rise.

**Exit rule.** Roll back if the primary falsifier trips or if the trust survey drops materially while objective signals improve.

**Scoped gaps (from red-team) the experiment will not resolve.** Cash-refund path (no policy named — handled today by agent handoff); unaccompanied-minor and multi-leg-international flows (off this five-screen surface); non-English copy (English-only prototype); session resumability on connection loss (system concern). Each is a follow-up, not a blocker for the controlled A/B.
