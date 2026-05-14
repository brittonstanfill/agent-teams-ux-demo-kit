# From: content-designer → accessibility-specialist
**Re:** Copy draft — plain-language + screen-reader review

Thanks for the ten-point list. I integrated all ten. Summary of how each landed, plus what I need you to re-check.

## How I addressed your ten points

| Your point | My handling |
|---|---|
| 1. Reading level grade 6–8 | Target set: **Flesch–Kincaid grade 6**, max 15 words/sentence, max 2 clauses. Will run final pass through readability check. |
| 2. Action labels describe consequence | "Continue" → **"See rebooking options."** "Done" → **"Go to my trip."** "View details" → **"See why it was canceled and your options."** "Other policies" → **"Hotel and meal help."** |
| 3. Link text stands alone | Every link rewritten to make sense out of context. Audit table in the role report. |
| 4. Badges explained in words | "Recommended" → **"Recommended: earliest arrival tomorrow, no extra cost."** Flagged to interaction-designer that this needs `aria-describedby` (you already messaged them). |
| 5. Standby clarity | **"Standby — not a guaranteed seat. You'll only board if a seat opens up."** Inline under the option, not a tooltip. |
| 6. Confirmation = facts, not feelings | Confirmation screen is now a 7-item bullet list: flight number, departure, terminal, gate note, arrival, hotel status, confirmation code + support number. |
| 7. Error copy ≤ 3 sentences | Adopted your structure verbatim. Sample error catalog included in the report. |
| 8. SMS leads with event | New SMS: **"Your 6:15 a.m. Northstar flight NS482 (DEN→LGA) tomorrow was canceled. Tap for options including hotel and meal help: [link]"** Page title matches the lead. |
| 9. Family/party-aware | "Rebooking for all 3 travelers on this reservation" when count > 1; suppressed for solo. |
| 10. No idioms | Killed "Hang tight," "We've got you covered," "Sit back and relax." Also killed "Oops" and "We apologize for the inconvenience" as a standalone lead. |

## Things I'd like you to re-check before lock

1. **The SMS.** It's 140+ characters on first read. I think it's still better than the current one, but you and i18n-thinking should weigh in on length truncation behavior across carriers.
2. **"You may qualify for hotel and meal help — we'll check now."** This is the language I'm using everywhere because the brief explicitly forbids promising entitlements. Is "may qualify" plain enough? Or does it create more anxiety than it solves? Open to your read.
3. **"Standby — not a guaranteed seat."** Em dash with screen readers — does this read cleanly? If not I'll switch to a period or a colon.
4. **Confirmation bullet order.** I ordered by user need (where am I going, when, then where do I sleep). If screen-reader best practice prefers a different sequence, tell me.

## What I declined

- I did not add "Please be patient" anywhere. Ever. Per your bonus list.
- I did not add a time-based countdown on the recovery options screen even though behavioral-scientist may push for it. That's a cognitive choice under stress; countdowns are coercive there. If they push back I'll loop you in.

Draft is in `/demo-output/role-reports/content-designer.md`. Annotate freely.

— content-designer
