# Visual Designer — Prototype Note

## 1. Visual choices that hold the anchor

**Palette.** Six-step neutral dark scale on near-black canvas (#0c0e10). Primary ink reads ~16.5:1 (AAA at any size); secondary ~9.8:1; tertiary ~6.1:1 (AA, metadata only). One near-white accent on the single primary button per screen. No brand-blue, no gradient.

**Type.** System stack. Headline 30/38 medium — the event itself carries the weight. Title 20/28 on flight summaries. Body 17/26. Metadata 14/20, tabular numerals on times and codes.

**Spacing.** 4pt rhythm (4/8/12/16/24/32/48), vertical only, 24px gutters inside the 390px viewport.

**Button hierarchy.** One primary per screen. Screen 1's two forks are stacked buttons of identical size — only the fill differs — satisfying IA's co-equal refund path. Decline controls on screen 3 are real `<button>` with 44px targets and `aria-pressed`, not links.

**The "no" list applied.** No illustration, no exclamation marks, no "We're sorry," no checkmarks, no shimmer, no Recommended badge, no fare delta, no countdown, no Done terminal, no icon-only meaning.

## 2. How the prototype answers each IA primary decision

- **Screen 0 (open or ignore).** Plain event verb, one link.
- **Screen 1 (travel or not).** Event headline, cause, three held-item status rows as system placeholders, two same-size path buttons. Refund/credit is the second button — not a link, not a tab.
- **Screen 2 (pick one).** Filter row (arrive-by, nonstop, party-size) with visible labels. Chronological list. Held-seat and standby flags are textual.
- **Screen 3 (confirm + accept/decline each item).** Flight summary, two-traveler eligibility rows as status, three support items each with an Accept/Decline pair.
- **Screen 4 (save/share).** Offline-viewable receipt covering flight, hotel, baggage, meal. Save/Share row. Persistent support link. Copy that says reopen-to-rebook — kills the dead-end.

## 3. Known gaps before A11y and Behavioral audit

- Accept/Decline pair uses `aria-pressed` toggle with no live region. SR users may not get state-change feedback; A11y will likely ask for a radiogroup or live status.
- Focus ring contrast against every surface not measured per pair — likely fine, not verified.
- Standby flag is warm-tone ink + 1px border. Colorblind users read it as plain text, which is the intent. Behavioral may want more separation from confirmed rows.
- Filter `<select>` uses the native picker; iOS dark-mode rendering is OS-dependent.
- Default state on screen 3 is Accept-pressed across all items. Behavioral may flag this as nudging acceptance versus a neutral unselected default.

## 4. Open questions for the audit pass

- Should the refund/credit fork carry per-traveler eligibility on screen 1, or is that deferred to its screen-2-equivalent? IA implies deferred; I deferred.
- Including a standby row in the same list as confirmed options — trust risk even when labeled? Kept for completeness.
- No CD/IA conflict surfaced. CD's type-led, no-illustration posture and IA's per-traveler status block both resolve to plain text rows.

## Revision pass

What changed:
- **Focus ring.** `.btn-primary:focus-visible` layers 2px `--ink-inverse` inset + 4px `--focus` outer — 3:1 on both surfaces.
- **Headings.** Stage `<h1>` is the sole `<h1>`. Each `h1.event` → `<h2 class="event">`. SMS hidden `<h1>` removed; SMS `<main>` gets `aria-label`.
- **Anchors → buttons.** Four primary actions are now `<button type="button">`. Skip-link, jump nav, `tel:`, SMS link stay `<a>`.
- **Accept/Decline → radiogroup.** Three Screen 3 items use `<fieldset class="support-radios">` (Accept checked), `vh` legend, `aria-live="polite"` status. Inline JS updates the line. Pair gap → `--s-3`.
- **Standby flag.** `.flag.standby` dashed; held flag solid.
- **Filter.** Legend → "Filter flights"; party-size input `aria-describedby` a visible "1–9 travelers" hint.
- **Skip-link.** First focusable in `<body>`, hidden until focused.
- **Standby row.** Moved out of the main `<ul>` into its own `<section>` + `<h3>`.

What I did NOT change:
- **Accept-as-default.** Ships as-is — entitlements owed; status-quo bias is pro-user. Radios keep Accept checked.
- **Refund-fork weight.** Ships as-is — same structural treatment as primary.
- Palette, type, spacing, voice, copy (except the legend rename).

New gap:
- `.support-radios label:has(input:checked)` paints the selected pill via `:has()`. Modern engines fine; older WebViews skip the fill. Native radio dot still carries state.
