# Visual / UI Designer — Canceled-Flight Recovery

## Aesthetic anchor

Linear's restraint meets Stripe's clarity, applied to a high-stress airline disruption surface. The user is tired, mobile-only, and reading at 10:46 p.m. — exuberance, illustration, and brand color signaling all read as noise. Restraint reads as trust.

Mood: calm, sober, deliberate, legible, plain-spoken.

Principles (named, so calls aren't arbitrary):
1. **Hierarchy is exaggerated under fatigue.** One H1 per screen, large, balanced. No competing weights.
2. **Color is for state, never for decoration.** A warm amber stripe means "event happened"; a muted green means "confirmed"; one teal-navy is the only action color. No brand color used to decorate.
3. **Dynamic values render at body weight, never as headline.** A token is decision-support content, not the message.
4. **The cheaper option is not visually weaker than the more expensive one.** Both $0 flights and the +$84 flight get the same card chrome; cost is a label, not a hierarchy.
5. **The human path is visible on every screen.** Hiding "talk to someone" to reduce calls is a trust failure mode that outranks the metric.

## Design system

**Type ramp** (4 steps, system fonts, no web font load):
- Display 22px / 1.25 / -0.01em — page H1 only
- H2 17px / 1.25 — secondary headings
- Body 15px / 1.45 — primary read
- Small 13px / 1.4 — meta, captions, summary rows
- Micro 11px / 1.0, uppercase, tracked — screen-label chrome only

**Color** (semantic, not decorative):
- Ink scale `#0E1726 → #F6F8FA` (7 steps) carries all surfaces and text
- One brand action: `#0E5A85` (deep teal-navy), darker on hover
- Alert (event): `#FCEFD5` fill / `#E6B767` stripe / `#7A4B0A` text — used once, on the cancellation block
- Confirmation: `#E2F1E8` / `#1F5A3C` — used once, on the booked banner
- Token chip: `#F2F4F8` fill with hairline border — neutral on neutral, never competes
- All body text against page wash passes WCAG AA (`#0E1726` on `#FFFFFF`: 17.4:1; `#5B6678` on `#FFFFFF`: 5.7:1)

**Spacing** — 4pt grid (`4, 8, 12, 16, 20, 24, 32, 40`). Vertical rhythm inside the body uses `gap: 16px` as the default chunk; tighter `gap: 12px` inside list groups.

**Radii** — 6 / 10 / 14px. Cards 10, screens 14, small chips/buttons 10. Consistent through every component.

**Shadow** — two-stop, low-contrast (`0 1px 2px` + `0 4px 16px` for cards; `0 2px 4px` + `0 12px 32px` for the screen surface). Shadow is structural, not decorative.

**Motion stance** — none beyond a 120ms color transition on interactive surfaces. `prefers-reduced-motion` disables all transitions globally. No autoplay, no parallax, no entrance animation.

## How the IA spine was implemented

The IA proposed 4 screens; I rendered 5 because the brief allows up to 5 and the SMS entry is the trust-establishing first beat. The SMS surface is a real screen, not a decorative preview — it's where the user reads "crew availability" before they ever tap. Dropping it would put the IA's biggest copy win (the rewritten SMS) into prose-only territory.

Final sequence:
1. **SMS entry** — verified-sender pattern, plain-language event, the IA's exact rewritten SMS string
2. **Status & Plan** — H1 = the event itself; amber-stripe block carries the cause; reassurance line names hotel/meal support inline; primary CTA "See my options", secondary "Talk to someone"
3. **Choose your path** — four peer cards (rebook / standby / credit / hotel & meal) in IA-specified order, with consequence one-liners exactly as written by IA. No default selection. The refund-seeker dead-end is rendered as an honest note above the persistent "Talk to someone" footer — visible, not buried.
4. **Pick a flight** — three flight cards in time order (earliest first, per IA). The $0 cards and the $84 card share identical chrome and button size. Fare badge color: green for "Same fare", neutral ink for "+$84" — cost is information, not punishment.
5. **Confirm & save** — confirmation banner, H1 restates the chosen flight, summary block as a `<dl>`, hotel/meal status as tokens, "Send me a copy by email and text" + "If plans change again, see options". No "Done."

The IA's "Talk to someone" persistence requirement is honored as a footer on every screen except the SMS (which is the user's phone, not the airline app).

## Placeholder token treatment

The biggest craft tension on this brief was: how do you show tokens honestly without letting them become the visual hero? Three rules applied:

1. **Tokens inherit surrounding type.** `.tok` never overrides font-size, weight, or family — only adds a faint background fill (`#F2F4F8`), a hairline border, and 5px horizontal padding. Read at a glance, the token is the same weight as the words around it.
2. **Tokens never appear in an H1.** The Screen 5 H1 reads "You're booked on the 7:10 AM flight to LGA" — the time is a fact from the user's selection on the prior screen, not a placeholder. Placeholder data lives in the summary block and the support block, both at small-body weight.
3. **Tokens wrap, they don't clip.** `word-break: break-word` on the chip and on summary `<dd>` cells. A long `{confirmation_code}` will line-break inside its row, not push the layout sideways.

## Viewport-fit notes

**~390px width:** Rendered to PNG at 390×8000 with headless Chromium. The grid collapses to a single column. Screen cards land at full container width (~358px content area inside 16px page padding). All buttons span full width and clear the 48px touch-target minimum. No horizontal scroll, no clipped text, no overlapping chrome. Tokens fit inline; the longest body token (`{new_arrival_time}` within a meta row that already contains "arrives" and a separator) reflows cleanly when needed.

**1280px desktop:** The grid switches to `auto-fit` at `minmax(380px, 420px)` — three screens land on the first row, two on the second. Each screen retains its 420px max-width so the design intent (mobile-first cards) is preserved. The page reads as a flow, not a desktop redesign.

**Deliberately no phone bezels.** A status-bar abstraction (time + status dots) plus a thin app-bar gives each card "mobile screen" identity without a kitsch frame that would clip content or invite skepticism about whether the artifact is just a mockup wall.

## Deliberately deferred

- **Family / multi-passenger UI.** Screen 2 hints at it ("Traveling with others on this trip? They'll appear on the next screen"), but the actual multi-pax picker is not built. Flagged here, IA flagged it as a scoped gap.
- **Filter affordances on flight list.** IA suggested nonstop-only and arrival-before. A copy line on Screen 4 names this as coming; controls are not built. Otherwise the screen acquires complexity that's not load-bearing for the primary decision.
- **Standby flow detail.** The path card promises a separate flow ("you wait at the gate and may not get on") but the standby-specific screen variant is not built. Three of four paths in the IA spine converge on the same flight-list screen; standby needs its own variant in production.
- **Hotel & meal selection UI.** The peer card opens a panel in production; this prototype represents the entitlement as a token-bearing status block on the confirmation screen rather than its own screen, to stay inside the 5-screen budget.
- **Empty/error/loading states.** Production needs them. Out of scope for the disruption-recovery prototype as authored.

## Sanity check before handoff

Local render check at 390px and 1280px via headless Chromium PNG. No `overflow-x: hidden` on the page (the only `overflow: hidden` is the standard `.visually-hidden` screen-reader utility, which is a 1px clip and not a layout mask). No microscopic text — smallest readable type is 13px body-small; 11px is used only for non-essential screen-chrome labels above each card. The strict render-proof loop is lead-owned after audits, per the protocol.

## Revision pass

One surgical pass against the A11y + Behavioral audits. Scope-limited: no new copy, no new screens, no token-restraint regressions, no `overflow: hidden`.

1. **Heading hierarchy (six h1s).** Demoted all four `h1.event` inside screen sections to `h2.event`; updated the CSS selector to `h1.event, h2.event` so the display ramp is preserved. Demoted the `<h3>` in the support block to `<h4>` and renamed the `.support-block h3` rule to `.support-block h4`. The `<h1>` in `.page-intro` remains the only top-level heading. Outline is now: 1× h1, 5× h2 (one per screen), 1× h4 (nested under the Screen 5 h2). Strictly there is an h2→h4 skip in the support block; honored the user's explicit direction over my preference for h3.
2. **SMS aria-labelledby.** Added a `<h2 id="s1-title" class="visually-hidden">SMS entry — your flight was canceled</h2>` inside the `.sms-frame` and moved the `id` off the `.sms-bubble`. The section's `aria-labelledby` now resolves to a true heading instead of a body bubble. The hidden h2 also makes the SMS screen contribute correctly to the document outline.
3. **Focus ring.** Replaced `--focus: 0 0 0 3px rgba(14, 90, 133, 0.35)` with `--focus: 0 0 0 2px #fff, 0 0 0 5px var(--brand-600)` — a 2px white inner halo plus a 3px solid brand-600 outer ring. Brand-600 on white is 6.0:1; the white halo guarantees ≥3:1 against any container fill including `--brand-100` selected washes. No alpha, no reliance on background blending.
4. **Reflow at 320px.** Changed `.stack` grid track from `minmax(360px, 1fr)` to `minmax(min(100%, 360px), 1fr)` (and the 900px breakpoint variant analogously). Below 360px the track collapses with the viewport instead of forcing horizontal scroll; at desktop the multi-column behavior is preserved because `min(100%, 380px)` resolves to 380 once the container exceeds it.
5. **Back arrows.** Set `aria-hidden="true"` on all five `<span class="back">` elements and removed every `aria-label="Back"`. The arrows are decorative chrome in a stacked storyboard — they never had real navigation behind them, so labeling them as interactive was a lie to AT. Decorative is honest; converting to `<button>` would have implied behavior this prototype does not deliver.
6. **Label in Name (Choose this flight).** Removed `aria-label` from all three flight CTAs entirely. The visible string "Choose this flight" is now the accessible name — first words match visible words verbatim, satisfying 2.5.3 by the cleanest possible route. The meta row above each card already carries time / stops / fare information for sighted users; an AT user reaching the button will have already read that meta row from the surrounding card markup.
7. **Behavioral parity on flight CTAs.** Demoted the 7:10 AM CTA from `btn-primary` to `btn-secondary` so all three "Recommended"-free flights present as visual peers. The "earliest option" meta line carries the time-ordering work; no copy added. The remaining `btn-primary` instances on the page are now Screen 2's "See my options" (the only path forward on that screen, legitimate primary) and Screen 5's "Send me a copy by email and text" (the leave-with-proof action). Both keep their emphasis honestly.

Nothing rejected. All seven items applied as specified. The Screen 5 support-block heading is the only structural compromise (h2 → h4 skip); flagged above and accepted under explicit direction.
