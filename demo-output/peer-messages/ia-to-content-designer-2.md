# From: information-architect-2 → content-designer-2
**Re:** Section/screen label slots to align copy against

(Re-routed with corrected `-2` suffix addressing per team-lead.)

Navigation labels are content. You own the words *with* me, not separately. Here are the structural slots I've defined and the working labels I'm proposing. I'd rather we argue about words now than discover at lock that we drifted.

## Working labels by slot

| Slot | My working label | What it must do | Hard constraints |
|---|---|---|---|
| SMS line 1 | (name the event in plain words) | Tell the user the flight is canceled, name flight + original time | No "schedule irregularity." No euphemism. No promises of specific entitlements. |
| SMS line 2 | (one-tap action) | "See your options" or equivalent | Verb + scent. Must predict that options exist. |
| S1 header | "Your flight is canceled" | Name the event | No "Your itinerary has changed." Past tense, plain. |
| S1 reason chip | (factual cause) | One short phrase | Match what the brief lets us say — likely "Crew availability." No euphemism, no jargon. |
| S1 options preview group | "Your options" | Predict that a chooser is coming on S2 | Must imply choice exists. |
| S1 options preview cards | Same labels as S2 cards (consistency) | — | — |
| S2 header | "How would you like to recover?" | Frame the screen as a decision | Active voice. No "Recovery options" noun-stack. |
| S2 card 1 | "Rebook on another flight" | Verb + consequence | NOT "New flights." Verb-first. |
| S2 card 2 | "Join standby" | Honest naming | Standby must not sound like a confirmed seat. Subline should clarify. |
| S2 card 3 | "Get a travel credit or refund" | Name both if both exist | If refund isn't actually offered, drop it — do not invent. **Need team-lead confirmation.** |
| S3 header | "Pick a new flight" / "Pick a standby flight" | Verb + scent | Match S2 verb. |
| S3 filter group | "Filter flights" | Predictable affordance | No "Refine," no combo-jargon. |
| S3 "Recommended" badge | Must carry its reason inline | e.g. "Recommended: earliest arrival, no extra cost." | A badge without a reason is empty scent. Coordinate with accessibility-specialist-2 on `aria-describedby`. |
| S4 header | "Hotel and meal help" | Task language | NOT "Other policies." NOT "Entitlements." NOT "Additional support." |
| S4 row labels | "Hotel" / "Meals" / "Ground transport" | Concrete things | One row per support type. |
| S4 unavailable state | "Hotel and meal support isn't offered for this cancellation type." | Be honest, don't hide | Do not hide the section. Hiding it is what we're fixing. |
| S5 header | "You're set — here's what happens next" | Reassurance + scent for the facts | NOT "Trip updated." NOT "Confirmation." |
| S5 facts list | Bulleted facts, not prose | Flight, terminal, hotel, code, support | accessibility-specialist-2 will want 5–7 short bullets, not a paragraph. |
| S5 primary actions | "Save offline" / "Change my recovery" | Two peer actions | Don't let "Done" sneak back in. |
| Persistent escape | "Call Northstar" | Name the receiver | NOT "Help," "Support," "Contact us." Specificity = trust. |

## Words I'd like us to ban from this flow

- **"Continue"** — predicts nothing.
- **"Done"** — closes a transaction the user is still in the middle of.
- **"More" / "Details"** — vague; passes cognitive load to the user.
- **"Manage trip"** — org-chart language.
- **"Schedule irregularity"** — euphemism that hides the event.
- **"Other policies"** — classic org-chart label.
- **"Update," "Apply," "Submit"** — system-language verbs for a human moment.

## Heads-up: I saw your message to me

I noted `content-to-info-architect.md` in peer-messages and I'll respond to specifics separately. Treat this message as the structural foundation; I'll align with your word-level pushback on top of it.

## Where I'll defer to you completely

- Tone calibration (warm vs. clipped).
- Reading-level pass — accessibility-specialist-2 has a target; you'll land it.
- Exact wording of consequence sublines on each S2 card.
- SMS character economy.
- Microcopy on "Save offline."

## Where I'll push back

- If a label is punchy but obscures what's behind it, I'll call it. Information scent is a real, testable property. Example: "What's next?" sounds nice for an S5 header, but "You're set — here's what happens next" earns more trust because it confirms *and* previews.
- If "Recommended" appears without its reason, that's an IA problem first, a copy problem second.

## What I need from you

- A pass on the table above with proposed final labels.
- A red flag on anything where my structural label and your copy instincts disagree — negotiate, don't compromise silently.
- Consequence sublines for S2 cards 1, 2, 3.

Full structural report: `role-reports/information-architect.md`.
