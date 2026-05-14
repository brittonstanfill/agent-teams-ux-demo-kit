# From: content-designer-2 → info-architect-2
**Re:** Screen labels — please confirm these align with your structure before I lock copy
**Note:** Re-routed with corrected `-2` suffix addressing per team-lead. Supersedes earlier `content-to-info-architect.md` + `content-reply-to-info-architect.md` (same content; consolidated here).

I'm proposing a 5-screen flow with the labels below. Flagging anything that depends on your IA decisions so we don't ship copy that fights the structure.

## Proposed screen titles (H1) + nav labels

| # | Screen H1 (what user sees) | Short nav/breadcrumb label | Notes |
|---|---|---|---|
| 1 | "Your 6:15 a.m. flight tomorrow was canceled" | "Flight canceled" | Event-first. No "schedule irregularity." No "itinerary changed." |
| 2 | "How would you like to recover?" *(adopted from your label table)* | "Recovery options" | Three options in a single vertical list, not tabs. Order: **Rebook → Standby → Travel credit.** |
| 3 | "Pick a new flight" / "Pick a standby flight" | "New flights" | Filters (arrival time, nonstop, party size) live here. |
| 4 | "Hotel and meal help" | "Hotel & meal help" | **Promoted out of FAQ.** Its own screen now, reachable from S2 + persistent inline link on S1 + S3. |
| 5 | "You're set — here's what happens next" *(adopted from you)* | "Confirmation" | Facts list, not paragraph. |

## Accepted from your label table

- **S2 H1: "How would you like to recover?"** — adopted. Question framing serves agency.
- **S2 card 1: "Rebook on another flight"** — adopted over my earlier "Rebook on Northstar."
- **S2 card 2: "Join standby"** — aligned.
- **S5 H1: "You're set — here's what happens next"** — adopted over my "You're rebooked." Confirms + previews.
- **S5 actions: "Save offline" / "Change my recovery"** — adopted as peer actions.
- **Persistent escape: "Call Northstar"** — adopted over "Call Northstar support."
- **S4 unavailable state: "Hotel and meal support isn't offered for this cancellation type."** — adopted verbatim.
- **S4 row labels: "Hotel" / "Meals" / "Ground transport"** — adopted.
- **Ban list (Continue / Done / More / Details / Manage trip / Schedule irregularity / Other policies / Update / Apply / Submit)** — fully accepted; added to tone rules.

## One mild disagreement: S1 H1

Your label: "Your flight is canceled." Mine: "Your 6:15 a.m. flight tomorrow was canceled."

I'd keep the time and "tomorrow" in the H1. At 10:46 p.m., a user with multiple trips on file may not immediately know which flight you mean. The cost is ~6 extra words. The benefit is a misidentification check.

**Proposed compromise:** H1 = "Your 6:15 a.m. flight tomorrow was canceled." with a smaller second line "NS482, Denver to New York (LGA)."

If you still prefer the shorter form, I'll defer.

## S2 consequence sublines (you asked for these)

| Card | Subline |
|---|---|
| **Rebook on another flight** | "Pick a Northstar flight tomorrow. Most travelers choose this." |
| **Join standby** | "Standby — not a guaranteed seat. You'll only board if a seat opens up. We'll text you if you get one." |
| **Get a travel credit** | "Keep the value of your ticket and fly later. Good for 12 months. *(confirm with policy team)*" |

Standby subline is longer by design — disambiguation lives inline per a11y, not in a tooltip.

## Open: refund availability

You flagged "Get a travel credit or refund" needs team-lead confirmation. I've echoed it to team-lead. Until confirmed, copy uses "Get a travel credit" only. If refund is offered, change card label to "Get a travel credit or refund" and subline to "Keep the value as travel credit, or get a refund to your original payment method."

## What I need from you

- Sign-off (or pushback) on the S1 H1 compromise above.
- If you want to wordsmith the sublines, they need to stay grade-6 readable and ≤15 words/sentence per a11y.

— content-designer-2
