# From: content-designer → team-lead
**Re:** Task #12 complete — 3 findings + 1 tension + peers messaged

## Status

- Task #12 → **completed**
- Deliverable: `/demo-output/role-reports/content-designer.md`
- Status note: `peer-messages/content-task-status.md` (SendMessage/TaskUpdate not in my real toolset — files used as substitute, following a11y's precedent)

## Top 3 findings

1. **Lead every surface with the event in plain words.** The current copy hides "canceled" behind "schedule irregularity," "itinerary changed," and "changes have been applied." Fixing the SMS, page title, H1, and confirmation H1 is the highest-leverage change in the flow and likely moves call volume on its own.

2. **Every CTA must name what tapping does.** "Continue," "Done," "View details," "Other policies" are abandonment magnets under stress. Rewrites: "See rebooking options," "Go to my trip," "See why it was canceled and your options," "Hotel and meal help." This is also a WCAG 2.4.6 / 3.3.2 requirement.

3. **Hotel/meal help must come out of the FAQ — but the words have to be honest.** Surfacing it is an IA fix; framing it is a content fix. Language: **"You may qualify for hotel and meal help — we'll check now."** This trades a fake promise for a real path. Critically, this respects the brief's prohibition on inventing entitlements.

## One tension (revised)

**Original prediction:** I expected behavioral-scientist to push for warmer/more confident hotel/meal framing and create a tension with hedged-honest.

**Actual:** behavioral-scientist's handoff arrived aligned with hedged-honest — they pushed *against* manipulated urgency, *against* unexplained authority labels, *against* confirmshaming on decline. They also flagged a real risk I'd undercounted: **a hedge that doesn't resolve also damages trust.**

**Updated tension:** not warmth vs. honesty, but **"how do we make the hedge resolve fast enough to count as honesty rather than evasion?"** Concretely: "You may qualify — we'll check now" only works if the check returns a definite answer within ~10 seconds on the same screen. If the eligibility check is slow or unreliable, the hedged language reads as a corporate dodge. **This becomes a behavioral + content + engineering question** — is the eligibility check fast and reliable enough to be the trust mechanism? If not, we need different copy and a different UX. Flagging for you to surface to eng / ops.

## Peers messaged

- **information-architect** (`content-to-info-architect.md`) — confirming screen labels, four naming sign-offs (Standby, Travel credit, Hotel & meal help, CTA conventions), and one structural ask: treat hotel/meal as a co-equal recovery surface, not a sub-policy.
- **accessibility-specialist** (`content-to-accessibility-specialist.md`) — copy draft summary with their 10 blockers each accounted for, plus 4 items I want them to re-check before lock (SMS length, "may qualify" phrasing, em-dash with screen readers, confirmation bullet order).

## Inbound integrated

- **accessibility-specialist's 10-point list — all 10 integrated.** Reading level target set (FK grade 6, max 8). Action labels rewritten. Standby disambiguation. Confirmation rebuilt as facts list. Error pattern adopted. SMS leads with event. Family-aware phrasing. Idioms killed.
- **information-architect's label slots table — accepted with one mild pushback.** Adopted active-voice S2 H1, "Rebook on another flight," S5 H1 "You're set — here's what happens next," "Save offline" / "Change my recovery" peer actions, "Call Northstar" persistent escape. Mild disagreement on S1 H1 — keeping the time/"tomorrow" for misidentification protection. Delivered S2 consequence sublines. Reply: `content-reply-to-info-architect.md`.
- **ux-researcher's emotional arc + voice asks — adopted.** Added orientation → understanding → agency → closure spine. Added consequence sublines to every option. Accepted their offer to pull support-call transcripts for round two. Reply: `content-reply-to-ux-researcher.md`.
- **behavioral-scientist's 7 framing risks — all 7 adopted.** Reframed fare-difference to anchor against original ticket (not $0). Suppressed prominent "$0" chip. Added neutral equal-weight decline labels ("Skip for now"). Delivered phrase library for hedged eligibility. Reply: `content-reply-to-behavioral.md`.

## Open team-lead questions

1. **Is a refund offered alongside travel credit?** IA flagged; I echoed. Until confirmed, copy uses "Get a travel credit."
2. **Hotel/meal coverage wording.** Need policy/legal to confirm we can use "You may qualify — we'll check." Or give me the operative phrase.
3. **Travel credit duration ("12 months")** — policy team confirmation.
4. **Eligibility check latency.** New question raised by the revised tension above: is the hotel/meal eligibility check fast and reliable enough (≤10s, same screen) for the hedged-honest copy to land? If not, the copy needs to change. Eng/ops surface.

## Awaiting

- All teammate inbounds received and integrated this round. Ready for round two.

Ready for the next round.

— content-designer
