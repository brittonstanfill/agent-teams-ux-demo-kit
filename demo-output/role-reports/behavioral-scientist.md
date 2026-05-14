# Behavioral Scientist Report: Canceled-Flight Recovery

## Top finding

Screen 2 visually presents three "peer" paths but treats only one as real: Rebook carries a blue-tinted card, a "Recommended for getting there" badge, AND captures the screen's lone primary CTA ("Find a flight") — which means a tired traveler who actually wants a refund has to notice the mismatch between the bottom card and the bottom button to escape the rebook funnel. That is asymmetric friction on the refund path, and it is the single behavioral risk that converts an otherwise honest flow into a soft dark pattern.

## Blockers (must change HTML or copy)

1. **Screen 2 — the primary CTA does not match the user's selection.** The page renders three path cards as peers, then commits a single `btn-primary` labeled "Find a flight" at the bottom (line 821). A user who reads the cards left-to-right, taps "Request a refund," and then taps the prominent blue button at the bottom will land on rebook. This is a roach-motel pattern dressed as a default.
   - **Smallest fix:** remove the standalone bottom CTA entirely; each path card *is* the CTA. The cards are already `<button>` elements (lines 797, 805, 812). Drop the `<div class="actions">` block on Screen 2 so there is no path-agnostic primary button at all. Keep "Back to status" as a quiet link.

2. **Screen 2 — the "Recommended for getting there" badge on Rebook is unjustified anchoring.** Rebook is recommended for *getting to the destination*, but the brief's user has not yet stated their goal. A user whose actual best option is a refund (e.g., they can drive, or the trip no longer makes sense) is steered against their stated goal by a badge that imports an assumption.
   - **Smallest fix:** replace the badge text with a neutral descriptor that is true for everyone: drop the badge entirely, and let the card description carry the framing ("Pick a replacement flight. Earliest arrival first."). If a badge is kept, make it descriptive, not evaluative — e.g., "Fastest path to destination" stated as a fact, not "Recommended."

3. **Screen 3 — the "Morning" filter chip is pre-checked (line 875).** This is a silent default that re-sorts the user's options before they have stated a preference. For the briefed user (6:15 a.m. flight gone, family event tomorrow), morning may be right — but the system does not know that, and a pre-applied filter that hides afternoon flights from a stressed user is a hidden-option pattern.
   - **Smallest fix:** remove `checked` from the Morning chip. Sort default ("earliest arrival") is fine and matches the inferred user job; filtering is a stronger move and must be user-initiated.

4. **Screen 4 — "Continue without support" is a confirmshame-adjacent choice.** Pairing "Request hotel & meal support" (primary blue) with "Continue without support" (secondary) as the only two outcomes implies the user is opting *out* of help. For an eligible traveler, that wording could shame them into thinking they declined when in fact eligibility was never confirmed.
   - **Smallest fix:** relabel the secondary to describe the *state*, not a refusal: "I'll handle tonight myself" or "Skip — I have a place to stay." Keep the primary as-is.

5. **Screen 5 — the primary CTA reads "Done — save a copy" (line 1105) but tapping "Done" implies trip closure.** A traveler whose plans may change again (the brief explicitly contemplates this) needs the CTA to signal that the record stays live. "Done" is a behavioral full-stop.
   - **Smallest fix:** relabel to "Save my record" or "Save and keep this live." This is one word of HTML; the offline-record affordances above it already do the work.

## Important (should change, lead may waive)

1. **Screen 2 — `is-default` styling on the Rebook card (line 797) plus the "Recommended" badge plus card-order-first is three reinforcing nudges toward the same option.** One is anchoring; three is a thumb on the scale. Recommend keeping order + light visual emphasis and dropping the badge (covered in Blocker 2).
2. **Screen 1 — the status banner copy "You don't need to do anything to keep your spot" (line 730) is reassuring but slightly misleading: there is no "spot" anymore.** Suggest: "You don't need to do anything yet — we'll walk you through your options." Preserves the reassurance, drops the inaccuracy.
3. **Screen 4 — the "Talk to someone about tonight" tertiary link is good, but it sits below "Continue without support."** A stressed user who is unsure about eligibility should see "talk to someone" *before* the opt-out, not after it.
4. **Screen 3 — flight cards beyond the first use `btn-secondary` for "Hold this flight" (lines 935, 957).** This visually scores the earliest-arrival flight as the "right" choice. Defensible (it matches the sort), but combined with the sort label, it double-anchors. Recommend equalizing button weight and letting sort do the work.

## Falsification metrics

These metrics distinguish "reduced calls because the flow worked" from "reduced calls because help was hidden":

1. **Refund-path completion rate among users who tapped "Request a refund" on Screen 2.** If <70% of refund-tappers complete a refund (vs. defect to rebook or call), asymmetric friction is real. Target: parity with rebook completion rate ±10 points.
2. **Call rate among users who saw Screen 4 with `{hotel_status}` = "not eligible" within 30 minutes of viewing.** If this rate is *higher* than the pre-redesign Screen-4 call rate, the conditional language is failing — users feel brushed off, not informed. If it is dramatically *lower*, audit qualitatively: are they giving up rather than calling?
3. **Ratio of "Continue without support" taps to confirmed-eligible users.** If eligible users are clicking the opt-out, the framing is suppressing claims — a hidden-entitlement pattern even though the screen exists.
4. **Share of Screen-5 viewers who tap any of {Save as PDF, Send to email, Add to wallet} within 60 seconds, AND share who return to the flow within 24 hours.** First number tests whether the offline record reassures; second tests whether "Done" stranded them (Blocker 5).

Invalidator: if call volume drops but refund-path completion drops faster than rebook completion, the flow is succeeding at the wrong goal.

## Preserved dissent prompt

Red-team the **"Recommended for getting there" badge on Rebook (Screen 2)**. I have called it a blocker; the lead may judge it as an honest signpost for the dominant user job. I want this contested explicitly: is it anchoring against a refund-seeker's stated goal, or is it disambiguating a confusing peer set for the 80% case? A 2-cell test (badge vs. no badge) on refund-path conversion among self-identified refund-intent users would resolve it.
