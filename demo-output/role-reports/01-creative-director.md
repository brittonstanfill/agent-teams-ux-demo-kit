# 01 — Creative Director: Anchor & Quality Bar

Artifact: Northstar Air canceled-flight recovery, mobile, ≤5 screens.
Posture: calm operational authority. Not delight. Not apology theater.

---

## 1. Reference language

**Primary: NTSB / FAA NOTAM operational honesty, filtered through Linear's restraint.**
What we take from NOTAMs (inferred): the discipline of stating the facts first, in the order an operator would brief them — *what happened, what is true now, what you can do next*. No softening verbs. No "we apologize for the inconvenience." The traveler is, at 10:46 p.m., effectively an operator of their own rescheduling problem; we hand them a clean operational picture.
What we take from Linear (inferred): one decision per surface, generous negative space, type that does the hierarchy work without color or weight gymnastics, and a near-monochrome palette where the one accent color means something.

**Secondary, for the support surface only: Citymapper's "you are here, your options branch like this."**
The hotel/meal/support screen should feel like a transit-card with branching paths, not an FAQ. (recommendation)

Explicitly **not**: Airbnb warmth, Duolingo encouragement, Headspace softness, big-airline marketing gloss. Any of those, applied to a 10:46 p.m. cancellation, reads as gaslighting.

---

## 2. Aesthetic anchor

- **Typography stance:** one type family, two weights (Regular + Semibold), three sizes per screen maximum. The headline declares the fact at a size that is uncomfortably large for a marketing surface and correct for a stress-instrument. Body sets at 17px minimum (mobile), line-height 1.45+. Numbers (times, gate, fare diff) are tabular. (recommendation)
- **Color stance:** near-monochrome on a warm off-white or a near-black (pick one and own it; I lean **deep ink on warm bone**, not pure white — pure white at 10:46 p.m. is hostile). One accent — a desaturated, slightly-warm teal — used only for the active decision. Red is reserved for irreversible/destructive only; the cancellation itself is **not** red. The cancellation is a fact, not an alarm. (recommendation; rules out the navy-and-red airline default)
- **Density stance:** one decision per screen, fully framed. No tabs on the recovery-options screen — tabs hide the comparison the user needs. (recommendation, ruling out the current tabbed pattern noted in the brief)
- **Motion stance:** none beyond a 120ms cross-fade between screens and a static focus ring. No skeletons that shimmer, no progress micro-animations, no celebratory checkmark on confirm. Motion under stress reads as the product fidgeting. (recommendation)

---

## 3. Three moves worth stealing

1. **The "operational header" pattern.** Every screen opens with a two-line header: line 1 is the *fact* in plain English ("Your 6:15 a.m. flight tomorrow is canceled."); line 2 is the *current state* of what we're doing about it ("You have not been rebooked yet. Three options below."). No hero image. No icon. The header *is* the hero.
2. **Side-by-side option comparison, not tabs.** On the recovery-options screen, the three paths (rebook / credit / standby) are visible simultaneously as stacked cards with a one-line *consequence* under each label — "You arrive tomorrow" vs. "You decide later, no flight held" vs. "You wait at the gate, seat not guaranteed." Consequence copy is the design. (recommendation, directly addresses the brief's "labels do not explain consequences")
3. **Entitlements surfaced as a persistent strip, not a screen.** Hotel voucher and meal credit live in a thin always-visible strip at the bottom of every recovery screen — "Hotel and meal support available. Tap to claim." It is never collapsed, never inside an FAQ, never called "Other policies." (recommendation, directly addresses the brief's hidden-entitlements problem)

---

## 4. Failure mode to avoid

The version we must not ship: a five-screen wizard with a blue gradient header, a sad-cloud illustration, the word "Oops," a progress bar across the top showing "Step 2 of 5," a "Recommended" badge with no explanation, three equally-weighted tabs, a chatbot bubble in the corner, and a confirmation screen with confetti or a checkmark animation. Body copy starts with "We're sorry for any inconvenience this may cause." Hotel info is under a chevron labeled "More." This is the meeting-template version. If your draft has any three of those elements, you have drifted. The tell: a senior designer scanning it would not be able to name a single deliberate choice.

---

## 5. Quality bar for sign-off

When Visual Designer pings me, I will reject:
- Any screen with more than one primary action.
- Any use of red on the cancellation fact itself.
- Any apology-first copy in a headline slot (content-designer owns the phrasing, but the *register* is mine: state-the-fact, then offer-the-path).
- Any stock illustration, lottie, or hero image. The type is the hero.
- Tabs on the recovery-options screen.
- A confirmation screen that lacks a printable/screenshotable summary block with new flight number, times, hotel name, and a support number visible without a tap.
- Anything that could have come out of a Bootstrap admin template with the colors swapped.

A passing artifact: a designer seeing it cold can name **three deliberate moves** on the first scan. If they can't, we shipped median.

---

## 6. Brief to each teammate

- **UX Researcher:** validate the *order of operations* a stressed traveler actually needs (fact → options → consequence → entitlements → confirm-with-receipt). Don't bring me satisfaction scores; bring me the moment in the current flow where confidence collapses.
- **Information Architect:** five screens is a ceiling, not a target. If you can do it in four with the entitlements-strip pattern, do four. No tabs on recovery-options.
- **Visual Designer:** deep ink on warm bone, one desaturated-teal accent, two type weights, no illustration. The headline carries the page. Show me your three deliberate moves on first ping.
- **Interaction Designer:** the experience quality is *deliberate and quiet*. No shimmer, no progress bar across the top, no celebratory confirm. One decision per screen.
- **Content Designer:** the register is plain operational. State the fact; then the state; then the path. "We are sorry for the inconvenience" is banned from headlines. Voice and phrasing are yours within that register.
- **Behavioral Scientist:** your dark-pattern floor is hard; I defer. Specifically watch the "Recommended" badge and the default-tab pattern from the current flow — both currently nudge against the user.
- **Accessibility Specialist:** WCAG is a hard floor; I defer. Specific asks: screen-reader order must match visual order (fact → state → options); the entitlements strip must be reachable, not a trap; 17px body minimum; tap targets ≥44pt; works at 200% zoom without horizontal scroll.

---

*If any teammate proposes the consensus-safe answer, name it as such in-thread. "This is the safe version; here is the version I'd ship" is a productive sentence on this team.*
