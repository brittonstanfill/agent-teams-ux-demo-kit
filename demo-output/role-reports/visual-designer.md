# Visual Designer Report: Canceled-Flight Recovery

## Aesthetic anchor

Linear's restraint, crossed with Apple system honesty. A tired traveler at 10:46 p.m. needs legible hierarchy, one obvious next move per screen, and a quiet surface that doesn't feel like marketing. Signal-red appears in exactly one place (Screen 1's banner); the rest of the flow uses a single calm action blue.

**Mood:** calm, candid, grown-up, low-temperature, gate-side.

**Principles:**
- Hierarchy is exaggerated under fatigue. One H1, oversized screen titles, one primary action; everything else recedes.
- Color is for state, never decoration. Red on the cancellation banner only. Blue for actions and the support link.
- Token pills are visible content. Monospaced inline chips that wrap, never overflow. A page-head note explains they render server-side.
- Refund is a peer. Path cards have identical weight; the Rebook default gets a quiet blue ring + tint. No "Recommended" badge.
- Trust signals beat trust claims. `Call support` lives in every header and in a bottom dock.

## Visual system

**Type.** System sans, 1.18 ratio capped: 28/24/20/17/15/13/12. Bold 650/680 titles, 400 body. Line-height 1.45 body, 1.18-1.22 titles.

**Color.** Neutral slate ramp (ink-50→ink-900). Action blue `#1d4ed8`. Signal red `#b42318` on `#fef3f2` — used exactly once. Body text `--ink-600` or darker.

**Spacing.** 4pt rhythm: 4/8/12/16/20/24/32/40/56.

**Radii.** 8 chips, 12 cards/buttons, 16 confirm hero, 22 large panels, 38 phone frame.

**Shadow.** Two: hairline card shadow, deeper phone-frame shadow. Borders carry inner structure.

**Motion.** 160ms ease on hover only. `prefers-reduced-motion` zeroes transitions.

## Component inventory

- **Phone frame** — 390px max, 38px radius, hairline border, deep shadow.
- **App header** — sticky brand + persistent `Call support` at 44px target.
- **Status banner (S1)** — red pip + uppercase label + plain body. Static, no live region.
- **Path cards (S2)** — `<button>` in `<ul role="list"><li>`. Default Rebook: blue ring + tint + `aria-current="true"`. No badge.
- **Flight cards (S3)** — depart/arrive times primary; route/stops/duration meta; inline reason line explains rank. All hold buttons secondary weight.
- **Filter chips** — semantic `<label>` + checkbox, 44px min height; selected state inverts to ink-900. No pre-selected filters.
- **Eligibility card (S4)** — conditional framing, disclosure as left-rule pull quote. Action order: primary → quiet talk-to-someone → secondary state opt-out.
- **Confirmation hero (S5)** — dark inverted panel; status pill + `dl` summary.
- **Save row** — three offline options 3-up, collapses to 2-up under 360px.
- **Support dock** — bottom of every screen, second route to a human.
- **Storyboard nav** — page-head `<nav>` with anchors to each `#screen-N`.

## Audit-fix log

A = Accessibility blocker, B = Behavioral blocker, Bi = Behavioral important.

1. **A1** — Outer `<main class="page">` → `<div>`. Each inner `<main class="screen">` → `<section aria-label="Screen N content">`. Zero `<main>` elements remain.
2. **A2** — `h1.screen-title` × 5 demoted to `h2`. In-screen `.status-banner`, `.eligibility`, `.confirm-hero` h2s demoted to h3; CSS selectors updated. Page-head is the lone `<h1>`.
3. **A3** — `aria-hidden` removed from all five `.screen-label` divs. Each `.name` span gets `id="screen-N-title"`; the `section.phone` uses `aria-labelledby` to point at it.
4. **A4** — `role="list"`/`role="listitem"` removed from `<button>`/`<article>`. Screen 2 paths and Screen 3 flights now use `<ul role="list">` + `<li>` wrappers. Default Rebook gets `aria-current="true"`.
5. **A5** — Page-head note added: tokens render server-side; live build substitutes values before paint.
6. **A6** — `role="status"` removed from Screen 1 banner. Heading carries the announcement.
7. **A7** — "Change sort" → `<button type="button">` with 44px target and focus ring. All `href="#screen-N"` now resolve to real section IDs.
8. **A8** — `.stub-line .label` raised `--ink-500`→`--ink-600`. Route arrows raised `--ink-400`→`--ink-600`.
9. **A9** — `.btn-primary:focus-visible` now uses a `2px --ink-900` outline at 3px offset plus a `0 0 0 2px #fff` box-shadow halo. Reads against blue fill and white surface.
10. **A10** — `.chip` min-height 36→44px; padding 8/14.
11. **A11** — Added `<nav aria-label="Storyboard screens">` in page head with anchor chips to every `#screen-N`.
12. **B1** — Screen 2 bottom "Find a flight" CTA block removed entirely. Path cards are the CTAs; "Back to status" kept as quiet link.
13. **B2** — "Recommended for getting there" badge removed. `.is-default` ring + tint still nudge (IA names Rebook the default); card description carries framing.
14. **B3** — `checked` removed from Morning filter chip.
15. **B4** — Screen 4 secondary relabeled **"I have a place to stay tonight"**. Order: primary request → quiet "Talk to someone" → secondary state. Talk-to-someone now sits above the opt-out.
16. **B5** — Screen 5 primary relabeled **"Save my record"**.
17. **Bi2** — Screen 1 banner copy: "You don't need to do anything yet — we'll walk you through your options."
18. **Bi4** — All three Screen 3 "Hold this flight" buttons set to `btn-secondary`. Chose all-secondary over all-primary: three competing blues out-shout each other; the sort label and per-card reason line carry ranking without a button-weight thumb on the scale.

**Deliberately rejected:** none.

**Open TODOs:** `.badge` CSS is now dead code (prune next pass). A11y Important #5 (announce CTA-label change on path select) needs JS; out of scope for static prototype.

## Viewport-fit note

Static analysis at 390px: phone is `max-width: 390px`; page wrapper `max-width: 520px`. Token pills wrap (`word-break: break-word`). Chip and storyboard-nav rows use `flex-wrap: wrap` — the 44px chip height adds vertical, not horizontal, dimension. The `@media (max-width: 360px)` step-down trims the H2 28→24px and collapses save-row 3-up→2-up. No headless probe this pass (Playwright unavailable in env); lead owns strict render proof. No throwaway scripts left behind.
