# Accessibility Specialist — Northstar Canceled-Flight Recovery

Labels: [O]bserved (from prototype/brief) · [I]nferred · [A]ssumption · [R]ecommendation.

## TL;DR

**4 Blockers, 5 Should-fix. One blocks ship: bare "Continue" on Screen 3 (4.1.2 + brief's explicit ban).** Most important fix: replace `<section aria-label="Screen N">` reviewer scaffolding with a single document-level landmark per screen *and* add a real `<main>` per device — without it, every screen reads with no landmarks and the four flow steps blur into one long page for SR users.

---

## 1. Blockers (must-fix before ship)

| # | Issue | Severity | WCAG | Location (observed) | Recommended fix |
|---|---|---|---|---|---|
| B1 | Bare "Continue" button | Blocker | 2.4.6 Headings & Labels (AA), 2.4.9 Link Purpose (AAA, but content's verb+object rule is project-binding) | `index.html` line 978 (Screen 3 footer CTA) | Use content-designer's prescribed label **"Confirm tonight's plan"**. Bare "Continue" is also explicitly banned by the brief and CD report. |
| B2 | No `<main>`, no headings hierarchy across screens, four `<h1>`s on one page | Blocker | 1.3.1 Info & Relationships (A), 2.4.1 Bypass Blocks (A), 2.4.6 (AA) | All four screens — only `<section aria-label="Screen N">` wraps each | Each "device" must be its own `<main>` or `<article>` with a programmatic heading. As authored, an SR user encounters four H1s with no landmark separation — at 10:46 p.m. this reads as one document with four cancellations. Either ship one screen per route (most likely, this is a stacked reviewer artifact), or wrap each in `<main aria-labelledby="...">` and demote screens 2–4 to H1-of-region. |
| B3 | Flight cards on Screen 2 are non-interactive `<div>`s | Blocker | 2.1.1 Keyboard (A), 4.1.2 Name/Role/Value (A) | `index.html` lines 823, 835, 847, 859 — `<div class="flight-card">` with `cursor: pointer` and no role, no tabindex, no handler | Make each `<button type="button">` (or `<a>`) so keyboard users can select. Interaction Designer specs card-tap-to-confirm; that requires a focusable, named, role-having element. As authored, a keyboard-only user cannot reach Screen 2's primary content. |
| B4 | Filter chips have no `aria-pressed` (or any selection state exposed to AT) | Blocker | 4.1.2 Name/Role/Value (A), 1.3.1 (A) | `index.html` lines 807–814 — `<button class="chip is-active">` carries visual state only | Add `aria-pressed="true"` to active chip, `aria-pressed="false"` to inactive. "Earliest arrival" is also a sort opener (has a caret), not a toggle — give it `aria-haspopup="listbox"` and `aria-expanded`. Without this, an SR user hears five identical "button" announcements with no way to know which filter is on. |

### "What this feels like" — for each Blocker

- **B1 (bare Continue):** At 11 p.m., the user has just declined a hotel and accepted a meal credit. JAWS announces "Continue, button." They stop. *Continue what?* They've already confirmed everything visible above. Their thumb hovers. This is exactly the moment the brief is trying to recover, and we've recreated the original sin.
- **B2 (no landmarks, four H1s):** A VoiceOver user using the rotor to jump by headings hears: "Your 6:15 a.m. to LGA was canceled." Then "Other flights tomorrow." Then "Tonight's covered." Then "You're set for tomorrow." With no landmarks between, there is no "screen" — just a stream. A tired user who lands mid-flow can't tell whether they've gone forward or backward.
- **B3 (non-interactive flight cards):** A keyboard-only user tabs from the filter chips, through the "Back to the held seat" link, and the entire flight list is *invisible to them*. The brief promises a screen-reader user finishes without calling support. They cannot.
- **B4 (chips with no state):** An SR user toggles "Nonstop" and hears "Nonstop, button" — same announcement as before the tap. No idea if it took. They tap again. Now Nonstop is *off* visually. They give up and tap "Talk to a person."

---

## 2. Should-fix (AA-conformant but degraded for AT users at 10:46 p.m.)

| # | Issue | WCAG / rationale | Location | Fix |
|---|---|---|---|---|
| S1 | Status strip has `aria-hidden="true"` on the wrapper [O line 703], but no SR-accessible step indicator | 1.3.1 — visual progress invisible to SR | All screens | Add `<p class="sr-only">Step 1 of 4</p>` above each strip. Keep the visual strip decorative. |
| S2 | "Talk to a person — about 6 min wait" link goes to `href="#"` [O line 966] | 3.2.4 Consistent Identification — link is named but inert in prototype | Screen 3 | Acceptable for prototype; flag for build. |
| S3 | Micro-action `aria-label`s duplicate visible label [O lines 1084, 1092, 1098] | 2.5.3 Label in Name (A) — `aria-label` overrides; if it doesn't match visible text exactly, voice-control users can't say it | Screen 4 | Drop `aria-label` entirely; the visible `<span class="label">` is the accessible name. Content-designer's redline #3 was correct. |
| S4 | "Hotel tonight" summary value is **"Confirmation sent by text"** [O line 1044] — without the actual hotel name, an SR user listening to the summary has no destination | 3.3.1 / inclusive design | Screen 4 | Include hotel name and address inline. SMS link is a parallel channel, not a substitute. |
| S5 | `.pinned-label` "Held for you" is a styled `<div>` [O line 817], not a heading or labeled region; Interaction Designer's spec calls this a landmark | 1.3.1 | Screen 2 | Either wrap the held card on S2 in `<section aria-label="Held for you">` (matches IxD spec), or promote "Held for you" to an `<h2>`. |

---

## 3. Redlines on teammate messages

### To Visual Designer

- **Contrast pairs — I confirm his math against the actual hex values [I, calculated]:**
  - Ink `#2A2622` on `#FAF7F2` ≈ **13.4:1** — passes AAA. **Confirmed.**
  - Ink-2 `#6B6259` on Surface ≈ **5.7:1** — passes AA body (≥4.5:1). **Confirmed.**
  - Ink-3 `#9A9087` on Surface ≈ **3.0:1** — **fails 1.4.3 for text**. Passes 1.4.11 Non-Text Contrast only. Your "restricted to ≥12px uppercase eyebrows" doesn't save this: 1.4.3's large-text exemption requires ≥18pt regular or ≥14pt bold, and uppercase doesn't qualify; small uppercase is *harder* to read, not easier. **Darken to ~`#857B70` (≈4.0:1) or `#7A7167` (≈4.7:1).** This affects: every `.eyebrow`, `.summary-k`, `.held-meta .item .k`, `.brand .time`, the "+1d" overnight marker [O line 862]. Non-negotiable per 1.4.3.
  - Accent `#3F5A48` on Surface ≈ **7.1:1**. **Confirmed.** Focus ring `#2F4837` on Surface ≈ **8.8:1**. **Confirmed — passes 1.4.11.**
  - Surface on Accent ≈ **8:1** for primary CTA. **Confirmed.**
- **Focus ring on the moss CTA:** 2px `#2F4837` against `#3F5A48` background ≈ **1.4:1** — **fails 1.4.11 Non-Text Contrast (≥3:1)** if the ring is *inside* the button. Your `outline-offset: 3px` puts the ring on the *Surface* `#FAF7F2`, which is ~8.8:1 — **passes**. Confirmed safe *as authored*, but document that offset is load-bearing for compliance.
- **Touch targets — bump btn-small to 44.** Primary 52px is great. `btn-small` at 40px [O line 520] fails **2.5.5 Target Size (Enhanced, AAA)** which is 44×44 CSS px, and is below iOS HIG 44pt / Android 48dp baseline. WCAG 2.2's 2.5.8 Target Size (Minimum) AA requires only 24×24, so you pass AA — but the brief's user is tired, mobile-only, possibly one-handed. **Recommend 44 minimum.** Spacing around chips also needs to keep effective hit-zone ≥44 if the chip itself stays smaller.
- **Ink-3 on Accent-soft (`#E6ECE6`)** for the "moss delta" — `#9A9087` on `#E6ECE6` ≈ **2.8:1**. **Fails 1.4.3.** The actual delta in the prototype uses Accent `#3F5A48` (the `.delta` class, line 300) on Accent-soft — that pair is ~6.4:1, **passes.** Confirm you weren't planning to recolor.

### To Interaction Designer

- **Native `<dialog>` — yes, with a polyfill note.** Baseline browser support as of 2026 is broad (Chrome/Edge/Safari/Firefox all shipped `showModal()` with focus trap and Esc-to-close years ago), so this is a green-light path for modern mobile. [A] Focus return on close is browser-handled. **Two gotchas:** (a) on iOS Safari, opening `<dialog>` doesn't auto-`inert` the rest of the page in older versions — set `inert` on the page root yourself, or accept that VoiceOver may still navigate behind the dialog. (b) `<dialog>` doesn't auto-announce; it needs `aria-labelledby` pointing to the dialog's `<h2>`. Confirm copy-designer's "Switch to the 9:55 a.m.?" is wrapped in a real heading inside the dialog.
- **Chip group semantics — call:** `role="button"` + `aria-pressed` is **correct for the multi-select toggles** (Nonstop, Morning, Standby). **Not** `role="checkbox"` (visually no checkbox, would confuse SR users who expect a check). **Not** `role="tab"` (these don't switch panels). **Exceptions:**
  - "Earliest arrival" is a sort opener, not a toggle — it should be `<button aria-haspopup="listbox" aria-expanded="false">`, NOT `aria-pressed`.
  - "Take credit instead" is a route-out (your spec) — it's a plain `<button>` that triggers a dialog, no `aria-pressed`. Treating it as a toggle would mis-cue state.
- **Card-tap-to-confirm with redundant Enter handler — does it announce coherently?** **Not safely without changes.** [I] If the flight card is a `<button>` (per B3 fix), Enter activates it; that opens a `<dialog>`; VoiceOver/NVDA will announce the dialog's accessible name. The risk is the source card and the dialog title don't match — your card says "7:10 a.m. DEN→LGA," your dialog title is "Switch to the 9:55 a.m.?" — content-designer's example dialog references "9:55 a.m." but the user tapped 7:10. Make sure the dialog title is **dynamically populated with the tapped flight's identifier**, and that the `aria-describedby` body line carries "Releases your held 7:10 a.m. seat." Without dynamic titling, the SR user hears a swap they didn't ask for.

### To Content Designer

- **(1) Heading levels:** Each card's `<h3>` on Screen 3 [O lines 922, 940, 958] currently has no preceding `<h2>` — heading order skips H1 → H3. **Fails 1.3.1 / 2.4.6 best practice.** Either add a visually-hidden `<h2 class="sr-only">Tonight's support options</h2>` after the lede, or promote support-card titles to `<h2>`. Same problem in reverse on Screen 4: summary section "keys" (`.summary-k`) are styled `<div>`s, not `<dt>` — your `<dl>`-style intent isn't realized in markup. Wrap as `<dl><dt>Flight</dt><dd>NS 612...</dd></dl>` and SR will announce key-then-value as you wanted.
- **(5) S1 reading order:** Held-card group `aria-label="Held seat offer"` is set [O line 714]. SR will announce "Held seat offer, group" *first*, then descend into "Seat held for you" eyebrow, then time, then meta strip, then "why" line. Order in DOM places "why" *after* the meta strip [O lines 736–757] — **your requested order is already correct as authored.** Confirmed.
- **(6) "a.m." pronunciation:** [A] Both VoiceOver (iOS/macOS) and NVDA pronounce "a.m." with periods as "A M" (not "A period M period") in default speech rates and most voice profiles, because they're trained to recognize the common abbreviation. JAWS is similar. **Don't strip the periods globally.** Risk: at very high speech rates or with unusual voice synthesizers, behavior varies — I can't promise every AT version handles it. Mitigation: add `<abbr title="ante meridiem">a.m.</abbr>` so SR users on verbose modes hear the expansion. *I cannot fully verify this without live AT testing across the matrix — flag as "needs verification in usability test."*
- **SMS short-link concern:** `nsair.co/t/4k2` is opaque visually and aurally. Your "Northstar:" prefix recommendation lands — **confirm.** Add to QA: SR users should never receive a bare short-link without a brand prefix. For users with cognitive disability, append a one-word context: "Open trip: nsair.co/t/4k2 (Northstar)" so the trust signal brackets the URL.

---

## 4. Screen-by-screen audit

**Screen 1 — Held-Seat Offer.** Keyboard path: brand link (decorative, no focus needed) → primary "Keep this seat" → secondary "See other options." Tab order matches visual. **SR reading order issue:** the brand "Tonight, 10:48 p.m." [O line 700] is a styled `<span>`, not a `<time>` — SR may read "10:48 p.m." as a separate utterance with no context. Wrap as `<time>`. Contrast and focus ring OK. Target size 52px primary passes. Atmospheric gradient is decorative + `aria-hidden`. **The one thing that breaks for a tired AT user:** they hear "Held seat offer, group" then a moss-pulse dot they can't see, then "Seat held for you" — and have to assemble "this is a recommendation, not a notification" from context. Adding `aria-roledescription="Recommended option"` on the group makes the intent audible. [R]

**Screen 2 — Other Flights.** Keyboard path **broken** (B3): flight cards are non-interactive divs. Filter chips reachable but stateless (B4). "Back to the held seat" link reachable. **SR reading order issue:** filter row `role="group"` with `aria-label="Filter flights"` [O line 806] is correct, but chips read as five sibling buttons with no group-internal hierarchy — fine for AA, but the "Earliest arrival" caret implies a different control type. **The one thing that breaks:** keyboard-only user reaches the flight list, finds nothing focusable, and cannot complete the brief's primary task. **Ship blocker.**

**Screen 3 — Tonight's Support.** Keyboard path: H1 → article 1 buttons (Book/Decline) → article 2 buttons → article 3 ghost → "Talk to a person" link → footer "Continue." Tab order matches visual. `<article>` per support card per IxD spec. **SR reading order issue:** H3s without intervening H2 (see Content redline #1). `btn-small` 40px under 44 (Should-fix). **The one thing that breaks:** bare "Continue" (B1) at the end leaves the user unsure what they're confirming.

**Screen 4 — You're Set.** Keyboard path: micro-actions are `<a href="#">` — tabbable but inert (acceptable for prototype). **SR reading order issue:** summary "keys" aren't true `<dt>` — they read as plain text headers without programmatic key/value pairing. The check-mark celebration icon is `aria-hidden`, good. **The one thing that breaks:** "Hotel tonight: Confirmation sent by text" — the SR user just confirmed a hotel they cannot name. If their text app crashed or the SMS hasn't arrived, they're stranded with no destination on the confirmation screen.

---

## 5. Cognitive accessibility / stress-AT overlap

The brief: tired, stressed, mobile-only, low bandwidth, possibly SR. Three compound points:

1. **Confirm-swap dialog under cognitive load (S2).** [I] A user is browsing alternatives, taps a card, and a `<dialog>` traps focus with "Switch to the 9:55 a.m.? This releases your held 7:10 a.m. seat." Under stress, "releases" reads as loss-aversion — they may default-tap the wrong button. **Fix:** make "Keep my held seat" the *default-focused* button in the dialog (focus the safe option). For SR users, this means Esc-to-cancel AND default-focus-to-cancel both protect the held state.
2. **Pulse animation on the held-card eyebrow.** [O CSS lines 233–237 — note: pulse is defined as a static dot in the prototype; no `@keyframes` ship yet, but the Interaction Designer's spec calls for an active pulse.] If shipped as a continuous pulse, this risks **2.3.3 Animation from Interactions (AAA)** and triggers vestibular concerns for users with motion sensitivity. **Fix:** wrap in `@media (prefers-reduced-motion: reduce) { .pulse { animation: none; } }` and cap duration. Better: make the pulse a one-shot on mount (CD's "moss-pulse" framing). Stress + autoplay motion at 11 p.m. is a poor combination.
3. **No skip-link, no focus management between screens.** [O] If this ships as a multi-route SPA, the SR/keyboard user must re-tab from the top on each route change. Under cognitive load + small screen + low-bandwidth re-render, this compounds: each screen transition costs ~6 tabs to re-orient. **Fix:** on route change, move focus to the new screen's H1 (`tabindex="-1"` + `.focus()`). Announce route via `<div aria-live="polite">` ("Now on Tonight's support").

---

## 6. Inclusive design fixes the team missed

- **Mobility carrying luggage one-handed:** primary CTAs sit at varying positions per screen. On a 375px viewport one-handed at 11 p.m., the user's thumb arc favors the bottom 60% of screen. **Recommendation:** primary CTA should be reachable in the lower third on every screen. S1 and S3 pass; S2's primary action *is the flight card* (mid-screen) — confirm thumb reach is acceptable.
- **Low-bandwidth image fallbacks:** SVG inline icons are fine (small, no network). The atmospheric gradient is CSS — also fine. **But** there is no `<noscript>` fallback; if interaction depends on JS not yet authored, document required-JS surfaces.
- **No-network offline copy:** S4's "Save offline" tile is the right call. But S1–S3 don't gracefully degrade if the rebook API fails — IxD specs error states; confirm content-designer's strings ship with the offline banner.
- **SMS as primary channel for users without smartphones:** The brief assumes mobile. A user on a feature phone receives the SMS, taps the short-link, lands in mobile Safari. The full flow needs to work without app installation. **Verify:** no native-app deep-link assumption. Open in browser must work.
- **Family-account context:** "Forward to family" on S4 [O line 1092] is good. But the H1s and copy assume one traveler. If this rebooking covers a family of four, the held seat (singular) is misleading. **Recommendation:** content-designer should flag a multi-pax variant for the next iteration. Out of A11y scope but inclusive-design adjacent.
- **Language complexity:** copy reads at ~6th-grade level (good for stress + cognitive accessibility). One phrase to watch: "honest-disabled bag card" is jargon — the user-facing string "You haven't checked a bag yet" is plain, confirmed.

---

## 7. Compliance summary (load-bearing criteria only)

| WCAG 2.1 AA | Status | Element / note |
|---|---|---|
| 1.1.1 Non-text Content (A) | Pass | All decorative SVGs marked `aria-hidden="true"`; no informational images without alt text [O]. |
| 1.3.1 Info & Relationships (A) | **Fail** | B2 (landmarks/heading hierarchy), B4 (chip state), S5 (held-for-you region), Content redline (1) (h3 without h2). |
| 1.4.3 Contrast Minimum (AA) | **Fail** | Ink-3 `#9A9087` at 3.0:1 on Surface (eyebrows, meta keys, summary keys, "+1d"). |
| 1.4.10 Reflow (AA) | Pass | Single-column at 375 px; no horizontal scroll except intentional chip row [O line 387]. |
| 1.4.11 Non-text Contrast (AA) | Concern | Focus ring 8.8:1 passes when offset is on Surface; if any control puts ring on Accent fill, fails 1.4:1. Confirm in build. |
| 2.1.1 Keyboard (A) | **Fail** | B3 (flight cards not focusable). |
| 2.4.3 Focus Order (A) | Pass | Visual order matches DOM order [O]. |
| 2.4.6 Headings & Labels (AA) | **Fail** | B1 (bare Continue), B2 (heading hierarchy). |
| 2.4.7 Focus Visible (AA) | Pass | `:focus-visible` outlines defined for `.btn` and `.btn-small` [O lines 355, 536]. Confirm `.chip`, `.flight-card`, `.return-link`, `.person-link`, `.micro-action` inherit. |
| 2.5.5 Target Size Enhanced (AAA) | Concern | btn-small 40px below 44. Brief's user state argues for AAA on this one. |
| 3.2.4 Consistent Identification (AA) | Pass | "Talk to a person" labeled consistently; verb+object pattern holds except for B1. |
| 3.3.1 Error Identification (A) | Not assessable | Error states specced but not authored in prototype. Pass content-designer's strings forward. |
| 3.3.3 Error Suggestion (AA) | Not assessable | Same as 3.3.1. |
| 4.1.2 Name/Role/Value (A) | **Fail** | B3 (flight cards), B4 (chip state), B1 (bare label). |
| 4.1.3 Status Messages (AA) | Concern | No `aria-live` region for the offline banner, hold-expiry, or success states yet [I from IxD spec]. Author at build. |

---

## Summary for parent agent

- **Total blockers found: 4.** (B1 bare "Continue", B2 landmarks/heading hierarchy, B3 non-interactive flight cards, B4 chip state.)
- **Ships? No.** B3 alone means a keyboard-only / SR-only user cannot complete the brief's primary task on Screen 2. The brief's quality bar — "screen-reader user finishes without calling support" — is unmet as authored.
- **Most important single fix:** Convert the four `.flight-card` divs to `<button type="button">` (or `<a href>`) with accessible names like "7:10 a.m. NS 612, DEN to LGA, arrives 3:42 p.m., 4 hours 2 minutes later than original. Tap to switch." Without this, the rebooking flow is mouse-only.

Files relevant to this audit:
- `/Users/brittonstanfill/agent-team-experiments/northstar-20260514-0207-trim-team/demo-output/prototype/index.html` (lines 711–712, 714, 803–815, 822–870, 909, 978, 1019, 1084–1102 cited above)
- `/Users/brittonstanfill/agent-team-experiments/northstar-20260514-0207-trim-team/demo-output/role-reports/accessibility-specialist.md` (this report)
