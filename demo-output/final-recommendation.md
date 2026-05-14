# Northstar Canceled-Flight Recovery — Recommendation

## 1. Executive recommendation

Replace the three-tab "New flights / Travel credit / Standby" picker with a **held-seat-first** recovery flow: four screens, one decision per screen, entitlements surfaced before commit, standby demoted to a filter. The current flow asks a tired user to adjudicate options before explaining what happened, and hides help they qualify for behind "Other policies." The redesign answers the silent first question ("am I getting home?") with a confirmed seat already held, then makes the alternative one tap away. Self-service should rise; if it rises by hiding help, the guardrails below will flag it.

Prototype: `demo-output/prototype/index.html` (mobile portrait, all four screens stacked). Ship behind a 5-user moderated test plus the experiment cohort in §4.

## 2. Redesigned flow

**Entry SMS.** Replaces "Schedule irregularity on NS482." Names the event, gives the reason without blame, names the held seat, gives one next step.

> Northstar: your 6:15 a.m. flight tomorrow (NS482, DEN–LGA) is canceled — crew availability. We've held a seat on the 7:10 a.m. Open trip to keep it or pick another: nsair.co/t/4k2

**Screen 1 — Held-Seat Offer.** Answers: *am I getting home?*
- H1: "Your 6:15 a.m. to LGA was canceled."
- Held-seat card with the *reason* shown inline (≤14 words): "Earliest confirmed seat tomorrow, same fare." No "Recommended" badge — the card *is* the recommendation.
- One transparency line under the card when a meaningful alternative exists: "Other flights include a nonstop arriving 4:18 p.m." (conditional render — fires only when a same-day alternative is meaningfully different).
- Primary "Keep this seat." Secondary "See other options" — equal width, hairline weight; visual hierarchy carries the path, not button size.
- Footer reassurance: "Your held seat stays open while you decide. Hotel and a meal can be covered tonight — we'll get there next."

**Screen 2 — Other Flights.** Answers: *what are my real options?*
- Sort defaults to earliest arrival. No fare difference shown during recovery — arrival delta does the comparison.
- Held seat pinned top + "Back to the held seat" link at bottom; held seat is preserved during browsing. Selecting an alternative opens a confirm dialog whose primary names the alternate ("Switch to the 9:55 a.m. nonstop") and whose ghost reads "Not yet" — neutral valence, default focus on the safer option.
- Standby is a filter chip, not a peer tab. "Take credit instead" is a route-out chip, not a co-equal default.

**Screen 3 — Tonight's Support.** Answers: *where do I sleep, and who pays?*
- H1 renders conditionally on server-side eligibility: "Tonight's covered, if you need it." (eligible) or "Help available tonight." (pending). Same voice, honest by construction.
- Hotel and meal each get their own card with verb+object actions ("Book a hotel for me," "Send my meal credit") and explicit decline cards. The "no checked bag" card is honest-disabled, not removed.
- Footer CTA "Confirm tonight's plan." Persistent "Talk to a person — about 6 min wait" link, never removed.

**Screen 4 — You're Set.** Answers: *what's next if this falls apart again?*
- Summary card: flight + hotel + baggage + tomorrow morning, each as key/value. Hotel value includes the property name and address inline — the SMS is a parallel channel, not a substitute (see guardrails).
- Micro-actions: Add to Wallet · Forward to family · Save offline. Save offline writes to local cache so the itinerary survives a 4 a.m. dead battery and bad connection.
- Footer: "If anything changes, we'll text you. Reply HELP anytime."

## 3. Accessibility and trust guardrails

Audit pass identified four blockers; all are resolved in the prototype.

- Flight cards are real `<button>` elements with composed accessible names — keyboard-only users can now complete rebooking.
- One landmark per screen; one H1 per screen; heading hierarchy correct.
- Filter chips expose `aria-pressed`; sort opener exposes `aria-haspopup` / `aria-expanded`.
- Verb+object labels throughout (bare "Continue" removed). Ink-3 darkened to pass 1.4.3; secondary targets bumped to 44 px; pulse animation respects `prefers-reduced-motion`.
- Confirm-swap dialog default-focuses the safer ghost; Esc dismisses; focus returns to the invoking card.

Trust guardrails:
- No "Recommended" badge anywhere user-visible. The held card carries its reasons.
- Fare difference suppressed during disruption recovery (the upgrade-eligible exception is named below as a known gap).
- Hotel/meal language is conditional — "Northstar can cover" is offered, not asserted; the H1 only asserts coverage when the server confirms eligibility.
- "Talk to a person" is present on every screen with a real wait-time estimate, never used to hide self-service.

## 4. Experiment plan

Three experiments, each falsifiable, each with a guardrail and a kill rule. Ship the design only with all three instrumented.

**E1 — Informed acceptance, not silent acceptance.** *Primary:* % of users who view Screen 2 at least once before confirming. *Guardrail:* time-to-confirm doesn't balloon; post-arrival CSAT among held-seat-accepters. *Kill:* CSAT drops > 0.3 (5-pt) — we induced regret. Sample: 5-user moderated session + cohort A/B on the S1 alternative-preview line.

**E2 — Fare suppression doesn't hide value.** *Primary:* 72-hour post-rebook support-call rate tagged "fare/upgrade." *Guardrail:* rebook-completion rate; travel-credit selection rate (a jump signals users felt boxed in). *Kill:* fare-related calls rise materially OR upgrade-eligible CSAT divergence appears.

**E3 — Entitlements without overclaim.** *Primary:* hotel-voucher claim rate among eligible users. *Guardrail:* ineligible-user claim-attempt rate and complaint theme "you said it was covered." *Kill:* ineligible-attempt complaints rise — the H1 framing did harm.

Known gaps deferred to v2 (named, not buried): the multi-passenger PNR variant of Screen 1 (held seat is currently singular); the refund-seeker first-class path; the SMS-broken Screen 4 case (hotel name and address inline above mitigates, but the address-fallback path needs build review); and the upgrade-eligible user whose held seat may downgrade them silently.
