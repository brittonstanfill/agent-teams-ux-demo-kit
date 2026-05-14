# Visual Designer — Northstar Trip Recovery Prototype

A traveler at 10:46 p.m. with a canceled 6:15 a.m. flight does not need cheer. They need a calm, clear, factual surface that says what happened, shows the real options, surfaces the help that may apply, and lets them leave knowing what to do next. The visual system is built to that brief.

This report covers: aesthetic direction, the token system, the five screens in source order, what I deliberately left rough vs. polished, the viewport-fit proof, and the calls I expect Accessibility and Behavioral to push on. **Section 10 (Audit response) records every change made during the post-audit revision pass.**

---

## 1. Aesthetic direction

**Anchor:** Linear's restraint, crossed with the deliberate quiet of Things 3 and the serious-but-human tone of Stripe's reports. *Quietly serious.* Not playful, not corporate-aviation-blue-stock, not the generic SaaS card grid.

**Mood (3–5 adjectives):** calm, deliberate, grounded, awake-at-night legible, trustworthy.

**Principles (named, defensible):**

1. **Hierarchy is exaggerated under fatigue.** The load-bearing line on S1 ("Your 6:15 a.m. flight NS482 (DEN–LGA) is canceled.") and on S5 ("You're rebooked.") is genuinely large — 22–32px, not a timid 18px. A tired user reads the largest thing first, and that thing should be the truth, not a status chip.
2. **Color carries state, never decoration.** One accent (`#1D4A6B`, a deep slate-teal — "night sky over snow," not corporate aviation blue). The warn tint on the canceled banner and the confirm tint on the rebooked outcome are desaturated; they earn presence by being rare. No accent color appears purely as ornament.
3. **White space is structural.** The vertical rhythm groups content into perceptible blocks before any border is drawn. Borders and tints are quiet support.
4. **Cards earn their chrome.** A card border is only used when the contained element is genuinely tappable or genuinely a unit of trust (a flight card, a support block, a confirmation card). I refused to chrome every paragraph.
5. **Type and weight do most of the work.** Two weights only (400, 600). No 500 — keeps the system honest. Letter-spacing tightens on display sizes (-0.015 to -0.02em) for an intentional, "this was set, not autoflowed" feel.

What the surface should NOT feel like: cheerful, bouncy, Tailwind-component-library-stock, airline-marketing-blue, FAQ-bot-styled. What it should feel like: a serious utility that respects the user's stress.

---

## 2. Layout strategy

**Choice:** Stacked vertical sections, not horizontally arrayed phone-frame mockups.

Why: phone-frame mockups on desktop become layout debt at 390px (the frame either has to disappear or has to become a fixed-width element that exceeds viewport). Stacked sections give five clearly-labeled "screens" that read as one continuous prototype on mobile and as a vertical document on desktop. The IA flow itself is a sequence; stacked sections show the sequence, in source order, with no presentation gimmick fighting it.

Each screen has:
- A small `SCREEN N · purpose` chip at the top (the screen marker is informational, not chrome).
- The screen's own H2 title.
- The IA's specified content in IA-specified order.
- The IA's specified buttons, with the IA's specified labels verbatim.

A masthead names the brand and the document. An intro paragraph plus an SMS rewrite block (per IA §3) sits above S1 so the entire recovery story — message in, trip out — can be read in one pass.

---

## 3. Design tokens

```
Surface       #FAFAF7   warm paper, not stock cool gray
Paper         #FFFFFF
Ink           #0F1419   near-black, slightly blue
Ink-dim       #5A6470
Ink-quiet     #8B95A0
Hairline      #E5E2DA
Hairline-strong #CFCABE
Accent        #1D4A6B   deep slate-teal — Northstar
Accent-soft   #EAF0F4
Warn-ink      #7A2E1F   used only on the canceled banner
Warn-tint     #FBEEEA
Confirm-ink   #1F4A36   used only on the rebooked outcome
Confirm-tint  #E8F0EA
Caution-ink   #6B5316   used on the standby risk note and the fare-difference badge
Caution-tint  #F6EFD8

Type scale    13 / 14 / 15 / 16 / 17 / 18 / 20 / 22 / 24 / 26 / 28 / 32
Weights       400, 600 only
Letter-spacing -0.005 to -0.02em on display sizes
Line-height   1.12 (display) / 1.45 (body) / 1.5 (paragraph)

Radii         6 / 10 / 14 / 20px
Shadow        very low — 0–4px lift, tuned to feel like paper, not floating UI

Tap targets   buttons min-height 48px; chips min-height 36px (informational, not primary actions)
```

The accent appears in: the brand mark, the primary button fill, the "Choose" CTA on option cards, the dot in screen chips, the hover border on tappable cards. Nowhere else. It is a state and trust signal, not a brand wash.

---

## 4. Walkthrough — what each screen does

**Intro + SMS rewrite (above S1).** Lede paragraph anchors the user in the scenario. SMS block uses a paper-white card with a small "SMS · 10:46 p.m." label and a dot in the accent color — a quiet phone-notification metaphor without committing to a fake phone frame. The SMS copy is verbatim from IA §3, including the `{system-supplied link}` placeholder.

**S1 — What happened.** The load-bearing line is the canceled status, set in a warm desaturated red-brown banner. The eyebrow word is "Canceled" in small caps (not "Schedule irregularity"). Below the banner, three labeled rows — Reason / What this means right now / Tonight — laid out as labeled list items with quiet icon marks. Primary button: "See my options." Secondary: "Get help from an agent." Both are full-width on mobile, side-by-side on desktop.

**S2 — Choose how you'll get there.** Three full-width option cards, no pre-selection. Each card has a title, a "Choose →" CTA on the right, and a one-line consequence sentence. The "Wait for standby" card carries an inline caution note ("Standby is not the same as a rebooking. If no seat opens, you stay where you are tonight.") in the muted caution tint — color reinforces the consequence the IA called out as currently under-stated. Below the three cards: a dashed-bordered support link, "See tonight's support — hotel, meals." It is intentionally visually quieter than the option cards (the primary decision is the path) but louder than a footer (it must not be buried). At the bottom, a persistent agent row.

**S3 — Pick a flight.** Filter chips and a sort line at the top — chips read as light, informational, and not as primary actions (small radius pills, 36px height). Three flight cards. Each card has the depart→arrive times in display weight on the left and a reasoned badge stack on the right. **No bare "Recommended."** Badges name the reason: "Earliest arrival," "Nonstop," "No extra cost." When a fare difference exists, it shows in the muted caution tint as "Fare difference {system-supplied}" — surfaced, not hidden, per IA §3. The meta line below each card carries stops/duration/route in a quieter weight. Agent row at the bottom.

**S4 — Review, support, and confirm.** Three peer blocks, in IA-specified order: (1) Your new plan summary, (2) Tonight's support (with two sub-blocks: hotel, meal — each with an "Add support" outlined button in accent color), (3) What changes (baggage / check-in / gate). The support block is **peer** to the plan summary, not a footer FAQ. The primary button is the long one — "Confirm new flight and support" — and it fits cleanly on a single line at 390px in the accent fill. Secondary: "Edit choice." Agent row at the bottom.

**S5 — Your updated trip.** Outcome headline reads "You're rebooked." — not "Trip updated." The headline lives inside a confirm-tinted block with a check eyebrow. Below: a trip-at-a-glance card with the new flight times in display weight, a route eyebrow, a check-in / gate / baggage meta grid. Then a confirmed-support block (mirrors S4's structure, but reads as receipt — no toggles). Primary: "Save to phone." Secondary: "My plans changed — change my trip again." Tertiary: "Talk to an agent." A small dashed re-entry note reassures that the current trip stays as it is until the user confirms a change.

---

## 5. Decisions I expect the audits to push on

1. **The warn tint on the canceled banner.** I picked a desaturated red-brown (`#FBEEEA` tint, `#7A2E1F` ink) rather than a saturated alert red because the user is already tired and the system shouldn't shout. Accessibility will check contrast — `#7A2E1F` on `#FBEEEA` is well above AA for normal text (computed ~8.9:1). I expect them to verify the lighter sub-headline weight inside the banner also clears. The status eyebrow ("Canceled") is in the same ink as the headline, not a lighter shade, so the eyebrow itself is full-strength.

2. **The "Add hotel support" / "Add meal support" outlined buttons** on S4 are styled as accent-bordered outlined buttons at 40px height (not the 48px primary minimum) because they are *secondary commitments inside a card*. Accessibility may push for 44px or 48px to match the global tap-target rule. I'll defer — bump them to 44px on revision pass if asked. (I think they read as sufficiently distinct as inline toggles, but the rule is the rule.)

3. **Default sort = "earliest arrival" on S3.** This is the IA's recommendation, anchored on an assumption about the family-event context. Behavioral may want to either (a) defend the default visibly (a short rationale tag near the sort line), or (b) ship unsorted. I went with the IA's call and made the sort label visible ("Sorted by earliest arrival. Change sort.") so it's at minimum *honest* even if the default itself is a nudge.

4. **No pre-selection on S2 option cards.** All three options have identical visual weight. There is no "recommended" card. I expect Behavioral to verify this reads as truly neutral — particularly that the order itself (rebook → credit → standby) doesn't read as an implicit recommendation. Order matches the IA's section 6 punch-list; defensible.

5. **The intentionally-quiet `support-link` on S2 ("See tonight's support — hotel, meals.")** Visually it's dashed-border, muted ink, full-width — louder than a link, quieter than the three option cards above it. This is intentional hierarchy: the user's job on S2 is to pick a path, and support is a parallel check. Accessibility may want stronger affordance that it is in fact a button.

---

## 6. What I left intentionally crude vs. intentionally polished

**Polished (load-bearing):**
- Type system (two weights, tight letter-spacing, clean scale).
- Color system (one accent, restrained tints, never color-alone meaning).
- Vertical rhythm and hierarchy on every screen.
- Card chrome only where it earns its keep.
- Primary button weight, color, and tap area.
- The "What happened" canceled banner and the "You're rebooked" outcome block — these are the two emotional hinges of the flow.
- No invented data anywhere — every dynamic field is `{system-supplied}` per IA §6's hard rule.

**Intentionally crude:**
- The brand mark is a simple inline-SVG eight-pointed star/compass. It is sufficient for an experiment prototype; a real brand mark would be authored separately.
- No real flight-detail expand state on S3 cards. The cards are tappable to advance, but expanding to see e.g. layover airport in-place is not built — the IA's flow says tap → S4, so I respected that.
- No real filter modal on S3. The chips are visually present, with the IA-named filter categories, but clicking them does not open a filter UI. Behavioral and Accessibility can audit affordance; the filter UX itself is a follow-up.
- No real "Save to phone" output. The primary button on S5 reads but does not generate a static artifact. Out of scope for prototype.
- Icons are inline SVG hand-authored stroke marks; they are intentionally simple and consistent in stroke weight (1.6–1.8px), not illustration-quality.
- No dark mode. Single light theme. Dark mode is a system-design follow-up; the token structure supports it (semantic ink/surface tokens) but I did not author the dark palette.

**Intentionally not present:**
- ARIA attributes beyond `aria-labelledby` and `role` where structurally clear. The Accessibility Specialist will audit and add what's needed — I prefer they author the ARIA than to add ARIA I don't fully understand and have them peel it back.
- Live regions, focus management, focus-visible refinements (basic `:focus-visible` outline-2px accent is set on key interactive elements as a floor).
- A skip link, landmark labels beyond `main` / `banner` / inferred regions.

---

## 7. Viewport-fit claim (the gated requirement)

**Tested with Chrome headless DevTools Protocol (`Emulation.setDeviceMetricsOverride`), top-level page, the actual `demo-output/prototype/index.html`.**

At every tested width — **360, 390, 414, 640, 768, 1024, 1280, 1440, 1920** — the document root yields `clientWidth === scrollWidth`, `overflow === false`, and `offenders: []`.

At 390px specifically:
```
viewport: { w: 390, h: 900 }
docEl:    { clientW: 390, scrollW: 390, overflow: false }
offenders: []
```

To verify the layout itself is clean (not just masked by `overflow-x: hidden`), I retested with the safeguard `overflow-x: hidden` rules commented out. Result: same — zero overflow at 360, 390, 1280, 1920. The `html, body { overflow-x: hidden }` declaration in the shipped file is defense-in-depth, not a cover for layout bugs.

**Claim:** At 390px, no element exceeds viewport width; no horizontal scroll. The five screens stack into a single column. The longest plausible strings — "Confirm new flight and support," "My plans changed — change my trip again," "FARE DIFFERENCE {SYSTEM-SUPPLIED}," "Eligibility: {system-supplied}" — all wrap inside their containers without forcing horizontal extension.

Defensive measures actually used in the layout (not just the mask):
- `box-sizing: border-box` on every element.
- `min-width: 0` on flex children that hold long text, plus `overflow-wrap: anywhere` on the same.
- Grid layouts collapse from 3-col to 2-col to 1-col at named breakpoints (`560px`, `480px`, `380px`) depending on the content density.
- The `.actions` button row uses `flex-direction: column` with `width: 100%` on each button at ≤640px.
- The flight cards drop from `1fr auto` grid to single-column at ≤480px, badges reflow inline.
- No fixed pixel widths on any container that contains user-bound copy or system-supplied placeholders.

---

## 8. Open notes for the auditors

- **For Accessibility:** the canceled banner uses `role="status"` and is also wrapped in a labelled region. The outcome block on S5 has the same pattern. Verify these are the right semantic roles for the moment — `status` is for polite live updates; a static loaded-once status block may not need it.
- **For Accessibility:** focus order in source order matches reading order on every screen. The `tabindex` is left default — every interactive element is a real `<button>`. Verify on screen reader.
- **For Accessibility:** the dashed-bordered support link on S2 and re-entry note on S5 are styled with `border: 1px dashed` — pure decorative, not relying on the dashed style for any meaning, but verify the visual cue is sufficient for an interactive affordance.
- **For Behavioral:** the standby card's inline caution note is the only place I used color (caution tint) to reinforce a copy point. The copy itself says "Standby is not the same as a rebooking. If no seat opens, you stay where you are tonight." — the color is reinforcement, not load-bearing.
- **For Behavioral:** I deliberately did not add a "popular choice" / "most travelers pick this" social proof badge to any option card. Anti-dark-pattern call; flag if you want to revisit.
- **For Behavioral:** the "Save to phone" primary on S5 is the IA's specified primary. The accent fill makes it dominant. If you'd rather "My plans changed — change my trip again" not be visually downweighted as a secondary, push and I'll equalize them on revision.

---

## 9. Files

- `/Users/brittonstanfill/agent-team-experiments/northstar-20260514-0448-topproof-team/demo-output/prototype/index.html` — single self-contained HTML file. No external dependencies. Inline CSS. Two tiny instances of `<svg>` for the brand mark, the row icons, and the trip-card arrow — all inline, no remote fetches.
- `/Users/brittonstanfill/agent-team-experiments/northstar-20260514-0448-topproof-team/demo-output/role-reports/visual-designer.md` — this report.

---

## 10. Audit response (revision pass)

Accessibility Specialist returned 5 BLOCKERS, 8 SHOULD-FIX, 6 NICE-TO-HAVE. Behavioral Scientist returned 2 BLOCKERS, 5 SHOULD-FIX, 3 NICE-TO-HAVE. This section records each item, the fix, and the viewport-fit re-claim. Every change landed in this single surgical pass.

### 10.1 Blockers fixed

**A11y B1 — S2 option cards had broken `role="list"`/`role="listitem"` on `<button>` elements.**
Removed `role="list"` from the `.options` wrapper. Removed `role="listitem"` from each option button. Wrapped the three buttons in `<div class="options" role="group" aria-labelledby="s2-options-h">` with a new `<h3 id="s2-options-h" class="group-h">Your three options</h3>` placed above the meta-line. The h3 uses a `.group-h` style (12px uppercase ink-quiet) — visually quiet, semantically loud, sits as a peer to the screen H2 in source order. Each option button now uses `aria-labelledby="optN-t optN-c"` (and a third id on the standby card for the caution note) so the AT-read name composes the title + the consequence sentence in a coherent phrase.

**A11y B2 — S3 flight cards same broken list+listitem pattern.**
Same fix. Removed both role attributes. Wrapped in `<div class="flights" role="group" aria-labelledby="s3-flights-h">`. Added `<h3 id="s3-flights-h" class="group-h">Available flights, sorted by earliest arrival</h3>` placed between the sort line and the flight stack (the audit's suggestion of "above the filter bar OR above the flight stack" — I chose above-the-flight-stack so the screen reader hears the filter chips, the sort sentence, and then the heading that names the actual list, in that scan order).

**A11y B3 — Flight buttons had no accessible name; would announce as undifferentiated number runs.**
Each flight `<button>` now carries an explicit `aria-label` that reads as a sentence:
- *"Depart 7:10 a.m. tomorrow, arrive 2:48 p.m., 1 stop, 5 hours 38 minutes, DEN to LGA. Earliest arrival."*
- *"Depart 2:40 p.m. tomorrow, arrive 8:22 p.m., nonstop, 3 hours 42 minutes, DEN to LGA. Fare difference applies."* (audit's "fare difference applies" phrasing — keeps the system-supplied literal out of the spoken name)
- *"Depart 6:30 p.m. tomorrow, arrive 2:05 a.m. the next day, 1 stop, 5 hours 35 minutes, DEN to LGA. No extra cost."*

Added `aria-hidden="true"` on every `<span class="sep">→</span>` arrow inside flight cards so the visible arrow stays decorative.

**A11y B4 — `.toggle` was 40px tall, below the WCAG 2.2 floor and below this design system's 48px tap-target baseline.**
Changed `.support-item .toggle` to `min-height: 44px; padding: 10px 14px;`. Matches WCAG 2.2 SC 2.5.8 and the design system's stated floor. Verified: both "Add hotel support" and "Add meal support" buttons render at 44px without breaking the surrounding card rhythm.

**A11y B5 — `role="status"` on the static S1 banner would double-announce on some AT.**
Removed `role="status"` from the S1 `.status` block. Kept `aria-labelledby="s1-status-h"`. Confirmed there is no `role="status"` on the S5 outcome block either (I had not added one originally; I am also not adding one in this pass — the audit was explicit not to).

**Behavioral B1 — S5 outcome asserted hotel/meal confirmation by default; one invented entitlement claim.**
Two changes:
1. Removed the "Hotel and meal support confirmed where the system says you qualify. References below." sentence from the S5 outcome subhead. New subhead reads: *"Tomorrow, 7:10 a.m. from DEN. Details below."*
2. Replaced the two populated support items in the S5 support panel with a single neutral example item showing the conditional pattern. The panel and the example item each carry a `data-render` annotation (`{if user added support}` and `{per item user added on S4}`), and an HTML comment above the panel spells out the rendering rule for engineering. The panel title is `{system-supplied: status — e.g. "Confirmed" or "Pending"}` so the static prototype itself does not assert a status. The example item's status field reads `{system-supplied: status — Confirmed · Ref {…} / Not eligible · {reason} / Pending}` — naming all three valid states so a reviewer sees the system is meant to render honestly, including "not eligible" decisions plainly rather than by silent omission.

**Behavioral B2 — S4 primary button "Confirm new flight and support" wrote a check the toggle UX could not verify.**
**I went with option (a) — dynamic button copy.** The static S4 primary now reads **"Confirm new flight"** (the default state — no support added). Below the button row I added a small commit-hint line: *"Button text updates if you add support — for example, *Confirm new flight and hotel*."* This makes the runtime behavior visible inside the static prototype: the button will become "Confirm new flight and hotel," "Confirm new flight and meal," or "Confirm new flight and hotel + meal" once a toggle is pressed.

Why option (a) over (b): option (a) is anchored in the IA's named-commitment principle ("buttons name the consequence, not the mechanic"). Option (b) (keep the conjunctive copy plus "Added"/"Not added" pills plus a "Reviewed — not needed" affordance) would have required the user to opt out of a default conjunction — silence-as-consent into a button that names something the user did not in fact do. Option (a) inverts that: the button names exactly what the user has authorized, and grows as they authorize more. Behavioral was explicit that (a) was preferred; lead bias was the same; I had no countervailing reason.

I retained the "Added" / "Not added" pill pattern from option (b) anyway, because the pills make the toggle state visually unambiguous *independently* of the commit button. The two mechanisms compose: pills tell you what state each support item is in; the button copy tells you what you are about to commit to. Both signals point the same direction.

### 10.2 SHOULD-FIX shipped (all of them, plus several NICE-TO-HAVE)

**A11y SF2 — Intro and SMS block moved inside `<main>`.** The masthead stays outside `<main>` as the document banner. The intro section is now the first child of `<main>`, so "Skip to main content" lands the user on the lede plus the SMS rewrite — the content they're meant to read.

**A11y SF3 — Skip link added as first child of `<body>`.** Styled `.skip-link` is off-screen by default (top: -100px), appears at top-left on `:focus` with an accent outline. Added `id="main"` to `<main>`. Verified the skip target receives focus correctly.

**A11y SF4 — S2 support-link affordance strengthened.** (Composed with Behavioral SF2.) Changed from `dashed` to `solid` border, swapped surface background to paper white, added a small accent dot on the left, bolder "See tonight's support" lead, hover state now tints the background to `--accent-soft`. Still visually subordinate to the three option cards above it; clearly an actionable container, not a placeholder. Added an explicit `aria-label="See tonight's support — hotel and meals. Check what's available before you commit."` for AT clarity (the button has lots of internal markup; an explicit name avoids any composition surprises).

**A11y SF5 — "Choose →" CTAs inside option-card buttons are now `aria-hidden="true"`.** The visible cue stays for sighted users; the accessible name now reads `{title} — {consequence}` cleanly without the redundant "Choose" word.

**A11y SF7 — "Change sort" promoted from `<span>` to `<button type="button" class="change-sort">`.** Visual treatment also lifted (Behavioral SF4): accent color, underline on hover, 32px min-height. Sighted users now read it as obviously tappable; keyboard users can tab to it; AT users hear a button.

**A11y SF8 — Agent affordance label normalized to "Get help from an agent" on all five screens.** S5's "Talk to an agent" became "Get help from an agent" per the consistency rule (3.2.4). Reconciled with IA punch-list — the consistency floor wins.

**Behavioral SF1 — Travel-credit consequence sentence extended.** New copy: *"Cancel this trip and use the value later. You will not be rebooked, and no flight is held for you. **Expires:** {system-supplied}."* Names the user-job give-up plainly; no invented policy.

**Behavioral SF2 — S2 support-link salience lifted.** (See A11y SF4 above — same change set.) Visual lift: solid border, paper background, accent dot, slightly stronger ink. Still subordinate to the three option cards.

**Behavioral SF3 — S1 "Tonight" row above-fold position verified, not lifted.** I ran a top-level CDP layout probe at 390 × 800 and measured: at S1 in view, the Tonight row sits 406px below the screen title, and the primary button sits 434px below. On a typical mobile usable viewport (≥620px after browser chrome), both fit on one screen with the Tonight row comfortably above the primary button by ~28px. Verified visually in a 720px-tall band capture (`/tmp/s1-band.png` during the revision check). No reordering needed.

### 10.3 Cheap NICE-TO-HAVE shipped

**A11y NH2 — Removed explicit `role="banner"` from `<header>`.** Implicit role is the same; ARIA-light is better.

**A11y NH3 — Removed redundant `aria-hidden="true"` from the inner `<svg>` of the brand mark.** The outer `<span class="brand-mark" aria-hidden="true">` already hides the whole subtree.

**A11y NH4 — Global `:focus-visible` rule added.** Now applies to `.btn`, `.chip`, `.support-link`, `.toggle`, `.change-sort`, `.skip-link`, and `.agent-row .btn`. 2px solid accent outline with 2px offset. The existing `.option` and `.flight` focus-visible rules are retained. Non-text contrast on the focus ring against the surface is 8.95:1 (per accessibility-specialist's contrast math).

**A11y NH6 — Reentry prose on S5 now names the button label exactly.** Was "Use the link above"; now reads "Press *My plans changed — change my trip again* above." Label-in-name match for any AT user reading the prose adjacent to the button.

### 10.4 Deliberately deferred / accepted-as-flagged

**A11y SF1 — Two H1s competing.** Accepted as flagged. The prototype meta-H1 ("A recovery flow that names the event, the options, and the help.") and the five screen-titled H2s are correct for a stacked five-screen prototype document. In production, each screen is its own page with its own H1; this is a handoff note to engineering, not a prototype change.

**A11y SF6 — `{system-supplied}` reads as literal "system supplied" in every AT.** Accepted as documented-for-handoff. The IA's hard rule prohibits invented data. For prototype/audit reading, the verbatim placeholder is the right floor. For real user testing with screen-reader participants, the moderator pre-briefs the convention. For production, the placeholders become real data or humanized fallbacks ("Not yet posted") — never `{system-supplied}` to a real user.

**A11y NH1, NH5** — informational notes. NH1 already correct (`<html lang="en">`). NH5 is a harmless silent CSS feature setting; no action.

**Behavioral SF5 — S3 card "selected" affordance.** Runtime concern. The static prototype's `<button>` advances to S4 on tap; the IA's non-destructive-back rule is the runtime assumption. Documented for interaction-designer/engineering: back-from-S4 must return to S3 without committing, and S3 must not visually indicate a stale "selected" state on return. Not redesigning the static prototype for this.

**Behavioral NH3 — Pre-commit summary on S4.** Deferred with reason. The S4 layout already shows, above the commit button, in order: (1) the new flight summary, (2) the support items with their "Added" / "Not added" pill state, (3) the "What changes" block. Adding a separate "What you're agreeing to" summary block would push the primary button below the fold on 390px (the S4 stack is already dense by the audit's count). The commit-hint line below the buttons ("Button text updates if you add support") plus the dynamic button copy together carry the pre-commit-clarity job that NH3 was after. If telemetry shows S4 regret-call follow-ups, revisit.

**Behavioral NH1, NH2** — defensive nudges to preserve. No code change; recorded for future revisions.

### 10.5 Viewport-fit re-claim (after revision)

Re-ran the top-level CDP probe (`Emulation.setDeviceMetricsOverride`, `document.documentElement` measured directly on the shipped `demo-output/prototype/index.html`) after all revisions landed.

At every tested width — **360, 390, 414, 640, 768, 1024, 1280, 1440, 1920** — the result is identical:

```
docEl: { clientW: <viewport-width>, scrollW: <viewport-width>, overflow: false }
offenders: []
```

Spec width specifically:
```
viewport: { w: 390, h: 900 }
docEl:    { clientW: 390, scrollW: 390, overflow: false }
offenders: []
```

I also re-ran the test with the `html, body { overflow-x: hidden }` defense-in-depth rules **commented out** to ensure the layout itself is clean, not masked. The first pass of this no-mask test surfaced a real overflow at 360 and 390px caused by the new long-string placeholder I added to the S5 support panel (the `support-item-status` had `flex: 0 0 auto` which prevented it from shrinking when its content was a multi-state placeholder like `{system-supplied: status — Confirmed · Ref {…} / Not eligible · {reason} / Pending}`). I fixed the underlying CSS: `.support-item-status` is now `flex: 1 1 auto; min-width: 0; overflow-wrap: anywhere; text-align: right` on wide screens, and `flex-basis: 100%; text-align: left` at ≤480px so it wraps to a second line gracefully. After this fix, the no-mask probe returns zero overflow at every tested width. The mask in the shipped file is true defense-in-depth, not a cover for layout bugs.

**Claim:** At 390px, no element exceeds viewport width; no horizontal scroll. The audit-driven content additions (the new h3 group headings, the longer travel-credit copy, the lifted support link, the commit-hint line, the conditional S5 placeholder strings, and the "Not added" / "Added" status pills) all fit cleanly inside their containers and reflow naturally on smaller viewports.
