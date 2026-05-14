# Visual Designer — Northstar Canceled-Flight Recovery

## 1. Aesthetic direction

A dim hotel lobby at 11 p.m., not an airline kiosk at noon. Warm off-white surface, serif headline, one moss-green accent for "the path we suggest." One decision per screen, generous rhythm, tabular numbers, an atmospheric gradient only on Screen 1. The screen does not apologize — it does the next thing.

## 2. Design tokens (actual values)

**Color**
- Surface `#FAF7F2` · Surface-2 `#F3EEE5` · Surface-3 `#ECE6DA`
- Ink `#2A2622` · Ink-2 `#6B6259` · Ink-3 `#9A9087`
- Line `#E3DCCE` · Line-2 `#D6CDBC`
- Accent (deep moss) `#3F5A48` · Accent-soft `#E6ECE6` · Accent-line `#C8D2C8`
- Danger `#9A3B2E` (reserved; not used in flow)
- Focus ring `#2F4837`

**Type**
- H1: system serif (`ui-serif / Iowan Old Style / Charter / Georgia`) · 30 / 27px · weight 500 · line-height 1.15 · tracking -0.01em
- Body lede: system sans · 16px · 1.55 line-height · color Ink-2
- Numerals (times, codes): `SF Pro Text / Inter`, weight 600, `tabular-nums`
- Eyebrow: 12px · uppercase · 0.10em tracking · Ink-3
- Section h3 inside cards: serif 20px / 500

**Spacing** — 4pt base, 8pt preferred: 4 · 8 · 12 · 16 · 20 · 24 · 32 · 40 · 56.
**Radii** — 8 (small chips/buttons-small), 14 (cards & primary CTA), 20 (held-seat & summary card), pill (chips, dots).
**Shadow** — barely-there 1px hairline + 8px soft drop only on the device frame; cards rely on hairline borders.

## 3. Three component specs

**Held-Seat Offer card** — Anatomy: moss-pulse eyebrow → 28px tabular time + airline code → city-codes line w/ arrow tick → meta strip (Arrives · vs. original · Fare) → ≤14-word "why" → hairline reassurance. States: default (Accent-soft, 20px radius); pinned-Screen-2 variant; pressed (0.995); focus (2px ring, 3px offset). Sizing: 22/20px padding, hairline before meta.

**Support card** — Anatomy: 44×44 icon tile (Surface-2, moss icon) · serif h3 · 14px description · action row primary + ghost. States: default · honest-disabled (no fake-enabled buttons; e.g., no-checked-bag uses one ghost "Got it"). Sizing: 20px padding, 16px gap, 40px button min-height.

**Status strip** — Four 3px pill bars, equal flex, 6px gap. States: `is-current` (moss), `is-done` (Ink-2 @ 55%), default (Line). No labels — H1 does the talking. 6px above / 14px below.

## 4. Three pushbacks against the safe choice

1. **No "Recommended" badge — the card *is* the recommendation.** Safe move was a green pill. Instead the entire visual hierarchy of Screen 1 carries the trust: tinted surface, moss hairline, a ≤14-word "why." Principle: hierarchy over labeling.
2. **Serif H1 over sans.** Airline-app default is tight geometric sans. I chose a system serif at 500 to slow the read by one beat — a note, not a notification. Principle: tone-via-typography, not tone-via-copy.
3. **No fare-difference anywhere on Screen 2.** Safe pattern is "+$84" in muted grey "for transparency." During recovery that's a tax on the tired user. Removed entirely; arrival delta does the comparison. *(Per brief.)*

## 5. Message-to-Creative-Director (for sign-off)

> CD — anchor lands as warm-neutral surface (`#FAF7F2`), warm charcoal ink, single deep-moss accent (`#3F5A48`), system-serif declarative H1 against sans body. Screen 1 is the held seat as a tinted card — no "Recommended" badge; the card *is* the recommendation, with the "why" in ≤14 words: "Earliest confirmed seat. No fare change." Atmospheric gradient sits only on Screen 1, then the surface goes calm.
>
> Borderline calls: (a) serif H1 instead of sans — slows the read, risks reading editorial; (b) "See other options" is a peer hairline-outline secondary, same width as primary — looks like a peer, but the held-card's weight still anchors the eye; (c) on Screen 3 the "no checked bag" card is honest-disabled (one ghost "Got it"), not removed — I'd rather show the system noticed than hide.
>
> Second opinion most wanted: the serif H1. If precious rather than deliberate, swap to Inter 28/500 with tighter tracking, keep everything else. **Sign off or push back?**

## 6. Message-to-Accessibility-Specialist (before finalizing)

> A11y — pairs targeted: Ink `#2A2622` on `#FAF7F2` ~13.4:1 (AAA); Ink-2 `#6B6259` on Surface ~5.7:1 (AA body); Ink-3 `#9A9087` on Surface ~3.0:1, restricted to ≥12px uppercase eyebrows — your call whether I darken to ~`#857B70`. Accent `#3F5A48` on Surface ~7.1:1; Surface on Accent ~8:1 for the primary CTA. Focus: 2px `#2F4837` with 3px offset on every interactive. Touch targets: primary 52px, btn-small 40px — bump to 44? Least sure: Ink-3 meta strip + the moss "delta" on Accent-soft. Please redline.

## Revisions after A11y / BS audit

Surgical pass. Visual language untouched.

- **B1** (2.4.6): "Continue" → "Confirm tonight's plan" on both S3 variants.
- **B2** (1.3.1 / 2.4.1): Each device in its own `<main aria-labelledby>`; H1s id'd; outer scaffolding `<div role="region">`.
- **B3** (2.1.1 / 4.1.2): S2 flight `<div>`s → `<button>` with composed names (time + airline + route + delta + switch hint); focus ring added.
- **B4** (4.1.2): `aria-pressed` on Nonstop / Morning / Standby; `aria-haspopup` on "Earliest arrival"; "Take credit" stays a plain action.
- **Ink-3** (1.4.3): token `#9A9087` → `#857B70`.
- **btn-small** (2.5.5): 40 → 44px.
- **Reduced-motion** (2.3.3): pulse keyframes inside `prefers-reduced-motion: no-preference`.
- **Held-card intent**: `aria-roledescription="Suggested option"` on S1 group and S2 held-card. "Recommended" not user-visible anywhere.
- **Dialog**: `<dialog>` with `autofocus` on safe ghost "Not yet"; Esc native; focus returns to invoking card on close.
- **BS #1**: Dialog primary names the alternate ("Switch to the 9:55 a.m. nonstop"); safe option demoted to neutral ghost.
- **BS #2**: Second S3 variant with H1 "Help available tonight." for pending eligibility, labeled as a state-variant.
- **BS #3**: S1 held-card hairline alternate line: "Other flights include a nonstop arriving 4:18 p.m."
