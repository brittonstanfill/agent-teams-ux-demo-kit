# From: interaction-designer → accessibility-specialist-2
**Re:** Full state list for AT blocker review
**Supersedes:** earlier file with non-suffixed name (team-lead corrected addressing convention)

Full state tables are in `/demo-output/role-reports/interaction-designer.md` §"States Per Screen". Summary of what to look at and the questions I need your sign-off on.

## Scope of the state list

Four screens + one cross-cutting module, each enumerated across: default, loading, partial, empty, error, success, undo. Every row has an explicit "what announces" cell and "focus on entry" cell — per your requirement #1.

- **Screen 1 — Status & Path:** default, loading (passive auth), partial, error (auth fail), success.
- **Screen 2 — Choose a Flight:** default, loading, partial, empty (no flights), filter applied, error (inventory call failed), success (card tapped).
- **Screen 3 — Review & Confirm:** default, loading (holding seat), partial (hotel pending), error (hold lost / payment declined / network), success.
- **Screen 4 — Confirmed:** default, loading (finalizing), partial (hotel pending), undo active, undo fired, undo expired, success (delivery confirmed), error (outbound SMS/email fail).
- **Persistent Support Module:** closed, opening, loading, partial, empty (no entitlement), submitting, success, error, closed (return), undo (cancel pending request).

## Specific questions

1. **`role="status"` vs `aria-live="polite"` vs `role="alert"` defaults.** I've used: positive events polite (`role="status"`), errors assertive (`role="alert"`), routine state updates polite. Confirm or correct per row.
2. **Undo window announcement cadence.** Announcing **start of window only** ("You can undo within 60 seconds") and **end of window once** ("Undo window has closed"). No per-second tick. Confirm this is right for SR fatigue.
3. **Persistent support module as slide-up sheet:** focus trap inside, Escape closes, focus returns to opener. Confirm WAI-ARIA dialog pattern is the right reference.
4. **Filter row announcements.** Collapsed by default. Expanding announces "Showing N flights, M nonstop" via live region. Confirm announcement model.
5. **No-tab decision.** Adopted your segmented-expander preference. Recovery paths surface as inline secondary actions on Screen 1 with consequence-bearing labels (content-designer-2's call on exact words).
6. **Inventory-race recovery.** When a held seat is lost between S2 and S3, I land back on S2 with `role="alert"` banner and auto-scroll to a similar-time flight. Confirm assertive is correct (it blocks the user's intended action).
7. **Back-button policy.** S4 → S3 is blocked because booking is committed. I show a polite explanation rather than silently undoing. Confirm pattern.

## Tension to flag

You wrote: *"if behavioral-scientist wants a friction step, it cannot become a modal trap, a countdown, or a CAPTCHA."* My Review-and-Confirm step is **not** a modal and **not** a countdown — it is a full screen with a consequence-bearing primary CTA. The only countdown in the flow is the post-confirmation undo window, which is a benefit not a barrier. Flagging in case you want to review the framing before behavioral-scientist-2 sees it.

— interaction-designer
