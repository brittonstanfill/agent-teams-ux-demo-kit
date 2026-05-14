# Demo Input: Northstar Air Canceled-Flight Recovery

## Scenario

Northstar Air is a fictional airline. A traveler gets a text message at 10:46 p.m. saying their 6:15 a.m. flight has been canceled due to crew availability. They are tired, mobile-only, and trying to get to a family event the next day.

The current recovery experience technically lets the traveler rebook, request a hotel voucher, and confirm next steps. In practice, people abandon the flow and call support.

## Business Goal

Reduce support calls and increase successful self-service recovery without hiding important options or pushing users into worse choices.

## User Goal

Understand what happened, choose the best available recovery option, get any required support, and leave with confidence about what happens next.

## Current Flow

### Entry SMS

> Northstar Alert: Schedule irregularity on NS482. Manage trip: link

Problems suspected:
- "Schedule irregularity" hides the real event.
- No urgency, next step, or reassurance.
- No mention of rights, options, hotel, or support.

### Screen 1: Trip Status

Header: "Your itinerary has changed"

Body:
> NS482 DEN to LGA is no longer operating. We are sorry for the inconvenience.

Primary button: "Continue"

Secondary link: "View details"

Problems suspected:
- The user still does not know what choices they have.
- "Continue" does not say what will happen.
- The important information is behind a vague link.

### Screen 2: Recovery Options

Three tabs:
- New flights
- Travel credit
- Standby

Default tab: Travel credit

Problems suspected:
- The default may not match the user's likely goal.
- The labels do not explain consequences.
- Hotel and meal support are absent.
- Standby may sound equivalent to confirmed rebooking.

### Screen 3: New Flights

List of flight cards:
- 7:10 a.m. tomorrow, one stop, "Recommended"
- 2:40 p.m. tomorrow, nonstop, "$84 fare difference"
- 6:30 p.m. tomorrow, one stop, "$0"

Problems suspected:
- "Recommended" is not explained.
- Fare difference appears during disruption recovery.
- Sort order may not reflect user goal.
- No filters for arrival time, direct flight, mobility needs, or travel party.

### Screen 4: Support

Hotel voucher and meal credit are in a collapsed FAQ called "Other policies."

Problems suspected:
- Entitlements are hidden.
- The user may pay out of pocket unnecessarily.
- Low-trust pattern under stress.

### Screen 5: Confirmation

Header: "Trip updated"

Body:
> Your changes have been applied.

Primary button: "Done"

Problems suspected:
- No summary of new flight, hotel, baggage, arrival, check-in, or support next steps.
- No offline backup.
- No clear path if plans change again.

## Constraints

- Mobile-first.
- Keep the redesign to 5 screens or fewer.
- Do not invent legal obligations, airline policy, or compensation rules.
- Assume the user may be tired, stressed, low bandwidth, using a screen reader, or traveling with family.
- The business still wants to reduce calls, but not by hiding help.

## Desired Output

Create a better recovery flow with:

- A revised screen sequence.
- Button and notification copy.
- Accessibility guardrails.
- Trust and behavior guardrails.
- A simple experiment plan to test whether it works.
