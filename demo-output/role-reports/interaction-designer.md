# Interaction Designer — Northstar Canceled-Flight Recovery

Labels: [O]bserved · [I]nferred · [A]ssumption · [R]ecommendation. Behavior only — no entitlements.

## 1. State machine per screen

**Screen 1 — Held-Seat Offer**
| State | Trigger | Signal | Next-screen affordance |
|---|---|---|---|
| Default | SMS deep-link opens | Moss pulse dot on "Seat held for you" eyebrow; tabular time renders | Primary "Keep this seat" → S3; secondary "See other options" → S2 [R] |
| Loading | Open from cold start | Atmospheric gradient + skeleton on held-card meta strip only; H1 and lede render first [R] | Buttons disabled until card resolves |
| Success (accepted) | Primary tapped | Button shifts to spinner-in-button (no full-screen blocker); pulse dot stops on confirm | Auto-advance to S3 [R] |
| Error | Rebook API fails | In-card amber inline message replaces the meta strip; primary becomes "Try again"; secondary becomes "Talk to a person" [R] | Stay on S1; do not auto-route |
| Empty/no-data | No held seat could be offered | Held-card collapses to a quiet "We couldn't hold a seat for you" panel; primary becomes "See available flights" → S2 [R] | Skip S1 acceptance entirely |
| Expired-hold | Hold timer elapsed (see §2) | Pulse dot stops; eyebrow flips to "Hold expired"; card desaturates (visual ask in §5) | Primary becomes "Refresh available seats" |
| Offline | No network on launch | Banner above brand bar: "Showing your last-known options"; buttons remain present but flag a confirm dialog [R] | Acceptance queues; user warned it isn't final |
| Low-bandwidth | Slow API | Held-card renders, meta items show inline skeleton bars for ≤3s then a retry chip; H1 never blocks [R] | Same |
| SR-traversal | VoiceOver/TalkBack | Reading order: brand → H1 → lede → held-card group (announced as "Held seat offer, group") → primary → secondary → reassurance | Same |

**Screen 2 — Other Flights**
| State | Trigger | Signal | Next |
|---|---|---|---|
| Default | "See other options" tapped | Filter row + pinned "Held for you" card at top of list; sort chip shows active state | Tap any card → S3 confirm-dialog (§2) |
| Loading | Entering screen | Filter chips render; flight cards stream in with 4 hairline skeletons [R] | — |
| Success (selected) | Card tapped | Brief inline confirm dialog (sheet, not full screen) summarizing change vs. held seat [R] | On confirm → S3 |
| Error | List API fails | Inline panel where list would be: "We can't load flights right now"; held-seat card still pinned and acceptable [R] | Back to S1 path remains live |
| Empty | No alternatives exist | List area shows quiet empty state; held-seat card still pinned; chip row hidden (no filters to apply) [R] | — |
| Partial | Some segments missing | Card with "Details incomplete — tap to refresh" affordance, not silently dropped [R] | — |
| Expired-hold | (cascades from S1) | Pinned card desaturates; copy slot reserved for Content [A] | "Refresh held seat" |
| Offline | Network drop mid-browse | Top banner; filter chips disabled; pinned held-card stays interactive if it was loaded [R] | Back to last known |
| Low-bandwidth | — | Skeletons per card; sort stays usable client-side after first load [R] | — |
| SR-traversal | — | Reading order: brand → H1 → lede → filter group → "Held for you" landmark → flight list → "Back to the held seat" link | — |

**Screen 3 — Tonight's Support**
States mirror above. Notable: each support card has its own *honest-disabled* state [O from visual report] — e.g., "no checked bag" shows a single ghost "Got it"; the Book/Send buttons never appear in a fake-enabled form. Offered-not-opted-in [O]: user must tap to opt in, "Continue" is always present and never gated by support choices [R].

**Screen 4 — You're Set**
- Default: summary card + 3 micro-actions + SMS footer.
- Partial-success: any TBD slot (e.g., gate) renders as `<span class="tbd">` placeholder with a "We'll text you" promise — already in the markup [O].
- Hotel-unavailable variant: hotel row swaps to "We couldn't confirm a hotel — talk to a person" inline [R]; rest of summary remains.
- Offline-save: micro-action triggers a local-cache write + checkmark swap on the tile (see §4).
- SR-traversal: H1 → check confirmation → summary as a labeled region with 4 sub-regions → micro-actions as a labeled group → SMS footer.

## 2. The held-seat mechanic

- **How it's held** [R]: a real reservation lock (PNR-level) signaled by the moss pulse + "Seat held for you" eyebrow. **No countdown timer visible** — counters spike anxiety at 11 p.m. and contradict the concierge anchor. Instead, expiry is communicated only when it happens (state change), and the reassurance footer carries the steady-state promise.
- **Sit-too-long on S1** [R]: hold extends silently up to ~20 minutes [A]. At T-2min the screen shifts to a soft "Still here? We're still holding it" inline note above the primary — no modal, no interruption. On expiry, S1 enters Expired-hold state and primary CTA refreshes the offer.
- **Browsing alternatives on S2** [R]: **the held seat is preserved while browsing**. Tapping a peer card opens a *confirm dialog* ("Switch to this flight? Your held 7:10 a.m. seat will be released."). The release happens on confirm, not on tap. This is the defensible call — the IA spine says S2 is a side-trip; releasing on browse would punish curiosity.
- **Cascading cancel** [R]: if the held seat is also canceled mid-flow, S1 (or pinned card on S2) flips to a danger-toned variant with a single recovery CTA "See what we can do" → re-runs the offer engine. The user is never silently dropped into S2.
- **Retreat affordance on S2**: **pinned card at top of list + a "Back to the held seat" text link at bottom**. Both, not either. Pinned card is the visual anchor; the bottom link rescues users who scrolled past it on a long list. Reject sticky footer — it competes with native browser chrome and collides with screen-reader landmarks [R]. **This answers IA's question: yes, pinned card holds up — augmented with a bottom-of-list return link.**

## 3. Error and recovery paths

| Case | Screen state | Copy intent (for Content) | Recovery affordance |
|---|---|---|---|
| Rebooking can't process | S1 Error | Acknowledge, don't blame; offer retry or human | Primary "Try again" + ghost "Talk to a person" (wait time visible) |
| Card on file fails (hotel voucher) | S3 inline-error on hotel card only | Don't block the flow; offer alternate or human | Inline ghost "Use a different card" + "Talk to a person"; other support cards unaffected |
| No seats tomorrow at all | S1 Empty → routes to S2 Empty | State the gap; offer credit or human; no false hope | Primary "Take travel credit" + ghost "Talk to a person" |
| Network dropped mid-flow | Top banner across whichever screen is active | Reassure: nothing lost; queued | Banner with "Retry" affordance; any in-flight action shows "We'll finish this when you reconnect" [R] |
| Hotel accepted, no rooms tonight | S4 Partial-success on hotel row | Don't roll back the flight; flag this one row | Inline "We couldn't confirm a hotel — talk to a person" + the human-link remains |

Cross-cutting: **double-submit** is prevented by disabling the primary on first tap and showing in-button progress. **Refresh mid-flow** restores from server-side draft (S1 always reachable). **Back button** on S2 returns to S1 with held seat intact; on S3 it returns to S2 with the *prior* selection still active (not lost). **Expired session** prompts re-auth in a sheet, not a full redirect.

## 4. Microinteractions

1. **S1 "Keep this seat"** — Tap: button compresses (scale 0.995, already in CSS [O]). Within 80ms the label is replaced by an inline spinner — no full-screen blocker. On success the moss pulse dot stops, the eyebrow swaps to "Seat confirmed," then ~250ms advance to S3. Escape: a short window (~3s) on S3 reveals an inline "Undo — back to options" link near the H1 [R].
2. **S2 filter chips** — **Sort chip ("Earliest arrival") is single-select with a sheet picker** (the caret in markup is the affordance [O]). Other chips (Nonstop, Morning, Standby, Take credit instead) are **multi-select toggles**, except "Take credit instead" which is a route-out — tapping it opens a confirm dialog ("Leave rebooking and take credit?"). Standby remains a filter chip, never a peer card [O from IA]. Active state mirrors the existing `is-active` ink-on-surface treatment [O].
3. **S2 flight-card tap** — Opens a confirm sheet, not navigation. Sheet shows the swap impact ("Releases your held 7:10 a.m. seat"). Primary confirms; ghost cancels and the held seat is undisturbed. Undo on S3 same as above.
4. **S4 "Add to Wallet"** — Tap hands off to OS sheet. On return: tile swaps icon to a checkmark + "In Wallet" label for the rest of the session [R]. If the sheet is dismissed without saving, no state change. No toast — the tile *is* the receipt.
5. **S4 "Save offline"** — Tap writes itinerary to IndexedDB/service-worker cache. Success: tile flips to "Saved · tap to view offline" with timestamp. Failure: tile shows "Couldn't save — try again" inline; no modal. This action must work with no network (it is *the* offline action).

## 5. Handoffs

**Message-to-Accessibility-Specialist**

> A11y — focus order per screen below. **S1**: brand → status-strip (decorative, `aria-hidden` already set [O]) skipped → eyebrow → H1 → lede → held-card as `role="group"` with `aria-label="Held seat offer"` [O] → primary → secondary → reassurance. **S2**: brand → H1 → lede → filter chip group (`role="group"`, chips as `role="button"` with `aria-pressed`) → "Held for you" landmark → flight-list → "Back to the held seat" link. **S3**: each support card is an `<article>` with the action row as the focus target after its h3 [R]. **S4**: summary card as a labeled region with four `<dl>`-style sub-regions, then micro-actions as a button group, then SMS footer. **Dialogs** (S2 confirm-switch, S3 inline errors, S4 hotel-fail): native `<dialog>` with focus trap, return focus to invoking control, Esc dismisses. **Keyboard**: Tab order matches visual; Enter activates buttons and cards; Space toggles chips; on S2 the card-tap-to-confirm pattern needs a redundant Enter handler — least sure this announces well via SR (does the dialog title carry the swap impact clearly?). **Gestures**: no swipe-only actions; horizontal chip scroll has keyboard-arrow equivalent. Please redline the dialog model and the chip group semantics.

**Message-to-Visual-Designer**

> Vis — I need a treatment for **Expired-Hold** state of the held-seat card (S1 default and S2 pinned). It can't just be the default card without the pulse — the user needs to *see* something changed. Proposal: desaturate the moss surface toward Surface-2, swap eyebrow color to Ink-3, drop the pulse, add a hairline-only "Refresh" affordance inside the card. Also need a **cascading-cancel** variant — same card shape but danger-aware without screaming (perhaps a thin Danger hairline on the meta strip only, not a red fill). Can you spec both? Second small ask: confirm-dialog (used on S2 swap and S3 errors) — radius, padding, and shadow tokens, since you said hairline-only for cards but a dialog probably needs the 8px soft drop.

## Open questions

- Hold duration: is the underlying inventory system capable of a 20-min PNR lock? [A] — needs eng confirm.
- "Take credit instead" chip — does taking credit close the trip entirely or leave support (hotel/meal) on the table? Behavioral and content question.
- S4 "Forward to family" — SMS share vs. OS share-sheet? Defer to content-designer for tone, but I'd default to OS share-sheet for trust.

---

## Messages-to-teammates (verbatim for relay)

**To Accessibility-Specialist:**

> A11y — focus order per screen below. **S1**: brand → status-strip (decorative, `aria-hidden` already set [O]) skipped → eyebrow → H1 → lede → held-card as `role="group"` with `aria-label="Held seat offer"` [O] → primary → secondary → reassurance. **S2**: brand → H1 → lede → filter chip group (`role="group"`, chips as `role="button"` with `aria-pressed`) → "Held for you" landmark → flight-list → "Back to the held seat" link. **S3**: each support card is an `<article>` with the action row as the focus target after its h3 [R]. **S4**: summary card as a labeled region with four `<dl>`-style sub-regions, then micro-actions as a button group, then SMS footer. **Dialogs** (S2 confirm-switch, S3 inline errors, S4 hotel-fail): native `<dialog>` with focus trap, return focus to invoking control, Esc dismisses. **Keyboard**: Tab order matches visual; Enter activates buttons and cards; Space toggles chips; on S2 the card-tap-to-confirm pattern needs a redundant Enter handler — least sure this announces well via SR (does the dialog title carry the swap impact clearly?). **Gestures**: no swipe-only actions; horizontal chip scroll has keyboard-arrow equivalent. Please redline the dialog model and the chip group semantics.

**To Visual-Designer:**

> Vis — I need a treatment for **Expired-Hold** state of the held-seat card (S1 default and S2 pinned). It can't just be the default card without the pulse — the user needs to *see* something changed. Proposal: desaturate the moss surface toward Surface-2, swap eyebrow color to Ink-3, drop the pulse, add a hairline-only "Refresh" affordance inside the card. Also need a **cascading-cancel** variant — same card shape but danger-aware without screaming (perhaps a thin Danger hairline on the meta strip only, not a red fill). Can you spec both? Second small ask: confirm-dialog (used on S2 swap and S3 errors) — radius, padding, and shadow tokens, since you said hairline-only for cards but a dialog probably needs the 8px soft drop.
