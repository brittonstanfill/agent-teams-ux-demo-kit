# Devil's Advocate — Stress Test

## 1. Steel-man the current proposal

This prototype refuses the dominant industry response to disruption — sympathy-theater + comparison-shop — and replaces it with a dispatcher posture that does three load-bearing things simultaneously: it states the event in human words on first frame, it surfaces entitlements as already-held status (not as offers the user must claim), and it co-equalizes the "I'm not traveling" fork with rebooking so the refund-seeker is never punished by the IA. Every canonical dark pattern named in the brief — hidden hotel/meal, opaque "Recommended," fare-delta during disruption, Done dead-end, urgency theater — is affirmatively absent and replaceable as a single grep. The structural decisions (one decision per screen, reversibility promised three times, persistent human-escape link, offline-viewable receipt) are conservative in the literal sense: they reduce the cost of being wrong at every step. Shipping this is a defensible Bayesian move against the status quo even before a single usability session.

## 2. Strongest opposing design

**Alternative: SMS-native resolution with a one-screen web fallback.** Replace the five-screen flow with a structured SMS thread: (1) "Flight NS482 6:15a DEN→LGA canceled, crew. We've held a seat on the next eligible flight + hotel + meal credit. Reply OK to accept, FLIGHT for other options, OUT for refund, CALL for a human." (2) confirmation text with hotel name, address, baggage instruction, support number. The web link is a *single* offline-cacheable receipt page, no flow. Argument: the user is already in SMS at 10:46 p.m.; the brief itself begins in SMS; the modal switch into a browser flow is the abandonment surface. SMS is the lowest-bandwidth, screen-reader-friendliest, most cacheable channel that exists; defaults can do the work the prototype's pre-selected radios are already doing, with less UI to mistrust. **Why the team's design is still defensible:** SMS-only collapses on multi-passenger PNRs, on filter needs (arrive-by, nonstop, party-size), and on per-traveler eligibility differences — exactly the cases the IA promoted to first-class citizens. The web flow earns its keep when the party is >1 or the held seat does not work. But the team has not justified *why* the default path is web rather than SMS-with-web-as-escape, which is a real strategic gap.

## 3. Hidden assumptions

- **Per-traveler eligibility is a real backend field.** If hotel/meal/protection comes back only at PNR level, Screen 3's per-passenger rows degrade to a single party line and the trust gain collapses.
- **The system can "already hold" a seat at SMS dispatch time.** If the held-seat is actually a UI fiction rendered before inventory is reserved, the prototype is making a promise the backend will break.
- **The user reads English at the headline's register.** Headline-led, type-only design assumes literacy and language fluency; no translation, plain-language, or icon fallback path exists.
- **Call volume is a UX problem, not an operations symptom.** If people call because crew-cancel events cascade (re-cancels, missed connections, gate changes within 4 hours), no recovery screen fixes the root cause.
- **Decision-makers are solo.** The flow has no "I need to ask my spouse / boss / caregiver before I confirm" pause; reversibility copy substitutes for an explicit hold.
- **Tired-thumb single-device.** No state hand-off to a second device, no email parity, no kiosk parity at the airport.

## 4. Pre-mortem

- **Six months in, support calls drop 22% but post-confirm disputes ("I never agreed to that hotel") rise 3x.** Cause: pre-selected Accept defaults harvested entitlements users didn't read; instrumentation caught it late because reversal-rate was measured at 24h, not 7d.
- **The flow ships, then a multi-leg cascade event hits.** Users on Leg 2 see the Screen 1 fork ("still traveling?") but the system has no representation for "yes but my downstream is now broken too." Calls spike, not for self-service failure but for a fork the IA never modeled.
- **Non-English-dominant travelers abandon at Screen 1 at 2x the English rate.** Type-led, idiom-rich copy ("Find me another flight") doesn't survive machine translation; the dispatcher posture reads as cold rather than calm.

## 5. What would falsify the recommendation

In moderated testing, if **>30% of users tap "Find me another flight" and then back out within 10 seconds without selecting a flight**, the Screen 1 fork is being chosen by salience, not intent — users are deferring the real decision (travel-or-not) and discovering it on Screen 2. The IA's "one decision per screen" claim fails at its load-bearing screen. (Different mechanism from the Behavioral Scientist's confidence and reversal falsifiers: this targets fork-comprehension, not post-confirm regret.)

## 6. One bias the team is at risk of

**Anchoring on the Creative Director's posture.** The "calm night-shift dispatcher, type-led, no illustration, no motion" anchor was set first and never seriously contested — every subsequent role report cites it approvingly, and the Visual Designer's revision pass explicitly preserved palette, type, spacing, voice, and copy. The A11y and Behavioral audits found surgical defects but no posture-level objection. This is the structural condition for anchoring: an early, confident, aesthetically coherent frame that subsequent specialists optimize *within* rather than *against*. The team has not asked whether a warmer, more guided, or non-web channel would outperform the dispatcher register for the specific user state described in the brief (tired, stressed, 10:46 p.m., family event tomorrow). The posture may well be right — but no one has been paid to argue it's wrong, until now.

**Here's what would change my mind:** (a) evidence the backend actually returns per-traveler eligibility and real-time held inventory; (b) a moderated test with at least 3 non-English-dominant participants where the Screen 1 fork is comprehended in under 15s; (c) a logged baseline showing call volume is driven by recovery UX failure rather than by operational cascade events the screen cannot address.
