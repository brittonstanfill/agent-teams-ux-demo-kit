# Northstar Canceled-Flight Recovery — Recommendation

## 1. Executive recommendation

Replace the current recovery flow with a redesign that solves the stressed traveler's job in order — understand, choose, get support, leave with confidence — and closes the current flow's trust failures: vague event wording, the Travel-Credit default, buried entitlements, and an empty confirmation.

Three load-bearing changes:

1. **No default on path choice.** Rebook, Refund-or-credit, and Standby are a real choice. Standby is visually subordinated because it is structurally non-equivalent to a confirmed seat.
2. **Support entitlements surface before confirmation.** Hotel, meals, ground transport, and bags are discrete rows with explicit Accept or Decline. Rows distinguish "Available for you" from "Check with an agent" on border and badge, never color alone.
3. **A durable, offline-shareable confirmation.** Screen 5 names the new flight, support secured, and the next three steps with times. Anything unresolved is a tappable "Resolve with agent" action, not a dead label.

Ship behind the experiment in §4. Do **not** promote to all traffic until the operational backend can reliably populate per-passenger entitlement values; otherwise the design collapses into an SMS that says "call us."

## 2. Redesigned flow

Five mobile-first screens, one primary decision per screen, persistent "Talk to an agent" on every screen, party-size carried across Screens 2–5.

1. **Status.** Plain account ("Your 6:15 AM flight NS482 to LGA was canceled. Reason: crew availability."), hedged reassurance, single CTA "See my options."
2. **Choose a recovery path.** Three peer cards — Rebook, Refund or credit, Standby — no default. Party-size stepper (default 1). Standby uses dashed container, smaller type, a "Not equivalent to rebooking" chip, and a "non-confirmed option" divider.
3. **Rebook (or Refund branch).** Flight cards as a roving-tabindex radiogroup. Filter chips for arrival, nonstop, earliest, seats-together, accessibility — none pre-pressed. "Recommended" replaced by a self-naming criterion. Fare difference is $0 during recovery; if a real difference exists, the card states it plainly. Refund and credit are peers.
4. **Support tonight.** Hotel, meals, ground transport, bags as discrete rows with Accept and Decline. Confirmed: evergreen rail and "Available for you" badge. Unconfirmed: dashed border and amber "Check with agent" badge. No invented amounts or names — placeholders read as system-supplied tokens.
5. **Confirmation.** Durable summary, offline / share affordance, "Plans changed again?" re-entry. Pending items are tappable "Resolve with agent" actions.

The SMS rewrites plainly: flight number, route, departure, that it is canceled, one link. No promised compensation, hotel coverage, voucher amounts, or wait times.

## 3. Accessibility and trust guardrails

- **Keyboard / screen reader:** path choice is a single-select toggle inside a fieldset/legend; flight choice is a radiogroup with roving tabindex and Arrow/Home/End/Space/Enter. Stepper is a spinbutton with `aria-valuetext`. `<main>` wraps the screens.
- **Contrast / target size:** functional small text uses a 4.7:1 token; decorative meta is a separate, clearly labeled lower-contrast token. Primary CTAs and stepper buttons are 44×44.
- **Non-color signaling:** Standby's non-equivalence and confirmed-vs-unconfirmed support rows signal on border and badge in addition to color.
- **Motion:** transitions disabled under `prefers-reduced-motion`; no autoplay.
- **Trust:** no pre-selected paths, no buried entitlements, no manufactured urgency, no confirmshaming. Pre-acceptance reads "Available for you," not "Confirmed." Every support row has a visible Decline. Pending items route to a real handoff.
- **Honesty discipline:** no invented amounts, hotel names, voucher values, wait times, expiration windows, eligibility promises, phone numbers, or compensation rules anywhere in the artifact.

## 4. Experiment plan

**Hypothesis:** the redesigned flow reduces inbound disruption-recovery calls within 24 hours of an SMS-notified cancellation without reducing agent-tap rate or shifting refund-to-credit ratio against user interest.

**Primary metric:** inbound-call rate per SMS-notified cancellation within 24 hours, by topic (rebook, refund, hotel, meals, bags, other). Target: reduction on rebook and refund; flat or down on hotel/meals/bags.

**Guardrails:** (a) per-screen agent-tap rate not flat or down across Screens 1–5; (b) "Pending agent" resolution rate from Screen 5; (c) refund-to-credit ratio vs. current flow.

**Falsifiers (any triggers a hold):** (i) high "Resolve with agent" taps on Screen 5 paired with low actual agent-connection within 24 hours — parking users; (ii) inbound calls on entitlement topics rise while agent-tap rate falls — hiding help cognitively; (iii) first-flight-card selection rate >2σ above 1/n — the un-pressed sort chip masks a hidden order default; (iv) refund-to-credit ratio flat or shifts toward credit — peer framing isn't breaking inertia.

**Exit rule:** promote to 100% only when the primary metric improves, no falsifier fires for two disruption cycles, and the backend supplies confirmed entitlement values in most disruptions.
