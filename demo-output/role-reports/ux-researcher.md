# UX Researcher Role Report — Northstar Air Canceled-Flight Recovery

**Author:** UX Researcher
**Scenario:** 10:46 p.m. cancellation SMS for a 6:15 a.m. flight; mobile-only, tired traveler; family event the next day.
**Confidence note:** This report is grounded in the brief plus established disruption-research patterns. Where I draw on prior literature rather than direct observation of *this* product, I mark it [inferred]. No metrics, quotes, or policies are invented.

---

## Top 3 Findings (Front-Loaded)

### Finding 1 — The user does not yet know what happened, what their choices are, or what it will cost them. The current flow asks them to act before it informs them.
- [observed from brief] SMS uses "Schedule irregularity"; Screen 1 says "Your itinerary has changed" with a vague "Continue" button; entitlements (hotel, meal) are buried in a collapsed FAQ.
- [inferred] Under high-stress, low-cognitive-bandwidth conditions (late night, tired, mobile-only), users default to the lowest-cost behavior that resolves uncertainty — calling a human. That is consistent with the abandonment-then-call pattern noted in the brief.
- **So what:** The flow's first job is *orientation*, not *action*. Information ordering is the highest-leverage change.
- **Confidence:** High that orientation is broken (multiple converging signals in the brief). Medium that fixing it reduces calls — needs validation.

### Finding 2 — The default option ("Travel credit") is misaligned with the dominant user goal (get to the family event tomorrow).
- [observed from brief] Tabs default to Travel credit; rebooking is one tab over; "Recommended" on the 7:10 a.m. card is unexplained.
- [inferred] In a same-day or next-day disruption with a known destination event, the modal user job is "preserve the trip," not "monetize the cancellation." Defaulting to credit invites the user to feel pushed toward the airline's preferred outcome — a trust hit at the worst possible moment.
- **So what:** Default tab should match the inferred dominant job (rebook), with credit and standby clearly available but not pre-selected. "Recommended" needs a one-line reason or it should be removed.
- **Confidence:** Medium. Needs lightweight validation that "get me there tomorrow" is in fact the dominant job for this disruption type.

### Finding 3 — The confirmation screen does not close the loop. Users leave without an offline-survivable artifact of what was decided.
- [observed from brief] Screen 5 says "Your changes have been applied" with no summary of new flight, hotel, baggage, arrival, check-in, or what to do if plans change again.
- [inferred] Travelers under stress re-check decisions repeatedly and need a screenshot-able / forwardable summary. Without one, they call support to "confirm it went through" — exactly the call the business is trying to avoid.
- **So what:** The confirmation must be a complete, self-contained recap including next steps and an "if something else changes" path. This is likely a meaningful share of the avoidable call volume.
- **Confidence:** High that the gap exists; medium on call-volume impact — testable.

---

## Primary and Secondary User Needs

### Primary needs (what the user must accomplish to succeed)
1. **Know what actually happened, in plain language.** [observed from brief: "Schedule irregularity" obscures the event]
2. **Understand what options exist and what each one means for them.** [observed]
3. **Choose a path with confidence that they didn't miss a better one.** [inferred]
4. **Get the support they're entitled to (hotel, meals) without having to ask or hunt.** [observed from brief: support is hidden in FAQ]
5. **Leave with a clear, durable confirmation of what comes next.** [observed]

### Secondary needs (conditions that determine whether the primary needs can be met)
6. **Trust that the airline is on their side, not steering them.** [inferred] Especially relevant given the default-to-credit pattern.
7. **Operate at low cognitive load.** [inferred] Tired, late at night, mobile-only.
8. **Be reachable to a human if self-service does not fit their situation.** [recommendation] A visible "talk to someone" path that is not the *only* path.
9. **Accommodate complicating factors:** traveling with family, mobility needs, screen reader, low bandwidth. [observed from brief constraints]
10. **Recover gracefully if the plan changes again.** [observed: no path on confirmation screen]

---

## Emotional State at Each Disruption Step

All labels below are **[inferred]** based on disruption-research patterns and the scenario as written. None are observed from this product's users directly — they are hypotheses to validate.

| Step | Likely emotional state | Driving factor |
|---|---|---|
| SMS arrives (10:46 p.m.) | Alarm → confusion | "Schedule irregularity" is jargon; no urgency cue or next step. User isn't sure if this is serious. |
| Tap link → Screen 1 (Trip Status) | Anxiety + frustration | Confirmed the trip is broken, but no options visible. The "Continue" button feels like a trap door. |
| Screen 2 (Recovery Options, default = Credit) | Suspicion / mistrust | Default feels like the airline is steering them. May trigger "let me just call." |
| Screen 3 (New Flights) | Decision overload + bargaining | "Recommended" without rationale, fare difference appearing during a *cancellation*, no filters for their actual constraints (arrival time, family). |
| Screen 4 (Support hidden in FAQ) | Resignation or anger | If they discover entitlements were hidden, trust collapses. If they don't, they pay out of pocket and resent it later. |
| Screen 5 (Confirmation) | Lingering uncertainty | "Done" without a recap means the user re-opens the app, re-checks email, or calls to confirm. |

**Implication for the team:** The emotional arc currently moves from confusion → suspicion → resignation. The redesign should move it toward: orientation → understanding → agency → closure.

---

## Open Research Questions to Validate

Ordered by decision-impact. Each includes the lightest method that could resolve it.

1. **What is the dominant user job in a same-day/next-day cancellation?** (Rebook? Credit? Talk to human?)
   - *Method:* Analyze existing support-call transcripts and chat logs for stated intent in the first 30 seconds. [recommendation] No new recruiting needed.
2. **Where exactly do users abandon the current flow, and what do they do next?**
   - *Method:* Funnel analysis + session replays of the last 30–60 days of disruption events. [recommendation]
3. **Does the "Travel credit" default cause users to perceive the airline as adversarial?**
   - *Method:* 5–8 moderated concept tests of two prototypes (default=rebook vs. default=credit), measuring trust and choice confidence. [recommendation]
4. **What information do users need on the confirmation screen to *not* call to "make sure it went through"?**
   - *Method:* Diary-style follow-up with recent disruption travelers: "When did you re-check, and what were you looking for?" [recommendation]
5. **For users traveling with family, with mobility needs, or using a screen reader — does the current flow fail differently than for the general population?**
   - *Method:* Targeted usability sessions with 3–5 participants in each segment. [recommendation] Coordinate with accessibility-specialist.
6. **Does framing entitlements as "what we owe you" vs. "options you can request" change uptake and call rates?**
   - *Method:* Copy A/B test, in partnership with content-designer and behavioral-scientist. [recommendation]

---

## Assumptions That Need Testing

I am labeling these explicitly so the team does not treat them as findings.

| # | Assumption | Risk if wrong | Lightest test |
|---|---|---|---|
| A1 | Most cancellation-recovery users want to rebook on the same airline. [assumption] | We default to rebook and frustrate users who want credit or refund. | Intent analysis on existing support call logs. |
| A2 | "Schedule irregularity" is read as jargon and reduces comprehension. [assumption — strong but unverified for *this* user base] | We rewrite the SMS for no gain. | 5-person comprehension test of current vs. plain-language SMS. |
| A3 | Hiding hotel/meal entitlements in FAQ causes users to miss them and increases out-of-pocket spend. [assumption] | We surface entitlements and increase cost without reducing calls. | Support-ticket review: how often do users call asking about hotel/meals? |
| A4 | A complete confirmation summary reduces "did it go through?" calls. [assumption] | We add screen complexity without reducing calls. | Pre/post measurement after rollout, or prototype test asking "what would you do next?" |
| A5 | The user is the traveler. [assumption] | Bookings made by family members, EAs, or corporate travel see different needs. | Check booking-source data; sample 10 disrupted bookings by booker type. |
| A6 | Mobile-first means SMS + app, not SMS + web. [assumption — not stated in brief] | We optimize for a channel mix users don't actually use. | Channel-usage data pull. |
| A7 | "Recommended" is read as airline-serving rather than user-serving. [assumption] | We over-explain a label users already trust. | Quick comprehension probe in concept test. |

---

## Recommendations to the Team (research-grounded, not design-grounded)

- [recommendation] **Re-sequence the flow around orientation first, action second.** Screen 1 should answer: what happened, what are my options at a glance, am I going to be OK. Then drill into specifics.
- [recommendation] **Default to rebook, but make credit and "talk to someone" equally visible.** Do not steer.
- [recommendation] **Surface entitlements (hotel, meal) inline at the moment they are relevant**, not in an FAQ. This is a trust move, not a copy move.
- [recommendation] **Treat the confirmation screen as a primary deliverable, not a courtesy page.** It is likely doing real work in reducing follow-up calls.
- [recommendation] **Instrument the redesign before launch** so we can attribute call-volume changes to specific screens, not the redesign as a whole.

---

## Confidence Summary

| Claim | Confidence | Why |
|---|---|---|
| The current flow fails at orientation | High | Multiple converging signals in brief |
| Default-to-credit is misaligned | Medium | Strong inference, not yet validated for this user base |
| Confirmation gap drives calls | Medium | Plausible mechanism; needs measurement |
| Specific emotional states by step | Low-to-medium | Inferred from disruption-research patterns; not observed in this product |
| Specific copy/IA fixes will reduce calls X% | Not claimed | Would be a bluff without instrumentation |

---

*Pushback note for the team:* If anyone proposes a fix and says "users want X," ask them which observed behavior supports it. Users under stress report what they wish were true. Behavior in the funnel is the source of truth, and we should be looking at it before we ship.
