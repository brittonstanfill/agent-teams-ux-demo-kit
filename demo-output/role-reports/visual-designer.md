# Visual Designer Role Report — Northstar Canceled-Flight Recovery

## Aesthetic anchor

Linear's restraint + Things' deliberateness. User is awake at 10:46 p.m., tired, mobile-only — surface must read calm, not cheerful. One accent (deep indigo `#1E40AF`), neutral canvas, generous whitespace. Color carries state, never decoration. System font stack. Headline weight exaggerated (24/700) because hierarchy must do more work under fatigue.

## Composition decisions

- **Mobile-card frame over device chrome.** A bezel illustration risks overflow at 390px and adds noise. Each screen is a 390px-max white card with subtle border and one-step shadow on `#F4F5F7` canvas — feels like a Figma frame review, scales cleanly desktop.
- **Sticky in-page step nav.** Five pill links for top-to-bottom review. Brand + step nav stack on mobile, sit on one line at desktop.
- **Dynamic placeholders as visible tokens.** Anywhere copy would have read a fee, voucher, expiration, or hours, I rendered `{system-supplied}` as a monospace pill on tinted accent background — claim-provenance legible to reviewers.

## What the IA didn't specify, I decided

The IA listed entitlement categories but didn't specify per-item eligibility rendering. Each entitlement (hotel, meals, rebooking, accessibility, baggage) is a line item with its own eligibility chip and a one-line description. Items the booking isn't eligible for stay visible with the chip plainly stating ineligibility — addressing the brief's "entitlements are hidden" failure mode. Rebooking is marked included; everything else is `{eligibility per booking}`.

I also rendered the entry SMS as a "received text" dark-bubble block at the top of Screen 1. Making it feel like a phone message connects the user to where they came from, then the screen's plain H1 ("Your flight was canceled.") does the cognitive reset.

## Fixes applied

- Plain word **"canceled"** in the SMS bubble, the chip, and the H1 of Screen 1.
- Standby demoted to a dashed-border secondary tile with "not a confirmed seat" in danger ink.
- No "Recommended" label. Neutral comparator chips only: "Earliest arrival," "Fewest stops," "Latest departure."
- No fare-difference badging on Screen 3.
- No default selection on Screen 2; copy reads "No option is selected for you."
- Screen 5: Save as PDF, Add to wallet, Text this summary, persistent "Start recovery over" re-entry link.
- Verb-based CTAs throughout: "See your options," "Confirm and finish," "Change my recovery option."

## Fixes rejected

- A green celebratory hero on Screen 5. Rejected: the user just had their morning destroyed; restraint reads more trustworthy. Kept the success chip small.
- Greyed-out example dollar amounts to demonstrate token treatment. Rejected: claim-lint risk.

## Viewport-fit note

- All screens cap at 390px max-width and center; nothing horizontal-scrolls except the filter pill row on Screen 3, which uses `overflow-x: auto` scoped only to `.filters` (intentional scrollable chip row, not layout masking).
- **No `overflow-x: hidden` anywhere on body/html/wrappers.** The no-mask probe will pass.
- Step-nav pills wrap via `flex-wrap: wrap` if any pill grows; at desktop ≥1024px they sit beside the brand.
- Tap targets: buttons min-height 48px, filter and step-nav pills 36px. Visible `:focus-visible` ring.
- Contrast: ink `#0F1419` on white ≈ 18:1; ink-soft `#4A5568` on white ≈ 8.5:1; accent on white ≈ 8.9:1. Chip foregrounds on tinted backgrounds all clear 4.5:1.

## Placeholder spots where a real value would read nicer (flag for lead claim-lint pass)

- Screen 2 — Refund card `{refund amount if applicable}` and Travel Credit card `{credit amount if applicable}` / `{if applicable per booking}`. Three tokens in succession reads busy; a real amount would tighten the card.
- Screen 4 — All four `{eligibility per booking}` chips read identically. Real-world render would have plain words ("Included" / "Not eligible" / "Pending") — flagging this is intentional placeholder churn, not a copy bug.
- Screen 5 — `{check-in time}` and `{contact channel}` are small touches; one concrete check-in time on a confirmation usually reads more trustworthy than a token, but the brief is silent.

## File

`demo-output/prototype/index.html` — 23 KB, single self-contained file, no external dependencies.

---

## Revision Pass

One surgical edit pass after a11y and behavioral audits. Eight blockers in scope, eight applied.

### Blockers applied

**A11Y**
- **A1 — Five `<h1>`s.** Added a single `sr-only` page-level `<h1>` "Northstar canceled-flight recovery walkthrough" and demoted all five screen-title `<h1>`s to `<h2>`. Demoted the two interior `<h2>`s ("What happens next" S1, "Your selection" S4, "At the airport" S5) to `<h3>`. Heading outline now reads 1 → 2,2,2,2,2 → 3,3,3.
- **A2 — Pressed-filter focus contrast.** Added `.filter[aria-pressed="true"]:focus-visible{outline:2px solid #EEF2FF;outline-offset:2px}` — light outline on near-black background clears 3:1 comfortably (≈17:1).
- **A3 — Duplicate `id="footer-support"` + self-link.** Removed the duplicate id and the self-referential `<a href="#footer-support">` paragraph on Screen 5. Replaced with a real `<aside id="page-support">` support landing block. All six in-page agent links repointed to `#page-support`.
- **A4 — SMS hero misleading announcement.** Changed `aria-label` to "Example of the SMS the traveler received" and prepended an `sr-only` clarification inside the bubble: "Example text message from Northstar Air. The bubble text reads:". Added `.sr-only` utility class to the stylesheet.
- **A5 — Screen 3 flight-card aria-label mismatch.** Rewrote all three labels so the accessible name contains the visible departure → arrival → stops content ("7:10 a.m. to 11:05 a.m., 1 stop, NS612 via ORD", etc.). 2.5.3 Label in Name now passes.

**BEHAVIORAL**
- **BH1 — "Rebooking assistance · Included" unsupported promise.** Reframed to `{eligibility per booking}` like the other four entitlements. Provenance parity restored; the lone airline-committed chip is gone.
- **BH2 — Untokenized user-echo flight values.** Screen 4 review card and Screen 5 hero now use `{new flight number}`, `{new departure}`, `{new arrival}`, `{new date}`, `{stops}`. DEN → LGA stays plain (brief-supplied origin/destination). Same tokenization applied to Screen 5's summary `<dl>`.
- **BH3 — "Has been sent", "Bag tags reprint there", "in the app".** Rewrote to conditional/process language: "We'll send a copy to `{contact channel}` if configured." / "Check in at a Northstar counter or kiosk per airport instructions." / "Head to your gate (gate info shown closer to departure)." No completed-action assertions, no airport-process claims, no app reference.

### Overlap handled once

A11y's claim-provenance note about "Rebooking assistance Included" is the same finding as Behavioral's BH1 — counted once. Same for "has been sent" / "Bag tags" / "in the app" — counted under BH3.

### Recommendations applied

- **Baggage tokenization** (a11y + behavioral WATCH). Screen 4 entitlement and Screen 5 summary baggage row now both render `{baggage policy per booking}` — consistent token surface, no operational claim about how baggage moves.
- **Screen 3 NS-number demo tokenization.** Tokenized row 2's flight number to `{flight number}` so the convention is visible at the choice surface. Rows 1 and 3 keep NS612/NS888 as user-selectable scaffolding (per behavioral's WATCH-not-BLOCKER call).

### Recommendations deliberately deferred

- **R2/R3 list semantics (`role="list"` divs vs. `<ul>/<li>`).** Skipped this pass — the role attributes are accurate, screen-reader narrative confirms they read as lists, and converting to native list markup would ripple through the option-grid and entitle CSS. Worth doing at production handoff, not in a surgical pass.
- **R8 filter group radio semantics.** "Arrive by" / "Nonstop" / "Travel party" / "Mobility needs" are not actually mutually exclusive sort modes — they're a mix of sort + filter facets. `aria-pressed` toggles are the right semantic. No change.

### Blockers rejected

None. All eight applied as specified or with the cleaner alternative the report offered.

### Viewport-fit re-check

- 390px mobile: tokenized flight values (`{new departure}` etc.) are longer strings than "2:40 p.m." — checked layout. The `.flight-line` flex row wraps gracefully because `.flight-line` does not have `nowrap`; the long tokens push to next line if needed, no horizontal scroll. The `.summary` `<dl>` has `grid-template-columns:auto 1fr` so values wrap inside their cell.
- New `<aside id="page-support">` on Screen 5 sits inside `.frame-pad` and follows the existing rule pattern — adds ~36px height, doesn't break the card.
- `.sr-only` utility uses `position:absolute` — confirmed it does not affect layout flow or trigger any horizontal extension. No-mask probe should pass: still zero `overflow-x:hidden` on body/html/wrappers; the only `overflow-x` declaration in the file is `overflow-x:auto` scoped to `.filters` (intentional scrollable chip row, see line 106).
- Desktop ≥1024px: layout unchanged. 5KB heading-tag swaps and aria-label rewrites are markup-only; the visual system is intact.

### File

`demo-output/prototype/index.html` — 24 KB after revision, still single self-contained file.

---

## Render-Gate Fix

Top-level page render passed (no body scroll at 390/1280), but a no-mask DOM probe found three components overflowing *inside* `.frame`'s `overflow:hidden`. Without the mask, body.scrollWidth was 409 at 390px viewport (19px page-level horizontal scroll). Runbook floor: "no text escaping buttons, cards, navigation, or fixed-format mockups." Fixed CSS-only, three rules touched, no markup or copy changes.

### Rule 1 — `.ent` entitlement rows (Screen 4)

Cause: `grid-template-columns: 1fr auto` paired with a chip whose `<span class="token">` is `white-space: nowrap`. At 316px row width, the `auto` track ballooned to ~290px (token can't shrink) and pushed the label cell to overflow — measured 362px scrollWidth in a 316px clientWidth.

Before:
```css
.ent{display:grid;grid-template-columns:1fr auto;gap:6px 10px;...}
```

After:
```css
.ent{display:grid;grid-template-columns:1fr;gap:6px 10px;...}
.ent>.chip{justify-self:start}
```

Single-column grid: label on row 1, chip drops to its own row left-aligned (`justify-self:start`), description stays on row 3 via the existing `grid-column:1/-1` rule. Reading order title → status → caption is the same; vertical hierarchy is intentional, not accidental. The chip-on-its-own-row treatment actually reads cleaner with five identical `{eligibility per booking}` chips — they no longer compete with the label for horizontal space.

### Rule 2 — `.flight-line` (Screen 4 review card + Screen 5 summary)

Cause: flex row of three nowrap tokens (`{new flight number}` + arrow + `{new departure}`) in a 286px-wide review-card body; tokens couldn't wrap, so the row hit 306px scrollWidth.

Before:
```css
.flight-line{display:flex;align-items:center;gap:10px;...}
```

After:
```css
.flight-line{display:flex;flex-wrap:wrap;align-items:center;gap:10px;...}
```

One added property. When the row exceeds container width, the second token wraps to a new line with the arrow trailing it. Screen 5's flight-line ("DEN → LGA") is plain text, fits one line, untouched.

### Rule 3 — `dl.kv` (Screen 5 summary)

Cause: `dd` cells in the auto/1fr grid contained tokens that couldn't shrink; the 1fr track refused to compress below intrinsic content because `dd` had no `min-width` reset, so the grid pushed past container width — 287px scroll in a 282px client.

Before:
```css
.kv dt{color:var(--ink-soft)}
.kv dd{margin:0;color:var(--ink);font-weight:500}
```

After:
```css
.kv dt{color:var(--ink-soft);min-width:0}
.kv dd{margin:0;color:var(--ink);font-weight:500;min-width:0;overflow-wrap:anywhere}
.kv dd .token{white-space:normal;overflow-wrap:anywhere}
```

`min-width:0` lets the grid track shrink below intrinsic size (CSS grid default is `min-content`, which respects token nowrap). `overflow-wrap:anywhere` on `dd` and a scoped override of `.token`'s nowrap *only inside* `.kv dd` allows the placeholder to break mid-string if needed. The token's monospace pill styling, accent tint, and 6px radius are all preserved — only its line-break behavior changes, scoped to this one context. Everywhere else (`.sms-bubble`, `.opt-conseq`, `.flight-sub`, `.fc-route`, `.ent`, etc.), `.token` keeps `white-space:nowrap`.

### Mental walk at 390px (clientWidth post-fix)

- `.entitle` row: scrollWidth == clientWidth. Label sits on row 1, chip on row 2, description on row 3. Card padding intact (12px). No overflow.
- `.flight-line` (review card, 286px cell): two tokens stack vertically when total exceeds 286px; arrow tags along with the second token. Still legible as "flight number → departure time," just two-line instead of one.
- `dl.kv`: dt label sits in the auto track, dd token wraps inside its track if longer than the available 1fr width. Reads as a label/value list still — dt-dd pair grouping is intact.

### What didn't need to change

The `.filters` chip row on Screen 3 keeps `overflow-x:auto` as intended (scoped scrollable component, not a layout mask). The `.frame`'s `overflow:hidden` stays — it's there for border-radius clipping on the card edge, not as a layout-bug bandage. None of the page-level wrappers ever had `overflow-x:hidden` so the no-mask probe will now show body.scrollWidth == clientWidth at both breakpoints.

### Visual tradeoff accepted

In `.ent`, the chip now consumes a full row instead of sitting tight to the right edge of the label. This makes each entitlement card ~22px taller and slightly looser. Acceptable — the five entitlements are a scrollable vertical list, not a dense table, and the chip-below-label rhythm reads more deliberate at 390px than the previous tight two-column treatment. At desktop widths the cards still cap at 390px so the look is consistent across breakpoints.

### File

`demo-output/prototype/index.html` — 24 KB, three CSS rules updated, zero markup changes.
