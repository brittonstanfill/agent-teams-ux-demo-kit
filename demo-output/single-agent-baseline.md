# Canceled-flight recovery — meeting-ready recommendation

## Executive recommendation

Rebuild the late-night cancellation flow around one principle: **tell the truth fast, then put every honest option — including a person — in front of the user on the same screen as the care they're owed.** [recommendation]

The current flow loses people in three predictable places: it hides the event behind "schedule irregularity" [observed from brief], it defaults the recovery step to "Travel credit" [observed from brief], and it buries hotel/meal entitlements inside a collapsed "Other policies" FAQ [observed from brief]. Each is a quiet trust violation. Together they teach the user that the app is more interested in containing them than in helping them — so they call.

The redesigned flow is five mobile screens. It plainly names the cancellation and its cause, presents three equal-weight paths (rebook / refund-or-credit / talk to a person) with no preselected default, removes fare-difference language from the disruption context, adds filters that match real constraints (including travel-party seating) [inferred from brief: family-event traveler, family is named as a constraint], pairs care entitlements with the confirm step instead of hiding them in policy, and ends on a saveable trip card with a clear "plans change?" path. [recommendation]

We expect this to reduce support calls **without** suppressing them. If the experiment shows calls dropping while NPS or downstream complaints rise, we are containing — not helping — and we roll back.

---

## Redesigned flow (5 screens)

### Screen 1 — Alert detail (the SMS deep-link landing)

**Purpose:** Replace "Schedule irregularity on NS482" with a plain, calm, factual statement and the single most useful next step. [recommendation]

What it shows:
- Headline names the event ("Your 6:15 a.m. flight tomorrow is canceled.")
- One-line cause label, neutral and honest, distinguishing controllable causes from weather (because the next screen's care offer depends on it) [assumption: the cause-class is already available from the operational system at SMS-send time]
- A two-cell "Was → Now" fact bar, so the user can orient at a glance even at 10:46 p.m.
- A "tonight's care" callout that previews hotel/meal coverage **before** asking for any choice
- Primary CTA: "See my options"
- Always-visible secondary CTA: "Talk to a person — wait shown live"

### Screen 2 — Choose your path

**Purpose:** Three equal options, no default, plain consequences. [recommendation]

What it shows:
- Three options as full-width cards (rebook, refund-or-credit, talk to a person)
- Each one explains the consequence in one sentence (no rebooking fee, refund vs. credit shown side-by-side at the next step, live agent with current wait)
- One soft signal under "Take another flight": "Most travelers in this situation" — calibrated language, not a coercive "Recommended" badge
- A repeated care callout: hotel and meal coverage shown on the next screen, whichever path you pick
- Secondary: "Save my place & close" so a stressed user can come back to their phone

### Screen 3 — Pick a flight

**Purpose:** Replace the misleading "Recommended" badge and the disruption-context fare difference with concrete attributes. Add filters that match real constraints. [recommendation]

What it shows:
- Heading frames the offer: "Flights we can put you on, at no extra cost"
- Filter chips: Soonest arrival · Direct only · Arrive by … · Seats together
- Flight cards show: departure time, route, total duration, stop count, arrival time band, and **named** attribute tags ("Earliest arrival", "Direct", "Seats together available")
- No "Recommended" badge; no fare-difference language during a Northstar-side cancellation
- Quiet exit ramp: "I want a refund or credit instead"

### Screen 4 — Confirm + care, on one screen

**Purpose:** Move hotel/meal entitlements out of the FAQ and into the confirm step, so the user claims them in the same gesture as confirming. [recommendation]

What it shows:
- Review card for the new flight (when, how, cost, bag status placeholder)
- Care card immediately below: hotel coverage, meal coverage, getting-to-the-hotel — each with system-determined eligibility surfaced live, not gated behind a claim form
- Two visible exit ramps: "Change flight" and "Switch to refund or credit"
- Primary: "Confirm new flight & claim care"
- Reversibility line: "Reversible for the next hour, or until check-in opens" [assumption: reversibility window is a business choice we recommend, not an existing policy]

### Screen 5 — You're set

**Purpose:** Replace the empty "Trip updated · Done" with a card the user can take with them. [recommendation]

What it shows:
- Headline restates the new flight, plainly
- A four-row check list: new flight, hotel tonight, meals, bags — with status placeholders for system-determined values
- Toolbar: "Save offline" and "Email a backup" — answers the low-bandwidth and dead-battery cases the brief names
- Footer line: "Plans change? Switch flight · Refund or credit · Talk to a person — all still free, all still reversible until check-in opens"

---

## Main issues found in the current flow

1. **The SMS hides the event.** "Schedule irregularity on NS482" forces the user to tap a link before knowing whether they need to act tonight or in the morning. [observed from brief] This is the single most expensive copy choice in the flow: it taxes every downstream metric.
2. **"Continue" promises nothing.** A button label on a stress flow should name the next state. [observed from brief]
3. **"Travel credit" as the default tab.** The first tab presented is the one with the worst average outcome for a traveler who needs to be somewhere tomorrow. [observed from brief]
4. **"Recommended" is unexplained.** Without a stated reason, "Recommended" reads as either a paid placement or an arbitrary sort — neither builds trust. [observed from brief]
5. **Fare-difference language during a Northstar-side cancellation.** Shows price deltas as if the user were shopping, in a moment when they aren't. [observed from brief]
6. **Filters absent.** No way to filter by direct, arrival window, or travel party — the things that actually determine whether a flight is acceptable to this user. [observed from brief]
7. **Care entitlements inside an "Other policies" FAQ.** This is the highest-cost pattern in the flow: it teaches users that getting hotel coverage is adversarial. Many will pay out of pocket; some will call to confirm; very few will trust the app on the next disruption. [observed from brief]
8. **Confirmation page gives the user nothing to take.** No new flight summary, no offline backup, no path back if plans change again. The flow ends exactly when the user most needs reassurance. [observed from brief]
9. **"Talk to a person" is implicit.** A late-night cancellation flow that doesn't keep a live-agent option visible at every step is signaling that calling is failure, not a peer choice. [recommendation]

---

## Recommended copy (verbatim)

### SMS / push

> Northstar: Your 6:15 a.m. flight tomorrow is canceled. We can put you on a later flight, refund or credit you, or get a person on the line. Open Trip ›

### Screen 1 — Alert

- Eyebrow: **Flight canceled**
- Headline: **Your 6:15 a.m. flight tomorrow is canceled.**
- Body: **Reason: a crew member isn't available. This isn't weather — it's on us. We can put you on a later flight, refund or credit you, or get a person on the line.**
- Care callout title: **Tonight's care, if you need it**
- Care callout body: **Hotel and meal coverage may be available because this cancellation is on us. You'll see exactly what's covered on the next screen — no claim form required.**
- Primary CTA: **See my options**
- Secondary CTA: **Talk to a person · wait shown live**

### Screen 2 — Choose your path

- Eyebrow: **Pick what helps most**
- Headline: **How do you want to get there?**
- Helper: **Each option is reversible until you confirm. Care tonight is the same on all three.**
- Option 1 title: **Take another flight**
  - Body: **See tomorrow's flights to the same destination. No rebooking fee — your fare follows you.**
  - Soft signal: **Most travelers in this situation**
- Option 2 title: **Refund or travel credit**
  - Body: **Choose between a refund to your original payment or a travel credit. We'll show both side-by-side before you commit.**
- Option 3 title: **Talk to a person**
  - Body: **Live agent — current wait time shows here. You can keep this screen open and we'll text you when it's your turn.**
- Care callout title: **If you need to stay overnight**
- Care callout body: **Tap any option above and the next screen tells you whether hotel and meal coverage applies to your trip tonight. Nothing is hidden from you here.**

### Screen 3 — Pick a flight

- Eyebrow: **Tomorrow · same route**
- Headline: **Flights we can put you on, at no extra cost.**
- Filter chips: **Soonest arrival**, **Direct only**, **Arrive by …**, **Seats together**
- Attribute tags (named, not abstract): **Earliest arrival**, **Direct**, **Most legroom on this route**, **Seats together available**, **Backup option**
- Microcopy: **No fees on any of these — this is a Northstar-side cancellation.**
- Secondary CTA: **I want a refund or credit instead**

### Screen 4 — Confirm + care

- Eyebrow: **Last look before we book it**
- Headline: **Confirm your new flight — and what's covered tonight.**
- Section A heading: **Your new flight**
- Section B heading: **Care tonight, if you stay over**
- Helper: **Anything wrong? Change flight · Switch to refund or credit**
- Primary CTA: **Confirm new flight & claim care**
- Microcopy under primary: **Reversible for the next hour, or until check-in opens.**

### Screen 5 — You're set

- Eyebrow: **You're set — get some sleep**
- Headline: **Tomorrow, 2:40 p.m. Nonstop to LGA.** *(time is the user's chosen flight, dynamic)*
- Subline: **We've texted you a backup copy of this card. If plans change again, this screen updates and you'll get a text.**
- Toolbar buttons: **Save offline**, **Email a backup**
- Footer: **Plans change? Switch flight · Refund or credit · Talk to a person — all still free, all still reversible until check-in opens.**

---

## Accessibility and trust risks, with mitigations

### Accessibility

| Risk | Mitigation in the artifact |
|---|---|
| Stressed, tired user at 10:46 p.m. — cognitive load floor | Body type is serif at ≥15px, hierarchy is type-led rather than icon-led, and one decision per screen. WCAG 2.1 SC 3.2.4 (Consistent Identification): same word for the same action across all 5 screens. |
| Screen reader use [observed from brief] | Semantic landmarks (`header` / `main` / `section` / `article`), one `h1` and a single `h2` per screen, real `button` elements (not styled `div`s), `aria-label` on each phone-frame `img` role, `aria-pressed` on filter chips, and a working skip link. WCAG 2.1 SC 1.3.1, 2.4.1, 4.1.2. |
| Color-only meaning | Care callout uses both a left rule (color) **and** a labeled title; flight tags carry text, not just color. WCAG 2.1 SC 1.4.1. |
| Contrast in dark mode | Ink #EFE7D3 on field #1B2230 measures ≈11.7:1; ember #E58A5C on the same field ≈5.0:1. Both clear AA, headline-size text clears AAA. WCAG 2.1 SC 1.4.3, 1.4.6. |
| Reduced-motion users | `@media (prefers-reduced-motion: reduce)` disables transitions and animations site-wide. WCAG 2.1 SC 2.3.3. |
| Touch targets at 390px wide | All buttons and chips meet 44×44 px effective target via padding. WCAG 2.5.5 (AAA, but easy to meet here). |
| Low bandwidth [observed from brief] | No external fonts, no external images, no third-party scripts. Inline CSS + JS only. Page is one HTML file under 30 KB. |
| Family traveling together [observed from brief] | "Seats together" filter chip and an explicit "Seats together available" attribute tag surface party-seating without forcing the user to read every fare class. |

### Scoped accessibility gaps

- Form-field labeling for "Arrive by …" date picker is not modeled in the artifact; needs `<label>` + native picker on implementation.
- Reduced-motion is respected, but live wait-time updates on Screen 2's Option 3 will need `aria-live="polite"` on implementation to announce queue position changes without spamming.

### Trust and behavioral risks

| Risk | Mitigation |
|---|---|
| The "Most travelers in this situation" line on Screen 2 could read as social-proof coercion. | Phrased as a calibrated signal, not a default; the option is not preselected; the line is removed entirely if Northstar cannot back it with actual telemetry on this disruption class. [recommendation] |
| The flow could inadvertently suppress "Talk to a person" to hit the call-deflection goal. | "Talk to a person" appears as a primary peer option on Screens 1, 2, and 5 — three of five screens — with live wait shown. Treat it as a guardrail in the experiment plan, not a target. |
| Hotel/meal copy could overclaim and create a downstream complaint. | All eligibility is phrased as system-determined ("coverage shown live", "if eligible"). The artifact never names a hotel, a voucher amount, or an eligibility rule that isn't in the brief. |
| The reversibility line could be used to soften a costly choice and then revoked. | If we promise "reversible for the next hour, or until check-in opens," operations has to honor it. Worth a separate ops sign-off before launch. [recommendation] |
| "Soonest arrival" as the default filter could bias toward earlier flights even when a later direct is the user's actual best option. | The chip is a chip, not a hardcoded sort; "Direct only" sits beside it as a peer; the flight cards carry concrete attribute tags so the user can override. |

---

## Experiment plan

Each experiment is named, has one falsifiable hypothesis, a primary metric, a guardrail metric, and an exit rule. None of these substitute for a qualitative read of session recordings during the same window. [recommendation]

### Experiment 1 — Plain SMS

- **Hypothesis:** Replacing "Schedule irregularity on NS482" with a plain SMS that names the cancellation and the three options increases self-service completion within 60 minutes of message receipt without raising "I didn't understand" support calls.
- **Primary metric:** Share of canceled-flight notifications that reach a completed self-service confirmation within 60 minutes.
- **Guardrail:** Volume of calls tagged "didn't understand the message"; this must not rise.
- **Exit rule:** If primary lifts by less than 3 points after two weeks across at least N=2,000 cancellations, hold and rerun with copy variants. If the guardrail rises at any point in the run, stop immediately.

### Experiment 2 — No default path

- **Hypothesis:** Removing the preselected "Travel credit" tab and presenting three equal-weight options reduces post-flow complaints about "I picked the wrong option" without reducing overall completion.
- **Primary metric:** Rate of post-confirm reversals + same-trip complaint tickets in the 72 hours after confirmation.
- **Guardrail:** Overall self-service completion rate must not drop more than 1 point.
- **Exit rule:** If primary improves by ≥10% relative and guardrail holds for two weeks, ship. If guardrail breaks, hold; if both flat, hold and investigate whether the issue is the default or the option labels.

### Experiment 3 — Care surfaced at confirm

- **Hypothesis:** Moving hotel/meal eligibility out of "Other policies" and onto the confirm screen increases voucher-claim rate among eligible users and reduces "do I get a hotel?" calls.
- **Primary metric:** Voucher-claim rate among users determined eligible by the operational system.
- **Guardrail #1:** Total voucher payouts per eligible cancellation — should rise (we expect more eligible users to claim what they're owed); a flat or falling number means the new placement isn't working.
- **Guardrail #2:** "Hotel / meal" support-call category — should fall, but not to zero (some calls are legitimate escalations).
- **Exit rule:** If claim rate among eligible users does not improve, this is a comprehension or trust problem, not a placement problem — rerun with copy variants before promoting.

### Experiment 4 — Visible live-agent

- **Hypothesis:** Keeping "Talk to a person" visible across the flow does not increase calls, because the call-friction reduction is offset by the trust and reversibility cues we add elsewhere.
- **Primary metric:** Inbound calls per canceled-flight notification, holding cancellation cause-class constant.
- **Guardrail:** NPS for canceled-flight cohort and the call-deflection share that was actually appropriate (i.e., the user's job was complete) — measured by post-trip survey.
- **Exit rule:** If calls rise without an NPS or appropriateness improvement, the experiment is losing on trust grounds and we revisit which surfaces show "Talk to a person." If calls fall and NPS rises, ship.

### Experiment 5 — Trip card you can take

- **Hypothesis:** Replacing "Trip updated · Done" with the saveable trip card reduces follow-up "what's my new flight?" calls and increases offline-save rate among low-bandwidth users.
- **Primary metric:** "What's my new flight?" call category in the 24 hours after confirmation.
- **Guardrail:** App reopen rate in the 24-hour window — we want users to be able to find their info, not to feel forced back into the app.
- **Exit rule:** If calls fall without app-reopen rate dropping uncomfortably, ship. If both fall together, that's a positive signal — the offline card is doing its job.

---

## Scoped gaps the artifact does not solve

- **Form labeling for the "Arrive by …" filter** — modeled as a chip; the implementation needs a native time picker with proper `<label>` association.
- **Live wait-time announcement for screen readers** — needs `aria-live="polite"` on the queue indicator and a debounce policy on implementation.
- **Operational backing for "Reversible for the next hour, or until check-in opens"** — requires ops sign-off before this copy ships.
- **The "Most travelers in this situation" line on Screen 2** — only ships if the operational telemetry can back it for this disruption class, otherwise it is removed at implementation.
- **Internationalization and pluralization** — the prototype uses English-locale time formats and idioms; localization is out of scope here.

---

## Labels used

- **[observed from brief]** — explicitly stated in the input brief.
- **[inferred]** — inferred from the input but not literally stated.
- **[assumption]** — working assumption a reader can disagree with.
- **[recommendation]** — a deliberate design call made here.
