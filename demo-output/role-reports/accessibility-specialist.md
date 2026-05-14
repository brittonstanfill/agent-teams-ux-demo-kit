# Accessibility Specialist — Canceled-Flight Recovery Audit

Audit target: `/demo-output/prototype/index.html`. Scope: WCAG 2.1 AA + WCAG 2.2 AA additions (2.4.11, 2.5.8). Mobile-first, screen-reader-aware. Findings classified BLOCKER (must change before lead red-team) / NEAR-BLOCKER (lead's call) / NOTE.

---

## 1. Summary

- **BLOCKERs: 3**
- **NEAR-BLOCKERs: 4**
- **NOTEs: 6**

Verdict: the prototype is **structurally sound and fixable in one surgical pass**. The Visual Designer has been careful — skip link present, focus-visible defined, target sizes mostly honored, reduced-motion honored, lang attribute set, heading order valid, decorative SVGs aria-hidden, dynamic values clearly marked. The blockers are concentrated in one ARIA pattern (the decision cards), one focus-target gap (skip link / cross-screen anchors), and one heading-relationship issue on Screen 5. Each is a small DOM change.

---

## 2. Findings

### BLOCKER 1 — Button semantics destroyed by `role="listitem"`

| | |
|---|---|
| **WCAG** | 4.1.2 Name, Role, Value (A); 1.3.1 Info and Relationships (A) |
| **Location** | `index.html` Screen 2, `.decisions` block (lines 833–857) |
| **Selector** | `button.decision[role="listitem"]` (three instances: primary, default, subordinate) |

The three primary decision cards on Screen 2 are `<button>` elements with `role="listitem"` applied. ARIA `role` overrides the implicit role of the host element. A screen reader encountering `<button role="listitem">` will announce "list item" and **drop the "button" role entirely** — the user no longer hears that it's actionable, no longer hears the activation hint, and on some AT/browser combinations the button is no longer reachable as a form control via SR rotor/forms-list.

**Fix for Visual Designer:** Remove `role="list"` from `.decisions` and remove `role="listitem"` from each `<button class="decision …">`. If the list semantic is desired, wrap each button in `<li>` inside a `<ul class="decisions">` — buttons keep their role, the list keeps its role, no ARIA needed.

```html
<ul class="decisions">
  <li><button class="decision primary" type="button">…</button></li>
  <li><button class="decision" type="button">…</button></li>
  <li><button class="decision subordinate" type="button">…</button></li>
</ul>
```

**What this feels like for the user:** A VoiceOver user on iPhone, at 10:46 p.m., tired, lands on Screen 2 and starts swiping. They hear: "How would you like to get there. Heading level 2. Pick one. You can change your mind on the next screen. List, three items. Rebook on another flight. Confirmed seat on a later flight. Most travelers choose this. List item." They have no idea this is a button. They double-tap because they have to try something, and it might work, or it might not — the activation cue they rely on for "this is the thing I tap" has been silently stripped by an ARIA misuse. This is the screen the entire flow pivots on, and the screen reader user is least confident here.

---

### BLOCKER 2 — Skip link and cross-screen anchors target non-focusable elements

| | |
|---|---|
| **WCAG** | 2.4.1 Bypass Blocks (A); 2.4.3 Focus Order (A) |
| **Location** | `index.html` line 729 (skip link), lines 798, 798→917→932→947→1012 (cross-screen primary CTAs that use `href="#frame-N"`) |
| **Selector** | `a.skip-link[href="#frame-1"]`; `a.btn.btn-primary[href="#frame-2"]`; `a.btn-secondary[href="#frame-4"]` (×3); `a.btn.btn-primary[href="#frame-5"]` |

The skip link points to `#frame-1`, which is a `<figure>` element. `<figure>` is not focusable by default. When a sighted keyboard user activates the skip link, the browser scrolls but **focus does not move into the figure**, so the next Tab keypress returns them to the top of the page or to the next ancestor focusable element — defeating the skip. Same problem applies to every primary CTA that uses `href="#frame-N"` to advance to the next screen: a screen reader user activates "See my rebooking options," the URL updates, but their reading position does not move to Screen 2's heading.

**Fix for Visual Designer:** Add `tabindex="-1"` to each `<figure id="frame-N">`. This makes them programmatic-focus targets without exposing them in the tab sequence. Also add a visible focus style for `:focus` on those figures so sighted keyboard users can see where they landed (or move focus to the `<h2>` heading inside instead — preferred). Optional belt-and-braces: in production, attach a small script that runs on hash-change and calls `.focus()` on the section's `<h2>` heading after setting `tabindex="-1"` on it.

---

### BLOCKER 3 — `<section aria-labelledby>` references work; but Screen 5's `confirm-hero` puts the eyebrow + check before the heading in DOM order, and the eyebrow text "Confirmed" is the second thing the SR hears before the actual confirmation sentence

| | |
|---|---|
| **WCAG** | 1.3.1 Info and Relationships (A); 1.3.2 Meaningful Sequence (A) |
| **Location** | Screen 5, `.confirm-hero` (lines 1043–1051) |
| **Selector** | `.confirm-hero > .check` (decorative, OK), then `<p class="eyebrow">Confirmed</p>`, then `<h2 id="s5-heading">` |

The section starts with `aria-labelledby="s5-heading"` — good. But in reading order, a screen reader user hears: "Confirmed. You're booked on the open brace rebooked underscore depart underscore time close brace flight tomorrow…" The standalone word "Confirmed" before the heading creates a stutter and, more importantly, the success state should be **announced as part of the heading itself**, not as a preceding decorative eyebrow. This is the moment that tells a tired traveler they're safe; the announcement should be unambiguous on the first hit.

**Fix for Visual Designer:** Either remove the `<p class="eyebrow">Confirmed</p>` from Screen 5 (the heading "You're booked on…" + the green check already convey confirmation, and Screen 5 is the only screen where eyebrow-then-heading-says-the-same-thing-twice happens), or move the eyebrow to be `aria-hidden="true"` so it remains a visual cue without doubling the SR announcement. Recommended: drop the eyebrow on Screen 5 only. Keep eyebrows on Screens 1–4 where they label a category, not the state.

---

### NEAR-BLOCKER 1 — Token strings in dynamic-value slots will be read literally by screen readers

| | |
|---|---|
| **WCAG** | 1.3.1 Info and Relationships (A) — at production time |
| **Location** | Every `<span class="tok">{…}</span>` in the prototype |

A VoiceOver user on this prototype will hear "Your open brace scheduled underscore time close brace flight tomorrow…" The IA report has explicitly scoped tokens as placeholders for runtime substitution, so this is a **prototype-stage artifact, not a shippable bug**. Calling it out as a NEAR-BLOCKER for the production handoff: when these tokens are replaced, ensure no token slot is ever rendered as raw `{token}` text in production. Add a runtime guard: if a token fails to resolve, render the surrounding sentence as a fallback (e.g., "Your flight tomorrow was canceled") rather than leaking braces. The Visual Designer doesn't need to change the prototype HTML for this; the engineering brief does.

---

### NEAR-BLOCKER 2 — Decision card `.consequence` text on the primary (dark) card is 13px

| | |
|---|---|
| **WCAG** | 1.4.4 Resize Text (AA) implication; 1.4.12 Text Spacing (AA) |
| **Location** | `.decision.primary .consequence` (Screen 2, lines 380–397) |

The consequence string "Confirmed seat on a later flight. Most travelers choose this." renders at `--fs-13` (13px) in `rgba(255,255,255,.78)` on `#0F1115`. Contrast is ~10:1, fine. But 13px on a high-stakes decision card is small for the demographic (tired travelers, possibly older eyes, possibly with the phone at arm's length on a dim hotel-lobby setting). Not a strict violation; an inclusive-design recommendation.

**Fix:** bump `.consequence` to `--fs-14` (14px). One token change.

---

### NEAR-BLOCKER 3 — Chip filter buttons (Screen 3) have `min-height: 30px`

| | |
|---|---|
| **WCAG** | 2.5.8 Target Size (Minimum) (AA, 2.2) — passes; industry mobile floor — fails |
| **Location** | `.chip` (line 415–432) |

30px height meets WCAG 2.2 AA's 24×24 floor. It does **not** meet the 44×44 industry mobile target (Apple HIG / Material). For a thumb-tapping user on a phone at midnight, three pill chips in a row at 30px tall is fiddly and easy to mis-tap onto the wrong filter. Especially "Same travel party" — a mis-tap silently changes the list semantics.

**Fix:** bump `.chip` min-height to 36px or 40px and add some inline padding. Confirms with WCAG 2.5.5 (Target Size, AAA) at 44 if you can spare the vertical space, but 36 is a meaningful improvement.

---

### NEAR-BLOCKER 4 — "Change sort" button at `min-height: 24px` sits at the exact floor with no margin around it

| | |
|---|---|
| **WCAG** | 2.5.8 Target Size (Minimum) (AA, 2.2) |
| **Location** | `.sort-line button` (line 441–452) |

24px is the exact minimum. The button sits in a row next to non-interactive text ("Sorted by arrival time.") with no enforced spacing on the left. The 2.5.8 exception for "inline" text targets may apply, but it's the kind of target a tired thumb will miss. Recommend `min-height: 32px` and a tighter visual treatment, or move "Change sort" to a small chip next to the filters.

---

### NOTE 1 — `<button class="decision">` uses inner `<span class="label">` containing the chev arrow

The button's accessible name is computed from all visible text inside it, which includes the `→` glyph. Because the chev is wrapped in `<span class="chev" aria-hidden="true">`, it's correctly excluded from the accessible name. Good. (Just confirming the pattern is intact.)

---

### NOTE 2 — Reason-pill content is system-supplied free text

`<span class="reason-pill">Reason: <span class="tok">{cancellation_reason}</span></span>` — when the system returns the reason, ensure it's plain-language (the brief flags "schedule irregularity" as banned). This is content-designer territory but worth flagging at the a11y handoff: technical jargon in this slot is a 3.1.5 Reading Level concern. Reading-level guardrail goes in the content style guide, not the HTML.

---

### NOTE 3 — `aria-hidden="true"` on the status bar is correct, but the "Step N of 4" indicator is NOT aria-hidden

`<span class="step">Step 1 of 4</span>` will be announced to screen readers in the app-header. That's actually useful — it gives orientation. Keep as-is. No change needed.

---

### NOTE 4 — Token-pill UI contrast against the warm entitlement background

`.tok` has `background: #F1F2F5` with `border: 1px solid #E5E7EB`. When a `.tok` sits inside `.covered` (warm cream background `#FFF6E5`), the boundary contrast between the tok and its surrounding card is roughly 1.07:1 — visually subtle. The token text itself (`#2A2F38` on `#F1F2F5`) is ~13:1, well above 4.5:1. The 1.4.11 Non-text Contrast (AA) requirement applies to UI components that convey state or boundary; tokens here are content slots, not interactive components, so 1.4.11 doesn't strictly apply. Visually, the tok still reads. Not a blocker. Worth bumping the token border to `#D9DCE3` or similar for clearer separation on warm surfaces.

---

### NOTE 5 — `.reason-badge.muted` text contrast is marginal

`color: var(--muted)` (`#5B6470`) on `background: var(--hairline-2)` (`#EEF0F3`) at 12px / weight 600 → ~4.68:1. Passes 1.4.3 (AA) for normal text by a hair (4.5:1 required). Bold 12px is borderline. Recommend tightening the muted color to `#4F5762` to give breathing room above the floor (~5.3:1).

---

### NOTE 6 — Screen-2 "Talk to an agent" button uses `.btn-ghost` styling (underlined link-like text)

This is a `<button type="button">` styled to look like a link. The accessible role is "button" (correct), but the underlined visual treatment will read as a link to many users. Not a violation. Worth a one-line check with the visual designer: do you want the visual to match the role (button = solid border) or the meaning (link-like for de-emphasis)? Either is OK; current state mismatches role and visual cue but neither AT nor sighted user is blocked.

---

## 3. What looks correct (preserves what's working)

- `<html lang="en">` — 3.1.1 Language of Page (A). 
- Heading hierarchy `h1 → h2 → h3` with no skipped levels in document order. 
- Skip link present and visible on focus with high-contrast outline. (Targeting issue separate — BLOCKER 2.)
- `:focus-visible` defined for all interactive elements with 3px outline + 2px offset. Focus indicator color (`#1E40AF`) against white surface ≈ 8.6:1 — well above 1.4.11's 3:1 floor for focus indicators. Focus indicator color on dark `.decision.primary` is `--accent-soft` (`#EAEFFB`) ≈ 17:1 against `#0F1115`. Excellent.
- Decorative SVGs all have `aria-hidden="true"`. Status-bar dots and brand mark correctly aria-hidden.
- `<section aria-labelledby="…-heading">` pattern correctly used on every screen, giving each screen a programmatic accessible name.
- `<figure>` + `<figcaption>` pattern for screen labels — VoiceOver and TalkBack will announce "figure, Screen 1 What happened and what's covered tonight."
- Reduced-motion media query honored: `@media (prefers-reduced-motion: reduce) { * { transition: none !important; } }`. No autoplay, no animation triggers — 2.3.3 Animation from Interactions (AAA) and 2.2.2 Pause, Stop, Hide (A) satisfied by absence.
- Primary CTA `.btn` is 48px min-height — exceeds 2.5.8 (24×24 AA) and meets 44×44 industry floor.
- `.btn-ghost`, `.support a`, `.save-options button` all at 44px min-height.
- `<a href="tel:…">` pattern for the support phone — keyboard-activatable, voice-control friendly, and on mobile triggers the dialer.
- Persistent support affordance on every screen — 3.3.5 Help (AA, 2.2) considered.
- No color-only meaning detected. The warm entitlement module is reinforced by an icon and a labeled heading. The green check on Screen 5 is reinforced by "You're booked on…" text.
- No motion auto-plays. No carousels. No time limits. No flashing.
- The `chip[aria-pressed]` pattern for filters is correct — toggle state is exposed to AT.

---

## 4. What I couldn't assess without live testing

- **Real screen-reader announcement timing** across iOS VoiceOver, Android TalkBack, macOS VoiceOver, NVDA + Firefox, and JAWS + Chrome. The DOM is structured correctly but I can't promise the announcement *feels* right without hearing it on real devices.
- **Hash-change focus behavior** for the cross-screen `href="#frame-N"` anchors in actual mobile browsers (Safari iOS, Chrome Android) versus desktop. BLOCKER 2's fix should be verified with a TalkBack-on-Pixel pass and VoiceOver-on-iPhone pass.
- **Voice Control compatibility.** Each button has visible text matching its accessible name (no aria-label override), which is the right pattern for "Tap Rebook on another flight"-style commands, but I haven't validated against actual Voice Control / Dragon utterances.
- **Cognitive-load testing at 10:46 p.m.** The plain-language status block and the warm "What's covered tonight" module read well for me, awake, in daylight, in audit mode. They need a real moderated session with travelers experiencing actual disruption stress — the strongest accessibility case is also the one I can't validate from HTML alone.
- **Zoom to 200% and reflow at 320 CSS px.** 1.4.10 Reflow (AA). The mockup phone frame is constrained to `max-width: 390px` — at 200% zoom on a 320px viewport it should hold, but the page-level grid (`repeat(3, …)`) on wide screens may produce horizontal scroll. Worth a quick zoom test.

---

## 5. Handoff to Visual Designer — ordered list of changes to clear blockers

Do these three things, in order, to clear the BLOCKERs:

1. **Fix the decision-card list pattern (BLOCKER 1).** Replace the `<div class="decisions" role="list">` containing `<button … role="listitem">` children with a real `<ul class="decisions">` containing `<li><button class="decision …" type="button">…</button></li>`. Remove all `role` attributes on `.decisions` and `.decision`. The CSS already targets `.decision` directly and will continue to work — you may need to add `.decisions { list-style: none; padding: 0; margin: 0; }` and `.decisions li { display: contents; }` (or remove `display: contents` and let the `<li>` participate as the flex child; either works).

2. **Make screen-frame anchors focusable (BLOCKER 2).** On each `<figure id="frame-1" … frame-5">`, add `tabindex="-1"`. As a stronger fix, point the skip link and inter-screen CTAs at the screen's `<h2>` heading id instead (`href="#s1-heading"`, `href="#s2-heading"`, etc.) and add `tabindex="-1"` to each `<h2>`. This guarantees focus moves to the heading on activation, which is the standard accessible pattern for in-page navigation. Update: skip link `href="#s1-heading"`, Screen 1 primary CTA `href="#s2-heading"`, Screen 3 "Confirm this flight" links `href="#s4-heading"`, Screen 4 "Confirm rebooking" `href="#s5-heading"`.

3. **De-stutter Screen 5's confirmation hero (BLOCKER 3).** Remove the `<p class="eyebrow">Confirmed</p>` from Screen 5 only. The heading text "You're booked on the {time} flight tomorrow, {route}." plus the green check icon already convey the success state without doubling the announcement. (Or, if the eyebrow is visually load-bearing, add `aria-hidden="true"` to it — but the simpler fix is removal on this one screen.)

Once those three are landed, the prototype clears my a11y gate for the lead's red-team review. The four NEAR-BLOCKERs (token-resolution guard, consequence font-size bump, chip target size, sort-button target size) are worth doing in the same pass if there's any time; none of them are gates.

---

*End of audit.*
