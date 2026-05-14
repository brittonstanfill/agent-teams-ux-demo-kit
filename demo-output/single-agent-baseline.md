# Northstar Air — Canceled flight recovery

## Executive recommendation

The current flow fails the traveler in three specific ways: it hides the *event* behind euphemism, hides the *choices* behind tabs with a defaulted answer, and hides the *support entitlements* behind a collapsed FAQ called "Other policies." All three failures push tired people to call. [observed from brief]

The redesigned flow keeps the screen budget (five screens) but reorganizes them around the traveler's actual decision sequence: **understand → choose → pick → confirm with support included → leave with a plan I can show.** Two cross-cutting changes do most of the work:

1. **Name the event in plain language at every step**, starting with the SMS. Stop saying "schedule irregularity."
2. **Surface hotel and meal support as a first-class option, not a buried policy.** Both the choice screen and the confirm screen check eligibility inline so people don't pay out of pocket and call later.

A third, smaller change matters more than it sounds: remove fare-difference labels from rebooking cards *during a cancellation*, and move any fare adjustment to a single, surprise-free confirm screen. The current flow asks a stressed person to make a fare decision before they've made a logistics decision, which is the wrong order. [inferred from problems listed in brief, screens 2 and 3]

What this redesign explicitly does **not** do: invent an entitlement policy, promise a compensation amount, name a hotel partner, or guarantee a static support wait. Anywhere those values appear in the prototype, they are framed as the system's current answer for *this* traveler — not a blanket policy. [recommendation]

---

## The redesigned flow

**Screen 0 — SMS / lock-screen notification.** Names the cancellation in the first sentence. Gives a reason if one is known, no euphemism if not. Offers two doors immediately: open the app, or call. A second notification line raises hotel and meal support as something to check inside.

**Screen 1 — Status.** Confirms what happened in the user's own language. Shows who's on the trip (you alone, you + companion, family group), because rebooking math depends on it. Previews the three paths so the user can spot the right one before tapping into a menu. The CTA names what happens next ("See my options"), not "Continue."

**Screen 2 — Choose your path.** Three cards of equal weight, each with a one-line consequence summary: *Get on another flight*, *Take travel credit*, *Talk to an agent*. Replaces the current tab pattern, which defaulted to "Travel credit" and read like an upsell. A separately visible row — "Hotel and meal support tonight" — lets the user check eligibility *before* picking a path, so they don't lock themselves out by accident.

**Screen 3 — Pick a flight.** Default sort is *earliest arrival*, not fare. "Recommended" tags are reasoned ("because you said you need to be in NYC tomorrow"), not magic. Filters cover constraints the brief calls out: nonstop, arrival time, mobility help, same airline. Fare differences are removed from the card during disruption and surfaced once, on confirm.

**Screen 4 — Review &amp; confirm.** One screen with the whole package: new flight, hotel and meal status, bag handling, and any fare difference. Each line is a real status row, not a decorative icon. A disclosure underneath — "If your plans change after you confirm" — preserves reversibility in writing. Refund, credit, and agent help stay reachable.

**Screen 5 — You're set.** Glanceable summary, saved offline so it works without signal. Next steps as a time-anchored list ("Tonight," "Before your shuttle pickup," "If anything changes"). One button to save to wallet, one quiet link to change the plan.

---

## Main issues with the current flow

| Where | Issue | Why it hurts |
|---|---|---|
| SMS | "Schedule irregularity on NS482" | Hides the event. Reads like clickbait. People assume "delay" and don't open. [observed] |
| Screen 1 | "Continue" with details behind a link | Forces a blind tap. No preview of choices means no orientation. [observed] |
| Screen 2 | Tabs, defaulted to "Travel credit" | The default reads as recommendation. Most travelers want to get *to their destination*, not a future credit. [inferred] |
| Screen 2 | No hotel/meal support visible | Buried entitlements lower trust and cause out-of-pocket spending followed by support calls — the exact thing the business wants to reduce. [observed] |
| Screen 3 | "Recommended" with no reason | Travelers can't trust an unsourced label, especially at midnight. [observed] |
| Screen 3 | Fare difference on rebooking card | Wrong question at the wrong moment. Decisions about a $84 fee come before decisions about "can I make it tomorrow at all?" [inferred] |
| Screen 3 | No filters for arrival time, nonstop, mobility, group | The brief lists exactly these as relevant; the flow ignores them. [observed] |
| Screen 4 | Entitlements in collapsed FAQ | Active dark-pattern adjacent: hiding help to reduce *successful* claims, which then increases calls. [observed] |
| Screen 5 | "Your changes have been applied. Done." | No summary, no offline backup, no path back. Stressed users will call to "make sure it worked." [observed] |

---

## Recommended copy (verbatim)

**SMS / push notification**

> Your 6:15 a.m. flight to LGA was canceled. Reason: crew availability. Tap to see your options for getting home — or call us if that's easier.

(If no reason is known yet, replace the second sentence with: *We're still confirming why — we'll update you here as soon as we know.* Do **not** fall back to "schedule irregularity.")

**Screen 1 — Status**

- Page header: *Your 6:15 a.m. flight was canceled.*
- Subhead: *Crew availability. We can sort this out in the app, or you can talk to a person — both ways are fine.*
- Primary CTA: *See my options*
- Quiet link: *What changed and why*

**Screen 2 — Choose your path** (cards)

- *Get on another flight* — *Today or tomorrow. Any fare difference is shown before you confirm — never as a surprise.*
- *Take travel credit* — *You'll see the credit amount, how long it lasts, and what it can and can't be used for before you confirm.*
- *Talk to a Northstar agent* — *Best if your trip is complicated, you're traveling with someone who needs help, or you'd rather not decide on a screen tonight.* (Wait time rendered live; not hardcoded.)
- Disclosure summary: *Hotel and meal support tonight.* Body: *You may be eligible for an overnight stay and a meal. We'll show what's available for your trip before you confirm anything — no need to pay first and ask later.*

**Screen 3 — Pick a flight**

- Page header: *Flights we can move you to.*
- Default sort chip: *Earliest arrival* (pressed)
- "Recommended" tag is always paired with a reason line, e.g.: *"Recommended" because you said you need to be in NYC tomorrow.*
- Footer note: *Fare difference? Shown on the next screen before you confirm. We won't surprise you with a charge during a cancellation.*
- Always-visible help: *Nothing here works for you? Talk to an agent.*

**Screen 4 — Review &amp; confirm**

- Page header: *Here's what you'll get if you confirm.*
- Primary CTA: *Confirm rebooking* (never "Done" / "Continue")
- Secondary: *Pick a different flight*
- Disclosure summary: *If your plans change after you confirm.* Body: *You can change or cancel this rebooking from your Trips screen. Travel credit, refund, and agent help stay available — they don't disappear because you confirmed.*

**Screen 5 — You're set**

- Page header: *You're set for tomorrow.*
- Subhead: *Saved to your phone so you can open it without signal.*
- Time-anchored next steps (e.g., *Tonight — head to the hotel desk*; *Before your shuttle pickup — we'll text the gate*; *If anything changes — you can change your flight, swap to credit, or reach an agent from this screen — nothing is locked.*)
- Quiet link: *Change my plan*

---

## Accessibility and trust risks (with mitigations)

| Risk | What it looks like | Mitigation in the redesign |
|---|---|---|
| Vague CTA on a high-stakes screen | "Continue" / "Done" with no preview | CTAs name the next outcome: *See my options*, *Confirm rebooking*, *Save to wallet &amp; offline*. WCAG 2.4.4 / 2.4.6 (purpose in context). |
| Status changes that screen readers miss | A "Live" badge that's only visible | The Live badge is announced via `aria-live="polite"`; the save-confirm subhead on Screen 5 is also live. WCAG 4.1.3. |
| Custom-widget filters with no state | Pretty chips with no `aria-pressed` | Filters are real `<button>` elements with `aria-pressed` toggles. Screen reader hears the state, not the styling. WCAG 4.1.2. |
| Color-only meaning | "Earliest arrival" as a green pill | Every pill carries a word, not just a hue. Status ticks on Screen 4 use shape + text, not check-mark color alone. WCAG 1.4.1. |
| Focus path disappearing on a phone | Tappable cards with no visible focus | Cards use real `<button>` elements with a 3-pixel focus ring; tab order follows DOM order. WCAG 2.4.7. |
| Low-bandwidth user gets stuck on a confirmation that won't load | Modal that only works online | Screen 5 saves an offline copy by default; "Save to wallet" is the prominent secondary. WCAG 1.4.10 reflow holds at 320 CSS px. |
| Family / multi-passenger traveler can't tell who got rebooked | One traveler shown when two booked | Screen 1 names passenger count and Screen 4 receipt repeats it. (The brief specifically calls out family / group as a constraint; the redesign respects it but does not yet model split-rebooking. Scoped gap, named below.) |
| Hidden entitlements as a dark pattern | Hotel/meal in "Other policies" FAQ | Entitlements appear on Screen 2 *and* Screen 4; trust-floor language ("no need to pay first and ask later"); no down-funnel surprise. |
| Pressure to confirm | "Trip updated" with no path back | Screen 5's *Change my plan* link and Screen 4's reversibility disclosure name explicitly that confirming is not a one-way door. |
| Choice-architecture manipulation | "Recommended" label without reason; popular-choice tag used as nudge | "Recommended" must carry a reason; "Most people pick this" is allowed only when backed by current behavioral data — otherwise removed. [recommendation] |

**Scoped gaps named, not solved:**

- *Split-rebooking* for groups (e.g., one passenger keeps the original route, one rebooks). The redesign assumes "rebooked together unless you ask otherwise." A more thorough flow needs an agent escalation or a per-passenger control. [assumption]
- *Refund-seeker path.* Travelers who want money back instead of credit need a clearly labeled refund route. Screen 2's "Take travel credit" card mentions it but does not own that journey. The redesign should add a fourth path or a refund toggle inside Screen 2's credit card. [recommendation]
- *Screen-reader-only walkthrough.* Linear reading order has been considered, but the redesign has not yet been tested with a real screen reader. Before launch, run with VoiceOver and TalkBack. [recommendation]

---

## Experiment plan

Three experiments, run sequentially (not in parallel) so a single change can be attributed.

### Experiment A — Plain-language SMS

- **Hypothesis:** Replacing "schedule irregularity" with "Your 6:15 a.m. flight was canceled" plus the recovery hint increases SMS-to-first-tap and reduces support calls from people who opened the SMS but bounced from the app.
- **Primary metric:** First-tap rate from cancellation SMS within 30 minutes of send.
- **Guardrail:** Inbound support call rate per cancellation event. Must not increase by more than 5 percent. [recommendation: tune threshold with the support-ops lead before launch]
- **Exit rule:** End at 4 weeks or 1,500 cancellation SMS sends, whichever comes first. Stop early if the guardrail breaches twice in a 48-hour window.

### Experiment B — Three honest paths vs. tabs

- **Hypothesis:** Replacing the three-tab Recovery screen with three equal-weight cards (with consequence summaries) increases self-service recovery completion and reduces "stuck-in-credit" calls where the user picked credit by accident.
- **Primary metric:** Percentage of cancellation events that complete a recovery action (rebook OR credit OR refund OR agent-routed) without contacting an agent for that same event later.
- **Guardrail:** Credit and refund completion rates must remain at parity or higher with the current tab flow. If credit collapses by more than 10 percent it suggests the new copy is steering people away, which is unacceptable. [recommendation]
- **Exit rule:** End at 4 weeks or 3,000 cancellation sessions, whichever comes first. Hold the experiment if the credit-collapse guardrail trips for two consecutive weeks.

### Experiment C — Inline hotel and meal support

- **Hypothesis:** Surfacing eligibility for hotel and meal support on Screen 2 and Screen 4 (rather than burying it in an FAQ) reduces (a) "where's my hotel" support calls within four hours of confirmation and (b) out-of-pocket reimbursement requests filed in the following week.
- **Primary metric:** Combined support-call + reimbursement-request rate for hotel/meal topics per overnight-eligible cancellation.
- **Guardrail:** Ineligible hotel claims (system flagged "not eligible" but user proceeded anyway) must not rise. If the inline check is too generous, it generates support load on the *back* of the funnel.
- **Exit rule:** End at 6 weeks or 1,000 overnight-eligible cancellation events, whichever comes first.

### What would change our mind on the whole redesign

- If first-tap rate rises but call volume rises in lockstep, the SMS is leading people to a flow that still fails them — go back to Screen 2's choice architecture, not the SMS.
- If self-service completion rises while refund/credit completion drops sharply, we have a steering problem in the choice screen and the new copy is doing harm.
- If accessibility audit (Axe + manual screen reader pass) finds any blocker we can't fix inside the artifact, hold the launch and treat the prototype as failed — not the experiment.

---

## Notes on what is and isn't asserted

Where the prototype shows specific values — flight arrival times, layover length, seat assignments, "fare difference: none" — those are the system's current answer for *this* traveler in the scenario, not blanket policy. The cancellation-rebooking-without-fare-difference *behavior* is a [recommendation] to operations; the prototype shows what the screen looks like when that recommendation is in place. If operations cannot honor it, the screen still works — the fare-difference line surfaces a real number instead of "None," and the surprise-free principle still holds.

Hotel and meal eligibility is shown as a system-determined state per traveler, not a guaranteed entitlement. The redesign does not invent how that eligibility is calculated; it only fixes how it is *surfaced* once the system has answered.

The "Most people pick this" descriptor on Screen 2's rebook card is a behavioral-data claim and should be backed by current data or removed. It is not a manipulator if it's true; it is a manipulator if it's decorative.
