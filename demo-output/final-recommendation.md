# Canceled-Flight Recovery: Recommendation

## 1. Executive recommendation

Replace the current recovery flow with a redesigned five-screen sequence that names the cancellation plainly, treats refund as a peer of rebook and credit, surfaces hotel and meal support on its own screen with conditional framing, and ends with a sharable offline record. The two design moves that matter most:

- **Refund is a first-class peer on Screen 2**, not a footer link. Removing the bottom path-agnostic CTA prevents reflex-funneling into rebook.
- **Support entitlements live on a dedicated screen** with copy that promises only a check ("we'll tell you what you qualify for"), never a specific amount, brand, or expiration unless the backend returns one.

Ship behind a gated experiment with the metrics in §4. If calls fall while refund-completion or eligible-claim rate also falls, the flow is succeeding at the wrong goal and must roll back.

## 2. Redesigned flow

Five screens, mobile-first. Each screen has one H1, one primary decision, and a persistent `Call support` link in the header.

1. **Status & cause.** Plain language: "Your 6:15 a.m. flight tomorrow is canceled" with the cause stated ("crew availability") and a soft preview of what comes next. Primary CTA `See your options`.
2. **Choose your path.** Three peer cards — Rebook (default, visually weighted, `aria-current="true"`), Request a refund, Take travel credit. Standby is demoted into Rebook as an inline option. **No** path-agnostic primary CTA at the bottom.
3. **Pick a replacement flight** (Rebook path). Default sort is earliest arrival. Filter chips are user-initiated; nothing is pre-checked. No fare-difference badge during disruption recovery. No "Recommended" tag on any card.
4. **Tonight's hotel and meal support.** Conditional copy framed without invented policy: "Hotel and meal support depends on the cause of the cancellation and what is available tonight. We'll tell you what you qualify for before you confirm." Three actions in this order: primary `Request hotel & meal support`, secondary `Talk to someone about tonight`, tertiary `I have a place to stay tonight` (state, not refusal).
5. **Confirmation & offline record.** Summary of new flight, support status, and next steps with `Save as PDF`, `Send to email`, `Add to wallet`. Primary CTA `Save my record` (not "Done").

SMS entry: "Northstar: Your 6:15a flight NS482 DEN→LGA tomorrow is canceled (crew shortage). Tap to rebook and check hotel/meal support: [link]. Or call [support_number]."

## 3. Accessibility and trust guardrails

- One H1 per document; per-screen titles are H2 with `aria-labelledby` regions. Storyboard nav with skip-to-screen links.
- Body text on `--ink-600` or darker; route arrows strengthened to meet 1.4.11. `.btn-primary` focus ring switched off the button's own blue.
- Filter chips raised to 44×44 minimum target size; primary buttons at 48px.
- Token pills are visible content with `overflow-wrap: anywhere` and `max-width: 100%`; a prototype note clarifies that real values render server-side.
- Trust guardrails: no pre-selected filters; no badges that import an assumption the user hasn't stated ("Recommended" removed); every screen carries a tappable `Call support` so call-volume reduction can never be claimed via hidden help.
- Conditional eligibility framing is the line between honest disclosure and brush-off — track the opt-out and not-eligible call rates as falsifiers.

## 4. Experiment plan

Two-cell rollout (new flow vs current) gated on these four metrics. Each is a ratio, not a vanity count, and at least one is intentionally an invalidator.

1. **Refund-path completion rate** among users who tapped `Request a refund` on Screen 2. Target: parity with rebook completion ±10 points. Below 70%: asymmetric friction is real.
2. **Call rate within 30 minutes of viewing Screen 4 "not eligible"**. If this rises, conditional language is failing — users feel brushed off. If it falls dramatically, audit qualitatively for users giving up.
3. **Ratio of `I have a place to stay tonight` taps to confirmed-eligible users**. If eligible users opt out, framing is suppressing claims — a hidden-entitlement pattern.
4. **Share of Screen-5 viewers who save the record within 60 seconds AND return to the flow within 24 hours**. First number tests reassurance; second tests whether the offline record stranded users when plans changed.

**Rollback trigger:** call volume drops AND refund-completion drops faster than rebook-completion — reduction-via-funnel, not reduction-via-clarity.

**Scoped gaps:** multi-passenger group-split (one refunds, others rebook) is not solved here and needs policy clarification before v2. Screen 4 assumes a backend that returns cause-and-availability in real time; if slow or post-hoc, replace "we'll tell you before you confirm" with a clear "we'll text you back" state.
