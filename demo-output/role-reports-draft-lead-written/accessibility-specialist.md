# Accessibility Specialist — Northstar Canceled-Flight Recovery

**Role:** Accessibility Specialist (CPACC/WAS-aligned review)
**Scope:** SMS entry + 5 screens (Trip Status, Recovery Options, New Flights, Support, Confirmation)
**Standards cited:** WCAG 2.1 AA, with 2.2 additions where relevant
**Context assumptions:** Mobile-first, 10:46 p.m., tired traveler, possible screen reader, possible low bandwidth, possibly traveling with family

---

## Top 3 Findings

1. **Status changes are invisible to screen-reader and low-vision users.** The current flow communicates a cancellation, default tab choice, fare differences, and "trip updated" outcomes purely visually. With no `aria-live` / status region and no semantic announcement, a screen-reader user does not know the flight is canceled, that "Travel credit" is selected by default, or that the confirmation actually succeeded. **WCAG 4.1.3 Status Messages (AA), 1.3.1 Info and Relationships (A).** *Blocker.*

2. **Hotel and meal entitlements buried under a collapsed "Other policies" disclosure are functionally inaccessible under stress and to AT users.** Disclosure widgets without proper `aria-expanded` state, descriptive triggers, and visible focus become invisible to switch/voice/screen-reader users — and to tired sighted users too. This is the difference between a family sleeping in an airport and a family in a hotel. **WCAG 2.4.6 Headings and Labels (AA), 3.3.2 Labels or Instructions (A), 4.1.2 Name, Role, Value (A).** *Blocker.*

3. **"Continue", "Done", "View details", "Recommended", "Schedule irregularity" — non-descriptive labels and link text fail users who scan, who navigate by headings/links, and who are cognitively loaded.** A screen-reader user pulling up a links list at 10:46 p.m. hears "Continue, View details, Done" and has no idea what any of them do. **WCAG 2.4.4 Link Purpose (A), 2.4.6 Headings and Labels (AA), 3.3.2 Labels or Instructions (A).** *Major.*

---

## Evidence Labels

- **[Observed from brief]:** Screen sequence, copy, defaults (Travel credit), "Recommended" tag without explanation, fare-difference shown during disruption, hotel/meal buried in FAQ, "Continue"/"Done" buttons, single SMS without next step.
- **[Inferred]:** Likely no `aria-live` regions, likely no visible focus styles, likely tab-based UI without proper `role="tablist"` and arrow-key navigation, likely color-only meaning for "Recommended" tag, likely small touch targets on flight cards.
- **[Assumption]:** The user opens the link on a phone, in bed or in transit, with bandwidth degraded, and may have low vision, may be a screen-reader user, may be a switch/voice user, may be using OS-level large text or zoom.
- **[Recommendation]:** Treat every state change as an announced status; promote entitlements above the fold; rewrite all action labels to describe consequences; size all targets ≥44×44pt; never rely on color or position alone; offer an offline/text summary at confirmation.

---

## Current-Flow Blockers (specific)

### Entry SMS — "Schedule irregularity on NS482. Manage trip: link"
- **Plain-language failure** for cognitive accessibility: "schedule irregularity" is jargon that obscures the event. **WCAG 3.1.5 Reading Level (AAA, but baseline for distress moments).**
- **No context for screen-reader preview cards**: when the SMS link is previewed by VoiceOver/TalkBack, the title that loads must announce the actual event, not "Manage trip." **WCAG 2.4.2 Page Titled (A).**
- **Recommendation:** "Your 6:15 a.m. Northstar flight NS482 (DEN→LGA) tomorrow has been canceled. Tap to see your options, including rebooking and hotel help: [link]"

### Screen 1: Trip Status
- **Single `<h1>` semantic miss [inferred]**: "Your itinerary has changed" likely renders as styled text, not `<h1>`. A screen-reader user navigating by headings (rotor/H key) lands nowhere. **WCAG 1.3.1, 2.4.6.**
- **"Continue" button label has no consequence** [observed]. **WCAG 2.4.6, 3.3.2.** Replace with: "See your rebooking options" (or whatever the next screen actually offers).
- **"View details" link** [observed] is the canonical failure pattern for **2.4.4 Link Purpose (A)** — out of context it means nothing.
- **No live announcement** that the page state represents a cancellation event. **WCAG 4.1.3.**

### Screen 2: Recovery Options (tabs)
- **Tab default = "Travel credit"** [observed]. From an accessibility lens this is *also* a cognitive-load failure: a tired user on the "credit" tab may believe a paid flight has become a credit, and either accept or panic. **WCAG 3.2.4 Consistent Identification (AA)** is fine, but **3.3.2 Labels or Instructions** is violated because tab labels don't disclose consequences.
- **Tab pattern** [inferred] likely missing `role="tablist"`, `role="tab"`, `aria-selected`, `aria-controls`, arrow-key navigation. Screen-reader users hear three unrelated buttons. **WCAG 4.1.2 Name, Role, Value (A).**
- **No hotel/meal entry point on this screen.** Forces users into a discovery hunt. **WCAG 3.3.2.**
- **"Standby" label** [observed] does not communicate that it is *not* a confirmed seat. Under stress this is a Major comprehension failure. **WCAG 3.3.2.**

### Screen 3: New Flights
- **"Recommended" badge without explanation** [observed]: if conveyed by color or shape alone, fails **WCAG 1.4.1 Use of Color (A)**. Even with text, fails **3.3.2** — recommended *why*? Earliest? Cheapest? Most reliable? A screen reader announces "Recommended" with no programmatic relationship to the flight it labels (likely **1.3.1**).
- **"$84 fare difference" during disruption** [observed]: not an accessibility law violation, but for cognitive accessibility under distress, presenting a charge without explaining whether it applies in a cancellation is a classic anxiety trigger. Note for content-designer.
- **Flight cards** [inferred] likely use `<div>` tappable areas — not buttons/links. Voice control ("tap 7:10 a.m.") and switch control will fail. **WCAG 4.1.2, 2.1.1 Keyboard (A).**
- **No filters for arrival window, nonstop, mobility, party size** [observed]. For travelers with mobility/medical needs, this forces card-by-card scanning. **WCAG 2.4.5 Multiple Ways (AA)** — and a real-world inclusion issue for travelers with assistive equipment or service animals.
- **Touch target size** [inferred]: likely under 44×44pt on the inline secondary actions ("View details," fare info). **WCAG 2.5.5 Target Size (AAA in 2.1; 2.5.8 Target Size Minimum 24×24 AA in 2.2).** Mobile baseline 44×44pt.

### Screen 4: Support (collapsed FAQ "Other policies")
- **Disclosure pattern** [inferred] likely missing `aria-expanded`, may not be keyboard-operable, and the trigger label "Other policies" violates **2.4.6**. A screen-reader user hears "Other policies, button" and skips it.
- **Burying entitlements** [observed]: this is a dignity and trust failure as much as a WCAG one. Users with cognitive disabilities and users in distress will not dig.
- **No way to request hotel/meal as a confirmed action** [observed] — at most, the FAQ describes rules. Need an actionable, named control: "Request hotel voucher" with announced result. **WCAG 3.3.2, 4.1.3.**

### Screen 5: Confirmation
- **"Trip updated. Your changes have been applied."** [observed]: meaningless to a screen-reader user *and* an exhausted sighted user. No new flight number, no time, no terminal, no hotel, no next step, no offline backup.
- **No `role="status"` or live-region announcement** that the change actually succeeded. **WCAG 4.1.3.**
- **No printable / SMS / email backup** for low-bandwidth and offline scenarios — accessibility includes situational disability.
- **"Done" button label** does not say what "Done" leads to (home? logout? trip?). **WCAG 2.4.6.**

---

## WCAG 2.1/2.2 Concerns by Criterion

| WCAG # | Name | Level | Where it bites | Required fix |
|---|---|---|---|---|
| 1.1.1 | Non-text Content | A | "Recommended" badge icon, status icons | Provide programmatic text alternative; do not use icon-only state |
| 1.3.1 | Info and Relationships | A | Tab structure, flight cards, headings | Proper semantic HTML; `role=tablist`, headings, lists |
| 1.3.5 | Identify Input Purpose | AA | Any contact-info field for hotel/voucher | `autocomplete="email"`, `tel`, `name` |
| 1.4.1 | Use of Color | A | "Recommended" badge, fare colors | Add text label + icon shape |
| 1.4.3 | Contrast (Minimum) | AA | Secondary text, disabled buttons, badges | ≥4.5:1 body, ≥3:1 large; partner with visual-designer |
| 1.4.4 | Resize Text | AA | Flight cards, tab labels | Layout must survive 200% zoom without horizontal scroll |
| 1.4.10 | Reflow | AA | All screens at 320 CSS px | No 2-D scroll at 320px |
| 1.4.11 | Non-text Contrast | AA | Tab indicators, focus rings, badges | ≥3:1 against adjacent colors |
| 1.4.12 | Text Spacing | AA | Flight cards | Layout must survive increased line/letter spacing |
| 1.4.13 | Content on Hover/Focus | AA | Any tooltip on "Recommended"/fare | Dismissible, hoverable, persistent |
| 2.1.1 | Keyboard | A | Flight cards, tab UI, disclosure | All operable via keyboard |
| 2.1.2 | No Keyboard Trap | A | Any modal (e.g., confirm rebook) | Esc closes; focus returns |
| 2.4.1 | Bypass Blocks | A | Repeated header on each screen | Skip link / landmarks |
| 2.4.2 | Page Titled | A | Each screen title in browser/app | Title reflects cancellation context |
| 2.4.3 | Focus Order | A | Tabs → flight cards → confirm | Logical, follows visual order |
| 2.4.4 | Link Purpose (In Context) | A | "View details", "Other policies" | Replace with descriptive text |
| 2.4.6 | Headings and Labels | AA | "Continue", "Done", "Other policies" | Action-describing labels |
| 2.4.7 | Focus Visible | AA | Tabs, cards, buttons | ≥3:1 focus indicator; partner with visual-designer |
| 2.4.11 | Focus Not Obscured (Min) | AA (2.2) | Sticky bottom CTA | Focused element must not be hidden by sticky bar |
| 2.5.3 | Label in Name | A | Buttons with visible text | Accessible name must include visible label (voice control) |
| 2.5.5 | Target Size (Enhanced) | AAA (aim for) | All taps | 44×44pt baseline |
| 2.5.8 | Target Size (Minimum) | AA (2.2) | All taps | ≥24×24 CSS px, spacing if smaller |
| 3.1.5 | Reading Level | AAA | SMS, screen copy | Plain language (~grade 6–8) under distress |
| 3.2.1 | On Focus | A | Tabs, selects | No surprise context change on focus |
| 3.2.2 | On Input | A | Tab selection auto-loading content | Should be expected pattern, or warn |
| 3.2.4 | Consistent Identification | AA | "Back", "Help" across screens | Consistent labels and icons |
| 3.3.1 | Error Identification | A | Rebook errors (sold out, payment) | Plain text error tied to field, live-announced |
| 3.3.2 | Labels or Instructions | A | Tabs, buttons, fare difference | Explain consequence before action |
| 3.3.3 | Error Suggestion | AA | Rebook errors | Suggest next action ("Try 2:40 p.m. flight") |
| 3.3.4 | Error Prevention | AA | Confirming rebook | Confirm step + reversible where possible |
| 4.1.2 | Name, Role, Value | A | Custom tabs, cards, disclosure | Use real semantics or proper ARIA |
| 4.1.3 | Status Messages | AA | Tab switch, fare update, "trip updated" | `role="status"` / `aria-live="polite"`; `assertive` only for true errors |

**WCAG 2.2 specific:** 2.4.11 Focus Not Obscured, 2.5.7 Dragging Movements (n/a here), 2.5.8 Target Size Minimum, 3.2.6 Consistent Help (place "Call support" identically across screens), 3.3.7 Redundant Entry (don't ask the user to re-type info they already provided), 3.3.8 Accessible Authentication (if rebooking re-auths, no cognitive function test like CAPTCHA).

---

## Assistive-Tech Implications

### Screen reader (VoiceOver / TalkBack on mobile)
- **First announcement on Screen 1 must be:** "Northstar Air. Heading level 1: Your 6:15 a.m. flight tomorrow is canceled." Not "Your itinerary has changed."
- **Tab switches must announce** the new state via `aria-live="polite"` region: "Showing rebooking options. 5 available flights."
- **Flight cards** must be a single focusable element each, with the entire card as the accessible name: "Flight option 1 of 3. 7:10 a.m. tomorrow. One stop in Chicago. Arrives 3:40 p.m. Eastern. No extra cost. Recommended because it gets you there earliest. Button."
- **Confirmation** must announce: "Success. You're rebooked on the 2:40 p.m. flight tomorrow. Hotel confirmed at [name]. Confirmation sent to your phone."

### Switch control / external keyboard
- Tab order must be: header → status announcement → primary recovery action → flight list → support entry → call support. No off-screen focus stops. No traps.
- Single-switch users must reach "Call support" within a reasonable scan count from any screen — pin it to a consistent location.

### Voice control (Voice Control / Voice Access)
- All visible button text must match the accessible name (**2.5.3 Label in Name**). "Tap See rebooking options" must work because that string is the visible label.
- Avoid icon-only buttons. If unavoidable, provide `aria-label` that matches a likely spoken phrase ("Close," not "Dismiss modal X-out").

### Large text / zoom (200%+) and OS dynamic type
- Flight cards must reflow vertically without truncation; do not lock height. Time, route, stops, fare, recommendation reason must all remain visible.
- Sticky bottom CTAs must not cover focused content (**2.4.11**).
- No text in images.

### Low vision / contrast sensitivity
- "Recommended" badge: ≥4.5:1 text on background, ≥3:1 badge against card background. Do not rely on a colored chip alone — pair with an icon and text.
- Focus ring: ≥3:1 against both the focused element and its surrounding background. (Partner: visual-designer.)

### Cognitive / situational disability (the 10:46 p.m. tired traveler is *every* user here)
- Reduce decisions per screen. One primary action, max two secondary.
- Show consequences before commitment ("This will rebook you and cancel your original ticket. No charge.").
- Reversibility: a 60-second "undo rebook" window with a clear status message.
- Plain language (~grade 6–8).

---

## Inclusive Design Fixes (cognitive load, stress, fatigue, low bandwidth, family)

1. **Lead with the event, not the system.** "Your flight is canceled. Here's what we can do." Not "Your itinerary has changed."
2. **Surface entitlements at decision time.** A persistent "Hotel + meal help available" pill on the recovery screen. Tappable, named control, not buried.
3. **Default the tab to "New flights,"** the option that matches almost every cancellation user's goal. Make "Travel credit" reachable, not default. (Partner: behavioral-scientist on framing; this is also an accessibility-of-comprehension issue.)
4. **Explain "Recommended" inline.** "Recommended: gets you there earliest with no extra cost." Plain text, programmatically associated with the flight card.
5. **Family-aware copy.** "Rebooking for all 3 travelers on this reservation." Confirms scope; reduces panic of "did I just rebook only myself?"
6. **Offline backup.** Send the final itinerary, hotel address, and a support number via SMS *and* render it as a copyable text block on Screen 5. Bandwidth, dead battery, no signal at the hotel — all common.
7. **One call-support affordance, consistently placed.** Same spot, same label ("Call Northstar support"), every screen (**WCAG 3.2.6 Consistent Help**, 2.2 AA).
8. **No time pressure on choices.** No "this offer expires in 4:59." If hold timers are required for inventory, announce and offer extension (**WCAG 2.2.1 Timing Adjustable, A**).
9. **Error states with recovery.** If a flight sells out mid-flow, announce assertively, name the alternative, do not dump the user.
10. **Reduce-motion default.** Any loading shimmer, success confetti, or screen transitions must respect `prefers-reduced-motion`. Distress + vestibular triggers do not mix.

---

## Handoffs Sent

> Note: SendMessage tool not available in this run; messages drafted below for delivery to teammates and the team lead. These are the explicit handoffs.

### → interaction-designer (state, focus, error recovery)

**Subject: State-level a11y requirements you'll need in your state list**

1. **Every state change needs an announced status.** Cancellation arrival, tab switch, rebook submitted, rebook confirmed, hotel requested, hotel confirmed, error. Use `role="status"` / `aria-live="polite"` for routine; `aria-live="assertive"` (or `role="alert"`) *only* for true blockers (sold out, payment failed). Map this to your state list as a "what announces?" column.
2. **Focus management on navigation:** when a new screen loads, move focus to the new `<h1>`. When a modal opens (confirm rebook, request hotel), trap focus inside; on close, return focus to the trigger. Escape closes modals.
3. **Error recovery is a first-class state, not an edge case.** Inventory sold out, payment declined, network failure, session expired — each needs (a) a named state, (b) an announced message, (c) a primary recovery action, (d) a path to human support.
4. **No keyboard traps in the tab pattern.** If you keep tabs, use the WAI-ARIA Authoring Practices tab pattern (Tab in/out of the tablist, arrow keys within). Otherwise prefer a segmented control with clear consequence labels.
5. **"Undo rebook" window** (~60s) as a real state, with live status message, before destructive confirmation.
6. **Persistent "Call support" affordance** as a global state-independent control (WCAG 3.2.6).

### → visual-designer (contrast, target size, hierarchy under stress)

**Subject: Visual a11y requirements before you finalize**

1. **Contrast minimums:** body text ≥4.5:1, large text (≥18.66px regular / 14px bold) ≥3:1, non-text UI (icons, focus rings, badge edges, tab indicators) ≥3:1. Test the "Recommended" badge and the "$84 fare difference" pill specifically — these are the highest-risk components.
2. **Focus indicator:** ≥3:1 against both focused element and adjacent background, ≥2px thick, offset for clarity. Cannot be color-only.
3. **Target size:** 44×44pt baseline (WCAG 2.5.5 AAA / iOS HIG); minimum floor 24×24 CSS px with spacing (WCAG 2.5.8 AA in 2.2). Flight cards, tabs, "Request hotel," and any close/dismiss controls.
4. **Don't rely on color alone.** "Recommended," fare diff direction (+/−), confirmed vs. pending — pair color with text and a shape/icon (WCAG 1.4.1).
5. **Hierarchy under fatigue:** one dominant CTA per screen. Secondary actions clearly subordinate but not invisible. Tertiary (help, support) discoverable, never hidden behind hover.
6. **Reflow:** must work at 320 CSS px wide and 200% zoom without 2-D scroll (WCAG 1.4.10, 1.4.4).
7. **Reduce-motion default** on any transition, shimmer, or confetti.
8. **Sticky bottom CTA must not obscure focused content** (WCAG 2.4.11, 2.2 AA).

### → content-designer (plain language, screen-reader friendliness, link text)

**Subject: Copy/phrasing a11y blockers — fix these before lock**

1. **Plain language at distress reading level (~grade 6–8).** "Schedule irregularity" → "canceled." "Your itinerary has changed" → "Your 6:15 a.m. flight tomorrow is canceled."
2. **Action labels must describe consequence.** "Continue" → "See rebooking options." "Done" → "Go to my trip" or "Close." "View details" → "See cancellation reason and your rights." "Other policies" → "Hotel and meal help."
3. **Link text must stand alone** (WCAG 2.4.4). Screen-reader users pull link lists out of context. "View details" fails; "See your rebooking options" passes.
4. **Explain badges and tags in words.** "Recommended" alone is empty; "Recommended: earliest arrival, no extra cost" carries meaning.
5. **Standby clarity.** "Standby" must say "Standby — not a guaranteed seat" inline, not in a tooltip.
6. **Confirmation copy must list facts.** New flight number, time, terminal, hotel, confirmation code, support number. The current "Your changes have been applied" is functionally meaningless to AT users and to tired sighted users.
7. **Error copy:** what happened (plain), why (if relevant), what to do next (named action). Three sentences max.
8. **SMS copy must lead with the event:** "Your 6:15 a.m. Northstar flight NS482 (DEN→LGA) tomorrow has been canceled. Tap for options, including hotel help: [link]"
9. **Family/party-aware phrasing** where applicable: "for all 3 travelers."
10. **Avoid idioms and metaphors** in alerts ("hang tight," "we've got you covered") — these poll badly with screen readers and translate poorly.

### → team-lead (status)

**Subject: Accessibility specialist — status**

**Top 3 findings:**
1. Status messages absent across the flow — screen-reader users do not know the flight is canceled, the default tab, or that the rebook succeeded. WCAG 4.1.3 / 1.3.1.
2. Hotel/meal entitlements buried in a collapsed FAQ — functionally inaccessible to AT users and to tired sighted users alike. WCAG 2.4.6, 3.3.2, 4.1.2.
3. Non-descriptive labels everywhere — "Continue," "Done," "View details," "Recommended," "Schedule irregularity." WCAG 2.4.4, 2.4.6, 3.3.2.

**One tension:** Behavioral-scientist may want a friction step ("Are you sure you want to rebook?") to reduce regret. I support intentional friction, but it cannot become a modal trap, a time-pressured choice, or a CAPTCHA-style cognitive test. I will require: focus management on open/close, escape key, plain-language stakes, no countdown timer, and a parallel "Call support" path. Will negotiate the exact pattern with interaction-designer.

**Messaged:** interaction-designer, visual-designer, content-designer.

---

## Handoffs Received

| Sender | Message | What Changed |
|---|---|---|
| _(none received at time of writing — will integrate inbound from visual-designer and content-designer when they arrive; recommendations above are written to be additive, not contradictory.)_ |  |  |

---

## "What This Feels Like" — Blocker Narratives

### Blocker 1 — Status messages absent (screen-reader user)
*I'm in bed. My phone buzzes. I tap the link, my screen reader starts reading: "Northstar Air. Your itinerary has changed. We are sorry for the inconvenience. Continue, button. View details, link." That's it. I don't know what happened. Did they move my flight an hour? Cancel it? Move me to a different airport? I tap Continue because there's nothing else. New page. "Travel credit, selected." Selected for what? Did I just give up my flight for a credit? I tap back. The page reloads. Nothing announces. I call support, because the app won't tell me what is happening to me.*

### Blocker 2 — Hotel entitlement buried (cognitively loaded sighted user, plus AT user)
*I'm exhausted. I've found a flight for tomorrow afternoon. Now what? I scroll. There's an FAQ that says "Other policies." I don't read FAQs at 11 p.m. I book a $240 hotel on my own card. The next morning I find out Northstar would have given me a voucher. I am angry, and I will not trust this app next time — I'll just call.* For a screen-reader user, the same FAQ disclosure may not even announce as expandable, so the entitlement is invisible.

### Blocker 3 — Non-descriptive labels (voice-control and cognitively loaded users)
*I use Voice Control because my hands shake. I say "Tap See rebooking options." Nothing happens — the button says "Continue." I say "Tap Continue." It works, but I don't know what I just did. The next screen has three tabs with no consequences explained. I say "Tap New flights." I don't know if I just canceled my original ticket.*

---

## What I Couldn't Assess Without Live Testing

- Real screen-reader announcement timing (does `aria-live="polite"` interrupt or wait — varies by AT version)
- TalkBack vs. VoiceOver behavior differences on the tab pattern
- Switch-control scan counts to reach "Call support" in practice
- Actual contrast ratios — depends on visual-designer's final palette
- Whether the tab UI is built as `<button>`s, `<a>`s, or `<div>`s under the hood
- Network-degraded behavior of `aria-live` regions when content streams in late
- Vestibular impact of any actual motion (need to see the prototype)
- Whether the SMS arrives with a usable preview title in iOS Messages / Android Messages

---

## Recommendation

Adopt the following as **non-negotiable accessibility guardrails** in the redesigned flow:

1. **Every state change has an announced status.** No silent UI transitions.
2. **Hotel and meal help is a first-class, named action on the primary recovery screen** — not a disclosure, not an FAQ.
3. **Every action label describes its consequence.** No "Continue," "Done," "View details," "Other policies."
4. **Default the recovery tab to "New flights"** unless brief instructions say otherwise.
5. **44×44pt targets, ≥4.5:1 text contrast, ≥3:1 non-text contrast, visible 2px+ focus ring, reduce-motion default.**
6. **Plain language at ~grade 6–8** across every screen and the SMS.
7. **Persistent, consistently placed "Call Northstar support"** (WCAG 3.2.6 Consistent Help).
8. **Offline backup** — itinerary and support number rendered as copyable text and sent via SMS at confirmation.
9. **Reversibility window** (~60s undo) on destructive rebooking, with live status announcement.
10. **No time pressure** on cognitive choices; if inventory holds are required, make timing adjustable (WCAG 2.2.1).

---

## Risks

- **Risk:** Adding announced status everywhere can become verbose for screen-reader users (announcement fatigue). *Mitigation:* prioritize — announce events that change state or surface new information; do not announce decorative changes.
- **Risk:** Default tab change ("Travel credit" → "New flights") may conflict with a business policy I can't see. *Mitigation:* flag for team lead; if travel-credit-default is a hard requirement, require an inline explainer at minimum.
- **Risk:** "Undo rebook" window may be technically infeasible against live inventory. *Mitigation:* if so, replace with stronger pre-commit confirmation that includes plain-language stakes — but not a modal trap.
- **Risk:** Hotel/meal entitlements made prominent may raise legal review concerns (over-promising). *Mitigation:* content-designer to phrase as "see if you qualify for hotel help" rather than guaranteeing, while still surfacing the entry point prominently.

---

## Open Questions

1. Will the tab pattern survive into the redesign, or will interaction-designer replace it? My WCAG findings change shape (tab roles vs. radio-segment vs. accordion).
2. Is there a hold/inventory timer required for rebooking? If so, we need 2.2.1 Timing Adjustable plus a visible, announced countdown.
3. Does Northstar's design system already define focus rings and target sizes? If yes, do they meet 1.4.11 / 2.5.8?
4. What's the actual support phone hours/SLA — so we can phrase "Call support" honestly?
5. Does the SMS pipeline support a usable link preview / page title?
6. Is there a confirmed list of party members on the reservation we can surface (for family context)?
