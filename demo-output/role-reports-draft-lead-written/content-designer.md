# Content Designer / UX Writer — Northstar Canceled-Flight Recovery

**Role:** Content Designer / UX Writer
**Scope:** SMS, all four in-app screens, persistent support module, error and confirmation copy
**Inputs used:** Brief; inbound from ux-researcher (voice rules), info-architect (slot map), accessibility-specialist (plain-language and link-text constraints), behavioral-scientist (framing risks). No invented policies, entitlements, or quotes.

---

## Top 3 Findings

1. **Lead with the event, not the system.** [recommendation] Every screen and the SMS currently starts with system-speak ("schedule irregularity," "itinerary has changed," "your changes have been applied"). The user needs the *event* in the first sentence: canceled, time, route, what we're doing about it.
2. **Action labels must describe consequences, not motion.** [recommendation, integrating accessibility 2.4.4 / 2.4.6 / 3.3.2] "Continue," "Done," "View details," "Other policies" all fail screen-reader users *and* tired sighted users. Replace with consequence-bearing verbs every time.
3. **Don't promise what the brief doesn't authorize.** [observed from brief constraints] The user wants reassurance, but I can't invent hotel guarantees, comp policy, or refund rules. Tone has to be *plain and confident about what we're doing*, not generous about benefits we haven't been told to offer.

---

## Evidence Labels

- **[Observed from brief]:** Current SMS copy, screen copy, button labels, "Recommended" badge with no reason, "$84 fare difference," hotel/meal in FAQ.
- **[Inferred]:** Users are tired, mobile, possibly stressed, may use a screen reader, may speak English as a second language.
- **[Assumption]:** Northstar's brand voice tolerates direct, calm, plain copy. Not jokey, not corporate.
- **[Recommendation]:** Plain-language target ~grade 6–8; sentences ≤20 words; no jargon; consequence-bearing action labels; honest about uncertainty; never promise entitlements not in the brief.

---

## Voice & Tone Rules

### Do

- **Use plain words.** "Canceled" not "schedule irregularity." "Free" not "no fare difference applies." "Hotel help" not "lodging accommodations."
- **Lead with the event, then reassurance, then action.** "Your flight is canceled. We're holding options for you. Tap to see them."
- **Use active voice.** "We canceled your 6:15 a.m. flight" beats "Your flight has been canceled." (When possible; use passive when ambiguating responsibility helps the user.)
- **Name consequences.** "Confirm rebooking" not "Continue." "Go to my trip" not "Done."
- **Be specific.** "Tomorrow at 2:40 p.m." beats "later flight." Times in 12-hour with am/pm; days as relative ("tomorrow") + absolute ("Thu May 14") for clarity.
- **Be honest about uncertainty.** "We may not have a hotel near the airport" beats silence or false guarantee.
- **Use second person.** "Your flight" not "the passenger's flight."

### Avoid

- **System jargon.** No "schedule irregularity," "trip irregularity," "operational disruption."
- **Apologetic boilerplate.** "We apologize for the inconvenience" is meaningless in distress. Replace with a concrete next step.
- **Idioms / metaphors.** "Hang tight," "we've got you," "smooth sailing" — bad for screen readers, bad for ESL.
- **Pseudo-urgency.** No "Hurry!" / countdown panic. Inventory holds are stated factually.
- **Unexplained badges or prices.** No "Recommended" without a reason. No "$84" without context.
- **Promises the brief doesn't authorize.** Never "we'll pay for your hotel" — say what action is available, not what entitlement is owed.
- **Exclamation points** (except very rarely on success).
- **Title case** in long button labels. Sentence case across the board.

### Reading level

Target ~grade 6–8 (per accessibility-specialist's 3.1.5 ask). Sentences ≤20 words. Buttons ≤4 words where possible, ≤6 max. Use one idea per sentence.

---

## SMS / Push Copy (Screen 0)

### Cancellation SMS

> Northstar Air: your 6:15 a.m. flight NS482 tomorrow (DEN→LGA) is canceled.
> We're holding rebooking and hotel options for you.
> Tap to see them: [link]
> Or call us: 1-800-NORTHSTAR (open 24 hours).

**Why each line:**
- L1 — event, time, flight #, route. Front-loaded. (per ux-researcher #1)
- L2 — reassurance + tells them what's behind the link.
- L3 — primary action.
- L4 — fallback (if the link won't open, the link expired, or the user prefers a person). Honesty about hours per accessibility-specialist's "phrase Call support honestly."

**Character budget:** ~210 chars. Fits most SMS gateways without splitting.

### Push notification (alternate / additional)

> Flight canceled — tap for options
> Your 6:15 a.m. NS482 tomorrow is canceled. We're holding rebooking and hotel options.

### Outbound SMS at confirmation (Screen 4 → user's phone)

> Northstar Air: rebooked on NS614, 2:40 p.m. Wed May 14, DEN→LGA, terminal A, gate posts 90 min prior.
> Confirmation code: ABCD12.
> Hotel held: Airport Inn DEN, 123 Quebec St. Check in any time.
> Need to change? Call 1-800-NORTHSTAR.

---

## Screen-by-Screen Copy

### Screen 1 — Status & Path

**Headline (h1):**
> Your 6:15 a.m. flight tomorrow is canceled.

**Subhead / reason:**
> NS482 (DEN→LGA) was canceled due to crew availability.

**Party scope (only if multi-passenger):**
> This affects all 3 travelers on this reservation.

**Reassurance line:**
> We're holding rebooking and hotel options for you.

**Primary CTA:**
> See rebooking options

**Secondary CTA (inline expander):**
> Other recovery options — travel credit, standby, call us

**Persistent support module (collapsed):**
> Get help — hotel, meals, or call us

---

### Screen 2 — Choose a Flight

**Sticky status banner (1 line):**
> Canceled: 6:15 a.m. NS482 tomorrow.

**Section label (h2):**
> Available flights tomorrow — pick one

**Filter row (collapsed label):**
> Filter flights (arrival time, nonstop, mobility help)

**Flight card example (best match):**
> 2:40 p.m. — nonstop
> Arrives 8:25 p.m. ET • $0 to rebook
> Best match: gets all 3 travelers there with no extra cost.

*(replaces "Recommended" with a reason; per behavioral-scientist's framing guidance, the reason is concrete and verifiable, not vague trust-me language.)*

**Flight card example (with fare difference):**
> 7:10 a.m. — 1 stop in Chicago
> Arrives 3:40 p.m. ET • +$84 to upgrade earlier
> Earlier arrival; costs more because it's a different fare class.

*(replaces "$84 fare difference" with an explanation of when and why it applies.)*

**Hotel module (visible at known position):**
> Need a hotel for tonight?
> If your new flight is tomorrow afternoon or later, you may qualify for hotel help. We'll check while you rebook.
> [Get hotel help]

*(phrasing: "you may qualify" — does not promise; "we'll check" — names the action. Per ux-researcher rule on uncertainty.)*

**"If your plans change" row (secondary recovery):**
> Want a travel credit instead? — keeps the trip value for a future flight (no fee)
> Add me to standby — earlier flights if a seat opens; not a guaranteed seat
> Call Northstar support — speak to a person now

*(every option carries its consequence inline, per accessibility-specialist's 3.3.2 ask.)*

---

### Screen 3 — Review & Confirm

**Headline (h1):**
> Review your changes

**Live-announce on entry (per accessibility):**
> Review your changes. Confirming will rebook all 3 travelers on the 2:40 p.m. nonstop tomorrow.

**"What changes" block:**
> Old flight: 6:15 a.m. tomorrow, NS482, DEN→LGA — canceled
> New flight: 2:40 p.m. tomorrow, NS614, DEN→LGA, nonstop
> Travelers: 3 (rebooking all)
> Baggage: carries over

**Cost block (no charge case):**
> Cost: $0. No fare difference applies because Northstar canceled your flight.

**Cost block (fare difference case — only if user chose an upgrade):**
> Cost: $84. This applies because you chose an earlier nonstop. The free 2:40 p.m. option is still available.

**Hotel block (only if requested):**
> Hotel: we'll request a room at a nearby partner. You'll see the confirmation here and by text.

**"What happens next" block:**
> We'll text and email your new itinerary.
> You can undo this rebooking for 60 seconds after confirming.
> Need help? Call 1-800-NORTHSTAR.

**Primary CTA:**
> Confirm rebooking

**Secondary CTA:**
> Back to flight list

---

### Screen 4 — Confirmed

**Headline (h1, live-announced):**
> You're rebooked.

**Itinerary block:**
> Flight: NS614
> Wed May 14 • 2:40 p.m. → 8:25 p.m. ET
> DEN, terminal A → LGA
> Travelers: 3
> Confirmation: ABCD12

**Baggage line:**
> Bags carry over from your original reservation.

**Hotel block (if any):**
> Hotel: Airport Inn DEN
> 123 Quebec St., Denver, CO 80207
> Check in any time tonight
> Confirmation: HOT9988

**Save-this-info actions:**
> Text me this info
> Email me this info
> Add to calendar

**Undo window (announced once, with countdown visible):**
> You can undo this rebooking for the next 60 seconds.
> [Undo rebooking]

**After undo expires:**
> Undo window closed. To change again, call support.

**Persistent support module:**
> Need help? — hotel, meals, or call us

**Footer reassurance:**
> We'll text you 3 hours before boarding.

---

### Persistent Support Module — Copy

**Closed pill / button label:**
> Get help

**Sheet header (h2):**
> What kind of help do you need?

**Options:**
> Hotel help — request a room if you qualify
> Meal help — get a meal credit if you qualify
> Call us — 1-800-NORTHSTAR, open 24 hours

**Hotel request form intro:**
> Tell us a few quick details. We'll check while you finish rebooking and reply by text.

**Hotel request submitted state:**
> Hotel help requested. We'll text you shortly.

**Hotel request failed state:**
> We couldn't submit the request. Try again, or call 1-800-NORTHSTAR.

*(phrasing: "you may qualify" / "we'll check" — does not promise the entitlement; surfaces the action.)*

---

## Error Copy (general patterns)

| Error | Headline (live-announced) | Body | Recovery |
|---|---|---|---|
| No flights | No flights match. | We can show next-day options, or you can speak to support. | [Show next-day flights] [Call support] |
| Inventory race (seat gone) | That seat just went. | We saved your filters. Here are the closest alternatives. | [See similar flights] |
| Payment declined | Card declined. | Try another card, pick a $0 option, or call support. | [Try another card] [Pick a $0 flight] [Call support] |
| Network lost | You're offline. | Your choice is saved. We'll resume when you're back online. | [Retry now] |
| Session expired | Sign-in expired. | Sign back in to keep going, or call support. | [Sign back in] [Call support] |
| Outbound SMS failed | We couldn't text you. | Copy your info below, or retry. | [Retry] [Copy itinerary] |

**Error tone rule:** plain → why (if useful) → what to do. Three sentences max.

---

## Confirmation / Handoff Copy

(See Screen 4 above for full screen copy. Three principles for handoff moments:)

1. **Every handoff to a human says what to do and who to talk to.** "Call Northstar support: 1-800-NORTHSTAR, open 24 hours."
2. **Every handoff to a future moment names the moment.** "We'll text you 3 hours before boarding." (Sets expectation for the next contact.)
3. **Every handoff *out of the app* survives the app.** SMS + email + copyable text on Screen 4 ensure the user has the info if the device dies.

---

## Tone Rules Cheat Sheet (printable)

**Always**
- Event first → reassurance → action
- Plain language at ~grade 6–8
- Sentence case, ≤20 words/sentence
- Action labels carry consequences
- Honest about uncertainty
- Specific times, dates, locations
- Second person

**Never**
- "Schedule irregularity," "itinerary has changed," "your changes have been applied"
- "Continue," "Done," "View details," "Other policies"
- Apologetic boilerplate
- Pseudo-urgency
- Unexplained badges or prices
- Promises the brief doesn't authorize
- Title case button labels
- Idioms

---

## Handoffs Sent

### → info-architect

**Subject: Confirm screen labels align with structure**

I've worked from your slot map. Three label changes I'm proposing — flag if any break IA:

1. Your slot "Available flights tomorrow — pick one" → I kept this.
2. Your "If your plans change" section → I kept this name; alternate option labels are inline.
3. Your "Best match" tag → I kept this, and added the reason inline ("Best match: gets all 3 travelers there with no extra cost").

**Question for you:** the persistent module — single label "Get help" across all screens (per WCAG 3.2.6 Consistent Help). Confirm this fits your IA, since it's repeated everywhere.

### → accessibility-specialist

**Subject: Copy draft summary for plain-language and screen-reader review**

Specific checks I need from you before lock:

1. **Plain-language check:** every screen above. Specifically: "rebooking," "rebook," "fare difference," "standby" — are these understandable at ~grade 6–8 or do I need to define them?
2. **Link-text check:** "See rebooking options," "Other recovery options," "Get hotel help," "Get help," "Try another card." Are they all stand-alone? (per 2.4.4)
3. **Live announcement copy:** are my proposed `role="status"` announcements ("Review your changes. Confirming will rebook all 3 travelers on the 2:40 p.m. nonstop tomorrow.") the right length — informative but not fatiguing?
4. **Undo window phrasing:** "You can undo this rebooking for the next 60 seconds." Is "next 60 seconds" calmer than a per-second readout?
5. **"You may qualify" phrasing on hotel:** does this read as honest and non-promising, or as evasive? Important for trust.

---

## Handoffs Received

| Sender | Message | What changed |
|---|---|---|
| ux-researcher | Lead with event → reassurance → action; no system language; explain badges and prices. | This is the spine of the voice section. SMS copy rewritten event-first. |
| info-architect | Slot map for every screen + persistent "Get help" label. | Wrote copy *into* the slots; consolidated support labels to a single phrase across screens. |
| accessibility-specialist | ~grade 6–8 reading level; link text must stand alone; explain badges in words; standby clarity; family/party-aware phrasing; no idioms. | Removed "hang tight"–style phrasing. Added party-scope sentence to Screen 1. Inlined the "Recommended" reason. Added "not a guaranteed seat" to standby. |
| behavioral-scientist | (Anticipated) Avoid loss-aversion bait, avoid "Recommended" without reason, avoid time-pressure copy on inventory holds, frame fare difference honestly. | "Recommended" → "Best match" with reason. Inventory-hold copy stated factually, no countdown panic on Screen 2. Fare-difference framing explains *when* it applies. Will revise more if behavioral-scientist's specific risks land before lock. |

---

## To Team Lead (status)

**Top 3 findings:** lead with the event; consequence-bearing action labels; never promise unauthorized entitlements.

**One tension:** behavioral-scientist may want bolder framing on the hotel entitlement to nudge users toward claiming it (where eligible), while I am holding the line on "may qualify" / "we'll check" because the brief explicitly forbids inventing entitlements. We'll need to align on a specific phrase: claim-positive without overpromising.

**Messaged:** info-architect, accessibility-specialist.
