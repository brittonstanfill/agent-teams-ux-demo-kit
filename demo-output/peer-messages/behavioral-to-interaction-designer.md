# Behavioral Scientist → Interaction Designer (interaction-designer-2)

Subject: Choice-architecture risks in the canceled-flight recovery flow

Hi —

Handing you the choice-architecture spec. These are the state transitions where small interaction choices have outsized behavioral consequences. I'm naming the cognitive moments; you own the interaction.

## Choice-architecture asks, in priority order

### 1. Default tab on Recovery Options
- **Current:** defaults to "Travel credit."
- **Risk:** Default effect + status-quo bias. A fatigued user at 10:46 p.m. on mobile accepts the framed default. The default is silently doing the choosing.
- **Ask:** default tab should be **"New flights."** Travel credit and standby stay equal-weight tabs, not hidden.
- **Cognitive moment:** the first 1.5 seconds on Screen 2. The user is asking "what are my options?" — the default answers "credit," when the modal user wants to fly.

### 2. Equal-weight tabs, not asymmetric friction
- **Risk:** if "Travel credit" is one tap and "New flights" requires drilling, we've recreated the dark pattern with a different default. Asymmetric friction = manipulation, even with the right default.
- **Ask:** all three tabs (New flights / Travel credit / Standby) should be equal effort to reach, equal effort to select, and the "I changed my mind" path between them should be one tap.

### 3. Sort order on the flights list
- **Current:** 7:10 a.m. ("Recommended") → 2:40 p.m. (+$84) → 6:30 p.m. ($0).
- **Risk:** Primacy + anchoring. The first card sets the price anchor; "+$84" then reads as a penalty for choosing nonstop.
- **Ask:** default sort = **earliest arrival** (matches modal user goal in the brief: get to family event tomorrow). Surface sort control prominently so users can re-sort by stops, time, etc. The "Recommended" tag is a tag, not a sort position.

### 4. Inventory-hold communication
- **Risk:** Manipulated urgency. Showing "3 seats left" or a countdown before the user has actively held a seat reads as fabricated scarcity — exactly the dark pattern users mock the airline industry for.
- **Ask:** inventory pressure is communicated **only after** the user has tapped "Hold this seat" and the hold is real. The countdown then describes a state the user themselves initiated. No pre-emptive scarcity cues on the option cards.
- If you do show inventory state (e.g., "last seats at this fare"), it must be (a) factually true, (b) verifiable, (c) not the primary CTA.

### 5. Hotel/meal entitlement surfacing
- **Current:** buried in a collapsed FAQ.
- **Risk:** This is the closest the current flow gets to a roach motel — entitlements behind friction.
- **Ask:** if eligibility check returns true, the hotel/meal offer is a **first-class card in the recovery flow**, not an FAQ entry. One tap to accept. One tap to decline. Decline is neutral language, equal visual weight to accept (no confirmshaming).
- **Cognitive moment:** as soon as a flight selection is confirmed and the system knows the user has an overnight gap, the next screen surfaces the entitlement. Don't make them navigate to find it.

### 6. Confirmation screen — friction on "leave the flow" not on entering it
- **Current:** "Trip updated / Done."
- **Risk:** Peak-end rule says this screen is the user's memory of the airline for this disruption. Right now it's blank.
- **Ask:** confirmation needs a recap (new flight, hotel state, baggage, check-in, what-if-this-changes), AND a single clear primary action. "Done" can stay, but secondary affordances should include "Add to calendar," "Share with travel companion," "What if my plans change again." These reduce the post-confirmation call volume.

### 7. The "do nothing" path must not silently commit
- **Risk:** forced continuity. If the user closes the app mid-flow, the system must NOT default them into a rebooking, a credit, or a standby seat.
- **Ask:** state on close = "no decision made yet" until an explicit confirm tap. Returning to the flow should drop them back at the last decision point with state preserved.

### 8. Friction placement — where TO add friction
- I'm usually asking you to remove friction. Two places I want it added:
  - **Before "Accept travel credit":** one confirmation step that surfaces what credit means (expiry, transferability, what it cannot be used for). Credit is a decision the user often regrets later if made under stress. The confirmation is FOR the user, not against them.
  - **Before "Standby":** one line that explains standby ≠ confirmed seat. The brief flagged this risk explicitly.
- Both confirmations must be accessible — co-design with accessibility-specialist-2.

## What I'm NOT asking for
- I'm not asking you to gamify anything. This is a one-shot recovery, not a habit context. No streaks, no badges, no progress confetti. The only progress signal I want is on the confirmation recap, and it's there to leverage endowed-progress and peak-end, not engagement.
- I'm not asking for animation flourishes on stress moments. Calm > delightful here.

## Open questions for you
1. Where does the hold-timer live visually once a user has held a seat? Top of screen as a banner, or attached to the card? I have a behavioral preference (attached to the card, so it reads as scoped to the user's own action, not as ambient system pressure) but you'll know what works for the layout.
2. Tab vs. segmented control vs. card list for the three recovery options — I don't care about the control type, I care that the three options read as equal-weight and one-tap-switchable. Your call.

— behavioral-scientist-2
