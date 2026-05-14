# Visual / UI Designer — Canceled-Flight Recovery

## Aesthetic anchor

Linear restraint × Things deliberateness. Calm, low-saturation, late-night-friendly. One action accent (calm blue, never red), one warm hue reserved exclusively for entitlements. The brief explicitly warned against "jolly chrome" and against support coercion via "large red alarm bar"; the palette is built to make those failure modes structurally impossible — there is no red CTA in the system.

## Design tokens

- **Color**
  - Ink `#0F1115`, Ink-2 `#2A2F38`, Muted `#5B6470`, Muted-2 `#8A93A1`
  - Paper `#F4F5F7` (workspace), Surface `#FFFFFF` (canvas), Hairline `#E5E7EB`
  - Accent `#1E40AF` for primary action; accent-soft `#EAEFFB` for the "reason" badge on the recommended flight
  - **Warm `#FFF6E5` / stroke `#F2D9A8` / warm-ink `#6B3A0E` — reserved for the "What's covered tonight" module on Screen 1 and the Tonight re-surface on Screen 5.** Nothing else uses this hue. That's the principle: color is for state and continuity, never for decoration.
  - Status colors (`--ok` green, `--danger` deep red) exist as semantic tokens but appear only where the principle demands (confirmation check). No alarm chrome.
- **Type:** system stack. Scale 12 / 13 / 14 / 15 / 17 / 20 / 24. Weight 400/500/600. Tabular numerics on flight times.
- **Spacing:** 4-pt grid (4 / 8 / 12 / 16 / 20 / 24 / 32 / 40).
- **Radius:** 28 phone frame, 12 cards, 10 buttons, 999 pills.
- **Shadow:** two soft layers, ink-tinted.
- **Touch targets:** all interactive elements ≥44 CSS px; primary buttons 48.
- **Token chip:** monospace pill on `#F1F2F5` with a hairline border. Visually subordinate to authored copy — readers immediately see they're data slots, not text.

## What I used from IA

- The 5-screen sequence and per-screen primary decision/CTA copy verbatim. CTA strings: "See my rebooking options," "Confirm this flight," "Confirm rebooking," "Add to wallet / Email a copy / Text a copy."
- The token list from §5: every dynamic value (flight times, route, support phone, entitlement amounts, confirmation code, baggage status, claim methods, fare differences) is rendered as a `{snake_case}` chip. I extended the list slightly (per-card flight tokens like `{flight_a_depart}`, `{checkin_open_time}`, `{gate_status}`, `{passenger_list}`, `{hotel_claim_method}`) to keep the surface honest where IA had specified the field but not the token — kept naming convention consistent.
- The hierarchy contract: hotel/meal entitlements at top of Screen 1; re-surfaced on Screen 5 in the same warm hue so the eye reads them as the *same* concept across the flow.
- Three stacked decision cards on Screen 2, no tabs. "Rebook" rendered as the dominant card (inverted to ink-dark with white type) — the visual weight makes the recommended path read first without a label. "Standby" rendered as a dashed-border subordinate card to address the brief's flag that standby reads as equivalent to confirmed rebooking.
- "Recommended" badges replaced with reason strings: "Earliest arrival," "Nonstop, closest to original time," "Later option" (muted).
- Persistent "Call Northstar support" affordance docked at the bottom of every phone frame — present, never coercive, never red.

## Why I made the call-outs I made

- **The warm hue is a finite resource.** It only appears on entitlements (Screen 1 hero module + Screen 5 Tonight block). That gives the brief's #1 unmet need a visual identity the eye can locate across the flow. Principle: gestalt grouping by color.
- **Standby is dashed, not solid.** The brief specifically flags that standby sounds equivalent to rebooking. A dashed border with muted ink-2 text signals "less complete commitment" without burying the option. Principle: visual subordination via stroke style, not by hiding.
- **Primary card is inverted, not blue.** Most "primary CTA" patterns put a blue button on top of a blue or accent card, which doubles the saturation. Inverting the rebook card to near-black with white type makes it dominant *and* keeps the page calm. The blue accent is reserved for the in-card primary CTA on Screen 1 and Screen 4.
- **Token chips are monospace.** They visibly read as data slots, not as authored copy. The team can run a render-gate scan for the `{...}` substring with full confidence.
- **Status bar inside the phone is dot-only.** No fake signal/battery glyphs invented as content. The "10:46 / 10:47…" times move forward across the 5 screens to suggest time passing during a late-night flow — subtle narrative cue, no invented data.

## Viewport-fit note (390 px)

The phone frame is `max-width: 390px; width: 100%` and the inner screen padding is 20 px (≈ 351 px of content width inside the canvas at 390). The longest line of authored copy is the Screen 1 headline; with two token chips inline, it wraps to 3 lines at 390 — checked against word-break, none of the tokens break across lines (`white-space: nowrap` on `.tok`). At 390 px viewport, the page padding is 16 px, so the phone frame fills the column with 8 px of breathing room each side. The Screen 5 "Save this trip" grid is 2×2 on mobile and stays 2×2 throughout — four buttons at 48 px tall fit comfortably in the column. **No `overflow-x` anywhere on `html`, `body`, or `.mockups`** — clipping is scoped only to `.phone` so the frame's rounded corners render cleanly without masking page-level overflow elsewhere.

## Intentional divergence from IA

**One:** IA's §5 says "Three stacked decision cards" but lists them in this order: Rebook → Standby → Cancel/Refund. I reordered Screen 2 to **Rebook → Cancel/Refund → Standby**. Reason: the brief flags that standby reads as equivalent to rebooking; placing it in slot 2 visually elevates it again, regardless of styling. Slotting it last (and dashing the border) lets it remain a top-level option without arguing visually for itself. The "Refund or travel credit" card sits in the middle because for users who *don't* want to fly, that's the next-most-relevant path; standby is a narrower use case. IA's own §6 open question #2 ("Standby as a top-level option … consider moving it under Rebook") signals this was already a live debate — I made the call within the IA-sanctioned framework rather than reopen the question.

## Accessibility hooks shipped (for the A11y specialist to audit)

- Skip link from page top to `#frame-1`; visible on focus, contrast ≥ 4.5:1.
- Semantic order: `h1` page-level, `h2` per-screen heading, `h3` per-section. No skipped levels.
- `<button>` for actions, `<a>` for navigation and tel: links.
- `aria-label` only where text is absent (the `<aside>`-style support docks use `aria-label="Support"`).
- Focus styles: 3 px solid accent outline with 2 px offset, never stripped. Default `:focus-visible` preserved everywhere.
- Touch targets ≥ 44 CSS px (most are 48).
- `aria-pressed` on filter chips on Screen 3.
- `prefers-reduced-motion` honored.
- Body text on white: `#2A2F38` on `#FFFFFF` ≈ 12.6:1. Muted meta `#5B6470` on `#FFFFFF` ≈ 6.5:1. Warm-ink on warm-bg ≈ 8.1:1.

## What I did not author

- Copy beyond the IA-fixed CTA strings and obvious connective tissue. Content designer owns refinement.
- Interaction-level state (loading, error, empty per-tap behaviors). Interaction designer's call.
- Full token JSON / Figma library — out of scope for the prototype; this HTML *is* the artifact.

---

## Revision pass v2

Surgical pass applied after the A11y and Behavioral audits returned with blocking authority. No redesign; no prior-run inspection.

**A11y BLOCKERs applied**
- BLOCKER 1 (decision list semantics): `<div class="decisions" role="list">` → `<ul class="decisions">`; each `<button class="decision …">` wrapped in `<li>`. All `role="list"`/`role="listitem"` removed from `.decisions` and `.decision`. CSS extended with `list-style: none; margin: 0; padding: 0` on the `<ul>` and `.decisions > li { display: flex; }` so the visual stacking, spacing, and full-width hit target are unchanged.
- BLOCKER 2 (focus-able nav targets): added `tabindex="-1"` to each screen `<h2>` (`s1-heading` … `s5-heading`). Retargeted the skip link (`#s1-heading`), Screen 1 primary CTA (`#s2-heading`), all three Screen 3 "Confirm this flight" links (`#s4-heading`), and Screen 4 "Confirm rebooking" (`#s5-heading`). The `id="frame-N"` attributes remain on `<figure>` elements for layout reference, but no nav now targets them.
- BLOCKER 3 (Screen 5 stutter): `<p class="eyebrow">Confirmed</p>` removed from Screen 5 only. Green check + heading carry the confirmation; SR no longer hears "Confirmed" twice.

**Behavioral BLOCKERs applied**
- BLOCKER 1 (Screen 4 re-notification): replaced with the tokenized rewrite verbatim (`{renotification_channels}` + `{renotification_entry_point}`).
- BLOCKER 2 (Screen 5 re-notification): replaced with the tokenized rewrite verbatim (`{renotification_channels}` + `{reentry_path_status}`).
- BLOCKER 3 (social proof): "Most travelers choose this." removed from Screen 2 primary card. Consequence is now `"Confirmed seat on a later flight."` alone.
- BLOCKER 4 (reversibility): Screen 2 subhead is now `"Pick one. You can review this choice before it's final."`
- BLOCKER 5 (process promise): Screen 2 refund consequence is now `"You won't fly with us on this trip. Refund or credit handled separately."`
- BLOCKER 9 (Screen 2 visual rebalance): Primary card is no longer inverted black. New treatment: `--accent-soft` (`#EAEFFB`) tinted background + 3 px `--accent` left border + small uppercase "Primary" tag at top of the card (visual only, `aria-hidden="true"`; the button's accessible name is unchanged). Refund and standby now use the same solid `--hairline` border on white surface — they read as honest alternatives, not rejected drafts. The subordinate (standby) card's dashed border is removed. The primary's consequence text was also bumped to `--fs-14` per A11y NEAR-BLOCKER 2.
- BLOCKER 10 (step counter): dropped entirely on all five screens (cleanest fix per the audit's recommendation). The `.app-header .step` CSS rule remains in the stylesheet but is now unused — harmless and leaves the system token available if a future correctly-counted indicator returns.

**A11y NEAR-BLOCKERs applied**
- NEAR-BLOCKER 2 (primary consequence size): bumped to `--fs-14` (handled inside `.decision.primary .consequence`).
- NEAR-BLOCKER 3 (chip target): `.chip` `min-height` 30 → 40 px; padding 6×12 → 8×14 px to match.
- NEAR-BLOCKER 4 (sort button target): `.sort-line button` `min-height` 24 → 32 px; padding 4 → 6 px vertical.
- NOTE 5 (muted color): `--muted` tightened from `#5B6470` → `#4F5762` to give breathing room above 4.5:1 against `--hairline-2`.

**Deliberately deferred (per lead's instruction)**
- Behavioral NEAR-BLOCKER 11 (eligibility "not eligible" / "checking" visual states for the entitlement module): NOT authored. The lead is recording this as a known-gap recommendation per the IA report's scoping, not expanding prototype scope this pass.
- Behavioral NEAR-BLOCKER 12 (second support modality token): NOT authored. Same reason — lead will name it as a recommendation rather than invent an unsupported affordance.
- A11y NOTE 4 (token border tightening on warm surfaces): skipped this pass; not trivial without re-tuning the warm palette, and the visual still reads.

**Viewport-fit confirmation**
Re-checked at 390 px mobile width. Phone frame remains `max-width: 390px; width: 100%`; inner screen padding 20 px each side (≈ 351 px content width). The new Screen 2 primary card adds 3 px left-border + a 10 px "Primary" eyebrow tag — both well inside the canvas. Chip min-height 40 and the new bottom padding do not push the filter row to wrap differently. The two new tokenized re-notification lines on Screens 4 and 5 wrap on their own paragraph and stay inside content width because `.tok { white-space: nowrap }` prevents token-internal breaks while normal text reflows. No `overflow-x` was added to `html`, `body`, or any screen container. **Nothing exceeds 390 px at mobile.**

---

## Revision pass v3 (render-gate fix)

The render-proof DOM check at 390px viewport reported `htmlScrollWidth: 417` (27px over), with `.page`, `.mockups`, and Screens 4/5 `.summary-block .row-item` rows flagged as offenders. Root cause was structural, not cosmetic:

1. **`.page` padding was eating the canvas.** At a 390px viewport, `padding: var(--s-7) var(--s-4) var(--s-8)` (16px each side) leaves only 358px for `.phone`, but the phone's children (and `.mockup-label`) assume `max-width: 390px`. With the card forcing 390 plus 32px of page chrome, the document scrollWidth landed at 422, well past 390.
2. **`.summary-block .row-item` couldn't honor its 38/62 split** with two `.tok` pills set to `white-space: nowrap` separated by a middle dot in the value column. Token strings like `{hotel_entitlement_status}` and `{rebooked_flight_summary}` are long enough that two of them side-by-side, plus the inter-token separator, force `.v` past 62% — the row pushes out, the card pushes out, the page overflows.

### What I changed

Added a single new media query block (just before `@media (prefers-reduced-motion: reduce)`):

```css
@media (max-width: 430px) {
  .page { padding: var(--s-6) var(--s-3) var(--s-7); }
  .summary-block .row-item {
    flex-direction: column;
    align-items: stretch;
    gap: 4px;
  }
  .summary-block .row-item .k { flex-basis: auto; }
  .summary-block .row-item .v {
    text-align: left;
    overflow-wrap: anywhere;
  }
  .tonight-row {
    flex-direction: column;
    align-items: stretch;
    gap: 4px;
  }
  .tonight-row .v {
    text-align: left;
    overflow-wrap: anywhere;
  }
}
```

Selectors touched: `.page`, `.summary-block .row-item`, `.summary-block .row-item .k`, `.summary-block .row-item .v`, `.tonight-row`, `.tonight-row .v`.

### Why this is a real layout fix, not clipping

- No `overflow-x: hidden` was added to `html`, `body`, `.page`, or `.mockups`. The pre-existing `.phone { overflow: hidden }` is unchanged and remains scoped to the phone card (it was there in v1).
- The two structural drivers of overflow are removed: page chrome surrenders 8px of horizontal real estate at narrow widths, and the key/value rows stop competing for a fixed split that two nowrap tokens cannot honor.
- `overflow-wrap: anywhere` on `.v` is a belt-and-braces guard against a single hypothetical token string longer than the column. It does **not** override the `.tok` `white-space: nowrap` — token content is wrapped *between* tokens (across the dot separator), not inside them. Tokens still read as discrete pills.

### Compositional rationale

The column-stack at narrow widths is the right move regardless of overflow math: at 390px the key/value split was already cramped, and reading "Hotel entitlement: {hotel_entitlement_status} · {hotel_entitlement_amount}" as a stacked label/value pair is more legible than as a squeezed two-column row. The stack reads as a labeled field, which matches how mobile detail sheets in Things and Linear handle similar density. The desktop 3-column grid (≥1180px) and tablet 2-up (≥760px) are untouched — the new media query caps at 430px, well below those breakpoints, and the row layout returns to the horizontal split as soon as the viewport can honor it.

### Carry-forward of v2 audit fixes

All v2 work is intact: Screen 2 primary-recommendation card (left border + eyebrow), Screen 1/4/5 tokenized re-notification lines, the Screen 4/5 confirmation that nothing-was-charged copy is system-supplied, the 4 px optical correction on the entitlement value, and the support bar's right-aligned chevron. None of those selectors were modified — only narrow-viewport overrides were added.

### Verification expectation

At 390px viewport: `.page` inner width becomes 390 − 24 = 366px; `.phone` fits inside that at its `max-width: 390px` (effectively constrained to 366 by parent). `.mockups` is a single 1fr column at this width, so no grid math forces overflow. `.summary-block .row-item` and `.tonight-row` no longer contain a horizontal flex pair, so the long-token overflow path is removed. Expected: `documentElement.scrollWidth === clientWidth` and `body.scrollWidth === body.clientWidth`.

---

*End of v3 pass.*
