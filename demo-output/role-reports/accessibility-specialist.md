# Accessibility Specialist Report — Canceled-Flight Recovery

Artifact under audit: `demo-output/prototype/index.html` (single self-contained HTML, five stacked mobile screen mockups).

Standards applied: WCAG 2.1 AA + the new WCAG 2.2 success criteria (2.4.11 Focus Not Obscured, 2.5.7 Dragging Movements, 2.5.8 Target Size Minimum, 3.2.6 Consistent Help, 3.3.7 Redundant Entry, 3.3.8 Accessible Authentication).

Severity legend:
- **Blocker** — must change the HTML before the prototype seals. WCAG-conformance, equivalence, or AT-usability failure.
- **Recommendation** — improves the experience, not a conformance bar at AA.

---

## 1. Audit method

1. **Static keyboard sweep**: read the DOM in tab order, identified every `<button>`, `<a>`, `<input>`, and confirmed each has a real interactive element (no `<div role="button">`). Walked the order: page header → screen 1 button → screen 1 call → screen 2 options × 4 → screen 2 call → screen 3 change → screen 3 filter chips × 3 → screen 3 flight cards × 3 → screen 3 checkbox → screen 3 confirm button → screen 3 call → screen 4 change links × 3 → screen 4 confirm → screen 4 go-back → screen 4 call → screen 5 save-as-image → screen 5 "plans changed" link → screen 5 call.
2. **Focus-visibility inspection**: traced `:focus-visible` rules. Found a single recurring focus-style: `outline: 3px solid var(--action)` (deep forest green `#0f4d3a`) with 2px offset. Then traced every interactive element's background against that outline color.
3. **Landmark and heading audit**: counted `<main>`, `<header>`, `<footer>`, `<section>`, `<article>` elements and every `<h1>`/`<h2>`/`<h3>` to construct the document outline.
4. **ARIA inspection**: walked every `role`, `aria-*` attribute. Cross-checked `role="radiogroup"` / `role="radio"` against ARIA-APG keyboard expectations. Flagged ARIA pattern misuse and redundancy.
5. **Contrast checks**: ran color-pair calculations on every text/background combo and every non-text UI indicator (focus rings, borders, status dots). Background of disabled state was checked against text color, against the live page canvas, and against the rest of the surface palette.
6. **Target size measurements**: pulled `min-height`, `padding`, and parent grid/flex gaps from CSS. Computed effective hit area at the smallest declared size.
7. **State-without-color check**: every `aria-pressed`, `aria-checked`, `aria-disabled` element verified to also carry a text or shape signal.
8. **Live-region semantics**: traced `role="status" aria-live="polite"` placement and considered whether the content is announced on initial load (most ATs do NOT announce live regions populated at parse time — this is a common false-positive pattern).
9. **Motion check**: searched for `transition`, `animation`, `transform: translate` etc. Confirmed the `prefers-reduced-motion` reset is harmless and that no motion is actually used.
10. **Honest-disclosure check**: re-read the disabled standby card, the "Checking eligibility" support items, and the hidden `not-included` state to confirm AT users hear the same honesty sighted users see.

---

## 2. BLOCKERS

These must change in the HTML before the prototype seals. Each is a real WCAG failure or a real AT-experience equivalence gap, not checklist theater.

### B-1. Focus indicator is invisible on the primary action button

- **WCAG**: 2.4.7 Focus Visible (A); 1.4.11 Non-text Contrast (AA); 2.4.13 Focus Appearance (AAA, but the AA floor is failed here too).
- **Location**: `.btn:focus-visible { outline: 3px solid var(--action); ... }`. Applied to "See my options" (Screen 1), "Review and confirm" (Screen 3), "Confirm changes" (Screen 4). The button background is `--action` (#0f4d3a). The outline is the same `--action`.
- **Problem**: a green outline on a green button is effectively invisible. Keyboard-only users land on the primary action of every screen and cannot tell they're there. The 2px `outline-offset` puts the ring against `--paper` white briefly, which gives some contrast, but the inner edge of the ring sits flush on green — the indicator does not have a 3:1 contrast against the *adjacent* color, which is the test 1.4.11 actually applies.
- **Required fix**: use a focus indicator that contrasts against BOTH `--action` and `--paper`. Two patterns work:
  - Two-tone ring: `outline: 3px solid var(--paper); box-shadow: 0 0 0 6px var(--ink-900);` (white inner halo, dark outer ring).
  - Or invert: `outline: 3px solid var(--ink-900); outline-offset: 3px;` and add a thin inner ring via `box-shadow: inset 0 0 0 2px var(--paper)` so the indicator reads against any background.
- **Severity**: Blocker. Keyboard users lose the primary action on three of five screens.

### B-2. Focus indicator is invisible on the selected flight card

- **WCAG**: 2.4.7 Focus Visible (A); 1.4.11 Non-text Contrast (AA).
- **Location**: `.flight-card:focus-visible { outline: 3px solid var(--action); ... }` AND `.flight-card[aria-pressed="true"] { background: var(--action-100); box-shadow: inset 0 0 0 1px var(--action); border-color: var(--action); }`. Together: a green outline appears against a green-tinted background with a green border.
- **Problem**: when a keyboard user tabs onto the already-selected card, the focus ring is hard to distinguish from the selection state. The two states must be visually independent.
- **Required fix**: same two-tone treatment as B-1, OR add a `outline-color: var(--ink-900)` override on the selected variant. Selected and focused are different states and need different visual treatments.
- **Severity**: Blocker. Conformance failure plus a real "where am I" problem for keyboard users.

### B-3. Multiple `<main>` elements in a single document

- **WCAG**: 1.3.1 Info and Relationships (A); ARIA-in-HTML spec; HTML Living Standard.
- **Location**: every `<article class="phone">` contains `<main class="screen-body">` — five `<main>` elements total inside one document.
- **Problem**: a document is allowed exactly one `<main>` landmark (or one perceivable `<main>` if multiples are present, with others hidden). Screen readers expose `<main>` as the "main content" landmark; users navigate to it with a single keystroke (e.g., NVDA's `D` key). Five mains means the AT user is told there are five "main content" regions in one document and must guess which one matters.
- **Required fix**: change `<main class="screen-body">` to `<div class="screen-body">` (semantic neutral, no landmark) OR to `<section class="screen-body" aria-label="Screen body">` if a landmark is needed per screen. The `<article>` already provides the per-screen grouping; the page itself does not need a single document-level `<main>` for a gallery prototype, but if you want one, wrap the entire `.screens` grid in `<main>` and use plain `<div>` inside each phone.
- **Severity**: Blocker. Document semantics are wrong and AT navigation is degraded.

### B-4. Heading hierarchy: six `<h1>` elements, two of them inside one article

- **WCAG**: 1.3.1 Info and Relationships (A); 2.4.6 Headings and Labels (AA).
- **Location**:
  - Page header `<h1>` "Northstar Air — canceled flight recovery" (line 689).
  - Five `<h1 class="screen-title">` elements, one per phone article (lines 710, 760, 826, 933, 991).
  - Plus a SECOND `<h1 id="confirm-headline">` inside Screen 5's confirm-hero (line 997) — this means Screen 5's article contains two `<h1>`s.
- **Problem**: this is a single HTML document. A screen reader reading the document outline hears six h1s. Even granting that each `<article>` could host its own h1 in some interpretations, two h1s inside one article is unambiguously wrong, and the document outline is broken regardless. The brief also flags screen-reader honesty as a concern; an unreadable outline is a screen-reader honesty failure.
- **Required fix**:
  - Keep the page-header `<h1>` ("Northstar Air — canceled flight recovery") as the single top-level h1.
  - Demote all five `.screen-title` h1s to `<h2>`.
  - Demote Screen 5's `confirm-hero` h1 (`#confirm-headline` "You're booked on NS614") to `<h3>` and update its enclosing `<section>` aria-labelledby reference (no other code change needed — the id reference still works).
  - Cascade: existing `<h2>` elements inside screens ("Tonight's support," "What happens next," "Save this summary") become `<h3>`. Existing `<h3>` ("Need a hotel or meals tonight?") becomes `<h4>`.
- **Severity**: Blocker. Outline is broken, multiple h1s in one article is non-compliant, and this is also the visual-designer's open question — see Section 4.

### B-5. Live region on Screen 1 does not actually announce

- **WCAG**: 4.1.3 Status Messages (AA).
- **Location**: `<div class="live-status" role="status" aria-live="polite">Your Northstar flight has been canceled.</div>` (line 714).
- **Problem**: a `role="status"` region that contains text *at page load* is generally NOT announced by NVDA, JAWS, or VoiceOver. Live regions announce *changes* to their content after the region is already in the DOM. The IA spec explicitly required "screen-reader (status announced as a live region on load)" — the current implementation does not satisfy that requirement.
- **Required fix**: drop the `role="status"` (it implies a status that changes), and rely instead on natural reading order. The status sentence should appear in the screen's first meaningful paragraph, before the screen title if necessary, OR be wired up so the live region is empty at parse time and populated by JS after first paint (which is genuine SC 4.1.3 territory). For a static prototype, the honest move is to remove the live-region attributes and let the heading and paragraph be read as content. If the team wants the "first thing announced" behavior, that needs JS that injects the text after a 100-200ms delay. Document this as a build-time requirement.
- **Severity**: Blocker for honesty: the design promised an announcement that does not happen. Either fix the implementation or remove the claim.

### B-6. Flight cards mix `role="radio"` with `aria-pressed` and lack keyboard semantics

- **WCAG**: 4.1.2 Name, Role, Value (A); 2.1.1 Keyboard (A).
- **Location**: Screen 3 `<div role="radiogroup">` containing three `<button class="flight-card" role="radio" aria-checked="..." aria-pressed="...">` (lines 846–869).
- **Problem**: three failures stacked:
  1. **Role conflict**: `aria-pressed` is for toggle buttons. `aria-checked` is for radios. Using both on the same element confuses ATs about which state to announce.
  2. **Keyboard pattern violation**: an ARIA radiogroup is expected to support arrow-key navigation between radios, with only the checked radio in the tab order (roving tabindex). The prototype gives every flight card `tabindex` 0 by default (they're `<button>`s), so Tab moves through all three. No JS implements arrow keys. This is the ARIA-APG "broken radio" pattern.
  3. **No initial selection in the markup but the second card is marked `aria-checked="true"`** — that's fine in isolation, but with `aria-pressed="true"` *also* on the same card, screen readers will announce "selected, pressed" which is incoherent.
- **Required fix** (two acceptable patterns, pick one):
  - **Pattern A — single-select toggle buttons** (simpler, no keyboard rewiring): remove `role="radio"` and `aria-checked` from each flight card. Keep `aria-pressed`. Change the wrapping `role="radiogroup"` to `role="group"`. Tab order works as-is, and SRs announce "button, pressed" or "button, not pressed."
  - **Pattern B — true radio group** (correct ARIA, requires JS): keep `role="radio"` and `aria-checked`. Remove `aria-pressed` entirely. Remove the `<button>` element and use `<div role="radio" tabindex="0">` OR keep `<button>` and add `tabindex="-1"` to unchecked radios. Add JS that handles arrow keys to move focus, Space/Enter to select, and updates `aria-checked` + `tabindex` accordingly.
  - For a prototype, Pattern A is the lighter fix and is honest about not having JS. Recommended.
- **Severity**: Blocker. The current state is ARIA misuse and will cause incoherent screen-reader announcements.

### B-7. Disabled standby card hides its "Unavailable" label from screen readers

- **WCAG**: 1.3.1 Info and Relationships (A); 4.1.2 Name, Role, Value (A).
- **Location**: `<span class="choose" aria-hidden="true">Unavailable</span>` inside the disabled standby option-card (line 788).
- **Problem**: the visible word "Unavailable" — the most important signal that this option is closed — is `aria-hidden="true"`. The card does have `aria-disabled="true"` which most screen readers announce as "dimmed" or "unavailable," and there is a `.why-disabled` line in the DOM. But the visible label says "Unavailable" while the AT user hears no such word from the choose-affordance area. Sighted and non-sighted users get different signals. The IA report's "visible honesty beats hidden absence" principle is violated by hiding the word "Unavailable" from AT.
- **Required fix**: remove `aria-hidden="true"` from the disabled card's `.choose` span. (Keep it on the other cards' "Choose ›" spans — those are decorative arrows.) Alternatively, split the markup: leave the chevron-affordance arrow aria-hidden on enabled cards, and use a plain `<span class="choose">Unavailable</span>` (no aria-hidden) on the disabled card.
- **Severity**: Blocker. Equivalence failure under the IA's own honesty rule.

### B-8. Recap-chip "Change" button drops below WCAG 2.2 target-size minimum

- **WCAG**: 2.5.8 Target Size (Minimum) (AA, WCAG 2.2).
- **Location**: Screen 3, line 833: `<button class="link-btn" type="button" style="min-height:auto; padding: 0;">Change</button>`.
- **Problem**: the `.link-btn` class normally enforces `min-height: 44px`, but the inline `style="min-height:auto; padding: 0;"` override collapses the button to the text's intrinsic height (~22px) with effectively no padding. Effective target is ~50×22px — fails the 24×24 minimum of SC 2.5.8 because the height is under 24px. There is also insufficient inactive-spacing around it (it sits flush with surrounding text and an adjacent "Change" link).
- **Required fix**: remove the inline style override. Keep `.link-btn`'s default `min-height: 44px`. If the visual designer's concern is that 44px is too tall for the chip context, increase the chip's own padding instead so the button doesn't dominate, or use a smaller inline padding of 8px vertical (giving roughly 38px effective height) AND ensure 24px of unobstructed spacing around it — but the cleanest fix is to honor the existing 44px floor.
- **Severity**: Blocker. WCAG 2.2 AA failure.

### B-9. Screen 4 inline "Change" links are too small for SC 2.5.8

- **WCAG**: 2.5.8 Target Size (Minimum) (AA, WCAG 2.2).
- **Location**: Screen 4 recap rows: `<a href="#" class="text-link edit" aria-label="Change flight">Change</a>` × 3 (lines 943, 948, 953).
- **Problem**: `.text-link` declares no `min-height` and is rendered as inline text. The "Change" word is approximately 50×22px. It sits adjacent to surrounding text on its row. Effective target is under 24×24 and the spacing exception of 2.5.8 cannot be relied on because the link is inside a content row, not surrounded by ≥24px of empty space.
- **Required fix**: convert these to `<button class="link-btn">Change</button>` (which carries the 44px min-height), OR add a wrapping affordance: `display: inline-block; min-height: 44px; min-width: 44px; padding: 10px 12px;` to the `.text-link.edit` selector. Either keeps the visual treatment small but gives the tap area what 2.5.8 requires.
- **Severity**: Blocker. WCAG 2.2 AA failure, repeated three times on a critical confirmation screen.

### B-10. Filter chip state change is not announced

- **WCAG**: 4.1.3 Status Messages (AA).
- **Location**: Screen 3 filter chips (lines 839–841) and the result count `<p class="filter-meta">Sorted by earliest arrival. 3 flights match.</p>` (line 843).
- **Problem**: when a user toggles a filter chip in a real implementation, the visible result count updates ("3 flights match" → "2 flights match"). The current markup has no live region around that count, so AT users hear nothing change. Sighted users get visual feedback (chip color flip + count update); AT users get only the chip's `aria-pressed` state flip.
- **Required fix**: wrap the result-count paragraph in `<div role="status" aria-live="polite" aria-atomic="true">` (or add the attributes directly to the `<p>`). Note this only matters when the JS to update the count exists; in the prototype, mark the element with the attributes so the contract is documented. Pair this with the B-5 note — the difference is that this element starts empty/unchanged at load and is updated *after* user action, which is exactly when `role="status"` works correctly.
- **Severity**: Blocker for the contract. The static prototype demonstrates state, and the live-region scaffolding must be in place so engineering inherits the right pattern.

---

## 3. RECOMMENDATIONS

Lower priority. None block the seal; all improve the audit floor.

1. **Add a skip-link or screen-jump nav at the top of the page.** Five stacked phone mockups means a keyboard user tabs through every interactive element in screen 1 before reaching screen 2. A small `<nav>` after the page header with five anchor links ("Screen 1: What happened," "Screen 2: …") would let reviewers jump and would model real-app skip-link behavior. Not strictly required (this is a gallery, not the live app) but it's the kind of detail that signals craft. *WCAG 2.4.1 Bypass Blocks (A).*

2. **Filter chips at 36px — bump to 44px and accept the row wrap.** See full answer in Section 4. Not a 2.5.8 failure as long as they stay above 24×24, but at 10:48 p.m. fatigue, a 44px target is the right call. *WCAG 2.5.5 Target Size (AAA — aspirational).*

3. **Add `aria-current="step"` or `aria-current="page"` to step indicators.** The "Step 2 of 4" eyebrow is plain text; if step indicators ever become navigable (and they should for back-tracking), `aria-current` should mark the active step. *WCAG 4.1.2.*

4. **Wrapping `<label>` AND `for=` on the support checkbox is redundant.** Pick one. Most AT handles both, but some announce the label twice. Drop the `for="accept-support"` since the input is nested. *Best practice, not a violation.*

5. **`.call-link` is an `<a href="tel:...">` styled as a button.** SR users may hear "link, Call Northstar at 1-800-555-0482" which is correct, but consider whether the assistive-tech mental model on iOS (where tapping `tel:` confirms before dialing) matches user expectations under stress. Add a brief visible hint like "tap to call" near the link, or accept that platform conventions handle this.

6. **Status bar mock chrome (`<div class="status-bar" aria-hidden="true">`).** Correctly hidden from AT. Good. Recommendation: if any number/text in that bar ever becomes meaningful (e.g., real network status), drop the aria-hidden — but right now it's correct.

7. **Page-footer "Concept only…" disclaimer uses `--ink-500` (#6b7280) on `--canvas` (#f6f4ef).** Contrast against the warm-off-white canvas is roughly 4.4:1 — borderline. AA passes for normal text at 4.5:1, so this is technically failing by a hair on the warmer background. Either nudge to `--ink-700` or bump the canvas back toward pure white for this region. *WCAG 1.4.3 Contrast Minimum (AA).*

8. **`.option-card[aria-disabled="true"]` background `--ink-100` (#f1f2f5) plus `color: --ink-500` (#6b7280)** — text contrast ≈ 4.3:1, slightly under the 4.5:1 AA floor. Disabled-control text is exempt from 1.4.3 in WCAG (the "incidental" exception applies because the text is not part of an active interface), but the *why-disabled* explanation ("Standby is closed for overnight cancellations…") is the user's only path to understanding the state and must be readable. Bump the why-disabled text color to `--ink-700` so the reason — which is functionally required content — passes contrast. *WCAG 1.4.3 (AA).*

9. **The offline-card's dashed border (`--ink-300` on `--canvas`).** Contrast ratio against canvas is ~1.5:1; the border alone does not satisfy 1.4.11 as a UI component boundary. However, the heading "Save this summary" carries the actual semantic load, so the border is decorative. Acceptable — but note that any future change that makes the border the *only* way to identify this region (e.g., removing the heading) would fail. *WCAG 1.4.11.*

10. **Add `lang` to elements containing flight codes if they ever localize.** Not an issue today; `<html lang="en">` is set correctly. Forward-looking note.

11. **The `<a class="text-link" href="#screen-2">Plans changed again?</a>` on Screen 5 (line 1033)** points to an anchor that doesn't exist (`#screen-2` has no element with id `screen-2`). The prototype's sections are labeled by id `cap-2`. Either fix the href or add `id="screen-2"` to the appropriate section. *WCAG 2.4.4 Link Purpose — passing on purpose, but the link is broken.*

12. **Screen 2 hidden `.not-included` state is in the DOM with `hidden` attribute.** Good practice for showing structure. When un-hidden in a real flow, ensure the change is announced via a live region (same pattern as B-10). *Documentation note.*

13. **"Save as image" button on Screen 5** doesn't currently do anything in the prototype. Acceptable, but in implementation make sure the saved image has alt-text equivalency — i.e., the offline summary is *also* available as selectable text and/or a downloadable PDF for screen-reader users who can't consume an image. *WCAG 1.1.1 Non-text Content (A).*

14. **Add `aria-describedby` from each option-card to a short consequence string** rather than the current inline `.consequence` (which is already linked via `aria-describedby`). Confirm the consequence string is read AFTER the label, not before, so the announce order is: "Rebook on another Northstar flight, button, Get on the next available flight we can offer." Verify in real AT. *Implementation detail.*

15. **Honest review of color independence**: every state I checked (canceled, not-guaranteed, selected, disabled, confirmed) carries text and/or shape in addition to color. *Pass on 1.4.1 Use of Color (A).*

---

## 4. Answers to Visual Designer's specific questions

### Q1. Filter chips at 36px min-height — acceptable, or require 44px with row wrap?

**Answer: I do not block on 36px, but I strongly recommend 44px and I want it on the record.**

- **WCAG 2.2 SC 2.5.8 (AA)** requires a 24×24 minimum target, OR 24px of spacing. The filter chips at 36×~80–120px satisfy 2.5.8 cleanly.
- **WCAG 2.5.5 (AAA)** recommends 44×44. We are not committing to AAA, so this is not a conformance bar.
- **My judgment**: this is a 10:48 p.m., tired-user, mobile-only context. Touch accuracy degrades under fatigue. 36px chips in three colors with two of them off-state look like easy taps until you actually try to tap "Direct only" with your thumb while holding a phone in one hand at the airport. 44px is the right call. The row wrap is acceptable — three chips at 44px will wrap to two rows on a 360px viewport with about 12px horizontal gap each. The wrap does not break layout because `.filters` already has `flex-wrap: wrap`.
- **Recommendation, not blocker**: bump `.filter-chip { min-height: 44px; padding: 10px 16px; }`. Accept the row wrap on narrow viewports. If this requires sacrificing a filter (showing only two), I'd rather have two 44px chips than three 36px chips for this audience.

### Q2. Each screen has its own `<h1>` inside an `<article>`. Acceptable, or demote to `<h2>` under a single page `<h1>`?

**Answer: Demote to `<h2>`. This is part of Blocker B-4.**

- The "h1 per article" pattern is defensible in *some* HTML5 outline interpretations, but the algorithmic outline (HTML5 sectioning) was never implemented by browsers or screen readers. ATs read the *flat* heading hierarchy. Five h1s in one document is reported to AT users as five top-level headings — confusing and structurally wrong.
- Compounding the problem: Screen 5 currently has *two* h1s in one article (the screen-title and the confirm-hero headline). That's unambiguous failure.
- **Required structure** (this is now part of B-4):
  - Page-level `<h1>` "Northstar Air — canceled flight recovery" — keep.
  - Screen titles ("What happened," "Choose how to recover," etc.) → `<h2>`.
  - Inner sections inside screens ("Tonight's support," "What happens next," "Save this summary," "You're booked on NS614") → `<h3>`.
  - Sub-blocks ("Need a hotel or meals tonight?") → `<h4>`.
- **Why this matters for the audit**: a screen-reader user navigating by headings (a common shortcut: pressing `H` repeatedly) should hear a clean outline that mirrors the user's mental model — one document with five stages. Six h1s breaks that. The fix is one CSS-less-relevant change: swap the tag, leave the class, the visual size doesn't move.

---

## 5. Sign-off conditions

I will clear this audit when ALL ten blockers (B-1 through B-10) are resolved in the HTML. Specifically:

1. ✅ Focus indicator on primary buttons uses a two-tone or contrasting color that meets 1.4.11 against both `--action` and `--paper`. (B-1)
2. ✅ Focus indicator on selected flight cards is distinguishable from the selected state. (B-2)
3. ✅ `<main>` elements reduced to at most one per document, OR removed entirely from inner `.screen-body` divs. (B-3)
4. ✅ Heading hierarchy collapsed to one page `<h1>`, screen titles as `<h2>`, inner sections as `<h3>`, sub-blocks as `<h4>`. Screen 5's `confirm-hero` h1 demoted. (B-4 + answer to Q2)
5. ✅ Screen 1 live-region claim resolved — either remove the `role="status" aria-live="polite"` (and let the content read naturally) or document the JS dependency for delayed injection. (B-5)
6. ✅ Flight cards converted to single-select toggle pattern (`<button aria-pressed>` with `role="group"`) OR full radio-group pattern with arrow-key JS. Pick one; do not mix `role="radio"`, `aria-checked`, and `aria-pressed`. (B-6)
7. ✅ Standby card's "Unavailable" label removed from `aria-hidden`. (B-7)
8. ✅ Recap-chip "Change" button restored to ≥44px target. (B-8)
9. ✅ Screen 4 "Change" links given ≥24×24 effective target via padding or `<button>` conversion. (B-9)
10. ✅ Filter-result count wrapped in a live region for state-change announcements. (B-10)

Recommendations are not gating, but I'll note which ones the team chose to address vs. defer.

---

## 6. What this feels like for the user — Blocker narratives

**B-1 / B-2 (invisible focus on primary action):** I am a keyboard user. I tab through the page to find my next step. I hear "See my options, button." I press it — nothing happens, because I haven't actually focused it yet, I just heard the AT preview. I tab again. The visual indicator is supposed to land on the button so I know I'm there. I see the button, I see the button color, I see no ring. I press Enter anyway and it works, but I've spent three seconds being unsure I was in the right place, on a screen that exists to tell me my flight at 6:15 a.m. is gone. That uncertainty compounds across five screens.

**B-3 / B-4 (broken landmarks and outline):** I am a NVDA user. I press `D` to jump to "main content" and I'm offered five regions to choose from. I press `H` to walk headings and I hear six top-level headings in one document. I cannot tell whether this is one app or five. I lose the sense of where I am, which is the exact failure mode the IA brief was trying to solve for sighted users with confusing copy.

**B-5 (live-region that doesn't fire):** I am a VoiceOver user. The team told the IA spec that the cancellation status would be announced as a live region on page load. I open the page. I hear "Trip update. What happened, heading level 1." No announcement of cancellation as status — just the heading. The team thinks they delivered an honest pattern; they didn't. I find the cancellation in the regular reading order, but the "announce-on-load" promise was a paper promise.

**B-6 (broken radio group):** I am a JAWS user choosing a replacement flight. I tab into the flight cards. JAWS says "selected, pressed, radio button" on the second card. I'm confused — am I selecting? Is it already selected? Why is it "pressed" AND "selected"? I press arrow-down expecting the radio group convention. Nothing happens — focus doesn't move. I press Tab and end up on the next card, which is announced as "not selected, not pressed, radio button." The combination of words is incoherent and I have to slow down and re-read each card individually.

**B-7 (Standby "Unavailable" hidden from SR):** I am a screen-reader user looking at recovery options. I hear: "Rebook on another Northstar flight, button," "Refund to original payment, button," "Travel credit, button," "Standby — Not guaranteed, button, dimmed." The word "Unavailable" — which a sighted user sees next to the standby card — is not in my audio. I have to guess from "dimmed" whether this is a temporary state or a permanent absence. The IA spec said "visible honesty beats hidden absence," and what I just heard was hidden absence.

**B-8 / B-9 (Change buttons too small):** I am a user with mild tremor (Parkinson's, MS, cerebral palsy, or just exhausted). The "Change" button is 22px tall and sits between two text blocks. My thumb covers it, misses it, accidentally taps the surrounding text. I try three times before I succeed. The prototype's claim of mobile-first care doesn't reach me.

**B-10 (filter state change silent):** I am a screen-reader user filtering flights. I press "Direct only." I hear "Direct only, pressed." But the result count silently changed from 3 flights to 1 flight. I don't know. I tab into the flight list and only find one card. I assume the filter broke. I back out, untoggle the chip, and walk through all three flights again to figure out what I missed.

---

## 7. What I could not assess statically

The following require live AT testing on real devices:

1. **Actual announcement order in NVDA, JAWS, VoiceOver iOS, VoiceOver macOS, TalkBack.** I traced the DOM but I did not hear it. Verbosity differences across SRs may surface or hide issues I haven't named.
2. **Whether the `tel:` link triggers a confirm-before-call dialog on iOS Safari vs Android Chrome.** Both should; verify.
3. **Whether the `prefers-reduced-motion` media query actually matters here.** No motion is defined; the rule is a safety net. Confirm no future regression introduces motion that bypasses the rule.
4. **Magnification at 400% zoom (SC 1.4.10 Reflow).** The render-gate work suggests this passes, but I haven't tested it. Recommend a manual 400% zoom check before sealing.
5. **Voice-control compatibility (Voice Control on iOS / Dragon).** Voice users say the visible button label to activate it. All visible labels match accessible names (SC 2.5.3 Label in Name) by inspection, but verify with voice in practice.
6. **Real-device touch accuracy on filter chips at 36px.** I'm recommending 44px on judgment; a quick test on a 5–10 person sample under simulated fatigue would settle it empirically.

---

## 8. Summary verdict (not for the report body)

10 blockers, 15 recommendations. Worst single issue: focus indicator invisibility on the primary action button (B-1), repeated across three screens. Verdict: **block-until-revised**. The blockers are mechanical and self-contained — a focused 60-90 minute revision should clear them.
