# Accessibility Specialist — Northstar Canceled-Flight Recovery

**Reviewer:** Accessibility Specialist (CPACC / WAS)
**Standard:** WCAG 2.1 AA (with 2.2 additions where applicable)
**Surface:** Mobile-first web/app, late-night SMS entry, distress context
**Scope:** SMS + 5-screen flow described in brief
**Date:** 2026-05-13

> **Label key (per team-lead spec):**
> `[observed]` = drawn directly from the brief.
> `[inferred]` = strongly implied by the brief but not stated.
> `[assumption]` = filling a gap; should be validated.
> `[recommendation]` = my proposed fix.

---

## Top 3 Findings (do these first)

1. **The SMS and Screen 1 deny the user the information they need to make a single decision** `[observed]`. "Schedule irregularity" and "Your itinerary has changed" are euphemisms; for a screen-reader user at 10:46 p.m. who hears the alert in a single VoiceOver swipe, there is *no event, no time pressure, no entitlement, and no next step* in the announced text. This violates **3.1.5 Reading Level**, **3.3.2 Labels or Instructions**, and the spirit of **2.4.6 Headings and Labels**. **Fix first**: rewrite the SMS and H1 to name the event, the flight, and the next action in plain language under 25 words. `[recommendation]`

2. **Hotel and meal entitlements are buried inside a collapsed FAQ** `[observed]`. For users with cognitive disability, low literacy, low bandwidth, or screen-reader users who cannot scan visually, hidden disclosure under a vague label ("Other policies") functionally removes the entitlement. This is a **3.3.2** failure and a **2.4.6** failure (the disclosure label does not describe its content), and creates a real-world equity harm beyond conformance. **Fix first**: surface support entitlements as a persistent, named region on the recovery screen with explicit eligibility status. `[recommendation]`

3. **"Continue," "Done," and "Recommended" are non-descriptive controls** `[observed]`. A screen-reader user navigating by buttons hears `"Continue, button"` with no context — a **2.4.4 Link Purpose (In Context)** and **2.4.9 Link Purpose (Link Only)** failure, and for "Recommended" without an accessible explanation, a **1.3.1 Info and Relationships** failure (the visual badge carries meaning that is not programmatically conveyed). **Fix first**: rewrite every primary action to name its outcome ("Rebook on 7:10 a.m. flight"); make the "Recommended" badge a programmatic label tied to a tooltip/expandable rationale.

---

## Current-Flow Blockers (specific, by screen)

### Entry SMS — `"Northstar Alert: Schedule irregularity on NS482. Manage trip: link"`

- **Blocker — Plain-language failure** `[observed]`. "Schedule irregularity" is jargon. The user cannot tell from the SMS alone whether the flight is delayed, canceled, gate-changed, or rebooked. **3.1.3 Unusual Words / 3.1.5 Reading Level.**
- **Blocker — Link text is "link"** `[observed]`. Many SMS clients announce the URL itself, but if the message is read by an assistant ("Hey Siri, read my texts"), the user hears "link" with no purpose. **2.4.4 Link Purpose.**
- **Major — No identification of sender authority or scam signal** `[inferred]`. Travelers under stress at 10:46 p.m. are exactly the population targeted by phishing; an unauthenticated link increases abandonment. Not a WCAG criterion, but a cognitive-accessibility / trust failure that drives users to call. `[recommendation]` Use a verified sender, include the last 4 of confirmation code, and never include a bare "link" word.

### Screen 1: Trip Status

- **Blocker — Heading does not name the event** `[observed]`. "Your itinerary has changed" is a euphemism for "canceled." **2.4.6 Headings and Labels (AA)** requires headings to describe topic or purpose. A screen-reader user navigating by H1 lands on a heading that does not match the urgency. `[recommendation]` H1: "Your 6:15 a.m. flight to LGA is canceled."
- **Blocker — "Continue" button has no programmatic purpose** `[observed]`. **2.4.4** and **2.5.3 Label in Name (A)** — the accessible name should match (or contain) the visible label and the consequence.
- **Major — "View details" is a secondary link with low affordance** `[observed]`. Screen-reader users may miss it; sighted low-vision users may not see contrast. **1.4.3 Contrast (Minimum)** `[assumption]` — link color contrast not specified in brief; flag for visual-designer-2.

### Screen 2: Recovery Options (3 tabs)

- **Blocker — Default tab "Travel credit"** `[observed]`. For a user trying to *get to a family event tomorrow*, defaulting to a non-travel option is a **3.2.4 Consistent Identification** concern *and* a cognitive-accessibility failure: the path of least resistance is the wrong path. `[recommendation]` Default to "New flights." If business needs to surface credit, do it as a peer card, not the active tab.
- **Blocker — Tab labels do not convey consequences** `[observed]`. "Standby" and "Travel credit" are industry terms. **3.1.3 Unusual Words.** `[recommendation]` "Rebook on a new flight," "Take a refund as travel credit," "Wait for an open seat (standby)."
- **Major — Tabs implementation must follow APG pattern** `[assumption]`. **4.1.2 Name, Role, Value** — tabs need `role="tablist"`, `role="tab"`, `aria-selected`, `aria-controls`; arrow-key navigation between tabs; activated panel must be reachable. Cannot verify without code.
- **Major — Hotel/meal support absent from this screen** `[observed]`. Forces the user to discover entitlements elsewhere. **3.3.2 Labels or Instructions.**

### Screen 3: New Flights

- **Blocker — "Recommended" is visual-only meaning** `[observed]`. **1.3.1 Info and Relationships (A)** and **1.4.1 Use of Color (A)** if conveyed by badge color alone. The screen-reader user hears the time but not the recommendation rationale. `[recommendation]` `aria-describedby` linking to "Recommended because it arrives by 9:30 a.m. and matches your original arrival window."
- **Blocker — Fare difference appears during disruption recovery** `[observed]`. Not strictly a WCAG failure, but for users with cognitive disability or under acute stress, an unexpected charge during recovery causes decision paralysis. `[recommendation]` Suppress fare difference during *involuntary* disruption, or label it explicitly as "No charge — airline-paid rebooking." Coordinate with content-designer-2 and behavioral-scientist-2.
- **Major — No filter for mobility needs, travel party, arrival time** `[observed]`. Excludes users with disabilities and caregivers. Not a single WCAG criterion, but a direct equity gap.
- **Major — Flight cards must be a list with proper structure** `[assumption]`. **1.3.1**. Each card needs heading-level for the time, programmatic grouping, and a single primary action whose accessible name names the flight ("Rebook on 7:10 a.m. one-stop arriving 1:42 p.m.").
- **Major — Touch target sizing on flight cards** `[assumption]`. **2.5.5 Target Size (Enhanced, AAA)** and the new **2.5.8 Target Size (Minimum, AA, WCAG 2.2)** — minimum 24×24 CSS px with adequate spacing. Recommend 44×44 baseline.

### Screen 4: Support (FAQ "Other policies")

- **Blocker — Entitlements hidden behind disclosure with vague label** `[observed]`. **2.4.6 Headings and Labels** and **3.3.2 Labels or Instructions**. "Other policies" is the classic anti-pattern — sighted users skim past, screen-reader users have no reason to expand.
- **Blocker — No status indication of what the user is entitled to** `[observed]`. **4.1.3 Status Messages (AA)** — when eligibility is determined, it should be announced via a live region, not buried in static FAQ.

### Screen 5: Confirmation

- **Blocker — "Trip updated" / "Your changes have been applied" gives no recovery information** `[observed]`. **3.3.2 Labels or Instructions** and **3.3.4 Error Prevention (Legal/Financial)** — for a travel transaction, the user must be able to verify the new flight, hotel, baggage, gate, and what to do if it changes again.
- **Blocker — "Done" button leads where?** `[observed]`. **2.4.4 Link Purpose**. `[recommendation]` Replace with a structured summary plus actions: "Add to wallet," "Email me a copy," "Get help."
- **Major — No live-region announcement when confirmation loads** `[assumption]`. **4.1.3 Status Messages**. Screen reader should announce "Booking confirmed. New flight: 7:10 a.m. tomorrow, arriving 1:42 p.m. Hotel voucher applied."
- **Major — No offline backup** `[observed]`. Equity issue for travelers in low-bandwidth airports, those who depend on screen-reader caching, and users whose AT relies on stable network.

---

## WCAG 2.1 / 2.2 Concerns by Criterion

| Criterion | Level | Where it applies | What's wrong | Fix |
|---|---|---|---|---|
| **1.3.1 Info and Relationships** | A | "Recommended" badge; flight cards; tabs | Visual structure not exposed programmatically | Use semantic HTML, `aria-describedby` for badge rationale, list semantics for flight cards |
| **1.4.1 Use of Color** | A | "Recommended" badge `[assumption]` | If recommendation is conveyed by green pill alone | Add icon + text label "Best match" in addition to color |
| **1.4.3 Contrast (Minimum)** | AA | "View details" link, secondary actions, fare-difference text `[assumption]` | Likely below 4.5:1 on disruption screens | Audit with measured values; coordinate with visual-designer-2 |
| **1.4.11 Non-text Contrast** | AA | Tab indicator, focus ring, button borders `[assumption]` | Often <3:1 on neutral backgrounds | Min 3:1 against adjacent colors |
| **2.1.1 Keyboard** | A | Tabs, flight cards, disclosure | Must be operable without mouse `[assumption]` | Verify in code; tabs need arrow-key nav per APG |
| **2.4.3 Focus Order** | A | Modal/sheet patterns if used `[assumption]` | Focus must move to opened sheet, return on close | Manage focus explicitly |
| **2.4.4 Link Purpose (In Context)** | A | "Continue," "Done," "View details," "link" in SMS | Non-descriptive | Rewrite: "Rebook now," "See trip summary," etc. |
| **2.4.6 Headings and Labels** | AA | H1 on Screen 1; "Other policies" disclosure; tab labels | Euphemistic / vague | Name the event, name the section |
| **2.4.7 Focus Visible** | AA | All interactive elements `[assumption]` | Default browser focus often hidden by custom CSS | 3:1 contrast focus ring, never `outline:none` without replacement |
| **2.4.11 Focus Not Obscured (Min)** | AA (WCAG 2.2) | Sticky headers/footers on mobile `[assumption]` | Focused element hidden behind sticky CTA | Add `scroll-padding` or move sticky bar |
| **2.5.3 Label in Name** | A | All buttons | Accessible name must contain visible text | Voice-control users say "Tap Continue" — must work |
| **2.5.5 Target Size (Enhanced)** | AAA | Flight cards, tabs, disclosure | Often <44×44 CSS px on dense lists | Aim for 44×44 baseline |
| **2.5.8 Target Size (Minimum)** | AA (WCAG 2.2) | All controls | Min 24×24 with spacing | Hard floor; 44×44 preferred |
| **3.1.3 Unusual Words** | AAA (but a real harm) | "Schedule irregularity," "Standby," "Travel credit" | Industry jargon | Plain language alternatives |
| **3.1.5 Reading Level** | AAA (but a real harm) | SMS, headings, tab labels | Above 8th grade `[assumption]` | Aim for grade 6 in distress flows |
| **3.2.6 Consistent Help** | A (WCAG 2.2) | Support contact must be in same place across flow | Hotel/meal hidden in FAQ; no consistent "Get help" entry | Persistent, consistently-located "Talk to a person" button |
| **3.3.1 Error Identification** | A | Rebooking failures `[assumption]` | Not described in brief | Errors must be programmatically associated and named |
| **3.3.2 Labels or Instructions** | A | Tabs, FAQ disclosure, confirmation | Missing descriptive instructions | Explain what each path does, what user gets |
| **3.3.4 Error Prevention (Legal/Financial)** | AA | Final rebooking step | Confirmation does not let user verify before submit `[assumption]` | Review-and-confirm step with editable summary |
| **4.1.2 Name, Role, Value** | A | Tabs, custom buttons, badge | Custom controls need ARIA | Tabs follow APG; buttons use `<button>`; badge has accessible text |
| **4.1.3 Status Messages** | AA | Confirmation; eligibility for hotel/meals | No live regions described | `aria-live="polite"` for non-urgent, `assertive` only for urgent |

---

## Assistive-Tech Implications

### Screen reader (VoiceOver / TalkBack / NVDA)

- **Entry experience**: VoiceOver auto-announces the SMS lock-screen banner. The user hears "Northstar Alert: Schedule irregularity on NS482. Manage trip colon link." They cannot tell if action is required tonight. **Rewrite to lead with the verb and the deadline.**
- **Heading navigation**: Screen 1's H1 "Your itinerary has changed" gives no recoverable information when navigating by headings. Same for Screen 5's "Trip updated."
- **Form/button mode**: On many flight cards, navigating button-to-button hears only "Recommended" or "Select." Full context lost.
- **Live regions**: Confirmation must announce on load. If the page transitions client-side, also announce "Page changed: Booking confirmed."

### Switch control / one-switch users

- Tabs requiring arrow-key navigation must also work with sequential scanning. **Default tab being wrong (Travel credit) costs a switch user 30+ scans to correct.**
- Hidden FAQ disclosures multiply scan steps. Each collapsed section is a tax.
- Sticky bottom CTAs that move focus unpredictably are catastrophic — name the destination before moving focus.

### Voice control (Voice Control / Voice Access / Dragon)

- **2.5.3 Label in Name** is binding here. "Tap Continue" must work. If the visible label is "Continue" but the accessible name is "Proceed to next step," voice users get nothing. `[recommendation]` Visible label === accessible name, and ideally rename to "Rebook now" so the spoken command is unambiguous.
- "Recommended" is dangerously ambiguous if there are three flights — "Tap Recommended" needs to disambiguate.

### Large text / 200% zoom / reflow (1.4.4, 1.4.10)

- Flight cards likely break at 320 CSS px width with 200% zoom `[assumption]`. Test with both real device font scaling (iOS Dynamic Type Largest, Android 200%) and browser zoom.
- Sticky bottom CTAs at 200% can cover content; verify with **2.4.11 Focus Not Obscured**.

### Cognitive / distress

- **This is a distress-state flow.** Late-night cancellation, mobile-only, family obligation. Cognitive load is at maximum.
- Decision paralysis is the biggest risk. *Three tabs with the wrong default* multiplies it.
- The "fare difference" line item triggers loss aversion at the worst possible moment.
- `[recommendation]` Single recommended path with two named alternatives, not three peer tabs. Coordinate with interaction-designer-2 and behavioral-scientist-2.

---

## Distress-State Walkthrough — "What this feels like"

> *It's 10:47 p.m. I'm packed. My niece's bat mitzvah is at 11 a.m. tomorrow. The phone buzzes. VoiceOver reads: "Northstar Alert: Schedule irregularity on NS482. Manage trip colon link." I don't know what irregularity means. I tap the link. The page says "Your itinerary has changed." I still don't know what happened. I swipe through three buttons: Continue, View details, Skip. I tap Continue. Now I'm on a tab called Travel credit. I didn't ask for credit. I came here to get on a plane. I swipe and find New flights. There are three. One says "Recommended" — recommended for what? One says "$84" — am I being charged? I'm not sure if I'm allowed a hotel. I scroll and find "Other policies" but I'm too tired to expand it. I close the app and call the 1-800 number. I am on hold for 47 minutes.*

This is the exact path the brief says people take. The accessibility failures and the abandonment failure are the same failure.

---

## Inclusive Design Fixes (consolidated)

1. **Plain-language rewrite of SMS and every heading.** Lead with event, flight, time, deadline.
2. **Default to Rebook.** Make travel credit and standby peer options reachable in one tap, not the front door.
3. **Persistent support panel** with eligibility status surfaced ("Hotel voucher: included. Meal credit: $25.") — `4.1.3` live region on eligibility load.
4. **Every button names its outcome.** "Rebook on 7:10 a.m. flight," "See full trip summary," "Talk to a person."
5. **"Recommended" badge** has icon + text + `aria-describedby` rationale.
6. **Suppress fare difference for involuntary disruption** or explicitly label as "No charge."
7. **Filters for arrival time, nonstop, mobility needs, travel party** — both an equity feature and a cognitive-load reducer.
8. **Confirmation screen is a structured summary**, not "Done." Include flight, hotel, baggage, check-in, what to do if it changes. Offline-backup link (Add to Wallet / Email me a copy).
9. **Consistent "Talk to a person" button** in the same location across all 5 screens (`3.2.6`).
10. **Verify in code**: focus management on screen transitions, live region on confirmation, tab semantics per APG, focus visibility 3:1, target size ≥24×24 (≥44 preferred).

---

## What I Could Not Assess Without Live Testing

- Actual color contrast values (need designs/tokens) — flagged for visual-designer-2.
- Screen-reader announcement timing across iOS/Android/desktop versions.
- Real-world tab/disclosure ARIA implementation (need code).
- Touch target measurements (need spec/build).
- Reflow behavior at 200% / 400% zoom.
- Reduced-motion handling for any transition animations `[assumption]`.
- Whether the app respects iOS Dynamic Type and Android Font Scale.
- Voice Control success rates for real button names.

---

## Peer Handoff Notes (drafted; SendMessage tool unavailable to me — team-lead please relay)

### → interaction-designer-2 (state-level blockers)

> Three state-level issues are blockers for me, in priority order:
> 1. **Default tab on Recovery Options must change from "Travel credit" to "Rebook"** — current default is a path-of-least-resistance trap that disproportionately harms cognitive-load and switch users.
> 2. **Confirmation state needs structured content + live-region announcement**, not a "Done" terminus. The state lacks a verifiable summary, which is both a 3.3.4 and 4.1.3 issue.
> 3. **Modal/sheet states (if used for support, hotel)** must manage focus on open and return on close, with an Escape path and a labeled close button. Please name the focus-management contract in your spec so I can verify.
> Bonus: please define a persistent "Talk to a person" surface present in *every* state (WCAG 2.2 — 3.2.6 Consistent Help).

### → visual-designer-2 (visual blockers)

> Four visual asks I need to flag:
> 1. **Contrast on "View details" and any secondary link / fare-difference text** — please confirm ≥4.5:1 on body text and ≥3:1 on UI/non-text (1.4.3, 1.4.11).
> 2. **Focus indicator** — visible ring with ≥3:1 contrast against both element and background; never `outline:none` without replacement (2.4.7, 2.4.11 for sticky overlap).
> 3. **Touch targets** — flight cards, tab handles, disclosure controls must hit ≥24×24 CSS px (WCAG 2.2 — 2.5.8). I'd prefer 44×44 baseline.
> 4. **"Recommended" badge** must use icon + text, not color alone (1.4.1). And please design a reduced-motion variant for any state transitions or skeleton loaders (prefers-reduced-motion).

### → content-designer-2 (copy / phrasing blockers)

> Six copy blockers, all plain-language / link-text issues:
> 1. **SMS** — replace "Schedule irregularity" with "Your 6:15 a.m. flight tomorrow is canceled." Replace "link" with descriptive purpose.
> 2. **Screen 1 H1** — "Your itinerary has changed" → "Your 6:15 a.m. flight to LGA is canceled." (2.4.6)
> 3. **Tab labels** — replace "Standby" and "Travel credit" with consequence-naming labels: "Wait for an open seat," "Take a refund as travel credit." (3.1.3)
> 4. **Buttons** — every CTA names its outcome: "Continue" → "Rebook on 7:10 a.m. flight"; "Done" → "See trip summary." (2.4.4, 2.5.3)
> 5. **"Recommended"** — needs a one-line explanation eligible for `aria-describedby`. Suggest: "Best match: arrives by your original time."
> 6. **"Other policies"** disclosure — rename to "Hotel and meal support" and surface eligibility as visible text, not a label. (2.4.6)
> Reading-grade target for distress flows: grade 6.

---

## Tension to surface to team-lead

**Tension:** The behavioral-science instinct (from behavioral-scientist-2) will likely be to reduce choice (one recommended path); the accessibility instinct agrees *and* requires that the alternatives remain reachable in one tap, with clearly-named consequences. If the team-lead lets behavioral-science collapse the alternatives behind a "More options" disclosure, we'll have re-created the "Other policies" anti-pattern in a new costume and re-fail 2.4.6 / 3.3.2. **My ask:** alternatives stay visible as named peer cards, not a disclosure.

