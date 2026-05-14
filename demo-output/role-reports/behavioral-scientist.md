# Behavioral Scientist — Trust & Dark-Pattern Audit

## 1. Audit summary

**TRUST FLOOR: pass.** The prototype consistently surfaces entitlements as status ("Already held for you"), keeps a support link visible on every screen, and preserves reversibility through Screen 3. No dark-pattern blockers found. Zero blockers, four risks worth instrumentation.

## 2. Blockers

Zero blockers. Defense: the canonical dark patterns the brief warns about (hidden entitlements, manipulated urgency, confirmshaming, forced continuity, drip pricing, Done dead-end, opaque "Recommended", fare-delta-during-disruption) are each affirmatively absent. Refund/credit is a co-equal stacked button, not a tab. Hotel and meal are surfaced on Screen 1 *and* itemized on Screen 3 *and* on the receipt. Screen 2 copy "Choosing a flight does not finalize it. You confirm on the next screen." actively reduces commitment anxiety (combats hyperbolic-discount-driven abandonment). No urgency timers. No upsell. Standby row is verbally flagged "Standby — not a confirmed seat" and visually differentiated.

## 3. Risks (watch-for)

- **Default-bias on Screen 3 support items** (Accept pre-pressed × 3). User in System-1 mode taps "Confirm rebooking and support" without inspecting individual rows; later disputes "I never asked for the shuttle." A/B: log per-item interaction rate before confirm; if <10% of confirmers ever touch a row, the default is doing the deciding.
- **Standby row in the same `<ul>` as confirmed flights** (Screen 2). Mechanism: visual grouping → category inference. Tired user pattern-matches "fourth option" and taps without parsing the warm-tone "Standby" flag. A/B: tap-through rate on row 4 vs. confirmed rows; intent-confirmation prompt on tap should show >25% back-outs if confusion is real.
- **"Find me another flight" as filled primary** vs. "I'm not traveling — refund or credit" as outline (Screen 1). Salience + default-bias asymmetry. Not coercive — see §4 — but measurable nudge toward rebook. A/B: refund-fork selection rate vs. a coin-flipped variant with neutral weights.
- **Sycophancy/over-reassurance creep.** "Nothing is final until you confirm" appears three times; "Nothing is charged" once. Reassurance is welcome, but if users *stop reading* it, the protection it provides erodes. A/B: dwell time on confirm screen and decline-rate on at least one support item.
- **`tel:` link labeled "Talk to a person — [support line]"** — good. But it's a tertiary support-link, below the primary CTA every screen. Mechanism: salience. Watch call-rate vs. self-serve completion to confirm support cost did not silently rise.
- **No surfaced "I need a different kind of help" path** (caregiver, mobility, missed connection downstream). Mechanism: choice-set framing. Not a blocker — the `tel:` link covers it — but if test sessions reveal a third user goal, the fork on Screen 1 may be undersized.

## 4. Position on contested items

**Accept-pressed defaults on Screen 3 — SHIP AS-IS.** These are legitimate entitlements the airline owes the traveler; status-quo bias is doing pro-user work. Copy reads "Decline anything you don't want. Nothing is charged." — accurate, non-confirmshaming, and reversible ("You can change support choices until departure"). A neutral unselected default would *raise* effort to claim entitlements the user already has, which is the exact sludge the brief tells us to remove. The Visual Designer's self-flag is a valid SDT/autonomy concern; mitigate via instrumentation (Risk #1), not by switching the default.

**Standby row in flight list — CHANGE AS FOLLOWS.** Label is sufficient verbally but the row sits in the same chronological `<ul>` with identical structural affordances. Seat-confidence confusion is plausible under stress. Lowest-cost fix: move the standby row to its own subsection with header "Standby option (not a confirmed seat)" — same screen, no new screen, preserves completeness without category-confusion.

**Refund-fork weight — SHIP AS-IS.** The filled button is the path the user *probably* wants (they're traveling to a family event tomorrow) and the outlined button is structurally identical: same size, same position in stack, same sub-copy pattern, same reversibility promise. This is honest anchoring on a base-rate, not nudging-against-stated-goal. If Risk #3 surfaces a real selection asymmetry beyond base-rate, revisit.

## 5. Falsification

Two measurable predictions; if either is violated, the trust-positive claim fails:

1. **Self-reported confidence at receipt.** In moderated test (n≥12), <75% of participants say "yes" to "do you know what happens next?" → the receipt is theater, not orientation.
2. **Post-confirm support-item disputes / reversals.** If >15% of users who confirmed on Screen 3 later toggle a support item or call to dispute one within 24h → the Accept-defaults are coercive, not pro-user; switch to unpressed.

## 6. Handoff

- **HTML change:** Standby row moves to its own `<section>` with explicit subheader on Screen 2 (Risk #2 / contested item).
- **Copy / hierarchy change:** None required. Hold "Nothing is final until you confirm" and "Nothing is charged" — they are doing load-bearing reassurance work.
- **Instrumentation:** Log (a) per-support-item tap-rate before Screen 3 confirm; (b) Screen 1 fork selection ratio; (c) standby-row tap-then-back rate; (d) 24h post-confirm support-item reversal rate; (e) self-serve completion vs. `tel:` tap rate.
