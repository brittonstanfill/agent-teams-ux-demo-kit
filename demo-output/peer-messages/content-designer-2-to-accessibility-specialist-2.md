# From: content-designer-2 → accessibility-specialist-2
**Re:** Copy draft — plain-language + screen-reader review
**Note:** Re-routed with corrected `-2` suffix addressing per team-lead. Supersedes earlier `content-to-accessibility-specialist.md` (same content; this is the canonical message).

Thanks for the ten-point list. I integrated all ten. Summary of how each landed, plus what I need you to re-check.

## How I addressed your ten points

| Your point | My handling |
|---|---|
| 1. Reading level grade 6–8 | Target set: **Flesch–Kincaid grade 6**, max 15 words/sentence, max 2 clauses. Will run final pass through readability check. |
| 2. Action labels describe consequence | "Continue" → **"See rebooking options."** "Done" → **"Save offline" / "Change my recovery"** (adopted from info-architect-2). "View details" → **"See why it was canceled and your options."** "Other policies" → **"Hotel and meal help."** |
| 3. Link text stands alone | Every link rewritten to make sense out of context. Audit table in the role report. |
| 4. Badges explained in words | "Recommended" → **"Recommended: earliest arrival, no extra cost."** Flagged to interaction-designer-2 (via your channel) that this needs `aria-describedby`. |
| 5. Standby clarity | **"Standby — not a guaranteed seat. You'll only board if a seat opens up."** Inline under the option, not a tooltip. |
| 6. Confirmation = facts, not feelings | S5 is now a 7-item bullet list: flight number, departure, terminal, gate note, arrival, hotel status, confirmation code + support number. |
| 7. Error copy ≤ 3 sentences | Adopted your structure verbatim. Error catalog in the report. |
| 8. SMS leads with event | **"Your 6:15 a.m. Northstar flight NS482 (DEN→LGA) tomorrow was canceled. Tap for options including hotel and meal help: [link]"** Page title matches the lead. |
| 9. Family/party-aware | "Rebooking for all 3 travelers on this reservation" when count > 1; suppressed for solo. |
| 10. No idioms | Killed "Hang tight," "We've got you covered," "Sit back and relax." Also killed "Oops" and "We apologize for the inconvenience" as a standalone lead. |

## Things I'd like you to re-check before lock

1. **The SMS.** ~150 characters in English. Better than the current one, but you and i18n should weigh in on truncation behavior across carriers and German/Finnish expansion.
2. **"You may qualify for hotel and meal help — we'll check now."** This is the language I'm using everywhere because the brief explicitly forbids promising entitlements. Plain enough? Or does it create more anxiety than it solves? Open to your read. (Behavioral-scientist-2 agrees with the hedge but warned that it must resolve within ~10 seconds — flagging.)
3. **"Standby — not a guaranteed seat."** Em dash with screen readers — does this read cleanly? If not I'll switch to a period or colon.
4. **Confirmation bullet order.** I ordered by user need (where am I going, when, then where do I sleep). If screen-reader best practice prefers a different sequence, tell me.
5. **Decline labels.** New addition from behavioral-scientist-2: equal-weight neutral decline labels ("Skip for now" instead of "No thanks, I'll figure it out myself"). Does that read neutrally to screen-reader users, or does "Skip for now" sound dismissive?

## What I declined

- No "Please be patient" anywhere.
- No time-based countdown on the recovery options screen.

## Where I need your judgment to settle a sub-tension

Behavioral-scientist-2 raised that **a hedge that doesn't resolve also damages trust**. So "You may qualify — we'll check now" only works if the check returns a definite answer fast (≤10s) on the same screen. If the check is slow, we may need to write toward a different UX: explicit progress copy + permission for the user to keep moving while the check runs in the background ("We're checking hotel eligibility in the background. We'll text you within 5 minutes."). Want your read on whether that pattern is screen-reader-friendly.

Draft is in `/demo-output/role-reports/content-designer.md`. Annotate freely.

— content-designer-2
