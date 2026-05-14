# Accessibility Specialist — Northstar Trip Recovery Audit

A WAS-discipline audit of `demo-output/prototype/index.html` against WCAG 2.1 AA and WCAG 2.2 additions, with explicit attention to the named user: a tired, mobile-only, possibly screen-reader-using traveler at 10:46 p.m. with a 6:15 a.m. cancellation. The visual designer asked me to author the ARIA; I am taking that authority and using it.

Claim labels: **[observed]** from the prototype source, **[inferred]** plausible AT behavior I cannot run on this surface, **[recommendation]** the change required.

---

## 1. Top-line verdict

**Do not ship as-is. Ship after BLOCKERS are fixed.** The contrast math is clean. The heading hierarchy is correct. The reading order matches DOM order, as the IA required. But three semantic patterns will mislead a screen-reader user in ways that, at 10:46 p.m., look like the app is broken: option cards announced through a `role="list"` wrapping `<button>`s with conflicting `role="listitem"`, a `role="status"` on a static load-once banner that may or may not announce depending on AT version, and tap targets that the visual designer explicitly flagged at 40px on the support toggles. None of these are stylistic preferences. All three change what a real user hears or can tap.

Counts: **5 BLOCKERS**, **8 SHOULD-FIX**, **6 NICE-TO-HAVE**.

---

## 2. BLOCKERS

### B1. Option cards on S2 use a broken `role="list"` + `role="listitem"` pattern on `<button>` elements
- **WCAG**: 4.1.2 Name, Role, Value (A); 1.3.1 Info and Relationships (A).
- **Location**: lines 1050–1075. `<div class="options" role="list">` containing three `<button type="button" class="option" role="listitem" aria-labelledby="opt1-t">…</button>`.
- **Problem**: a `<button>` with `role="listitem"` overrides the implicit `button` role. The element will announce as a list item, not as a button — the user will not know they can press it. Conversely, if the AT recovers the button role, the surrounding `role="list"` no longer contains valid list items and the list semantics collapse. NVDA, JAWS, and VoiceOver each handle this differently; none of them handle it well. **[observed in source]**
- **Required change** (Visual Designer must make):
  - Remove `role="list"` from the wrapper and remove `role="listitem"` from each option button.
  - Wrap the three buttons in a `<div role="group" aria-labelledby="s2-options-h">` with an off-screen or visible heading `<h3 id="s2-options-h">Your three options</h3>` (h3 is consistent with the S2 h2). Group is appropriate here because the buttons are *peers in a decision*; list semantics are not load-bearing.
  - The supplementary `<p class="meta-line">Canceled: 6:15 a.m. NS482 (DEN–LGA).</p>` is fine where it is, but should sit *after* the group heading so it does not visually separate the heading from the buttons.

### B2. Flight cards on S3 use the same broken `role="list"` / `role="listitem"` on `<button>` pattern
- **WCAG**: 4.1.2 Name, Role, Value (A); 1.3.1 Info and Relationships (A).
- **Location**: lines 1106–1158. `<div class="flights" role="list">` containing three `<button type="button" class="flight" role="listitem">…</button>`.
- **Problem**: same as B1. The buttons will announce as list items, losing button affordance. **[observed in source]**
- **Required change**: remove the role attributes; wrap the three buttons in `<div role="group" aria-labelledby="s3-flights-h">` with `<h3 id="s3-flights-h">Available flights, sorted by earliest arrival</h3>` placed before the filter bar OR explicitly above the flight stack. The heading also gives screen-reader users a navigable landmark for "the actual list of flights," which the current source order makes them tab past four chips and a sort line to discover.

### B3. Each flight `<button>` will announce as one undifferentiated run of numbers without an accessible name that names the flight
- **WCAG**: 2.4.6 Headings and Labels (AA); 4.1.2 Name, Role, Value (A); 2.5.3 Label in Name (A).
- **Location**: lines 1107–1122 (and the other two flight buttons), e.g.:
  ```html
  <button type="button" class="flight" role="listitem">
    <div class="flight-times"><span>7:10 a.m.</span><span class="sep">→</span><span>2:48 p.m.</span></div>
    <div class="flight-badges"><span class="badge badge-reason">Earliest arrival</span></div>
    <div class="flight-meta">…</div>
  </button>
  ```
- **Problem**: the button has no `aria-label` and no `aria-labelledby`. The accessible name is computed from the concatenated text content. A NVDA/VoiceOver user will hear roughly: *"7 10 a.m. arrow 2 48 p.m. Earliest arrival Tomorrow 1 stop system supplied 5 h 38 m DEN LGA, button."* The arrow glyph announces variably (often as "right pointing arrow" in VoiceOver). The `{system-supplied}` placeholder announces as literal "system supplied" — acceptable for an unwired prototype but worth naming. **[inferred AT behavior, observed source]**
- **Required change**: give each flight `<button>` an explicit accessible name that reads as a coherent sentence. Recommended pattern:
  ```html
  <button type="button" class="flight"
    aria-label="Depart 7:10 a.m. tomorrow, arrive 2:48 p.m., 1 stop, 5 hours 38 minutes, DEN to LGA. Earliest arrival.">
    … visible content unchanged …
  </button>
  ```
  Apply to all three flight buttons, with their own per-flight labels. Hide the arrow `→` glyph from AT (`aria-hidden="true"` on the `<span class="sep">`) so the visible "→" stays decorative. The "Fare difference {system-supplied}" badge content should appear inside the aria-label of card #2 as "Fare difference applies" rather than allowing the screen-reader user to hear the literal phrase "fare difference system-supplied" with no value.

### B4. The S4 "Add hotel support" / "Add meal support" buttons are 40px tall — below WCAG 2.2 minimum target size when the spacing rule isn't met, and below the iOS HIG / Android baseline for a primary commitment in a flow
- **WCAG**: 2.5.8 Target Size (Minimum) (AA, WCAG 2.2).
- **Location**: lines 1200, 1209. `.toggle` rule: `min-height: 40px;` (line 727). Visual Designer explicitly flagged this in their report §5.2 and said "bump to 44px if asked."
- **Problem**: WCAG 2.2 SC 2.5.8 requires that target size be at least 24×24 CSS pixels *or* have a 24px-radius clear spacing zone around the target. The `.toggle` buttons sit inside `.support-item` cards with `padding: 14px 16px` and the toggle has `margin-top: 12px` — the spacing exception can technically be satisfied, but only just, and the toggles are not separated from the card edge. More importantly, these are not utility chips: they are the **commitment to add a hotel** in a flow whose entire purpose is to surface this entitlement. A tired user, with shaky hands, in a moving rideshare, must hit this. The brief's user is mobile-only.
- **Required change**: raise `.toggle` to `min-height: 44px` and `padding: 10px 14px`. Match the global tap-target floor. No defensible reason to keep these at 40px when the rest of the system is 48px. **[observed visual-designer self-flagged; this audit converts the flag to a blocker]**

### B5. The S1 `role="status"` on a static load-once banner will (a) double-announce in some AT and (b) preempt the screen title
- **WCAG**: 4.1.3 Status Messages (AA); 1.3.1 Info and Relationships (A).
- **Location**: line 999. `<div class="status" role="status" aria-labelledby="s1-status-h">`.
- **Problem**: `role="status"` is an `aria-live="polite"` region intended for dynamic status messages that appear *after* the page has loaded — e.g., "Hotel added," "5 flights found." When applied to a static block that is part of the initial DOM, behavior varies: NVDA tends to announce it on page load *in addition* to reading the page in order, which produces the headline "Your 6:15 a.m. flight NS482…" twice — once as a live status, once as the normal flow. VoiceOver on iOS is less consistent. JAWS may or may not announce depending on verbosity settings. The visual designer's own report §8 noted this: *"`status` is for polite live updates; a static loaded-once status block may not need it."* They were right to flag it. **[observed source; inferred AT behavior]**
- **Required change**: remove `role="status"` from the S1 banner. Keep `aria-labelledby="s1-status-h"`. The element already has structural meaning via the surrounding `<section aria-labelledby="s1-h">`; the eyebrow word "Canceled" reads in source order. Same change to the S5 `.outcome` block — it does not have `role="status"` in source (good) but if the team is tempted to add one later, do not. The block reads as the H2 region's first content in source order, which is correct. If the team wants a live announcement when the user *first lands* on S1 from the SMS, that is a system concern (the navigation event triggers an `aria-live` toast, not a baked-in role on the static heading) and out of scope for this prototype.

---

## 3. SHOULD-FIX

### SF1. The page has two `<h1>` elements competing for the document's top-level heading
- **WCAG**: 1.3.1 Info and Relationships (A); 2.4.6 Headings and Labels (AA).
- **Location**: line 980, `<h1 id="intro-h">A recovery flow that names the event, the options, and the help.</h1>` is the only `<h1>`. The five `<h2>` screen titles below are correctly h2. **[observed]** This is technically fine for a single-h1 document, but the H1 is the *prototype meta-description*, not the user's task. A user landing in the middle (deep link, refresh) hears the meta description as the document's top-level heading. **Recommendation**: keep the prototype meta H1 but make sure each `<section class="screen">` has its `<h2>` as expected — that part is already correct. If this were the real product (not a stacked prototype), each screen would be a separate page with its own H1. Note this for handoff to engineering; do not change the prototype.

### SF2. The Intro and SMS rewrite block live *outside* `<main>`
- **WCAG**: 1.3.1 Info and Relationships (A); 2.4.1 Bypass Blocks (A — landmark approach).
- **Location**: lines 979–987 (intro) sit between `<header role="banner">` and `<main>` (line 989). **[observed]**
- **Problem**: the intro is content the user is meant to read. Putting it outside `<main>` means a "Skip to main content" / "navigate by landmark" gesture lands the user on Screen 1's `<section>` and misses the lede plus the SMS rewrite. For an audit/prototype document this is arguably fine; for a real product surface this would be wrong.
- **Recommendation**: move `<section class="intro">` and the SMS block inside `<main>`. The masthead stays in `<header role="banner">`. Banner landmark continues to be the "Northstar Air · Trip recovery / Prototype" line.

### SF3. There is no skip link
- **WCAG**: 2.4.1 Bypass Blocks (A).
- **Location**: none. **[observed: absent]**
- **Problem**: a keyboard-only user must tab through the masthead, the brand link area, and the SMS block before reaching the first interactive control on S1. For a five-screen stacked document, that is real friction. A skip link before everything else lets the user land directly on `<main>`.
- **Recommendation**: add as the very first child of `<body>`:
  ```html
  <a href="#main" class="skip-link">Skip to main content</a>
  ```
  with a `.skip-link` style that positions it off-screen until `:focus`, at which point it appears at top-left. Add `id="main"` to the `<main>` element.

### SF4. The S2 "support-link" is a `<button>` styled to look like a link/note — the affordance is ambiguous to both sighted and AT users
- **WCAG**: 3.2.4 Consistent Identification (AA); 4.1.2 Name, Role, Value (A).
- **Location**: lines 1077–1080.
- **Problem**: dashed border, muted ink, full-width — Visual Designer flagged this themselves (their §5.5). A keyboard user reaches it and may not know it's pressable. A screen-reader user hears "See tonight's support — hotel, meals. Check what's available before you commit. Right arrow, button." which is fine, but the visual affordance for sighted users is below par. The visual designer asked the audit to verify; I'm calling it.
- **Recommendation**: keep the button semantics. Strengthen the visual affordance: solid (not dashed) `1px solid var(--hairline-strong)` border, a faint hover background of `var(--accent-soft)`, and rename the `aria-hidden` arrow to be inside the accessible-name flow as "View support." Final pattern stays a button; visual cue becomes unambiguous.

### SF5. The "Choose" CTA inside each S2 option-card button is a `<span>`, not a separate control — but its visual placement on the right with an `→` glyph reads as a separate action to sighted users
- **WCAG**: 2.5.3 Label in Name (A).
- **Location**: lines 1051–1075 (the `<span class="option-cta">Choose</span>` inside each option button).
- **Problem**: a sighted user might try to tap *only* "Choose →" expecting it to be a discrete action. It is part of the surrounding button (correct), and the entire card is the hit target (correct), but the visual decoupling invites a user to think there is sub-action structure. For AT users, the word "Choose" is read aloud as part of the button name — which means each card announces something like *"Rebook on a Northstar flight Choose, See available flights tomorrow…"*. That is acceptable but adds a redundant word. **[observed]**
- **Recommendation**: make "Choose →" `aria-hidden="true"`. The visible visual cue stays for sighted users; the accessible-name flow becomes `{option title} — {consequence sentence}` which is what the user needs to hear.

### SF6. The `{system-supplied}` placeholder will read as the literal phrase "system supplied" in every AT
- **WCAG**: 3.3.2 Labels or Instructions (A) — interpretive concern for a prototype.
- **Location**: line 1011, 1064, 1118, 1132, 1153, 1177, 1182, 1183, 1199, 1202, 1206, 1218, 1219, 1220, 1252, 1258, 1266, 1270, 1271, 1283, 1290 (every dynamic field).
- **Problem**: a screen-reader user demoing this prototype will hear "Reason: system supplied" and "Expires: system supplied" and "Eligibility: system supplied" repeatedly. For a *prototype*, acceptable — the IA explicitly said do not invent data. For a *user test* with a real screen-reader user, this is going to be jarring and will require an explainer ahead of the session.
- **Recommendation** (prototype): leave as-is, document the convention in the README/handoff so test moderators can pre-brief screen-reader participants. **Recommendation** (production): replace with real values or, if unknown at render time, with a humanized placeholder like "Not yet posted" or omit the field. Never ship "{system-supplied}" to a real user.

### SF7. The `<span class="quiet">Change sort</span>` on the S3 sort line is not a button and not focusable, but reads visually as one
- **WCAG**: 4.1.2 Name, Role, Value (A); 1.3.1 Info and Relationships (A).
- **Location**: line 1104. `<p class="sort-line">Sorted by <strong>earliest arrival</strong>. <span class="quiet">Change sort</span></p>`
- **Problem**: visually it looks like a link/button. A keyboard user cannot tab to it. A sighted mouse user might click it and get nothing. A screen-reader user hears "Change sort" with no role announcement. **[observed]**
- **Recommendation**: make it a `<button type="button">Change sort</button>` styled identically. The Visual Designer can keep the same `.quiet` look; just change the element.

### SF8. The "Get help from an agent" / "Talk to an agent" button appears five times on the same document, but with two different visible labels — and a screen-reader user navigating by buttons may not realize they are conceptually the same path
- **WCAG**: 3.2.4 Consistent Identification (AA).
- **Location**: lines 1036, 1084, 1162, 1231, 1308. S1, S2, S3, S4 say "Get help from an agent." S5 says "Talk to an agent." **[observed]**
- **Problem**: 3.2.4 requires components with the same function to be identified consistently. "Get help from an agent" and "Talk to an agent" are the same function with different labels. A screen-reader user navigating the document by buttons will hear five "agent" affordances and have to interpret which is which.
- **Recommendation**: normalize. Either all five say "Get help from an agent" (IA's preferred phrasing on S1–S4) or all five say "Talk to an agent." My call: align to the IA's §2 phrasing, "Get help from an agent" across all five. The IA's section 6 punch-list for S5 listed "Talk to an agent" — that should be reconciled with IA; the consistency rule is the floor.

---

## 4. NICE-TO-HAVE

- **NH1**. Add `lang` attribute on any future translated copy fragments. Document is `<html lang="en">` already — good.
- **NH2**. The `<header role="banner">` is redundant: `<header>` at the top level of the document already exposes the `banner` role. Remove the explicit `role="banner"` to avoid over-instrumenting; harmless, but ARIA-light is better.
- **NH3**. The brand `<svg>` mark inside `<span class="brand-mark" aria-hidden="true">` has its inner `<svg aria-hidden="true">` also hidden — redundant double-hide. Either is fine; one is enough.
- **NH4**. `:focus-visible` is only applied to `.option` and `.flight`. Add it globally to `.btn`, `.chip`, `.support-link`, `.toggle`, and the agent-row buttons. Visual Designer's report §6 says they set a baseline outline; the audit confirms it is partial. Adding to all interactive elements harms nothing.
- **NH5**. The `font-feature-settings: "ss01", "cv11";` on `<body>` (line 49) is silently dropped on system fonts that lack these stylistic sets. Harmless; just noting.
- **NH6**. The `.reentry` element on S5 (line 1302) describes a re-entry path in prose but does not contain an actual `<a>` or `<button>` — the "Use the link above" phrasing refers to the secondary button "My plans changed — change my trip again." Adequate, but a screen-reader user navigating linearly may not connect the prose to the button. Consider making the prose say "Press 'My plans changed — change my trip again' above" so the label-in-name match is exact.

---

## 5. What the prototype got right (load-bearing for the lead's synthesis)

- **Single `<main>`. Single `<h1>`. Heading order is correct.** Five `<section>` blocks, each with a labelled `<h2>` via `aria-labelledby`. The IA's "source order = reading order" prerequisite is delivered. **[observed]**
- **Real `<button type="button">` for every interactive control.** No `<div onClick>` patterns. Keyboard reachability is complete. **[observed]**
- **Color is never the sole signal.** The canceled banner has the word "Canceled" as a textual eyebrow plus the headline. The S5 outcome has "Confirmed" as a textual eyebrow plus "You're rebooked." The standby card has the inline caution note as full text — the caution tint reinforces, doesn't carry. Badges on S3 each carry a textual reason ("Earliest arrival," "Nonstop," "No extra cost," "Fare difference {system-supplied}") — color reinforces, doesn't replace. **[observed; IA's structural prerequisite delivered]**
- **Contrast math passes everywhere it matters.** Computed ratios on the actual palette:
  - `#0F1419` ink on `#FFFFFF` paper: **18.5:1** (AAA).
  - `#0F1419` ink on `#FAFAF7` surface: **17.7:1** (AAA).
  - `#5A6470` ink-dim on paper: **6.0:1** (AA pass for normal text).
  - `#5A6470` ink-dim on surface: **5.8:1** (AA pass).
  - `#8B95A0` ink-quiet on paper: **3.04:1** — passes AA for *large text only* (18pt / 14pt bold). Used in the report for eyebrow labels (12–13px uppercase, weight 600) — uppercase 12px at 600 weight does **not** qualify as "large text" by WCAG. Borderline. See SF in section 6.
  - `#1D4A6B` accent on paper: **9.4:1** (AAA).
  - `#FFFFFF` on `#1D4A6B` accent fill (primary button): **9.4:1** (AAA).
  - `#7A2E1F` warn-ink on `#FBEEEA` warn-tint: **8.3:1** (AAA). The visual designer's claim of "~8.9:1" is close — the actual computed value is 8.27:1, still well above AA. The darker `#2A1410` used on the status headline computes **15.4:1**.
  - `#1F4A36` confirm-ink on `#E8F0EA` confirm-tint: **8.7:1** (AAA). Darker `#142A20` on the outcome headline: **13.1:1**.
  - `#6B5316` caution-ink on `#F6EFD8` caution-tint: **6.4:1** (AAA).
  - `#1D4A6B` focus-ring color on `#FAFAF7` surface: **8.95:1** for non-text contrast (AAA-level for the 3:1 non-text floor).
- **Two weights only (400/600), tight letter-spacing, generous line-height.** Reads cleanly under fatigue. **[observed]**
- **`prefers-reduced-motion` honored.** Line 956: all transitions zeroed under reduced-motion. The only transitions in the file are 80–120ms hover/active states; nothing animates on load, no autoplay, no parallax, no vestibular risk. **[observed]**
- **Primary buttons name the commitment.** "See my options," "Confirm new flight and support," "Save to phone" — these read sensibly out of context, which is exactly what a screen-reader user navigating by buttons needs. **[observed; IA-specified, faithfully implemented]**
- **No invented data.** Every dynamic field is `{system-supplied}`. **[observed]**
- **Persistent agent affordance.** Five of five screens have it. Adequate, with the consistency caveat in SF8.

---

## 6. Edge cases the IA flagged as scoped gaps that I'd push to close

- **Refund-seeker path (IA §5)**: as long as Northstar's policy doesn't permit a cash refund on a Northstar-caused cancellation, the agent-handoff absorbs them. From an accessibility standpoint, the agent path must be the *first* tabbable secondary on each screen so a refund-seeker who doesn't see their option on S2 can reach a human without re-navigating cards they don't want. Currently the agent row sits *after* the option cards on S2 — that's correct visual order for a user who wants self-service, but tabbing-wise, screen-reader users who skim option cards first will reach the agent row last. Acceptable; flag if the support-call data still shows refund-seeker abandonment after the redesign.
- **Mid-flow connection loss (IA §5)**: the prototype is single-page so this is silent here. For production: any inline reveal (eligibility result, "Add hotel support" confirmation) must use an `aria-live="polite"` region so the screen-reader user knows the system responded. The visual designer left that to me; my recommendation is that each `.support-item` get a sibling `<div role="status" aria-live="polite" class="support-item-result" hidden></div>` that is populated with the eligibility result string when the toggle is pressed. (In this static prototype the toggles do nothing yet — but the structure should be in place so engineering doesn't bolt it on later.)
- **Image-light / text-only render mode (IA §5)**: the prototype is already text-and-SVG only, no raster images. All SVGs are decorative and `aria-hidden="true"`. The "Save to phone" affordance on S5 is the IA's solution to bandwidth-constrained re-read; from an accessibility standpoint, the saved artifact must preserve heading structure (no flattening to a bitmap). That's a system-build call, not a prototype call. Worth flagging in handoff.
- **Multi-passenger / family (IA §5)**: the S3 filter has a "Travel party" chip; the S4 itinerary has a "Travel party" `<dt>`/`<dd>` row. Both rely on `{system-supplied}` data. From AT, the `<dl>` structure (lines 1179–1184) reads as a definition list — good. When data lands, multi-passenger seating-together status needs to be in the per-flight accessible name (B3's pattern) so the user hears "seats together: yes/no" before tapping. Production note.

---

## 7. What I could not assess without live testing

- **Real screen-reader announcement timing and verbosity across NVDA / JAWS / VoiceOver iOS / VoiceOver macOS / TalkBack.** I can identify the source patterns that will cause divergent behavior (B1, B2, B5), and I can predict the dominant cases, but the exact announcement strings depend on AT version and user verbosity settings. Validate before user testing.
- **Whether the `:focus-visible` outline at 2px solid accent is sufficient against the warm paper surface for low-vision users.** The 8.95:1 non-text contrast suggests yes; a user with central vision loss may still want a thicker indicator. Validate with a low-vision tester.
- **Voice-control compatibility.** Every button has a visible text label and that label is the accessible name (with the exceptions called out in B3 and SF5). Voice control ("Click 'See my options'") should work on every primary affordance after B3 is fixed. Not formally tested.
- **Real reduced-motion behavior on platforms that override the media query** (Windows, some Android builds). The CSS rule is correct; platform handling is out of my hands.
- **Whether the SMS block, sitting outside `<main>` and styled as a "card," is correctly skipped by users who use the SMS-only fallback path.** This is a meta question for the lead — the prototype shows the SMS as a *demonstration* of the rewritten copy. In production, the user receiving the SMS is on their phone's native messages app, not on this page. Audit assumes that's understood.

---

## 8. One paragraph per blocker — what this feels like for the user at 10:46 p.m.

- **B1 (option cards announce as list items, not buttons)**: A screen-reader user lands on Screen 2 expecting to choose a path. They swipe to the next element and hear *"list, three items. Rebook on a Northstar flight, list item."* They wait. Nothing else. They swipe again — *"Take travel credit and arrange later, list item."* They cannot find the action. They press a button gesture; nothing happens because the OS thinks they're on a passive list. They try double-tap (which works on list items in iOS VoiceOver for "activate" but inconsistently for buttons-marked-as-list-items). They get a flicker of feedback, no navigation. They call support.
- **B2 (flight cards same issue)**: Same story, one screen later. By now they have lost faith that this app understands what they are trying to do. They abandon to the phone line, which is the exact metric the brief asked us to move.
- **B3 (flight buttons announce as undifferentiated number-strings)**: Even if B1/B2 are fixed, a screen-reader user navigating by button will hear *"7 10 a.m. arrow 2 48 p.m. Earliest arrival Tomorrow 1 stop system supplied 5 hours 38 minutes DEN LGA, button."* They will hear three of these in a row, mostly identical-sounding. There is no clean way to compare. The Visual Designer's careful badge hierarchy — readable in milliseconds for a sighted user — is reduced to a 12-second monologue per flight for a non-sighted user. At 10:46 p.m., that is the moment they give up.
- **B4 (40px tap targets on Add hotel support / Add meal support)**: A user with a tremor, or holding a child in one hand, or in the back of a rideshare, taps near the toggle and misses. They tap again and hit the card body instead, which does nothing (the card is not a button). They tap a third time, more carefully. The hotel is the entitlement they came here for; this is exactly the moment we cannot make them work. The fix is two CSS values.
- **B5 (role="status" on the static S1 banner)**: A NVDA user lands on the recovery page from the SMS link. NVDA reads the page title, then the live region: *"Your 6:15 a.m. flight NS482 DEN to LGA is canceled."* The user begins to navigate. They reach Screen 1's H2 heading: *"What happened."* They navigate further and hear *"Your 6:15 a.m. flight NS482 DEN to LGA is canceled."* again — this time in flow. The double-announce is disorienting; the user wonders whether something just changed, whether the cancellation is new, whether they are looking at the same flight or a different one. At 10:46 p.m., that confusion costs them a minute and a phone call.

---

## 9. Files

- This report: `/Users/brittonstanfill/agent-team-experiments/northstar-20260514-0448-topproof-team/demo-output/role-reports/accessibility-specialist.md`
- Audited prototype: `/Users/brittonstanfill/agent-team-experiments/northstar-20260514-0448-topproof-team/demo-output/prototype/index.html`
