# Content Designer — Northstar Canceled-Flight Recovery

Labels: [O]bserved · [I]nferred · [A]ssumption · [R]ecommendation.

## 1. Voice & tone rules

- **Voice:** concierge at 11 p.m. to a tired traveler — competent, specific, finite, never performative. [R]
- **We name the event, then the next move.** No apology paragraph; the *attention* is the apology. [R]
- **Verbs name the outcome.** "Keep this seat," "Book a hotel for me." Never "Continue," "Submit," "Confirm" alone. [R]
- **Numbers stay numbers.** "6:15 a.m.," "+4h 02m," "about 6 min wait." No "early morning," no "shortly." [R]
- **Banned:** schedule irregularity · We apologize for the inconvenience · Your changes have been applied · Recommended · Click here · Continue (bare) · irrops · PNR · "oops" · exclamation marks · fake warmth ("Hang in there!") · false intimacy ("we know this is hard"). [R]
- **i18n watch:** no idioms ("on your plate"), no contractions in legal-adjacent strings, expect ~30% expansion in DE/FI — leave room. [R]

## 2. New SMS (replaces "Northstar Alert: Schedule irregularity on NS482")

> **Northstar: your 6:15 a.m. flight tomorrow (NS482, DEN–LGA) is canceled — crew availability. We've held a seat on the 7:10 a.m. Open trip to keep it or pick another: nsair.co/t/4k2**

158 chars. Names event, names reason (non-blame, from brief), names the held seat, gives one next step. No compensation invented. [R]

## 3. Screen-by-screen copy

Every H1 below answers the silent question UX Researcher mapped to that step. [O researcher §3]

### Screen 1 — Held-Seat Offer (answers: "Am I actually getting home?")

| Slot | String |
|---|---|
| Eyebrow | **Flight NS 482 — tomorrow** *(stet from current; concierge nit deferred)* |
| H1 | **Your 6:15 a.m. to LGA was canceled.** |
| Lede | **We've held a seat on the next flight out. Take it, or look at other options first.** (20 words) |
| Held-card eyebrow | **Seat held for you** |
| Held-card "why" (≤14 words, IA's ask) | **Earliest confirmed seat tomorrow, same fare.** (6 words) — see §6 for alternates |
| Meta keys | **Arrives · vs. original · Fare** |
| Meta values | **3:42 p.m. · +4h 02m · No change** |
| Primary CTA | **Keep this seat** |
| Secondary CTA | **See other options** |
| Reassurance footer | **Your held seat stays open while you decide. Hotel and a meal can be covered tonight — we'll get there next.** |

### Screen 2 — Other Flights (answers: "What are my real options?")

| Slot | String |
|---|---|
| Eyebrow | **Sorted by earliest arrival** |
| H1 | **Other flights tomorrow.** |
| Lede | **Your held seat stays open while you look. Tap a flight to see the swap.** |
| Filter chips | **Earliest arrival · Nonstop · Morning · Standby · Take credit instead** |
| Pinned label | **Held for you** |
| Held card delta line | **+4h 02m later than your original arrival** |
| Other-card delta lines | **+4h 38m later · +9h 15m later · +13h 25m later — overnight** |
| Confirm-swap dialog title | **Switch to the 9:55 a.m.?** |
| Confirm-swap body | **This releases your held 7:10 a.m. seat. You can switch back if seats remain.** |
| Confirm-swap primary | **Switch flights** |
| Confirm-swap ghost | **Keep my held seat** |
| Bottom return link | **Back to the held seat** |

### Screen 3 — Tonight's Support (answers: "Where do I sleep, and who pays?")

| Slot | String |
|---|---|
| Eyebrow | **A few hours to sleep** |
| H1 | **Tonight's covered, if you need it.** |
| Lede | **Northstar can cover a hotel near the airport and a meal while you wait. Take what you need, skip what you don't.** |
| Hotel h3 | **A hotel for tonight** |
| Hotel body | **We'll book a partner hotel near DEN and text you the confirmation. You can ask for a different room when you arrive.** |
| Hotel primary | **Book a hotel for me** |
| Hotel ghost | **I have lodging** |
| Meal h3 | **A meal while you wait** |
| Meal body | **A meal credit for restaurants in the terminal or near the hotel. We'll text the redemption details.** |
| Meal primary | **Send my meal credit** |
| Meal ghost | **No thanks** |
| Bag h3 | **Your checked bag** |
| Bag body | **No bag checked, so nothing to retrieve tonight. If that changes, we'll re-tag it for the new flight.** |
| Bag ghost (honest-disabled) | **Got it** |
| Person link | **Talk to a person — about 6 min wait** |
| Footer CTA (replaces bare "Continue") | **Confirm tonight's plan** |

### Screen 4 — You're Set (answers: "What do I do next if this falls apart again?")

| Slot | String |
|---|---|
| Brand time slot | **Confirmed** |
| H1 | **You're set for tomorrow.** |
| Lede | **Sleep well. Here's everything in one place — we'll text you if anything changes.** |
| Section keys | **Flight · Hotel tonight · Baggage · Tomorrow morning** |
| Flight value | **NS 612 · DEN → LGA · 7:10 a.m.** sub: **Arrives 3:42 p.m. · 1 stop · Check-in opens 4:10 a.m. · Gate** *TBD — we'll text you* |
| Hotel value | **Confirmation sent by text** sub: **Shuttle pickup at door 5 · 12 minutes from terminal** |
| Tomorrow value | **Leave the hotel by 5:00 a.m.** sub: **Boarding starts 6:30 a.m. · Mobile boarding pass arrives at 4:10 a.m.** |
| Micro-actions | **Add to Wallet · Forward to family · Save offline** |
| Wallet success label | **In Wallet** |
| Offline success label | **Saved · tap to view offline** |
| SMS footer | **If anything changes, we'll text you.** Reply HELP anytime to reach a person. |
| Plans-changed link | **Something changed — get help** |

## 4. Error & state strings (Interaction Designer's five cases)

| Case | Intent | String |
|---|---|---|
| Rebooking fails (S1) | Acknowledge, don't blame; offer retry + human | **We couldn't lock that seat just now. Try once more, or talk to a person.** Primary: **Try again** · Ghost: **Talk to a person — about 6 min wait** |
| Card on file fails for hotel (S3 inline) | Don't block the flow; offer alt + human | **The card on file didn't go through for the hotel. Use a different card, or have us book it on Northstar.** Ghost: **Use a different card** · Ghost: **Have Northstar book it** |
| No flights tomorrow at all (S1→S2 empty) | State the gap, no false hope | **We don't have a seat for you tomorrow. You can take travel credit and rebook later, or talk to a person tonight.** Primary: **Take travel credit** · Ghost: **Talk to a person** |
| Network drops mid-flow (banner) | Reassure: nothing lost | **You're offline. We'll finish this when you reconnect — nothing is lost.** Action: **Retry** |
| Hotel offered but no rooms (S4 row) | Don't roll back the flight; flag one row | **We couldn't confirm a room tonight. A person can find one for you — usually under 10 minutes.** Link: **Talk to a person** |
| Expired-hold (state change, no timer) | Quiet, not alarming | Eyebrow: **Hold expired** · Card body: **The held seat was released. Available seats refresh in a tap.** Primary: **Refresh available seats** |
| Cascading cancel (held flight also canceled) | Danger-aware, not screaming | Eyebrow: **Held flight canceled** · Body: **Your held 7:10 a.m. was canceled. We're looking at what's next.** Primary: **See what we can do** |

## 5. Notifications (≤2 lines each)

- **Original cancel (SMS):** *see §2.*
- **Hotel confirmed (SMS):** **Northstar: hotel confirmed — Hampton Inn DEN Airport, conf. HX-48217. Shuttle at door 5. Address & directions: nsair.co/t/4k2/h**
- **Gate update (push):** **Gate posted: NS 612 boards at A36, 6:30 a.m. Tap for boarding pass.**
- **New disruption (SMS):** **Northstar: NS 612 is now delayed to 8:05 a.m. — weather in ORD. Your seat and connection are still good. Details: nsair.co/t/4k2**

## 6. Three tradeoffs I made

1. **Honesty over warmth on the SMS.** I wrote "canceled — crew availability" instead of a softer "we've hit a snag." Naming the reason (non-blame, observed in brief) builds trust at the moment of highest doubt; warmth here reads evasive. [R]
2. **Brevity over hedging on the "why this seat" line.** "Earliest confirmed seat tomorrow, same fare." is 6 words. Alternates considered: "Gets you in earliest with no fare change" (9w), "Same airline, earliest arrival, no fare change" (7w). I chose the first because *confirmed* is the trust word — it does the work "Recommended" was failing to do. [R]
3. **Clarity over modesty on Screen 3's H1.** "Tonight's covered, if you need it." asserts coverage before the user has tapped anything. The risk is overclaim. Mitigation: the lede immediately qualifies *what's* covered (hotel + meal, no dollar amount, no policy claim). I'd rather the tired user know help exists than protect us from a soft promise. [R]

---

## Message-to-Information-Architect (verbatim for relay)

> IA — the four-screen spine held. The one place I felt structural pressure was **Screen 3's bottom-of-screen action**. With three opt-in support cards plus a persistent "Talk to a person" link, the only honest label for the final button is something like "Confirm tonight's plan" — which only makes sense if the user has tapped *something* above. If they tap nothing, the button labels a non-event. Two options: (a) hide the footer CTA until at least one card resolves and rely on the back-to-flow chrome, or (b) relabel "I have lodging" / "No thanks" as explicit decline states the screen tracks. I adapted in copy ("Confirm tonight's plan") but it's a flow seam, not a wording seam. Your call. Separate note: I banned "Recommended" and replaced the held-card "why" with **"Earliest confirmed seat tomorrow, same fare."** — 6 words, single-line at 375 px, *confirmed* carries the trust without overclaiming.

## Message-to-Accessibility-Specialist (verbatim for relay)

> A11y — copy choices that affect AT: (1) **Heading levels per screen**: S1 H1 = "Your 6:15 a.m. to LGA was canceled."; held-card title is announced via `aria-label="Held seat offer"` on the group, not a heading — verify SR reads the group label *before* the time. S3 each card's h3 is a real `<h3>`. S4 summary section keys (Flight/Hotel/Baggage/Tomorrow morning) are `<dt>`-style — confirm SR reads key-then-value, not flattened. (2) **Every button is verb+object** ("Keep this seat," "Book a hotel for me," "Send my meal credit") — no bare "Continue." (3) **No icon-only buttons.** Micro-actions on S4 (Add to Wallet / Forward to family / Save offline) pair icon with a visible label; the `aria-label` on the link can drop since the visible label is the label. (4) **SMS short-link concern**: `nsair.co/t/4k2` is opaque to a screen reader and looks phishy. Recommend the brand prefix "Northstar:" stays at the start of every SMS so SR users hear the source before the URL. (5) **Reading order matters most on S1**: eyebrow → H1 → lede → held-card group (label-first) → CTAs → reassurance. The "why" line inside the card should come *after* the meta strip so the user hears facts before justification. (6) Times read as "6:15 a.m." not "six fifteen AM" — confirm SR pronunciation of "a.m." with periods; if it spells "A period M period," strip the periods globally. Please redline (1), (5), and (6).

---

*All strings: recommendation. Event facts (6:15 a.m., NS482, DEN–LGA, crew availability, +4h 02m, 7:10 a.m.): observed from brief or carried forward from prior reports.*
