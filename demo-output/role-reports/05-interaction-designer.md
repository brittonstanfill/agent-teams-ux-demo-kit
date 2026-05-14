# 05 — Interaction Designer: State Model, Microinteractions, Recovery Paths

Posture: deliberate and quiet, per CD. The behavior layer's job is to make the product *settle* under stress — never to perform. Every state declares itself; nothing shimmers. Empty / error / loading are first-class screens, not afterthoughts.

---

## 1. State model (per screen)

### SMS entry surface
| State | Trigger | Surface change | User actions | Fallback |
|---|---|---|---|---|
| `default` | Cancellation event | Lock-screen card renders with fact + deep link + tel: number | Tap link, tap tel:, dismiss | tel: number is always present in body, never behind link (observed-from-brief: IA spec) |
| `link-stale` | Tap >12h after send (assumption) | Deep link routes to current trip status, not the cached fact | Auto-routes to Screen 1 with current state | If trip already resolved, Screen 4 (Receipt) with "Plans changed?" affordance |

### Screen 1 — Status & Stake
| State | Trigger | Surface change | User actions | Fallback |
|---|---|---|---|---|
| `default` | Authenticated deep-link arrival | Fact + state + "See your options" + strip | Tap CTA, view itinerary, call support, tap strip | None needed |
| `logged-out` | Deep link with expired/no session | Auth interstitial shows the fact above the login form (recommendation — auth must not hide the fact) | Login, biometric, "call instead" | tel: link always present |
| `second-cancellation` | Booking has prior canceled segment within 48h (assumption: detectable) | State line names count; entitlements strip shows prior claim status | Same actions, but Screen 2 will reorder | None needed — different content, same frame |
| `loading` | First paint while fetching live state | Fact + state visible from cached SMS payload; CTA shows "Checking..." in `--ink-3`, `aria-busy="true"` | Tap CTA queues the action | If fetch fails: see `offline` |
| `offline` | No network on first paint | Fact + state render from SMS-cached payload; CTA disabled with text "Offline — call to continue"; tel: link elevated to primary visual | Call, retry | (recommendation) Receipt-style cached view of last-known trip state |
| `error-fatal` | Booking lookup returns 5xx | Same header; CTA replaced with "Call Northstar — we couldn't reach your booking" wired to tel: | Call | None |

### Screen 2 — Choose Your Recovery
| State | Trigger | Surface change | User actions | Fallback |
|---|---|---|---|---|
| `default` | Arrive from Screen 1 | Three path cards, none selected, primary CTA disabled | Select a card | n/a |
| `selected` | User taps a path card | Card → `--teal-wash`, `aria-pressed="true"`, primary CTA enables with path-specific verb (cross-fade label in 120ms) | Continue, change selection, tap strip | n/a |
| `re-entry-from-receipt` | Arrived via "Plans changed? Start over" on Screen 4 | Path previously chosen renders as **history card** (see §5) — visible-as-history not visible-as-current. Selection is reset. | Pick again | n/a |
| `path-unavailable` | Standby closed / credit terms expired between fetches | The relevant card renders disabled with single-line reason; remaining cards still selectable | Pick available path or call | tel: in entitlements strip footer always reachable |
| `loading` | Re-fetching path availability on return from background (see §3) | Cards render skeletons-as-static-text (no shimmer per CD); CTA "Checking..." | Wait, call | If >3s, surface "Still checking…" inline; do not block tap-to-call |

### Screen 3 — Confirm the Specific Choice
| State | Trigger | Surface change | User actions | Fallback |
|---|---|---|---|---|
| `default-rebook` | Path = rebook | Sort row + flight cards by arrival, party-status on each | Select flight, open filters, back | n/a |
| `default-credit` | Path = credit | Terms block + dollar value + single "Accept credit" | Accept, back | n/a |
| `default-standby` | Path = standby | Next-flight time + queue estimate + "Add me to standby" | Confirm, back | n/a |
| `party-conflict` | Selected flight has fewer adjacent seats than party | Card's party row turns `--warn` rust + "Only N seats together. Split party?" inline (no modal) | Tap "Split party?" expands inline disclosure with two sub-choices: "Confirm anyway, sit apart" / "Pick a different flight" (recommendation) | n/a |
| `held-seat-expired` | The flight you tapped to confirm was held and lost availability mid-flow | Inline error replaces primary CTA: "Seats just taken — pick another" in `--danger`; card greys with strikethrough on arrival time; focus moves to the next available card (see §3 + §7 to a11y) | Pick another, call | tel: |
| `submit-loading` | User tapped confirm | CTA → `--ink-3`, "Holding seats..." with `aria-busy`, all flight cards become `aria-disabled` (visual: rule color softens) | Cancel (sends release request) | Auto-recover to `submit-failed` after 8s timeout |
| `submit-failed` | Network or server failure on commit | Inline error band above primary CTA (one line, in ink not red): "We couldn't confirm. Your seats are not held. Try again or call." Primary CTA re-enables; tel: surfaces as secondary equal weight (recommendation) | Retry, call | n/a |
| `offline-mid-flow` | Connection lost between selection and confirm | Banner over sort row: "Offline. Your choices are saved on this device. Reconnect to confirm, or call." (recommendation) | Reconnect, call | Saved selection persists locally for return |

### Screen 4 — Receipt
| State | Trigger | Surface change | User actions | Fallback |
|---|---|---|---|---|
| `default` | Confirmation committed | Receipt block paints together (see §2); secondary "Save / share"; tertiary "Plans changed? Start over"; support number is tel: link inside the block | Save, share, claim unclaimed entitlements, start over, call | n/a |
| `offline` | User returns to receipt without network | Renders entirely from cached state (no fetch); a small "Offline — last updated 9:54 p.m." line under stamp (recommendation; UXR low-bandwidth user) | Same actions; share is local share-sheet only | n/a |
| `re-rendered-after-re-entry` | User came back through Plans changed and re-confirmed | New receipt fully replaces; prior receipt is not retained on this surface (recommendation — keeping both would invite "which one is real?" calls) | Same | History accessible via "View itinerary" if engineering wants it |

### Entitlements strip + sheet
| State | Trigger | Surface change | User actions | Fallback |
|---|---|---|---|---|
| `strip-available` | Eligibility detected | Strip shows "Hotel and meal support available — Not yet claimed" | Tap to open sheet | n/a |
| `strip-partial` | One claimed, one not | Strip shows the unclaimed one; status line names what's claimed | Tap to open sheet | n/a |
| `strip-all-claimed` | All claimed | Strip persists with status only ("Hotel claimed — Marriott DEN. Tap for details.") — does not disappear (recommendation: disappearing strip breaks the spatial promise) | Tap for sheet (read-only) | n/a |
| `strip-not-eligible` | No entitlements for this disruption | Strip renders with plain text: "No hotel or meal support applies to this disruption. Tap for why." No teal. (recommendation — concealment is the failure mode UXR called out) | Tap for explanation | n/a |
| `sheet-open` | User taps strip | Sheet slides up 200ms ease-out; underlying screen `inert` + dimmed 35%; focus moves to sheet title | Claim, close, call | Backdrop tap and Esc both close |
| `sheet-claim-loading` | Tap "Claim" | Row replaces "Claim" link with "Claiming…" text in `--ink-3`, `aria-busy` on row | Wait | If >5s, swap to `sheet-claim-failed` |
| `sheet-claim-failed` | Backend error | Row shows one-line inline error in ink (not red) + "Try again" link, with tel: as alternative | Retry, call | n/a |

---

## 2. Microinteractions — answers to VD's three open questions

**Q1: Screen 3 → 4 receipt-paint, stagger or together?**

**Together.** (recommendation) The dl rows arrive as a single 120ms cross-fade with the rest of the surface. Staggered 30ms rows are the kind of motion CD explicitly banned — it reads as the product performing competence. The receipt should *appear settled*, not assemble. The only motion is the cross-fade of the prior screen out. VD's instinct is correct; I'm formalizing it. The confirm code and support number are visually heavy enough that "arrival weight" lands without animation help.

**Q2: "Plans changed? Start over" — visible-as-history state on path cards.**

When Screen 2 re-enters from Screen 4, the previously-chosen path renders as a **history card**, distinct from both default and active:

- Background stays bone-3 (not teal-wash) — it is not a current selection
- Left edge: 3px solid `--ink-3` accent stripe (recommendation — a deliberate "this is past" mark, not teal)
- A `--t-meta` caption above the label: "YOUR PRIOR CHOICE — 7:10 A.M., CONFIRMED 9:54 P.M." (CW owns words; structure is mine)
- The card is still tappable — re-selecting it is allowed and routes through Screen 3 again so the user re-commits explicitly
- `aria-pressed="false"`, `aria-describedby` pointing to the history caption so AT users hear "Rebook on a new flight. Your prior choice, 7:10 a.m., confirmed 9:54 p.m. Not currently selected."

Distinct from the other two cards (default), distinct from teal-wash (active). Three discriminable states at a glance.

**Q3: Sort/filters on Screen 3 — sheet, modal, or in-place?**

**Sheet, with one exception.** (recommendation) Filters open in the same bottom-sheet pattern as entitlements — preserves underlying scroll position, returns focus to the "Filters" link on close, and matches the only modal surface in the product. A full-screen modal would feel like a context switch the user didn't ask for; in-place expansion would push the flight cards below the fold under stress.

**The exception:** the **default filter chip** for party size renders in-place above the sort row as a non-dismissible affordance ("Showing flights for 3 travelers · change"). See §6 — this is the third option I'm proposing in the VD/UXR debate.

---

## 3. Error and recovery paths

The brief's business goal is *reduce calls without hiding help*. Every error path below must therefore (a) tell the truth, (b) keep self-service alive if possible, (c) make "call" one tap away.

1. **Rebook submit fails (Screen 3 → 4 commit).** Server returns error or times out at 8s. State → `submit-failed`. Inline error band above CTA in `--ink` (not red — failure to confirm is not destructive, just incomplete). Held seats are *released server-side*, and the message says so plainly. Primary CTA re-enables as "Try again"; tel: surfaces at equal visual weight beside it. Do not auto-retry — silent retry under stress causes double-bookings.

2. **Entitlement claim fails.** Sheet row enters `sheet-claim-failed`. Other entitlements remain claimable — failure isolates to the row. tel: line at sheet bottom is always visible. Underlying flow state is unaffected; user can dismiss the sheet and continue.

3. **Deep link from SMS arrives logged out.** Auth interstitial **shows the fact above the login form** (recommendation — auth must not hide what the user already knows from the SMS). Form has biometric-first, password fallback, and a "Call to continue without logging in" tel: link. After auth, route to Screen 1 default — do not skip ahead, the fact-acknowledgment beat is load-bearing per UXR.

4. **User loses connection on Screen 3.** Most important error path that isn't obvious from the brief. State → `offline-mid-flow`. The user's selected flight is **persisted to localStorage immediately on tap** (recommendation — selection is cheap, hold-the-seat is the expensive operation that should remain server-side). A banner replaces the sort row with: "Offline. Your choices are saved on this device. Reconnect to confirm, or call." The primary CTA disables but does not vanish; it shows "Reconnect to confirm" in `--ink-3`. When connectivity returns, the banner cross-fades out, the CTA re-enables, and a *new* availability check runs (because state may have changed during offline — see §6).

5. **A flight you held becomes unavailable mid-flow.** This is the most likely "I tapped and it lied to me" moment, and the one I'd most defend hard against. On commit, if the hold-then-confirm returns "seats no longer available": state → `held-seat-expired`. The tapped card greys, arrival time gets strikethrough, the party row's dot fades to `--ink-3`. An inline error replaces the CTA. **Focus management:** move focus to the next available flight card (not back to the disabled one, not into limbo) and announce via `aria-live="assertive"`: "Seats no longer available on the 7:10 a.m. flight. The 6:20 p.m. flight is now selectable." The user does not have to find the failure or hunt the new tappable thing.

6. **User backgrounds the app and returns 20 minutes later.** State on resume depends on where they were:
   - Screens 1–2: silent re-fetch on foreground; if availability changed, show a top-of-surface banner ("Options refreshed at 11:06 p.m.") for 4 seconds, then dismiss. No modal interrupt.
   - Screen 3 with a selection (not yet confirmed): re-validate the selection silently; if it's still available, no change; if it's gone, transition to `held-seat-expired` with the same focus + announcement pattern as path 5.
   - Screen 3 submit-loading state when backgrounded: assume the request completed or failed server-side; on resume, fetch authoritative trip state. If trip is updated, route to Screen 4. If not, restore Screen 3 with a banner: "We couldn't tell if your last attempt succeeded. Your seats are not held. Try again or call." (recommendation — never silently assume failure or success)
   - Screen 4: just re-render from cache. No surprise refresh.

---

## 4. Handoff to human support

CD said no celebratory motion; UXR said the user calls when they feel the system is hiding help. The handoff design is load-bearing because the business goal is *reduce calls without hiding help* — the moment we make "call" feel like failure, we've hidden it.

**Always-on:** `tel:` link visible on Screen 1 (tertiary slot), in the entitlements sheet bottom, inside the receipt block, and as a fallback CTA in every error state. Never behind an icon, never inside a "Help" submenu. (recommendation, observed-from-brief: business goal phrasing)

**Triggers that proactively surface "call" as equal-weight to "retry":**
- `submit-failed` on Screen 3
- `held-seat-expired` after the second consecutive failure
- `error-fatal` on Screen 1
- `offline` longer than 30s on any screen
- `party-conflict` where party size > 4 and no flight has the full party together (recommendation; this is the UXR-flagged "family of 4" failure mode)
- Second-cancellation state on Screen 1 (recommendation — pattern repetition is a trust violation; a human is the right answer here)

**Context passed to the agent (imagining the call lands):** confirmation code (if any), the user's last screen and last action, the canceled flight number, the selected-but-uncommitted flight (if any), entitlement claim status, party size, and elapsed time in flow. The agent should not have to ask "what's going on" — they should open with "I see you were trying to confirm the 7:10 a.m. for 3 travelers; the seats released about a minute ago. Want me to try the 6:20 nonstop?" (recommendation — this is what reduces the call's duration, even if it doesn't prevent it)

**What the user sees while the call connects:** static "Connecting to Northstar — your trip details are with the agent" panel on the same surface. No dial-tone animation, no progress bar. The screen the user was on remains in the background — they can see their context, the agent has it too. If the call drops, the surface persists; the user is not dumped to a home screen.

---

## 5. The "Plans changed? Start over" re-entry pattern

The tap target on Screen 4 is a tertiary link (`--teal-ink`, underlined). Tapping it does not navigate immediately. It opens an inline disclosure right below the receipt with one line of plain text and two equal-weight buttons (recommendation — a confirmation pattern, but not a destructive-style modal, because nothing irreversible happens yet):

- "If you start over, we'll keep your hotel and any claimed entitlements. We'll re-check flight availability."
- `[Keep this trip]` (secondary) `[Start over]` (primary, teal)

On `Start over`: 120ms cross-fade to Screen 2 in `re-entry-from-receipt` state. The previously-chosen path is the **history card** (spec in §2 Q2). Other paths render default. The strip is back, with prior entitlement claims preserved in the status line. The user makes a new selection and proceeds through Screen 3 → Screen 4 normally. The new receipt replaces the prior one.

Crucially, the history card is **tappable** — re-selecting the same path is a valid action. The user is not punished for changing their mind back. (recommendation — the alternative, locking out the prior choice, is dark-pattern-adjacent and would surface another call.)

---

## 6. Position on party-size

**I'm taking a third-option position: a non-dismissible default-filter chip above the sort row, AND VD's party-row on the card.** Both, not either.

VD's solution (party-row inside each card with a colored dot) is good but reactive — the user has to read each card to discover whether the party fits. UXR's stance (surface party at the option-to-flight transition) is correct about *when* the user needs the information, but treating party-size as a filter pretends it's optional. A filter implies the user might want to turn it off. A party of three is not a preference; it's a constraint.

**The third option:**
- A pinned chip above the sort row reads: "Showing flights for 3 travelers — change". It is not dismissible. The "change" link opens an inline disclosure with two sub-actions: "Split travelers across flights" / "Search with fewer travelers (separate booking)". (recommendation; CW owns words)
- Each flight card still carries the party-status row VD specified — but it now reinforces a promise rather than introducing the concept.
- Sort order subtly favors "all-N-confirmed-together" first within each arrival-time band (assumption; UXR's sort research [A2] would validate)

**Why this beats both alternatives:**
- It beats VD-alone because the user doesn't have to scan three cards to discover the constraint; it's stated before the list.
- It beats UXR-alone because party-size is not a filter to toggle; the chip's non-dismissibility says so structurally.
- It beats a modal-asking-party-size-on-entry because the booking already knows the party. We don't ask the user a question we can answer.
- The failure mode UXR called highest-likelihood — "family of 4 picks a flight, discovers no 4 seats, calls" — cannot occur if the chip + card-row pattern both render; the user sees the constraint twice, before and during selection.

If VD pushes back, my fallback is: keep the card-row pattern as primary; add the chip only when party size > 2 (recommendation; small parties are common and the chip becomes chrome). But I'd defend "always show" first.

---

## 7. Handoff messages

### To Accessibility Specialist

State changes the AT user must hear, beyond what's already in `aria-pressed` / `aria-modal`:

1. **Silent offline detection** — when state → `offline-mid-flow` mid-screen, an `aria-live="polite"` region must announce: "Offline. Your selection is saved. Reconnect or call to continue." Do not use `assertive` — the user is not in danger, just stuck. (recommendation)
2. **Held-seat expiry** — `aria-live="assertive"` because the user's last action was just invalidated and focus is about to move. The announcement and the focus-move should be sequenced so the announcement reads first.
3. **Path unavailability mid-flow on Screen 2** — `aria-live="polite"` on the card's disabled state: "Standby is no longer available."
4. **Strip status changes after claiming from sheet** — when the sheet closes and the strip reflects the new claim status, the strip must announce its new status *once* (polite). VD asked about announcement frequency on screen transitions — my answer: announce on status change, not on navigation. The strip's `aria-live` should be `off` by default and only switch to `polite` when its status text changes.
5. **Receipt arrival** — Screen 4 should announce "Trip updated. Your new flight is confirmed for 7:10 a.m." as a polite live message at first paint, not as an alert. The receipt block is `role="region"` with the same text in the visible h1; the live announcement is for users who land on this screen with focus elsewhere.
6. **Re-entry from Screen 4 → Screen 2** — focus moves to the new H1 ("Pick a path."); the history card needs `aria-describedby` to the prior-choice caption so its three-state distinction is communicated, not just visible.
7. **Filters sheet and entitlements sheet** — same focus-trap pattern; on close, focus returns to the originating link, not the top of screen.

If any of these conflicts with your audit, I'd rather restructure the state-machine than band-aid the announcement.

### To Visual Designer

Spec changes I need, framed as "I need X for state Y":

1. **For `held-seat-expired` state on a flight card** — I need a visual treatment for the *disabled-after-tap* card distinct from both default and the warn-rust party state. Suggest: bone-2 fill, ink-3 type, strikethrough on the arrival time, dot in `--ink-3`. Confirm.
2. **For the history card on Screen 2 re-entry** — I need the 3px `--ink-3` left edge accent and a meta caption slot above the label. This is a new sub-component of `.path-card`. (See §2 Q2.) Suggest class `.path-card.history`.
3. **For the party-size default-filter chip** — new component above `.sort-row` on Screen 3. Non-dismissible, but the "change" link opens an inline disclosure. Not a filter pill (no X to close). Style: bone-3 fill, 1px rule, 6px radius, body type, full width. (See §6.)
4. **For `offline-mid-flow` banner on Screen 3** — replaces the sort row; needs a slot. Style should not be alarming — ink-2 type on bone-2, no red. Equal visual weight to the strip below.
5. **For the inline `submit-failed` band on Screen 3** — above the primary CTA, single-line ink-2 type on bone-3 with a 1px rule, no red fill. Red would over-signal what is a recoverable state.
6. **For `strip-not-eligible`** — the strip persists but loses teal entirely. Confirm the type color (suggest ink-2) and that the chevron stays, because the tap-for-why behavior is the trust move.
7. **For the receipt "Plans changed?" inline confirmation** — needs an expandable region below the receipt block with two equal-weight buttons. Spec it as a disclosure, not a modal. (See §5.)

If any of these break the three-sizes-per-screen rule, tell me which one to drop. My priority order: 2 (history card) > 3 (party chip) > 1 (held-seat-expired) > others.

---

*Confidence: state model and recovery paths — high (anchored on IA's flow model and UXR's risk list, no invented policy). Microinteraction answers — high; receipt-together is the CD-aligned call, history-card spec is novel but follows from IA's "visible-as-history" framing. Party-size position — high conviction; the third option resolves a real disagreement rather than splitting it.*
