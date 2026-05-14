# 03 — Information Architect: Structure, Sequence, Labels

Posture: structure earns trust before words do. At 10:46 p.m. the user is not reading; they are scanning for *what is true* and *what comes next*. The IA's job is to make those two things unmissable on every surface.

I am taking CD's ceiling (5) and CD's target (4) seriously, and I am landing at **4 screens + 1 persistent entitlements strip + 1 SMS entry surface**. I will defend 4 over 5 below.

---

## 1. Revised screen sequence (4 screens)

**Screen 1 — Status & Stake** (Fact + What's true now)
- Purpose: tell the user what happened and what is not yet true, in one breath. (recommendation)
- Decides: nothing. This is read-only and earns scroll-to-options. (recommendation)
- Above fold (no scroll): flight identifier, the word "canceled" in plain text, original departure time, and the standing state ("You have not been rebooked yet."). Primary CTA: "See your options." (recommendation, supports CD's operational header — observed-from-brief)
- One tap away: full itinerary detail, support phone number, entitlements strip (persistent from here forward). (recommendation)

**Screen 2 — Choose Your Recovery** (Side-by-side comparison)
- Purpose: present rebook / credit / standby as a simultaneous comparison so the user picks the path, not the tab. (observed-from-brief: CD's "no tabs" directive)
- Decides: which recovery path. (recommendation)
- Above fold: three stacked cards, each with label + one-line consequence + the single most decision-relevant data point (rebook: earliest arrival time; credit: dollar amount or "value of fare"; standby: next-flight time + "seat not guaranteed"). Entitlements strip pinned bottom. (recommendation)
- One tap away: expanded detail per card, "Why these three?" explainer, support. (recommendation)

**Screen 3 — Confirm the Specific Choice** (Rebook list / credit terms / standby queue)
- Purpose: pick the *specific* flight, or accept the credit terms, or confirm standby placement. Same screen frame, content varies by path chosen on Screen 2. (recommendation)
- Decides: the concrete instance of the chosen path. (recommendation)
- Above fold: 2-3 options (for rebook) sorted by arrival time, each showing arrival, stops, and *any fare difference stated plainly with a non-defensive "Why?" link*. For credit/standby: the binding terms and a single confirm action. (recommendation)
- One tap away: filters (nonstop, arrival window, travel-party constraints), seat detail, baggage, entitlements strip. (assumption: filters are valuable but not on first paint)

**Screen 4 — Receipt** (Trip updated, with the receipt the current flow refuses to give)
- Purpose: give the user a screenshotable, offline-survivable summary of their new state. (observed-from-brief: current "Done" screen is the abandonment trigger)
- Decides: whether to claim entitlements they haven't yet, save/share the receipt, or change their mind. (recommendation)
- Above fold: new flight number, times, confirmation code, hotel status (claimed / available / N/A), support number, and a clear "Plans changed? Start over" affordance. (recommendation; CD's quality bar requires this block visible without tap — observed-from-brief)
- One tap away: share/save, request hotel/meal if not yet claimed, call support.

**Why 4, not 5:** the current 5-screen flow collapses because Screen 1 ("Your itinerary has changed" → Continue) is dead weight — it announces a fact and then asks for permission to show options. (observed-from-brief) Merging fact + options-entry into Screen 1, and using the entitlements strip to absorb what used to be the Support screen, removes two filler screens and adds one (Receipt). Net: 4. (recommendation)

**Would I defend 5?** Only if research shows that "Status & Stake" cannot also carry the entry to options without overwhelming the scanner. I do not believe it will, but I'd cede the ceiling to UXR if they bring evidence. (recommendation)

---

## 2. Entry surface — the SMS

The SMS is screen zero. It is the only surface guaranteed to be read. (inferred)

Structural requirements (CW owns words):
1. **Airline identity in the first token** — not "Alert," not a short code. The user must know who is texting at 10:46 p.m. (recommendation)
2. **The fact, named plainly** — the word "canceled," the flight number, the original date/time. "Schedule irregularity" is banned. (observed-from-brief)
3. **A reason fragment if known** — short, factual, no jargon. (assumption)
4. **The current state** — "You have not been rebooked yet" or "We have held a seat on [X], confirm in app." The SMS must not lie about what is already true. (recommendation)
5. **The single next action** — a deep link directly to Screen 1, not the generic "manage trip" hub. (recommendation)
6. **A fallback channel** — support phone number *in the SMS body*, not behind the link, because the link may fail or the user may be offline. (recommendation)

What it must *not* contain: apology language in the lede, marketing tone, an unexplained "Recommended" anything, or a link that requires login before showing the fact. (observed-from-brief)

---

## 3. Decision hierarchy on the options screen

**Primary decision:** which path — rebook, credit, or standby. (recommendation)

**Supporting info needed at decision time, per card:**
- Rebook: earliest confirmed arrival, whether a fare difference applies (yes/no, not amount yet). (recommendation)
- Credit: the value, and the consequence ("No flight is held"). (recommendation)
- Standby: next flight time + "Seat not guaranteed." (recommendation)

**One tap away:** the full list of rebook flights, credit terms, standby queue position estimate, "Why these three?" (recommendation)

**Defense of "no tabs":** tabs hide two of three options behind a click and force the user to *remember* what was on the unselected tabs to compare. Under stress, working memory degrades. (inferred from cognitive-load literature — Miller, Sweller; named-principle citation, not invented policy) Side-by-side cards make the comparison the visible artifact and let consequence copy do the work CD asked it to do. (observed-from-brief)

**Defense of stacked over horizontal:** three horizontal cards on mobile force each card under ~120px wide, killing the consequence line. Vertical stack preserves consequence-line readability and is reachable with one thumb. (recommendation)

---

## 4. Entitlements strip

- **What it shows:** the existence and current status of hotel and meal support — "Hotel and meal support available" / "Hotel claimed — [hotel name]" / "Not available for this disruption." (recommendation)
- **When it appears:** from Screen 1 onward, pinned to the bottom of the viewport. (observed-from-brief: CD directive)
- **When it disappears:** never within the recovery flow. On the Receipt screen it transforms into a status row inside the receipt block. (recommendation)
- **Tap behavior:** opens a sheet (not a new screen — sheet preserves the 4-screen count) showing what is available, eligibility in plain terms, and a single claim action. Dismissing returns the user to exactly where they were. (recommendation)

This pattern explicitly refuses the "Other policies" FAQ failure mode in the current flow. (observed-from-brief)

---

## 5. Navigation labels (draft — CW will refine)

Each label must answer: *what happens if I tap this?*

| Surface | Draft label | Consequence it must communicate | Alternatives considered |
|---|---|---|---|
| Screen 1 primary | "See your options" | "I will be shown choices, not committed" | "Continue" (banned — opaque), "Get rebooked" (presumes path) |
| Screen 2 card 1 | "Rebook on a new flight" | "I get a confirmed seat tomorrow" | "New flights" (current — under-specifies the commitment) |
| Screen 2 card 2 | "Take travel credit" | "I decide later; no seat held" | "Travel credit" (current — hides the no-seat-held cost) |
| Screen 2 card 3 | "Join standby" | "I wait at the gate; seat not guaranteed" | "Standby" (current — sounds equivalent to rebook) |
| Screen 3 primary | "Confirm this flight" / "Accept credit" / "Add me to standby" | path-specific commitment | "Continue," "Done" (both banned) |
| Screen 4 secondary | "Plans changed? Start over" | "I can re-enter the flow without calling" | "Modify trip" (org-chart language) |
| Strip | "Hotel and meal support — tap to view" | "There is something here for me" | "Other policies" (current — banned), "Benefits" (marketing) |

**Defense against "labels do not explain consequences":** every label above either names the action plus its commitment level, or is paired with a one-line consequence in the same visual unit. No label stands alone as a category noun. (recommendation, addressing observed-from-brief failure mode)

---

## 6. Edge cases for hierarchy

- **User changes mind mid-flow:** Screen 3 must offer "Back to options" not "Cancel." Screen 4 must offer "Plans changed? Start over" which re-enters at Screen 2 with prior choice marked so the user can see what they're undoing. (recommendation)
- **Already accepted a rebooking yesterday that canceled again:** Screen 1 must surface "This is your second cancellation on this trip" as part of the state line, and Screen 2 must reorder cards so credit and standby are not buried behind another rebook attempt. The user's mental model has shifted; the IA must shift with it. (recommendation; assumption that this state is detectable)
- **Multi-passenger booking:** Screen 2 must show passenger count in the fact header ("3 travelers"). Screen 3 rebook cards must state "All 3 confirmed" or "Only 2 seats available — split party?" as a consequence line, not as an error after submit. (recommendation)
- **Connecting itinerary:** Screen 1 state line must distinguish "the canceled segment" from "the rest of your trip." Screen 3 rebook options must show whether the connection still works or rebooks the whole itinerary — as a consequence line, not a footnote. (recommendation)

All four edge cases share a principle: state belongs in the header, not in a modal that interrupts the decision. (recommendation)

---

## 7. Handoff messages

### To Interaction Designer

**Flow model:** linear with one persistent surface (entitlements strip) and one re-entry point (Screen 4 → Screen 2). Not a wizard with a progress bar — CD vetoed that, and I agree (observed-from-brief). The user should not feel they are "in step 2 of 4"; they should feel they are at a decision.

**State transitions you'll need to design:**
1. SMS → Screen 1 (deep link, must survive logged-out state with a graceful auth interstitial that does not hide the fact)
2. Screen 1 → Screen 2 (forward only; no back to a non-screen)
3. Screen 2 → Screen 3 (three variants, same frame)
4. Screen 3 → Screen 4 (commit; this is the only irreversible-feeling transition and should be the calmest, not the most celebratory)
5. Screen 4 → Screen 2 (re-entry, prior choice visible-as-history not visible-as-current)
6. Entitlements strip → sheet → return (preserves underlying screen state exactly)
7. Any screen → support call (one tap, always; the strip is not the only escape hatch)

**Quiet but firm:** CD wants no shimmer, no progress bar, no confetti. The transition I'd push you hardest on is Screen 3 → Screen 4: it must feel resolved without feeling like a reward. A 120ms cross-fade and a settled-state Receipt is the brief. (observed-from-brief)

### To Content Designer

Each label has a structural role. Words are yours; the *job each word must do* is mine.

- **"See your options" (Screen 1 primary):** must signal *exploration without commitment.* If your phrasing implies commitment, the user won't tap.
- **Three card labels (Screen 2):** each must carry the *commitment level* of the path in the label itself, paired with a consequence line. The current "New flights / Travel credit / Standby" labels fail because they are content-type nouns, not decisions. (observed-from-brief)
- **Screen 3 primary actions:** must be *path-specific verbs*, not generic. "Continue" is the failure mode. The verb must match the commitment ("Confirm," "Accept," "Add me to").
- **"Plans changed? Start over" (Screen 4):** must signal *the door is still open* without sounding like the prior decision was wrong. Tone matters here more than anywhere else in the flow.
- **Entitlements strip label:** must communicate *something is available for you, here, now, not buried.* "Other policies" is the failure mode. Avoid "benefits" (marketing), avoid "support" (too generic — that's the phone number's job).
- **Receipt headers:** must read as facts the user can screenshot and trust — not as a thank-you note. CD's register is plain operational; the receipt is the purest expression of that.

Push back on me if you find a label slot where the structural role is unclear or in tension with the register — I'd rather restructure than ship a label that has to do two jobs.

---

## Summary (for the team channel)

**Screens:** 4 (Status & Stake → Choose → Confirm → Receipt) plus persistent entitlements strip and the SMS entry surface.

**Spine:** fact → comparison-of-paths → commitment-on-chosen-path → screenshotable receipt; entitlements live everywhere in between as a strip, never as a screen.

**Most controversial structural call:** merging the current "itinerary has changed" screen into the options-entry screen, eliminating the dead-weight "Continue" interstitial. Some teams will read this as rushing the user past the emotional beat; I'd argue the emotional beat is the SMS, and the app's job from Screen 1 onward is operational clarity.

**Pushback on CD:** none on the 4-screen call or the no-tabs call — both are right. Mild pushback I'd surface in debate: the Receipt screen is non-negotiable even if it pushes us to 5, and I would defend 5 over 4 before I would defend dropping the receipt. CD's quality bar already requires the receipt block, so I don't expect this to be a real fight.
