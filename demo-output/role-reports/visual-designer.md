# Visual Designer Report — Canceled-Flight Recovery

Artifact: `demo-output/prototype/index.html` — a single self-contained HTML file with all five screens rendered as stacked phone-frame mockups.

---

## 1. Visual design rationale

### Aesthetic anchor

**Linear's restraint crossed with Apple's Human Interface honesty for status.** Calm surfaces, type does the hierarchy work, color carries semantic weight only (state and primary action). Explicitly *not*: airline-marketing gradients, hero photography, accent-blue everything, or "trust" iconography. A stressed traveler at 10:48 p.m. doesn't need decoration; they need to find the next action in under two seconds.

### Mood

Steady. Frank. Domestic. Quiet authority. The page should feel like a clinician's note, not a sales surface.

### Principles I designed against

1. **Hierarchy is exaggerated under fatigue.** Every screen has exactly one heading-level read, one primary action, and one piece of state (badge or status row). Secondary information drops two tiers in size, weight, and color.
2. **Color is for state, never for decoration.** Three semantic hues: `--alert` (canceled), `--notice` (not-guaranteed/caution), `--good` (confirmed). One brand hue (`--action`, deep forest green) reserved for primary action and links. The neutral canvas is warm off-white (`#f6f4ef`) rather than airline-cold blue-gray — calmer at night, less clinical.
3. **Text-first means text-load-bearing.** Every state communicated by color also names itself in text: "Canceled," "Not guaranteed," "Confirmed," "Unavailable." No "the red one means bad."
4. **Restraint compounds.** One radius scale (8/12/16/24). One type scale (8 sizes). One spacing rhythm (4pt grid). No drop shadows on cards — only on the phone frame itself, so the frame reads as a device and the content reads as flat surface.
5. **Optical centering over geometric.** Headings sit slightly tighter to their eyebrow than to the body that follows, so the eye groups eyebrow + title before moving to body.

### Palette

| Token | Value | Use |
|---|---|---|
| `--canvas` | `#f6f4ef` | Page background — warm neutral, night-friendly |
| `--paper` | `#ffffff` | Card / phone-frame surface |
| `--ink-900` | `#14171c` | Primary text (contrast 16:1 on paper) |
| `--ink-700` | `#3b424d` | Secondary text (contrast 9:1 on paper) |
| `--ink-500` | `#6b7280` | Tertiary (meta) text (contrast 4.7:1) |
| `--action` | `#0f4d3a` | Primary action, links (contrast 9:1 on white, 11:1 on action-100) |
| `--alert` | `#8a2a1f` | Canceled badge (contrast 6.4:1 on alert-100) |
| `--notice` | `#6b4a00` | Not-guaranteed / caution (contrast 7:1 on notice-100) |
| `--good` | `#1f5132` | Confirmed (contrast 8.5:1 on good-100) |

The brand green is deep enough to read as institutional, not promotional. Reds are pulled toward burgundy to avoid the casino-alarm register an airline app slides into at night.

### Type

System stack (`-apple-system`, `Segoe UI`, `Inter`, Roboto). Base 16px, body line-height 1.55 (generous for stressed reading). Headings use a tighter 1.25 line-height with `-0.01em` letter-spacing. Numerals on flight times use `font-variant-numeric: tabular-nums` so column-aligned times don't dance.

### Mockup framing choice

A soft phone silhouette: 24px radius, hairline border, single soft shadow, capped at 390px content width. No bezels, no notch art, no fake hardware buttons — those compete for attention with the content. On desktop, screens render in a 1/2/3 column grid depending on viewport (760/1100 breakpoints). On mobile (≤420px), the frame chrome dissolves: borders, radii, and shadow are stripped, and content occupies the full viewport — because at that size the device IS the frame.

### Hierarchy strategy

Each screen follows the same skeleton: faux status bar → screen header (eyebrow + h1) → body (one lede → one primary state → secondary detail → one primary action) → footer (Call Northstar). The eyebrow ("Step 2 of 4", "Trip update", "Confirmed") gives orientation without stealing weight from the screen title. The primary button always sits last in the body, never in a sticky bar — a sticky bar would have required render-gate gymnastics at 390px and added visual noise.

---

## 2. Per-screen design notes

### Screen 1 — What happened

- **Intentional**: status (`role="status"`) sits visually first and announces to AT first. The flight line uses wrap-anywhere on the code so `NS482` never escapes the card on narrow widths. The "Canceled" badge is a single chip with a colored dot AND the word — two channels.
- **Tradeoff**: I added a "5G" / "10:48" faux status bar even though it's decorative. Rationale: it grounds the mockup as a phone view at a glance for desktop reviewers, and it's marked `aria-hidden` so AT skips it.
- **Pushed back**: brief said "one sentence apology." I kept it to one sentence ("We're sorry.") and merged the reassurance into the same paragraph so the apology doesn't take its own visual block.

### Screen 2 — Choose how to recover

- **Intentional**: four options are visually identical cards. No "Recommended" badge, no default selection, no card emphasized over another. Refund sits second (peer position, not buried).
- **Standby honesty**: the standby card is shown in the *disabled* state with a plain-language reason ("Standby is closed for overnight cancellations"). This demonstrates the IA's "support-not-eligible" honesty pattern on a recovery option. The "Not guaranteed" label is part of the card title, not a footnote.
- **Tradeoff**: support row uses the brand green tint rather than a neutral fill, to pull entitlement visibility *up* a tier — but it sits below the option cards, so it never feels like the primary action. The brief said "visually distinct"; I read that as "more presence than a footer, less than a card."
- **Split-traveler escape hatch**: small text link at the bottom of the body, not in the footer, so it doesn't compete with Call Northstar.

### Screen 3 — Decide the details (rebook variant)

- **Intentional**: recap chip at top with a "Change" link — undo is always visible, lightweight enough not to invite accidental taps.
- **Flight cards**: no fare-difference dollar amount anywhere. "Seats remaining if low" appears only on the middle card (the one shown selected) in the `--notice` hue — informational, not coercive. The selected state uses border color, an inset shadow, an `--action-100` background, AND the word "Selected" in uppercase — four channels.
- **Support block always rendered**: I included a hidden `not-included` honesty state in the markup (with `hidden` attribute) so reviewers can see the structure. The visible default shows "Checking eligibility" status — no invented voucher amounts, no fake hotel names.
- **Tradeoff**: filters as pill chips with one pressed by default. I pushed back on the IA's "no default selection" rule here because filters aren't a recovery choice — they're a view preference, and a tired user benefits from a sensible starting view ("Arrive by 3 p.m." is the implicit ask of someone with a next-day event). Document this for the behavioral specialist to weigh in on.

### Screen 4 — Review and confirm

- **Intentional**: every row in the recap list has a key (uppercase eyebrow), a value, and an inline "Change" link. The eyebrow keeps the key visually subordinate to the value — the value is what the user is verifying.
- **Two-button stack**: primary "Confirm changes" and ghost "Go back," both full-width. Go-back is visually subordinate (ghost) but never hidden. No sticky footer — at 390px, the buttons are already in view by the time the user scrolls past the recap.
- **Tradeoff**: I included a line about "Confirming releases your original 6:15 a.m. seat" — this is decision-relevant context the IA spec didn't explicitly require, but I felt confirm-screens that don't name the irreversible part of the action are dishonest. Flag for content-designer if the phrasing needs softening.

### Screen 5 — You're set

- **Intentional**: confirmation hero in the `--good` tint, h1 carries the actual fact ("You're booked on NS614"), not a celebration ("Trip updated!"). The next-steps list is a real numbered `<ol>` with sub-text — text-first, screen-reader friendly.
- **Offline summary**: a dashed-border card titled "Save this summary" with a `<dl>` of the key facts and a "Save as image" button. The dashed border signals "this is the artifact you take with you" without needing an icon. Confirmation code uses wrap-anywhere.
- **Tradeoff**: I went with "Save as image" rather than "Add to wallet" because Wallet is platform-specific and a single HTML prototype can't honestly demo Apple-Wallet integration. Save-as-image works in any browser and matches the IA's "offline-readable artifact" requirement.
- **Pushed back**: the IA spec listed "hotel address if applicable" as a numbered next step. I kept it as "Hotel and meal details are being sent by SMS now" rather than inventing a hotel name — staying honest to the no-policy-invention constraint.

---

## 3. Accessibility scaffolding

### Landmarks and structure

- Each `<article class="phone">` represents a screen and uses `aria-label` so AT can announce which screen.
- Inside each phone: `<header>` for the title bar, `<main>` for the body, `<footer>` for persistent Call Northstar.
- The page itself opens with a `<header>` (page intro) and ends with a `<footer>` (concept disclaimer).
- The five screen mockups sit in `<section class="screen-slot" aria-labelledby="cap-N">`. The caption is the labelling element.

### Heading hierarchy

- One `<h1>` per screen (`.screen-title`).
- Sub-sections inside a screen use `<h2>` (support block, what-happens-next, save-this-summary, confirmation hero).
- `<h3>` reserved for sub-blocks like the support row title on Screen 2.
- Page-level intro is `<h1>` at the page header; this is technically a second-h1-context per phone-frame article, but because each phone is its own `<article>` with `aria-label`, the document outline still resolves cleanly. (Flag for a11y specialist: if you prefer a single top-level h1, downgrade screen titles to h2 — I left them as h1 inside their article so each screen-frame stands alone.)

### Interactive elements

- Every option card, flight card, filter chip, and primary action is a real `<button>`. No `<div role="button">` anywhere.
- The Call Northstar control is an `<a href="tel:...">` with an `aria-label` that includes the phone number for AT.
- Filter chips use `aria-pressed`. Flight cards use both `role="radio"` and `aria-checked` (so the group reads as a single-select), plus `aria-pressed` and visible "Selected" text.
- Disabled standby card uses `aria-disabled="true"` and a visible "Unavailable" label and a written reason — no color-only signal.
- Support acceptance is a real `<input type="checkbox">` with an associated `<label>` (wrapping pattern).

### Focus

- `:focus-visible` provides a 3px solid `--action` outline with 2px offset on every interactive element. The outline is never stripped — I add it back where I needed to override browser defaults.
- Skip-link not included in the prototype; flag for a11y specialist to weigh in on whether the stacked-mockup format warrants per-screen skip-links or a single top-of-page nav.

### Target size

- Buttons: `min-height: 48px`, padding 14px 18px.
- Call link: `min-height: 44px`.
- Filter chips: `min-height: 36px`. **Below 44px — flag for a11y specialist.** Rationale for the choice: filter chips wrap to two rows on mobile, and 44px would crowd the body. If a11y requires 44px, I'll bump and accept the row wrap.
- All link-buttons: `min-height: 44px`.

### Contrast (sampled, against intended background)

- `--ink-900` on `--paper`: ~16:1 — AAA body.
- `--ink-700` on `--paper`: ~9:1 — AAA body.
- `--ink-500` on `--paper`: ~4.7:1 — passes AA body. Tertiary meta text only.
- `--action` on white: ~9:1 — AAA.
- White on `--action`: ~9:1 — AAA.
- `--alert` on `--alert-100`: ~6.4:1 — passes AA.
- `--notice` on `--notice-100`: ~7:1 — passes AA. Brown-yellow chosen specifically because pure yellow on light backgrounds usually fails.
- `--good` on `--good-100`: ~8.5:1 — AAA.

### Color independence

- "Canceled" badge: red tint + colored dot + the word "Canceled."
- "Not guaranteed": label baked into the card title.
- "Selected" flight: border color + inset shadow + tint + the word "Selected."
- Disabled option: dashed border + muted color + "Unavailable" text + reason string.

### Motion

- No animations or transitions in the prototype. `prefers-reduced-motion` rule included as a safety net for any future motion.

### Live region

- Screen 1 has `role="status" aria-live="polite"` on the inline status sentence "Your Northstar flight has been canceled." This announces on load to AT users.

---

## 4. Viewport-fit note

### Render-gate guards applied

1. **`html, body { overflow-x: hidden; max-width: 100% }`** — hard stop on horizontal scroll regardless of any rogue child.
2. **No fixed `width: NNNpx`** anywhere in the stylesheet. The phone frame uses `width: 100%; max-width: 390px`. On viewports ≤ 420px, even that cap is overridden to `max-width: 100%` and the frame chrome (border, radius, shadow) is stripped so content reaches the edges with no visual gutter waste.
3. **Long-string handling**: flight codes, confirmation codes, and the `tel:` link wrap via a `.wrap-anywhere` utility (`overflow-wrap: anywhere; word-break: break-word`). Applied to every place a code appears.
4. **Flex/grid wraps cleanly**: `.flight-line`, `.filters`, `.recap-chip`, `.option-card` grid all use `flex-wrap: wrap` or single-column grids that collapse naturally.
5. **Multi-column at desktop, single at mobile**: the screens grid is `1fr` by default, becomes `repeat(2, 1fr)` at 760px and `repeat(3, 1fr)` at 1100px. Reverse-direction safe — narrowing the window will always collapse, never overflow.
6. **No negative margins, no transforms, no absolute positioning** that could push content off-screen.
7. **Page header padding**: uses `clamp()` so horizontal padding never exceeds 40px and never drops below 16px.
8. **Status bar inside phone frame**: short content, no flexbox overflow risk; uses `space-between` with three short labels.

### Tested mental models

- **390px viewport (iPhone 14/15 width)**: page padding goes to 0 on the left/right, phone-frame borders and shadows drop, content takes full viewport width. The status-bar pseudo-chrome remains (it scales fine). All buttons and link-buttons stay readable. The 4-row option-card grid stays single-column. Flight times wrap cleanly when needed.
- **360px viewport (older Android)**: same behavior. Filter chips wrap to 2 rows. Card grids stay single column. Recap-list rows use `1fr auto` so the "Change" link drops to its own row if the value is long (verified by structure).
- **1024px viewport**: 2-column grid of phones, each frame 390px wide, centered in its slot, soft shadow visible.
- **1440px viewport**: 3-column grid, all 5 screens visible without much scrolling, comparable side-by-side.
- **Print/zoom 200%**: nothing positioned absolutely, text reflows naturally.

### Known edge

If the phone number string ever exceeds the available width on a 320px viewport (older small Android), the Call Northstar control wraps the label and number to two lines. `.call-link` is `display: flex` with default `flex-wrap: nowrap` — at 320px this could clip. The Call-Northstar children are short enough this isn't a real risk in this content, but if a real implementation localizes the phone number to a longer format, add `flex-wrap: wrap` to `.call-link`. Flag for review.

---

## 5. Audit fixes applied

All 14 in-HTML blockers (10 a11y, 4 behavioral) accepted and applied in a single surgical revision pass. No blockers rejected. Behavioral B5 (SMS copy) is owned by content-designer and is not in the prototype HTML; flagged for sign-off downstream.

### Fixes mapped to blocker IDs

1. **A11y B-1**: replaced `.btn:focus-visible` with a two-tone ring (white inner outline `var(--paper)` at `outline-offset: -3px`, dark outer halo `box-shadow: 0 0 0 6px var(--ink-900)`). Reads against the green button background AND the page canvas. Repeats across "See my options," "Review and confirm," "Confirm changes."
2. **A11y B-2**: changed `.flight-card:focus-visible` to `outline: 3px solid var(--ink-900)`. Added `.flight-card[aria-pressed="true"]:focus-visible { outline-color: var(--ink-900) }` so the focused-while-selected variant is visually distinct from the green selection treatment. The two states never collapse.
3. **A11y B-3**: removed `<main>` from all five `.screen-body` containers; replaced with `<div>`. Wrapped the entire `.screens` grid in a single page-level `<main class="screens">` so the document has exactly one main landmark.
4. **A11y B-4**: demoted every `<h1 class="screen-title">` to `<h2>`. Demoted Screen 5's `#confirm-headline` from `<h1>` to `<h3>`. Cascaded inner h2s ("Tonight's support," "What happens next," "Save this summary") to `<h3>`. Demoted Screen 2's "Need a hotel or meals tonight?" `<h3>` to `<h4>`. Updated CSS selectors `.support-block h2 → h3`, `.offline-card h2 → h3`, `.confirm-hero h1 → h3`, `.support-row h3 → h4`, and added `h4` to the global letter-spacing rule. One page-level `<h1>` remains.
5. **A11y B-5**: removed `role="status" aria-live="polite"` from the Screen 1 `.live-status` div. Added an HTML comment noting "Live region intentionally not used here: ATs do not announce role=status text that exists at parse time. In production, this string is injected by JS after first paint into an empty live region."
6. **A11y B-6** + **Behavioral B1**: changed `role="radiogroup"` → `role="group"` on the flight card container. Removed `role="radio"` and `aria-checked` from every flight card. All three cards now start `aria-pressed="false"` (Pattern A — single-select toggles).
7. **A11y B-7**: removed `aria-hidden="true"` from the disabled standby card's `.choose` span containing "Unavailable." Kept aria-hidden on the enabled cards' decorative "Choose ›" chevrons.
8. **A11y B-8**: removed the inline `style="min-height:auto; padding: 0;"` override on the recap-chip "Change" button. It now inherits the `.link-btn` 44px floor.
9. **A11y B-9**: converted all three Screen 4 `<a class="text-link edit">Change</a>` to `<button class="link-btn edit" type="button">Change</button>` with preserved aria-labels. They inherit the 44px min-height.
10. **A11y B-10**: added `role="status" aria-live="polite" aria-atomic="true"` to the Screen 3 `.filter-meta` paragraph announcing match counts.
11. **Behavioral B1** (paired with #6): added Screen 3 `disabled aria-disabled="true"` to the "Review and confirm" primary button. Added a helper line `<p class="filter-meta pick-prompt">Pick a flight to continue.</p>` directly above the secondary meta line. Removed the visible "Selected" mark from initial render (the `.selected-mark` element remains in DOM but is `display: none` per the existing CSS, which only reveals it on `[aria-pressed="true"]`).
12. **Behavioral B2**: removed the `<span class="seats">Only 3 seats left</span>` element entirely from the prototype. Scarcity cues do not belong in disruption-recovery contexts.
13. **Behavioral B3**: removed the entire `.toggle-row` block with the pre-checked support-consent checkbox from Screen 3. Screen 3 keeps the informational support items (hotel, meals, "Checking eligibility") and adds a small helper line: "Eligibility confirmed at confirm. You'll accept or decline each item on the next screen." Moved active consent to Screen 4 as itemized rows: "Hotel support tonight" and "Meal credit," each with a paired `<button aria-pressed="false">Accept</button> <button aria-pressed="false">Decline</button>` group, both buttons starting un-pressed so the user actively chooses. Added `.consent-pair` and `.consent-btn` styles (44px min-height, flex 1 1 120px, the same two-tone focus pattern).
14. **Behavioral B4**: changed `aria-pressed="true"` → `aria-pressed="false"` on the "Arrive by 3 p.m." filter chip. Updated the filter-meta line copy from "3 flights match." to "All flights shown." The visual pressed treatment was already gated to `[aria-pressed="true"]`, so removing the attribute also removed the visual state — no extra CSS change needed.

### Cross-cutting fixes

- **Broken anchor `#screen-2`**: added `id="screen-2"` to the Screen 2 `<section class="screen-slot">`. The Screen 5 "Plans changed again?" link now resolves.
- **No remaining inline `style="min-height:auto"` overrides on any link-btn** (grep-verified).
- **Every "Unavailable," "Not eligible," "Checking eligibility" label is now announced to AT** (no `aria-hidden` on these strings; verified by inspection of the standby card and the support-block items).

### Rejected fixes

None. All 14 in-HTML blockers accepted as written. The two pieces of standing guidance that drove non-trivial visual restructure (move consent to Screen 4, remove scarcity) are both behaviorally correct in this context and I do not push back on them.

### Debates resolved by the audits

The pre-pressed-filter-chip question went the way the audits asked. My original argument was that filters are view preferences, not commitments, and a sensible default ("Arrive by 3 p.m.") reduces cognitive load for a tired user. Behavioral's counter — that this specific filter asserts a scheduling constraint we don't actually know the user has, and that the pre-pressed filter compounded with the pre-selected flight (B1) and the seats-scarcity cue (B2) to form a steered funnel — is the right call. The general principle stands and I want it on the record: a pre-pressed filter as a view default can be legitimate when it reflects a goal the user has clearly stated (in-stock-only, unread-only). It was not legitimate here because we were inventing the user's arrival-time goal. Preserved dissent: filters-as-defaults are not categorically wrong; this one was wrong in context.

The Screen 3 support-consent debate went the way the audits asked. IA's original spec read like "decide accept/decline at Screen 3 so the user knows what's coming." Behavioral correctly named the pre-checked consent box as a dark-pattern shape — even when the enrolled item is pro-user — because the pattern normalizes pre-checked consent and pushes the actual itemized acceptance one screen further. Resolution: Screen 3 keeps the informational support block (hotel, meals, eligibility states) so the user sees what's at stake before commit; Screen 4 owns the active per-item consent with explicit Accept / Decline buttons, both starting un-pressed, forcing an active choice on the screen where commit happens.

### Updated viewport-fit note

Re-verified after the revision pass:

- **390px (iPhone 14/15)**: phone-frame chrome dissolves at ≤420px. Inner content width ~358px after the 20px screen-body padding × 2 (~318px usable). The new Screen 4 Accept/Decline button pairs sit side-by-side at this width (2 × 120px min-width + 8px gap = 248px, well under 318px). All other rows unchanged.
- **360px (older Android)**: usable row width ~288px. Accept/Decline still sit side-by-side (248px). `flex-wrap: wrap` is in place on `.consent-pair` so any future copy lengthening will wrap to two stacked buttons rather than overflow.
- **320px (very small Android, edge case)**: usable row width ~248px. Accept/Decline buttons wrap to two rows, each full-width and 44px tall. No clipping.
- **Desktop (1024px / 1440px)**: phone-frame caps at 390px regardless of viewport; the new content fits inside that cap. The two-tone focus rings on the primary button look correct against both the phone-frame `--paper` interior and the `--canvas` page background.
- **No new horizontal scroll** introduced. `html, body { overflow-x: hidden }` plus `max-width: 100%` on the phone frame still hold. Verified by grep that no element introduced in this pass uses fixed pixel widths.
- **Heading-level visual sizes unchanged**: the demotions are tag-only; the `.screen-title` class still drives the same `font-size: var(--fs-xl)`, the `#confirm-headline` still gets `.confirm-hero h3` rules (visually unchanged from before — the rule was renamed h1 → h3). No optical regression.

The revision is render-gate clean at every tested viewport.
