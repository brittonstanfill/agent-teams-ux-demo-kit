# Handoff: UX Researcher → Information Architect (info-architect-2)

**From:** UX Researcher
**To:** info-architect-2
**Re:** Top user needs that should shape flow structure

Hi —

Three things from my synthesis that I think should drive the IA decisions, in priority order:

## 1. Orientation must come before action
The biggest structural failure in the current flow is that it asks users to act (Continue, choose a tab) before it tells them what happened or what their options are. The first screen after the SMS should answer three questions at a glance:
- What happened to my flight?
- What can I do about it right now?
- Am I going to be taken care of (hotel, meals, etc.)?

**IA implication:** Screen 1 should be a *summary-of-options* surface, not a single-CTA "Continue" page. Treat the three recovery paths (rebook / credit / talk to a human) and entitlements (hotel / meal) as peer-level objects on the same screen, not nested tabs and FAQ accordions.

## 2. The default path should match the dominant job, not the airline's preference
Today, the Recovery Options screen defaults to "Travel credit." The dominant inferred user job in a same-day/next-day disruption with a destination event is "get me there." [inferred — flagged for validation]

**IA implication:** If we keep a tabbed structure, the default tab should be "New flights." Better: drop the tab metaphor and present rebook, credit, and standby as parallel cards with one-line consequence labels (e.g., what each one costs, how soon you'd travel, whether it's confirmed vs. waitlist). Standby in particular must not visually equate to confirmed rebooking.

## 3. Entitlements need a permanent home in the flow, not a hidden one
Hotel and meal support are currently in a collapsed "Other policies" FAQ. That's a trust-killing pattern under stress.

**IA implication:** Entitlements should appear as inline, persistent context at the moment they are relevant — likely adjacent to recovery options (because the option you pick affects whether you need a hotel) and again on the confirmation screen. They are not "policies" to the user; they are part of their plan.

## Bonus structural ask
The confirmation screen should be designed as a *durable, self-contained recap* — new flight, hotel, baggage, arrival info, check-in, and a clear "if plans change again" path. Right now it is effectively a dead end. Architecturally, treat it as a first-class screen with its own information model, not a "you're done" terminator.

## Open questions I'd like your read on
- Should "talk to a human" be a peer-level option on the recovery screen or a persistent affordance across all screens? My instinct is the latter, but I want your IA judgment.
- For users traveling with family or with mobility needs, should the flow branch early (a "tell us about your trip" step) or should those needs surface as filters within the flight list? I lean toward filters to avoid front-loading effort, but this is testable.

Happy to pair on the sitemap when you have something. I can also pull session-replay samples if it would help you validate the structure.

— UX Researcher
