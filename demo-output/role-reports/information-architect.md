# Information Architect Report — Canceled-Flight Recovery

Label key: [O] observed in brief, [I] inferred from brief, [A] assumption, [R] recommendation.

---

## 1. User-job spine

The ordered jobs a tired, stressed, mobile traveler must complete. Each job must be visibly resolved before the next one starts, or the user abandons and calls support [I — from brief: "people abandon the flow and call support"].

1. **Understand** — "What actually happened to my flight, and is it really gone?" [O — brief lists "Understand what happened" as the user goal.]
2. **Orient** — "What are my real options, and what does each one mean for getting to my event?" [I — brief notes labels don't explain consequences.]
3. **Choose** — "Pick one option without being tricked into a worse choice." [O — business goal: "without ... pushing users into worse choices."]
4. **Get support I'm owed** — "Do I get a hotel or meals? Don't make me hunt." [I — brief flags hidden entitlements as a trust failure.]
5. **Confirm and carry** — "Have a clear, offline-readable summary of what's next and how to reach a human if it breaks again." [I — brief flags missing summary, no offline backup, no path if plans change again.]

Design principle [R]: every screen must answer the current job *and* preview the next one, so users feel forward motion. Hidden information is the failure mode the brief is reacting to.

---

## 2. Revised screen sequence (5 screens)

### Screen 1 — What happened

- **Purpose**: Replace ambiguity ("Schedule irregularity," "itinerary has changed") with a plain, accurate statement of the event and the user's position. Resolve job 1 (Understand).
- **Primary user decision**: "I'm ready to see my options" — proceed to recovery options.
- **Content hierarchy** (top to bottom on mobile):
  1. Plain-language status: flight number, route, scheduled time, the word "canceled."
  2. Reason in plain language (no jargon).
  3. Reassurance sentence: rebooking and support options are available on this screen sequence.
  4. Passenger count on this booking (so multi-passenger users see "this covers all 4 travelers" up front).
  5. Primary action: "See my options."
  6. Secondary action: "Call Northstar" (always visible, never buried — addresses the support-visibility edge case).
- **Copy constraints**:
  - Do NOT use "schedule irregularity," "itinerary change," "service disruption." Say "canceled."
  - Do NOT promise compensation, hotel eligibility, or refund timing here. That's resolved on screen 3.
  - Apology is one sentence max. Tired users don't need a paragraph.
- **Key states**: default; multi-passenger (shows traveler count); screen-reader (status announced as a live region on load).

### Screen 2 — Choose how to recover

- **Purpose**: Show the full menu of recovery paths with honest consequence labels, so the user can pick without being steered. Resolves jobs 2 and 3 (Orient + Choose).
- **Primary user decision**: Pick one of: rebook on a Northstar flight, refund to original payment, travel credit, or standby. [R — refund must be a peer option, not buried; brief flags refund-seeker as a named edge case.]
- **Content hierarchy**:
  1. One-line framing: "Pick the option that works best for you. You can change your mind until you confirm." [R — reduces commitment anxiety.]
  2. Four option cards, stacked vertically (mobile-first). Each card shows: label, one-line plain-language consequence, and a "Choose" action.
     - **Rebook on another Northstar flight** — "Get on the next available flight we can offer."
     - **Refund to original payment** — "Cancel this trip and get your money back. We don't list a timeline here; we'll show it before you confirm." [R — refund-seeker gets a peer-level door.]
     - **Travel credit** — "Cancel this trip and hold the value for a future Northstar booking." [R — do not state expiration; that's a policy fact not in the brief.]
     - **Standby** — "Wait at the airport for an open seat on an earlier flight. Not guaranteed." [R — directly addresses the brief's worry that standby sounds equivalent to confirmed rebooking.]
  3. Support row at bottom of card list, visually distinct: "Need a hotel or meals tonight? See support options." (Links to Screen 3.) [R — pulls entitlements out of the FAQ basement.]
  4. Persistent "Call Northstar" link.
- **Copy constraints**:
  - No "Recommended" badge unless we can explain why. [O — brief flags this.]
  - No fare-difference dollar amount on this screen. [R — that's part of the rebook subflow on Screen 3.]
  - Default selection: none. Force an active choice. [R — brief notes the current default-to-credit may not match user goal.]
- **Key states**: default; one option disabled (e.g., no Northstar flights available today) with plain-language explanation; screen-reader (each card is a labeled button, not a div).

### Screen 3 — Decide the details (context-switching screen)

- **Purpose**: Whichever path the user picked on Screen 2, this screen handles the specifics AND surfaces support entitlements relevant to that path. Resolves the rest of job 3 (Choose) and job 4 (Get support I'm owed).
- **Primary user decision**: Confirm the specific flight / refund / credit / standby slot AND accept or decline overnight support if eligible.
- **Content hierarchy** (varies by path; all variants follow the same skeleton):
  1. Recap chip at top: "You chose: Rebook" (with "Change" link back to Screen 2). [R — undo path always visible.]
  2. The path-specific content:
     - **Rebook variant**: filterable flight list. Filters at top: "Direct only," "Arrive by [time]," "Same airport." Sort default: earliest arrival. Each flight card shows: depart time, arrive time, stops, seats remaining if low. No "Recommended" badge. No fare difference shown during disruption recovery. [R — brief flags fare difference as inappropriate during disruption.]
     - **Refund variant**: shows original payment method, total refund amount, and a plain statement: "We will show the expected timing on the confirmation step." [R — do not invent a refund window.]
     - **Travel credit variant**: shows credit value and a plain statement: "Expiration and terms will be shown before you confirm." [R — pulls policy facts out of IA scope; content-designer + legal own the exact terms.]
     - **Standby variant**: shows which flights you'd be standby for, time to arrive at airport, a plain statement that a seat is not guaranteed, and a "back up plan" link back to rebook. [R — addresses the "standby sounds equivalent to confirmed" risk.]
  3. **Support block** (always present on this screen, never collapsed): "Tonight's support." Lists hotel and meal support as discoverable items. Copy is conditional — if eligibility depends on the choice above, say so plainly. [R — entitlements are no longer behind an FAQ accordion.]
  4. Primary action: "Review and confirm." [R — never "Continue"; the label must predict the next screen.]
- **Copy constraints**:
  - Button labels must name the action: "Hold this flight," "Request refund," "Hold this credit," "Add me to standby."
  - Do NOT state hotel/voucher amounts, hotel names, or eligibility promises. Use placeholders like "Hotel support: see if you qualify" with a disclosure pattern owned by content-designer.
  - Do NOT use "Recommended" anywhere unless paired with a one-line reason.
- **Key states**: default per variant; no-flights-available (rebook variant collapses to "No Northstar flights match — try refund, credit, or call us"); support-not-eligible (block still appears, says "Overnight support isn't included for this disruption" — visible honesty beats hidden absence); low-bandwidth (flight list paginates, no auto-loading images).

### Screen 4 — Review and confirm

- **Purpose**: Final read-back before commit. Last chance to catch an error without calling support. Resolves job 3 (Choose, committed).
- **Primary user decision**: Confirm or go back.
- **Content hierarchy**:
  1. Plain-language summary: "Here's what will happen when you tap Confirm."
  2. Bulleted recap: new flight (or refund/credit/standby), all passengers covered, support accepted/declined, what we'll send by SMS and email.
  3. Edit links per line ("Change flight," "Change support").
  4. Primary action: "Confirm changes."
  5. Secondary action: "Go back."
- **Copy constraints**:
  - The confirm button must say what it does, not "Submit" or "Done."
  - State which traveler(s) the change applies to — multi-passenger edge case lives here.
- **Key states**: default; submitting (button disabled with progress, screen-reader announces "saving"); error (plain-language retry, "Call Northstar" elevated).

### Screen 5 — You're set

- **Purpose**: Closure plus carry-forward. Resolves job 5 (Confirm and carry).
- **Primary user decision**: Save the summary, OR change plans again, OR call for help.
- **Content hierarchy**:
  1. Plain confirmation sentence with the key fact ("You're booked on NS614, departs 2:40 p.m. tomorrow" / "Refund requested" / etc.).
  2. What happens next: a numbered list — when to arrive, where to check in, baggage status, hotel address if applicable, meal voucher delivery if applicable.
  3. Offline-friendly summary block: text-first, no required images, with a "Save as image" or "Add to wallet" action. [R — addresses the offline-backup gap.] (Visual-designer to decide the exact mechanism; IA only requires that an offline-readable artifact exists.)
  4. "Plans changed again?" link back to Screen 2 with the booking pre-loaded. [R — addresses "no clear path if plans change again."]
  5. "Call Northstar" link, persistent.
- **Copy constraints**:
  - Do NOT say "Done." Say "You're set" or similar — closure that doesn't dismiss next steps.
  - Do NOT promise SMS/email delivery times we can't guarantee.
- **Key states**: default; refund variant (shows "Refund requested" not "Refund complete"); support-included variant (shows hotel and meal info inline, not in a popover).

---

## 3. Entry SMS rewrite

The SMS is screen zero. It must carry the load that Screen 1 used to fail at.

**Required content (in order)**:
1. Plain event: "Your Northstar flight NS482 tomorrow at 6:15 a.m. (DEN to LGA) is canceled." [R]
2. Plain next step: "Tap to see your rebooking, refund, and support options." [R]
3. Plain reassurance: "All options are in the link, including hotel help if you qualify and a refund." [R — explicitly names entitlements and the refund path so the user doesn't have to call to confirm they exist.]
4. Plain escape hatch: "Or call us: [number]." [R — IA requires the slot; content-designer owns the actual number sourcing.]

**Constraints**:
- Must fit in a single SMS where possible, but accuracy beats brevity for a 10:46 p.m. cancellation. [R]
- Do NOT use "schedule irregularity" or any internal-jargon synonym. [O — brief flags this.]
- Do NOT promise compensation amounts or hotel eligibility in the SMS itself — say they exist in the link. [R]
- Do NOT use a shortened URL that looks like spam. Use a Northstar-branded domain. [R — trust under stress.]

**Tone**: factual, not chirpy. No exclamation marks. No "We're sorry for any inconvenience this may cause" — say it once on screen 1 with substance behind it.

---

## 4. Copy constraints for Visual Designer

These are the labeling rules. The visual designer can choose typography and emphasis; these are the strings and the don'ts.

**Labels that must be plain and predictive**:
- "Canceled" — never "schedule irregularity," "itinerary change," "service disruption."
- "See my options" — never "Continue," "Manage trip."
- "Rebook on another Northstar flight" / "Refund to original payment" / "Travel credit" / "Standby" — each followed by a one-line consequence sentence.
- "Hold this flight" / "Request refund" / "Hold this credit" / "Add me to standby" — never "Submit," "Select," "Confirm" without an object.
- "Review and confirm" — moves to Screen 4. "Confirm changes" — commits on Screen 4.
- "You're set" — closure on Screen 5. Never "Done."

**Things copy must NOT promise**:
- Specific hotel names, voucher dollar amounts, or vendor partners.
- Refund processing windows.
- Travel credit expiration dates.
- Eligibility for compensation under any specific regulation.
- That a standby seat will be available.
- That the next available flight is the "recommended" one — unless paired with a stated reason.

**Tone for stressed, tired users (10:46 p.m. on a phone)**:
- Short sentences. One idea per line on mobile.
- No marketing voice. No "We're excited to help you get to your destination!"
- Apology is brief and once. Empathy is shown by clarity, not adjectives.
- Honest about uncertainty. "We don't know yet, but here's how to find out" beats fake confidence.
- Every screen names the next step and where help lives.

**Accessibility-driven copy rules** [R]:
- Status changes announced as live regions, not as visual-only badges. Visual-designer needs to leave room for ARIA labeling on each option card and status chip.
- Buttons must be readable out of context (a screen reader hitting just the button should know what it does — "Confirm changes," not "OK").
- Color is never the only signal for option state (selected, disabled, recommended).

---

## 5. Scoped gaps

Edge cases I am explicitly NOT solving inside the 5-screen prototype, and why.

1. **Multi-passenger split decisions** — different travelers on the same booking wanting different recovery options (e.g., parent rebooks, teenager wants refund). [R — out of scope for the prototype.] Rationale: solving the split-decision UI would consume a full screen and the brief constrains us to 5 screens. The prototype treats all travelers as a unit and surfaces the count clearly. A "Need to split travelers? Call us" link belongs on Screen 2. The full solution is a Phase 2.
2. **Unaccompanied minors, mobility assistance, pets, oversized baggage** — these need policy and operational support the brief doesn't define. [R — out of scope.] Rationale: the brief says do not invent policy. Flow surfaces a "Call Northstar" route for these. Don't fake a self-service answer.
3. **Connecting itineraries with downstream legs** — if NS482 is leg one of three, the rebook math gets complex. [R — out of scope.] Rationale: brief example is single-leg DEN-LGA. Prototype assumes single-segment. A real implementation must handle this; the prototype's Screen 3 rebook variant can show a "Includes connecting flights" tag as a placeholder.
4. **Low-bandwidth offline mode beyond Screen 5's saveable summary** — true offline-first PWA behavior. [R — out of scope.] Rationale: too large for prototype. Mitigation: text-first layouts, no required images, Screen 5 produces a saveable artifact.
5. **Authentication and account recovery from the SMS link** — what if the user is logged out or the link expired. [R — out of scope.] Rationale: not in the brief. Assume the deep link authenticates the booking.
6. **Real-time inventory race conditions** — two users grabbing the last seat. [R — out of scope.] Rationale: error state on Screen 4 covers the user-facing case; the operational logic is engineering, not IA.
7. **Compensation rules by jurisdiction** — EU261, DOT, etc. [R — out of scope.] Rationale: brief explicitly says do not invent legal obligations. Copy uses non-promising language; legal/policy fills in real terms.

Edge cases the prototype DOES handle: refund-seeker (peer-level door on Screen 2), support visibility (Screen 3 support block is always rendered), screen-reader (live regions, labeled buttons, color-independent state), low bandwidth (text-first, paginated lists), family/multi-passenger as a unit (traveler count surfaced on Screens 1, 3, 4, 5; split decisions deferred to call).

---

## 6. Handoff to Visual Designer

Author the HTML prototype from this list. Five screens, mobile-first, in this order.

1. **Screen 1 — What happened**
   - Primary decision: tap "See my options."
   - Content order on the page: (a) flight line "NS482 - DEN to LGA - tomorrow 6:15 a.m. - **Canceled**"; (b) one-sentence plain reason; (c) one-sentence apology; (d) traveler count line ("This affects 2 travelers on this booking"); (e) primary button "See my options"; (f) secondary link "Call Northstar."
   - Copy constraints: use the word "Canceled," not "schedule irregularity." Do not list entitlements yet. One apology sentence.
   - Must-have states: default; multi-passenger (show count); screen-reader live region for the status.

2. **Screen 2 — Choose how to recover**
   - Primary decision: pick one of four recovery paths (rebook / refund / credit / standby).
   - Content order: (a) one-line framing "Pick the option that works best for you. You can change your mind until you confirm."; (b) four stacked option cards, each with label + one-line consequence + "Choose" action; (c) support row "Need a hotel or meals tonight? See support options."; (d) persistent "Call Northstar" link.
   - Copy constraints: no "Recommended" badge, no default selection, no fare-difference dollar amounts, no eligibility promises. Use the exact labels in Section 4.
   - Must-have states: default; one option disabled with plain-language reason.

3. **Screen 3 — Decide the details**
   - Primary decision: confirm the specific flight / refund / credit / standby slot, and accept or decline overnight support.
   - Content order: (a) recap chip "You chose: [path]" with "Change" link; (b) path-specific content (filterable flight list, refund summary, credit summary, or standby summary); (c) always-visible support block "Tonight's support" with hotel and meal items (or honest "not included" state); (d) primary action "Review and confirm"; (e) persistent "Call Northstar" link.
   - Copy constraints: button labels name the action ("Hold this flight," "Request refund," "Hold this credit," "Add me to standby"). No invented voucher amounts, hotel names, refund windows, or expiration dates. Do not surface fare-difference dollar amounts on rebook cards.
   - Must-have states: default per variant; no-flights-available; support-not-eligible (show, don't hide); low-bandwidth (paginate, no required images).

4. **Screen 4 — Review and confirm**
   - Primary decision: tap "Confirm changes" or "Go back."
   - Content order: (a) plain-language header "Here's what will happen when you tap Confirm"; (b) bulleted recap (new flight or refund/credit/standby, traveler coverage, support accepted/declined, what we'll send by SMS and email); (c) edit links per line; (d) primary action "Confirm changes"; (e) secondary action "Go back."
   - Copy constraints: confirm button names the action. State which travelers the change applies to.
   - Must-have states: default; submitting (button disabled, progress visible, ARIA announce); error (plain retry, elevate "Call Northstar").

5. **Screen 5 — You're set**
   - Primary decision: save the summary, change plans again, or call for help.
   - Content order: (a) plain confirmation sentence with the key fact; (b) numbered "what happens next" list (arrival time, check-in location, baggage, hotel address if applicable, meal voucher delivery if applicable); (c) offline-friendly summary block with "Save" action; (d) "Plans changed again?" link back to Screen 2; (e) persistent "Call Northstar" link.
   - Copy constraints: never "Done." Don't promise SMS/email delivery times. Refund variant says "Refund requested," not "Refund complete."
   - Must-have states: default; refund variant; support-included variant.

**Cross-cutting requirements for all screens**:
- Mobile-first single-column layout. No carousels.
- "Call Northstar" link is persistent and not hidden behind a menu.
- Text-first: no information conveyed only by image or color.
- One primary action per screen. Secondary actions are visually subordinate but never hidden.
- The header of each screen previews the job, not the brand ("What happened," "Choose how to recover," "Decide the details," "Review and confirm," "You're set").
