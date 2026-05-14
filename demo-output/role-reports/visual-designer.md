# Visual Designer — Northstar Canceled-Flight Recovery

## Aesthetic anchor

Linear's restraint meets Things 3's deliberateness, tuned for 11 p.m. tired-traveler. Text-first, generous spacing, monochrome with one quiet evergreen accent reserved for action. **Color is for state, never decoration.** No emergency red, no airline cobalt — those raise stress at the worst moment. Background is warm paper. Mood: calm, plain, deliberate, durable, honest.

## IA-handoff items honored exactly

- **Screen sequence and one-decision-per-screen:** matches handoff in order; each screen has one h1 and one primary CTA.
- **Content hierarchy on every screen:** what happened → what you can do → what we owe you (only if confirmed) → what happens next. Screen 1's status card encodes this literally.
- **No default on Screen 2's three paths:** all cards render `aria-pressed="false"` at load. CTA reads "Continue with my choice" — no implicit destination.
- **Standby non-equivalence:** Standby sits below an explicit "Or, a non-confirmed option" divider, uses a dashed container instead of a card, smaller type ramp, a warning chip ("Not equivalent to rebooking"), smaller radio dot. Lower visual weight, still reachable.
- **Refund paired with credit on Screens 2 and 3.** Never credit-only.
- **Persistent "Talk to an agent":** identical pattern on every screen, in document flow at the bottom — outlined pill in ink, not the accent, so it never competes with the primary CTA.
- **Party-size visible across Screens 2–5:** chip in the trip-context rail; stepper on Screen 2 that feeds downstream filters.
- **Confirmed vs. unconfirmed support rows:** confirmed rows have a 3px evergreen left rail, an icon tile in `--ok-soft`, and a "Confirmed" badge. Unconfirmed rows use dashed borders, neutral icon tile, surface-2 background, amber "Check with agent" badge. Two channels (border-style + badge), never color alone.
- **Filter chips on Screen 3:** horizontally scrollable, never hidden. "Earliest arrival" and "Seats together (2)" pre-selected from party context; clearable.
- **"Recommended" removed,** replaced with a criterion label ("Earliest arrival to LGA").
- **Fare difference shown as $0 with explanation** on every card; copy declares no fare difference applies during recovery.
- **Confirmation summary, offline/share, re-entry** all on Screen 5. Re-entry sits in a dashed surface — "path, not finished door."
- **System-provided placeholders** render as inline monospace tokens (`[hotel name from system]`, `[code]`). Scaffolding, not invented content.

## Adapted, with reason

- **Audit nav at the top:** brief asked for all five screens visible. Sticky chip nav for jumping; would not ship.
- **Stepper instead of yes/no toggle on Screen 2:** a stepper answers how many and feeds "Seats together" with a real number.
- **Status pip is amber, not red.** Red dominates at 11 p.m. and feels punitive. Amber matches "Check with agent," keeping severity language consistent.

## Type / color / spacing system

- **Type:** system stack, three weights (400/500/600), six sizes (12/14/16/18/22/28). Hierarchy exaggerated — H1 jumps two steps over body so the plain-language event lands first. Monospace reserved for codes, times, and route abbreviations to signal machine-supplied truth.
- **Color tokens:** `--ink` near-black with green undertone, `--accent` deep evergreen (action only), `--ok` leaf (confirmed state), `--warn` amber (check-with-agent), `--bg` warm paper. Focus ring is high-contrast blue, `:focus-visible` only. Selection uses a near-black outline + 2px ring, not the accent — accent is for forward motion.
- **Spacing:** 4pt grid in 4/8/12/16/24/32/48/64 steps. Whitespace does visual work — grouping support rows, separating confirmed from unconfirmed regions.
- **Radii:** 8/10/14 + full pill. Cards 14, rows 10, chips pill.
- **Shadow:** one barely-there elevation, only on Screen 1's status card. Rest is flat — the page is a document, not a stack of tiles.

## Persistent agent affordance

Same shape, place, and copy spine on every screen: low-elevation horizontal card with a contextual sub-line + outlined pill reading "Talk to an agent." Sits *after* the primary action so it never competes, but is one scroll away and always in tab order.

## Deliberately left for audit

- **Final copy and SMS rewrite** — content designer. Shapes only here.
- **ARIA, focus order, keyboard for chips/stepper/radiogroup** — interaction designer. Roving tabindex not implemented.
- **Contrast verification at 4.5:1 / 3:1 on every state combo + screen-reader announcements for state changes** — accessibility specialist. Specifically want audit on `--warn` on `--warn-soft` and `--ink-3` meta.
- **Skeleton / loading / error states** — out of scope for a static prototype.

## One thing I'd defend

Standby's visual subordination. The principle is honesty: the path is structurally inferior, and visually equalizing it would re-create the original flow's biggest trust failure under a new skin. The dashed container + reduced type + warning chip + "non-confirmed option" divider all say the same thing — *we will let you choose this, but we will not pretend it is the same kind of thing as a confirmed seat.*

---

## Revision pass

Triggered by accessibility-specialist and behavioral-scientist audits. Typography, color tokens, layout, Standby treatment, and confirmed-vs-unconfirmed row pattern all left intact.

### Blockers fixed

- **A11y B1 — Path radiogroup contradiction.** Dropped `role="radio"` / `role="radiogroup"` from Screen 2's three path buttons. Wrapped them in `<fieldset class="paths">` with a visually-hidden `<legend>How do you want to recover?</legend>`. Each button now carries only `aria-pressed="false"` at load. JS rewritten as a single-select toggle set (`wireToggleSet`) — no `aria-checked` is ever set on these. Same pattern applied to the refund pair on Screen 3 (`<fieldset class="refund-grid">` + hidden legend). Visual treatment unchanged.
- **A11y B2 — Flight cards listbox/option semantics.** Removed the `<ul role="listbox">` wrapper and `<li>` children; removed `role="option"` and `aria-pressed` from the flight buttons. Replaced with `<fieldset class="flights" id="flight-group">` + visually-hidden `<legend>Choose a flight to LGA</legend>`. Each flight is now `<button role="radio" aria-checked="false" tabindex="...">` with roving tabindex (selected = 0, others = -1) and a keyboard handler for ArrowUp / ArrowDown / ArrowLeft / ArrowRight / Home / End / Space / Enter. CSS selector `.flight[aria-pressed="true"]` updated to `.flight[aria-checked="true"]` so the selected visual treatment still applies.
- **Behavioral B1 — Screen 1 false reassurance.** Replaced the lead line "We're sorry — this isn't on you, and we can take care of the next steps from here." with "We're sorry — this isn't on you. We'll walk you through your options now, and flag anything we still need to confirm." Hedged verb, kept the reassurance block intact, visual weight unchanged.

### Should-fixes applied

- **A11y S1 — `<main>` landmark.** Wrapped the five `<section class="screen">` elements in `<main id="main">`. Audit nav remains outside `<main>`. Skip-link deliberately not added (acceptable per lead).
- **A11y S2 — Functional-text contrast.** Introduced `--ink-2b: #52605a` (≈4.7:1 on `--bg`) for functional small text; kept `--ink-3: #6b766f` for decorative meta only, with a comment in the token block clarifying that `--ink-3` does *not* meet 4.5:1. Applied `--ink-2b` to `.path--standby .path__sub` (Standby's consequence copy is no longer the lowest-contrast text on the page), `.flight__route`, and `.refund-card__sub`.
- **A11y S3 — Stepper semantics + target size.** Stepper container now `role="spinbutton"` with `aria-labelledby="party-label"`, `aria-valuemin="1"`, `aria-valuemax="9"`, `aria-valuenow="1"`, `aria-valuetext="Party size: 1 traveler"`, `tabindex="0"`. JS updates `aria-valuenow` and `aria-valuetext` (pluralized) on every change, replacing the bare `aria-live` value-only announcement. The +/− buttons raised from 36×36 to 44×44. The stepper container itself handles ArrowUp / ArrowDown / Home / End keys.
- **A11y S5 — Chip group label.** Changed `aria-label="Filter flights"` to `aria-label="Flight filters, multiple allowed"` so the relationship and cardinality is announced.
- **A11y S6 — Summary badge clarification on Screen 5.** "Pending agent" status converted to a labeled action (see Behavioral S3 below). The action's `aria-label` now reads e.g. "Meals: pending agent confirmation — resolve with an agent" so screen-reader users get the row context, not just the badge string.
- **Behavioral S1 — Pre-acceptance badge wording.** Screen 4 Hotel and Hotel-shuttle rows now read "Available for you" instead of "Confirmed" while in pre-acceptance state. Visual treatment (evergreen left rail, evergreen icon tile, `--ok` chip) preserved. Screen 5 keeps "Confirmed" because those rows reflect post-acceptance state from the prototype's scenario.
- **Behavioral S2 — Phantom decline affordance.** Added an explicit `<button>Decline</button>` to every Screen 4 support row (Hotel, Meals, Shuttle, Bags), styled as a quiet outlined secondary action in a vertical `.support-row__actions-group` next to the primary Accept/Check button. The instructional sentence updated: "Don't need something? Decline it on the row — silence isn't consent." No more invisible affordance.
- **Behavioral S3 — Pending-agent badges become actions.** Screen 5's Meals and Bags rows now render the status as `<a href="#s5-agent" class="support-row__state support-row__state--check support-row__state--action">Resolve with agent</a>` instead of a dead `<span>Pending agent</span>`. The agent affordance on Screen 5 carries `id="s5-agent"` so the anchor lands correctly. Visual treatment carries an outlined border and a hover/focus inversion so the action affordance reads.
- **Behavioral S4 — Stepper default.** Markup default dropped from 2 to 1. `aria-valuenow="1"` and `aria-valuetext="Party size: 1 traveler"` at load.
- **Behavioral S5 — "Earliest arrival" chip.** Un-pressed at load along with "Seats together" — no chip is pre-pressed. Eliminates the soft default entirely; user opts into sort/filter explicitly.

### Audit fixes deliberately rejected

- **A11y S4 — Broken anchors `#flight-detail`, `#agent`, `#explain`.** Left as scaffolding placeholder per lead's explicit instruction. Did not invent target content. The `#s5-agent` anchor added for Behavioral S3 is a real in-page target.
- **A11y S6 in full — adding visible per-row prose context on Screen 5 for Meals/Bags.** Partially addressed via the action's `aria-label` and the new "Resolve with agent" label, which together give screen-reader and sighted users a clearer signal than the bare "Pending agent" badge. Did not add a sentence per row in the summary table because (a) inventing wording for each row's pending detail without knowing what the system can actually surface risks invented operational facts, and (b) the row's link target plus aria-label already restores parity with the sighted view. Flagging for content-designer if the team wants per-row prose.

### Operational-fact discipline

Confirmed: no hotel names, dollar amounts, voucher values, wait times, expiration windows, phone numbers, gate numbers, eligibility promises, or compensation rules were invented during the revision. All system-supplied values remain monospace placeholders (`[hotel name from system]`, `[shuttle stop from system]`, `[interval]`, `[gate at check-in]`, `[code]`, `[window from system]`, `[arrive-by time from system]`). The Screen 4 "Available for you" wording is a state label, not an operational claim — it does not promise a specific hotel or a specific shuttle, only that the system has surfaced an option for the user's acceptance.
