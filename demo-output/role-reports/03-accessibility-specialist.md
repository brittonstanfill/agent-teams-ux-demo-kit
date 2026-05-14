# Accessibility Specialist Report — Canceled-Flight Recovery Prototype

Labels: **[OBSERVED]** verified in the prototype HTML/CSS, **[INFER]** reasoned from markup without live AT testing, **[ASSUME]** working assumption, **[REC]** recommendation.

Standards referenced: WCAG 2.1 AA, plus WCAG 2.2 additions (2.4.11 Focus Not Obscured, 2.5.8 Target Size Minimum).

---

## 1. Summary

The prototype's foundation is solid for accessibility: clean semantic HTML, no ARIA over-application, true buttons for the choice cards and toggles, generous contrast on body and emphasis text, `prefers-reduced-motion` respected, `lang="en"` set, tokens that wrap with `box-decoration-break: clone` so long values still read as content, and a persistent "Talk to a person" affordance per screen. The contrast palette is comfortably above AA on every text pair I measured. Where it fails today is in three places, all fixable in one revision pass: **(1) the flight cards on Screen 3 are interactive but not keyboard-reachable** — they are `<div>`s wired up by a click handler, so a keyboard or screen-reader user cannot select a flight at all; **(2) the focus ring (`--brand-500` #1f4e8a) has only 1.84:1 contrast against the primary button (`--brand-900` #0b2545)** so a keyboard user landing on the primary action gets no visible indicator; **(3) several interactive controls fall below the 44×44px target floor** — filter pills at ~29px, Accept/Decline toggles at ~40px, and the inline "Talk to a person" help link at ~20px tall. Once those three are fixed the artifact is in good shape against WCAG 2.1/2.2 AA.

---

## 2. Blockers

These must be addressed in the Visual Designer's revision pass before sealing.

### B1. Flight cards on Screen 3 are keyboard-inoperable

- **Location:** Screen 3, `.flight` elements inside `[aria-label="Available flights"]`.
- **What's wrong [OBSERVED]:** The cards are rendered as `<div class="flight" role="listitem">` with no `tabindex`, no `role="button"`, no `<button>` wrapper. The selection behavior is added in JS via a click listener on the parent group. A keyboard user cannot tab to a flight card, cannot press Enter/Space to select one, and a screen-reader user navigating by interactive elements will not encounter them at all. The "Confirm this flight" button below acts on a selection the user cannot make without a mouse.
- **WCAG failure:** 2.1.1 Keyboard (A), 4.1.2 Name/Role/Value (A), 2.4.3 Focus Order (A).
- **Fix [REC]:** Use a radio-group pattern. Either:
  - **(a)** Render each `.flight` as a `<button type="button" class="flight" role="radio" aria-checked="false">` inside a `role="radiogroup" aria-labelledby="..."` parent (drop `role="list"`/`role="listitem"`). Selected card gets `aria-checked="true"`. Add `:focus-visible` outline to `.flight`. Update JS to set/unset `aria-checked` and to support Arrow keys within the group. Or
  - **(b)** Use native `<input type="radio" name="flight" id="flight-1">` with `<label for="flight-1" class="flight">…</label>`, hide the input visually, and style the label as today. This gives keyboard, Space-to-select, and announce-as-radio for free.
  - Whichever pattern is chosen, also replace `aria-current="true"` with the radio's checked state — `aria-current` is for the current page/step, not for "selected item in a list of choices." (1.3.1 Info and Relationships.)

### B2. Focus indicator is invisible on the primary button

- **Location:** `.btn-primary:focus-visible { outline: 3px solid var(--brand-500); outline-offset: 2px; }` rendered on `<button class="btn btn-primary">` on Screens 1, 3, 4, 5.
- **What's wrong [OBSERVED]:** `--brand-500` is #1f4e8a; the button is `--brand-900` #0b2545. Computed contrast between ring and button is **1.84:1**. With `outline-offset: 2px` the ring sits 2px outside the button, against page background (paper white / `--ink-50`), where it is 7.84–8.35:1 — but the ring's *inner edge is adjacent to the button*, and WCAG requires the focus indicator to have ≥3:1 against the adjacent non-focused color of the component it indicates. A keyboard user tabbing to "See my options" / "Confirm this flight" / "Confirm tonight's plan" / "Save offline" sees a faint navy halo on a navy button — effectively no indicator.
- **WCAG failure:** 1.4.11 Non-text Contrast (AA), 2.4.7 Focus Visible (AA), 2.4.11 Focus Not Obscured (Minimum) (AA 2.2) — borderline 2.4.13 Focus Appearance (AAA, advisory).
- **Fix [REC]:** Use a **two-color focus indicator** so it survives on any button color. Two patterns work:
  - **(a)** Inner light ring + outer dark ring: `outline: 2px solid #fff; outline-offset: 0; box-shadow: 0 0 0 4px var(--brand-500);` (white inner against navy button gives 15:1; outer brand-500 against page is 7.8:1).
  - **(b)** Switch the focus ring to a light/warm color when on dark backgrounds: `.btn-primary:focus-visible { outline: 3px solid #ffd166; outline-offset: 2px; }` (yellow against navy is ~9:1; yellow against white is ~1.5:1, but the inner edge of the ring is what's adjacent to the button, so this is fine — verify against the page background by adding a 1px white inset). Pattern (a) is the more robust choice because it handles future button colors too.
- Apply the same pattern to **`.toggle[aria-pressed="true"]`** (selected state has brand-100 bg and brand-900 text — the brand-500 ring contrast against brand-100 is 6.0:1, fine — but the unpressed toggle has white bg and ink-700 text, where the ring is 8.4:1, also fine). The primary-button case is the only contrast failure; fixing it solves the worst of it.

### B3. Touch / pointer target sizes below WCAG 2.2 minimum

- **Location:** Three target classes, three screens.
- **What's wrong [OBSERVED, measured from CSS]:**
  - **Filter pills (`.filter`)** on Screen 3: `padding: 6px 12px` + `font-size: 14px` + `line-height: 1.2` → ~28.8px tall. WCAG 2.2 minimum (2.5.8) is 24×24 CSS px **with spacing exception**; mobile platform guidance (Apple HIG, Material) is 44pt / 48dp. At 28.8px these pass the bare WCAG 2.2 floor but fail platform target-size guidance and are uncomfortable for motor-impaired and large-finger users. Designer self-flagged this.
  - **Accept/Decline toggles (`.toggle`)** on Screen 4: padding 10+10 + font 14 with inherited line-height 1.45 → **~40px tall**. (Designer estimated ~38px assuming no line-height; the actual rendered height is closer to 40, but still under 44.) These fall short of platform 44/48 guidance and feel cramped, especially because they sit side-by-side in a 2-column flex row at ~120px wide.
  - **"Talk to a person" links (`.help a`)** on every screen: inline `<a>`, 14px text, no padding, ~20px tall × text-width wide. This is well below 24×24 CSS px **and** the text-link spacing exception does not apply when the link sits in a flex row with another element 12px away.
- **WCAG failure:** 2.5.5 Target Size (AAA) for all; **2.5.8 Target Size Minimum (AA)** for the help link specifically (the 24×24 floor and the spacing exception both fail it). The toggles and filters pass 2.5.8 strictly but fail platform conformance.
- **Fix [REC]:**
  - `.filter`: bump padding to `10px 14px` (→ ~37px tall) and add `min-height: 44px`. The pills are still pill-shaped.
  - `.toggle`: change padding to `12px 16px` and add `min-height: 44px`. The Accept/Decline pair will still fit in the 120px flex track.
  - `.help a`: wrap the link in 10px vertical padding (`padding: 12px 4px; display: inline-block;`) and add `min-height: 44px; display: inline-flex; align-items: center;`. The visual help strip stays the same; the hit area grows. Or move the link to its own line above the meta text so it can be a full-width pressable region.
  - Apply `min-height: 44px` to `.btn` as defense-in-depth even though it already computes to ~48px.

### B4. Screen 1 has a placeholder `{cause_plain}` token that is a sentence fragment, not a label

- **Location:** Screen 1, "The cause was `{cause_plain}`."
- **What's wrong [INFER]:** This is a placeholder, but a screen-reader user will hear it as literal "open brace cause underscore plain close brace" because the `.tok` is rendered as styled text, not via `content:`/CSS pseudo. The IA report explicitly required this — long tokens must be first-class content — so the AT behavior here is correct *for a prototype*. However, the sentence "The cause was {cause_plain}. This was not anything you did." reads strangely without substitution; screen-reader testers reviewing this prototype will hear an ungrammatical fragment. This is a prototype-only artifact, not a shippable defect, but the team should add a one-line note in the recommendation that the prototype's tokens are placeholders and the production string must be grammatical when filled in (e.g. the system substitutes "a crew availability issue" → "The cause was a crew availability issue.").
- **WCAG failure:** None directly; this is content quality, not conformance. Calling out because the brief is explicit about plain language (3.1.5 Reading Level, AAA, advisory).
- **Fix [REC]:** Leave the prototype tokens as-is (they correctly wrap and announce as content), and add to the lead's recommendation: "Placeholder tokens render as `{name}` in the prototype; production strings must substitute readable, grammatical content."

---

## 3. Non-blocking improvements

These don't block sealing. Worth listing for the lead and for a follow-up.

- **N1. Heading hierarchy crosses two contexts [OBSERVED].** `.page-intro h1` is the reviewer-chrome heading; each `<article class="mock">` has its own labeling via `aria-labelledby`. Inside Screen 1, `h-display` is rendered as `<h1>`, then Screens 2–5 use `<h2>`. So the document has two `<h1>`s (page-intro + Screen 1). Each article is `aria-labelledby` to its own caption strong text, which gives correct landmark labeling. A screen-reader user pressing H to jump headings will hear: page-intro h1 → Screen 1 h1 → Screen 2 h2 → Screen 3 h2 → … This is technically valid but slightly noisy. **[REC]** demote Screen 1's `h-display` to `<h2>` for parity with the other screens; keep visual size via the `.h-display` class. (WCAG 1.3.1.)
- **N2. `role="list"` + `role="listitem"` on Screen 3 is unnecessary [OBSERVED].** Once the flight cards become true radios (B1), drop the list semantics — `radiogroup`/`radio` carries its own structure. If the radio-group pattern is rejected, keep the list but switch to `<ul>`/`<li>` with `display: flex; list-style: none;` rather than adding ARIA roles to `<div>`s. ARIA is a last resort; native is preferred.
- **N3. The decorative status-bar SVGs on each phone are `aria-hidden="true"` [OBSERVED, verified clean].** Good. The clock "9:41" text inside `.statusbar` is *not* hidden, so a screen reader will announce "9 41" five times across the page. **[REC]** add `aria-hidden="true"` to the entire `.statusbar` div (currently it has aria-hidden only on the icon span). The "9:41" is decorative chrome, not content.
- **N4. The `<article>` elements use `aria-labelledby="s1-title"` etc., but the labelled element is inside a `<div class="mock-caption">` reading "Screen 1 of 5 What happened" [OBSERVED].** The label resolves to just "What happened" (the `<strong id="s1-title">`), which is correct — but the "Screen 1 of 5" context is lost from the accessible name. **[REC]** include both, e.g. `aria-label="Screen 1 of 5: What happened"` on the article, or restructure the caption so the full string is inside the labelled element.
- **N5. Selected-state for the flight card relies on color + border alone [OBSERVED].** Border changes from `--ink-200` (#d9dde2) to `--brand-700` (#13315c), background from white to `#fbfcfe`. Border contrast change is 9.5:1 between states (strong, passes 1.4.11 non-text contrast). Once B1 is fixed to a radio pattern, this becomes a non-issue because the radio's `aria-checked` carries the state semantically. Without fixing B1, this is a 1.4.1 Use of Color (A) concern — the only state cue is color.
- **N6. The status-token rows on Screen 4 (`Status: {hotel_status}`) [INFER].** When the production system fills the token with "we're checking eligibility" or "not eligible — call us", that string change is a meaningful update. **[REC]** if the status updates *live* on Screen 4 (e.g. eligibility resolves while the user is on the page), wrap the status value in `aria-live="polite"` so the change is announced. If it only updates on screen-load, no live region is needed.
- **N7. Screen 5 has no explicit `aria-live` on the confirmation [OBSERVED].** If Screen 5 is navigated to (not dynamically swapped in), the page-load announcement is sufficient. If it's a route change in an SPA, the team should focus the `<h2>` "You're rebooked…" headline on mount (`tabindex="-1"` + `.focus()`) so the screen-reader user hears the outcome.
- **N8. The standby "Not guaranteed" eyebrow is uppercase with letter-spacing 0.06em [OBSERVED].** Uppercase + tracking + 12.5px (`--t-caption`) is hard for low-vision and cognitive-load users. Contrast is fine (8.6:1). **[REC]** consider mixed case "Not guaranteed" with `font-weight: 700` instead of `text-transform: uppercase` — same emphasis, easier read. This is a content/visual call as much as a11y.
- **N9. The "↦" arrow on flight cards uses `aria-hidden="true"` [OBSERVED, verified clean].** Good. The depart/arrive relationship is carried in surrounding text ("from {origin_iata}" / "to {destination_iata}" implied by structure). A screen-reader user hears times and IATAs grouped per block; the arrow is decorative. **[REC]** consider adding `aria-label` to each `.time-block` ("Departure" / "Arrival") to make the role of each block explicit, since the visual arrow is the only cue today.
- **N10. The "↻" reduced-motion handler turns off all transitions [OBSERVED, verified].** Good. There's no animation that requires more nuance.

---

## 4. Verified clean

I checked these and they are good:

- **Page language [OBSERVED].** `<html lang="en">` is set. (3.1.1 Language of Page, A.)
- **Page title [OBSERVED].** Descriptive title, no origin-identifying terms. (2.4.2 Page Titled, A.)
- **Landmarks [OBSERVED].** `<main class="page">`, `<header class="page-intro">`, `<section class="strip">` with `aria-label`, each phone wrapped in `<article aria-labelledby>`. Reasonable landmark structure; a screen-reader user can jump between articles. (1.3.1.)
- **Buttons are real `<button>` elements [OBSERVED].** Every primary action, choice card on Screen 2, filter pill, and Accept/Decline toggle is a `<button type="button">`. No `<div onclick>` pattern *except* the flight cards (called out in B1). Keyboard and AT will reach all of these.
- **No placeholder-as-label [OBSERVED].** There are no form `<input>` fields in the prototype. Filters and toggles use `aria-pressed` correctly. No labels-via-placeholder pattern is present.
- **`prefers-reduced-motion` [OBSERVED].** `* { transition: none !important; }` inside the media query disables all transitions. There are no autoplay videos, no parallax, no carousel. (2.3.3 Animation from Interactions, AAA, met.)
- **Color contrast — body and emphasis text [OBSERVED, measured].** All measured ratios pass 1.4.3 Contrast Minimum (AA, 4.5:1 normal / 3:1 large) and most pass AAA (7:1 normal / 4.5:1 large):
  - `--ink-900` on white: **18.5:1** (body, headings)
  - `--ink-700` on white: **13.0:1** (secondary text)
  - `--ink-500` on white: **5.9:1** (tertiary / muted)
  - `--ink-500` on `--ink-50`: **5.6:1** (anchor card label)
  - `--brand-900` on white: **15.4:1** (links, brand)
  - white on `--brand-900`: **15.4:1** (primary button label)
  - `--brand-900` on `--brand-100`: **13.1:1** (tok-strong pill)
  - `--state-warn-ink` on `--state-warn-bg`: **8.6:1** (standby warning)
  - `--state-pos-ink` on `--state-pos-bg`: **8.0:1** (reason chips on flight cards)
  - `--state-info-ink` on `--state-info-bg`: **10.1:1** (info banner)
  - white on `--ink-900`: **18.5:1** (active filter pill)
- **Non-text contrast [OBSERVED, measured].** State-change borders (selected flight, pressed toggle) all use `--brand-700` against `--ink-200`: **9.5:1**. Well above 3:1.
- **Token wrapping [OBSERVED].** `.tok { display: inline; overflow-wrap: anywhere; word-break: break-word; box-decoration-break: clone; }` ensures long real-world strings stay inside their parent. Verified visually by the designer's probe; markup confirms it.
- **No keyboard trap [OBSERVED, INFER].** No modal, no dialog, no focus-trap JS. Tab moves linearly through the document; nothing intercepts. (2.1.2.)
- **Skip-link [INFER, ASSUME].** The prototype is a single scrollable page with no nav above the content, so the canonical skip-link rationale doesn't strictly apply. **[REC]** in the production app, the top-level shell will need a skip-link to the main content (2.4.1 Bypass Blocks, A) — this is downstream of the prototype.
- **`prefers-color-scheme` [INFER].** Not implemented, not required for AA. Out of scope for this artifact.

---

## 5. What I could not assess without live testing

- Real VoiceOver / NVDA / TalkBack announcement order and timing. My findings on screen-reader behavior are reasoned from markup, not measured. Specifically: the question of whether screen readers correctly group depart/arrive blocks on Screen 3 once they become radios is something to verify with a real session before shipping.
- Whether `box-decoration-break: clone` renders correctly across all mobile browsers (Safari 16+ and Chromium support it; older Firefox can break the pill background across lines).
- Whether the focus ring fix proposed in B2 actually reads as "focused" to users with low vision in bright sunlight, on a real device.
- Switch-control and voice-control compatibility — both depend on real device testing.

---

## 6. Handoff to Visual Designer

Ordered by impact. All blockers must be addressed in one surgical revision pass.

1. **Make Screen 3 flight cards keyboard-operable.** Convert `.flight` to a radio-group pattern. Either native `<input type="radio">` + `<label>` (preferred — free keyboard, free announcement), or `<button role="radio" aria-checked>` with arrow-key handling. Drop `role="list"`/`role="listitem"` and `aria-current` from the list-item context.
2. **Fix the focus ring on the primary button.** Switch `.btn-primary:focus-visible` to a two-color indicator: `outline: 2px solid #fff; box-shadow: 0 0 0 4px var(--brand-500);` (or equivalent). Verify the new ring is visible against both the navy button and the page background. Apply the same robust pattern to `.toggle:focus-visible` and `.choice:focus-visible` for consistency.
3. **Bump target sizes.**
   - `.filter`: `padding: 10px 14px; min-height: 44px;`
   - `.toggle`: `padding: 12px 16px; min-height: 44px;`
   - `.help a`: `display: inline-flex; align-items: center; min-height: 44px; padding: 10px 4px;` (or break onto its own row inside the help strip).
   - `.btn`: defensive `min-height: 44px;` even though it already computes to 48.
4. **Hide the decorative "9:41" status bar from screen readers.** Add `aria-hidden="true"` to the whole `.statusbar` (not just the icon span). This removes five repeated "9 41" announcements from the page.
5. **Demote Screen 1's `h-display` from `<h1>` to `<h2>`.** Keep the `.h-display` class for visual size. This gives a single `<h1>` (the page-intro reviewer chrome) and `<h2>` per screen, matching the other screens.
6. **Include "Screen N of 5" in each article's accessible name.** Move "Screen 1 of 5: What happened" into the `id="s1-title"` element, or use `aria-label="Screen 1 of 5: What happened"` on the article.
7. **Optional but recommended:** add `aria-label="Departure"` / `aria-label="Arrival"` to each `.time-block` on Screen 3 flight cards so the depart→arrive relationship doesn't depend on the visual arrow alone.

Once these land, I'll re-verify in a second pass on the revised HTML. The structural choices (semantic HTML, real buttons, true tokens as content, restrained ARIA, motion-respecting CSS) are all correct — the gaps are concentrated and fixable.
