# Information Architect Role Report — Northstar Canceled-Flight Recovery

## Jobs-to-be-Done (priority order)

1. **Know what happened, plainly** — the brief calls out that "schedule irregularity" hides the real event. (observed-from-brief)
2. **Choose a recovery option I can compare** — current default (Travel credit) may not match goal; consequences of each option are not labeled. (observed-from-brief)
3. **See support I'm entitled to before I commit** — hotel/meal are buried in "Other policies." (observed-from-brief)
4. **Leave with a portable, offline-readable plan** — current confirmation gives no summary, no offline backup. (observed-from-brief)
5. **Have a path if plans change again** — no re-entry route shown. (observed-from-brief)

Translation to screens: one screen per major decision, plus a confirmation that doubles as a portable record.

## Revised Screen Sequence (5 screens)

### Screen 1 — Cancellation Notice
- **Primary decision:** acknowledge and proceed to options.
- **Above the fold (mobile):** plain headline naming the cancellation; affected flight identifiers; cause in plain language; reassurance that options exist and the user is in the right place.
- **Secondary:** "What happens next" preview (3 bullets: pick recovery, see support, get a confirmation).
- **State change:** none yet; entry point only.
- **Primary CTA:** "See your options."

### Screen 2 — Recovery Options (side-by-side, no default selection)
- **Primary decision:** pick one of three paths.
- **Above the fold:** three labeled cards in this order — **Rebook on Northstar**, **Refund to original payment**, **Travel credit**. Each card states the consequence in one line (e.g., "Get on another Northstar flight," "Money back to your card," "Use later on Northstar"). Standby is demoted to a secondary link beneath, with a one-line clarifier that it is not a confirmed seat. (recommendation; brief notes Standby risks sounding equivalent — observed-from-brief)
- **Secondary:** a persistent "Talk to an agent" link in the footer (visibility, not a push). (recommendation)
- **State change:** selection is provisional; no commitment yet.

### Screen 3 — Choose a Flight (only shown if user picked Rebook)
- **Primary decision:** pick a replacement flight.
- **Above the fold:** filter row (nonstop, arrive by, travel party size); flight list sorted by arrival time by default. (recommendation)
- **Each card shows:** departure, arrival, stop count, seat availability indicator, and a neutral comparator chip (e.g., "earliest arrival," "fewest stops") rather than the unexplained "Recommended" label. (observed-from-brief: "Recommended" is not explained)
- **No fare-difference messaging during disruption recovery.** (observed-from-brief)
- **State change:** flight selected; held but not ticketed until Screen 4.

### Screen 4 — Support & Confirm
- **Primary decision:** review entitlements surfaced for this disruption, then confirm.
- **Above the fold:** a "Support available for this disruption" section that lists categories visibly (overnight accommodation, meals, rebooking assistance, accessibility/mobility) as line items with eligibility shown as {system-supplied per booking} status. If the booking is not eligible for a given item, the line shows the ineligibility plainly rather than being hidden. (recommendation; addresses brief's "Entitlements are hidden")
- **Secondary:** review of the selected recovery option (flight summary or refund/credit summary).
- **State change:** user confirms; system applies recovery and any support requests.
- **Primary CTA:** "Confirm and finish."

### Screen 5 — Confirmation & Plan
- **Primary decision:** save/share the plan; know what's next.
- **Above the fold:** a single summary card with the new flight (or refund/credit) status, support items confirmed, check-in time, and a "what to do at the airport" 3-step list. (recommendation, addresses brief's "no summary, no offline backup")
- **Secondary:** "Save this page" / "Text me this summary" / "Add to wallet" actions for offline use; persistent "Plans changed? Start again" re-entry link. (recommendation)
- **State change:** terminal; user can re-enter the flow.

## Copy Constraints

### MUST say (plain language)
- Name the event: "canceled" — not "schedule irregularity," not "itinerary changed." (observed-from-brief)
- Name the cause as supplied by the system: {cancellation reason}. Do not soften.
- On each recovery card, name the consequence in one line.
- On Standby: explicitly say it is **not a confirmed seat**. (observed-from-brief)
- On Confirmation: show what was decided, when to be where, and how to get help again.

### MUST NOT do
- No "Recommended" without a stated reason.
- No fare-difference display in disruption flow. (observed-from-brief)
- No fee amounts, no credit dollar values, no expiration dates, no voucher dollar amounts — these are {system-supplied} or omitted.
- No promises of 24/7 support, callback windows, hold times, hotel partners, or meal credit amounts. The brief is silent; we stay silent.
- No "no questions asked," no reversibility guarantees, no eligibility promises.
- No org-speak: "irregular operations," "IRROPS," "Tier 2."

### Dynamic placeholders (Visual Designer must render as {…})
`{flight number}`, `{origin airport}`, `{destination airport}`, `{scheduled departure}`, `{cancellation reason}`, `{passenger name}`, `{party size}`, `{new flight number}`, `{new departure}`, `{new arrival}`, `{seats remaining indicator}`, `{refund amount if applicable}`, `{credit amount if applicable}`, `{credit expiration if applicable per booking}`, `{support item eligibility per booking}`, `{check-in time}`, `{support channel options as configured}`.

## Scoped Gaps

- **Multi-passenger / family travel** — routed in Screen 3 filter ("travel party size") but full per-passenger handling is **out-of-scope-for-this-prototype-but-flagged**. (recommendation)
- **Low bandwidth** — flag in UI as text-first layout; defer image/map enhancements. (recommendation)
- **Screen reader use** — every screen must have a clear h1 naming the screen's purpose; CTAs must say what they do, not "Continue." Out-of-scope for full ARIA spec but flagged for Visual Designer. (recommendation)
- **Refund-seeker path** — included as a first-class option on Screen 2 rather than buried; deeper refund eligibility logic is **out-of-scope-but-flagged**. (recommendation)
- **Support visibility** — addressed via persistent footer link and Screen 4 entitlements section. (recommendation)

## Tree-Test Spot Checks (assumption: representative tasks)

- "Where do I get my money back?" → Screen 2, "Refund to original payment" card. (expected)
- "Will Northstar pay for a hotel tonight?" → Screen 4 support section, eligibility shown per booking. (expected)
- "Is standby a real seat?" → Screen 2 secondary link, clarifier reads "not a confirmed seat." (expected)
- "Plans changed again, what now?" → Screen 5 re-entry link. (expected)

## Handoff to Visual Designer

**Screen sequence (5):**
1. Cancellation Notice — primary decision: proceed; CTA "See your options."
2. Recovery Options — primary decision: pick path; cards = Rebook / Refund / Travel credit; Standby as demoted secondary link with "not a confirmed seat" clarifier; persistent "Talk to an agent" footer link.
3. Choose a Flight (conditional on Rebook) — filter row + flight list sorted by arrival time; neutral comparator chips, no unexplained "Recommended," no fare-difference.
4. Support & Confirm — entitlements as visible line items with per-booking eligibility; review of selected option; CTA "Confirm and finish."
5. Confirmation & Plan — summary card, offline/save actions, re-entry link.

**Required dynamic placeholders:** `{flight number}`, `{origin airport}`, `{destination airport}`, `{scheduled departure}`, `{cancellation reason}`, `{passenger name}`, `{party size}`, `{new flight number}`, `{new departure}`, `{new arrival}`, `{seats remaining indicator}`, `{refund amount if applicable}`, `{credit amount if applicable}`, `{credit expiration if applicable per booking}`, `{support item eligibility per booking}`, `{check-in time}`, `{support channel options as configured}`.

**Must-say copy:** the word "canceled" on Screen 1; consequence line on every recovery card; "not a confirmed seat" next to Standby; new flight details + check-in time + re-entry link on Screen 5.

**Must-not-say copy:** no "schedule irregularity," no unexplained "Recommended," no fare-difference during recovery, no specific dollar amounts/fees/expirations/wait times/hotel names/meal amounts/support hours, no eligibility or reversibility promises.

**Scoped gaps to flag in UI:** multi-passenger handling (filter present, deeper logic flagged); low-bandwidth text-first treatment; screen-reader-friendly headings and verb-based CTAs. Refund-seeker path is in-flow; deeper refund logic flagged. Support visibility is in-flow.

**Flagging convention:** in UI, render gaps as muted secondary text near the relevant control (e.g., "Traveling with others? Per-passenger options coming soon."). Document the same items in the final recommendation doc, owned by the lead.
