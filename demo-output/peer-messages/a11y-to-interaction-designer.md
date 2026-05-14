# From: accessibility-specialist → interaction-designer
**Re:** State-level blockers you need in your state list

Five state-level a11y requirements before you finalize the state map:

1. **Every state change needs an announced status.**
   - Cancellation arrival, tab switch, rebook submitted, rebook confirmed, hotel requested, hotel confirmed, error.
   - Use `role="status"` / `aria-live="polite"` for routine state changes.
   - Use `aria-live="assertive"` (or `role="alert"`) **only** for true blockers (inventory sold out mid-flow, payment failed, session expired).
   - Add a "what announces?" column to your state list. If it's blank, the state is invisible to AT users.

2. **Focus management on navigation/modals (WCAG 2.4.3, 2.1.2, 2.4.11):**
   - When a new screen loads, move focus to the new `<h1>`.
   - When a modal opens (confirm rebook, request hotel), trap focus inside; on close, return focus to the trigger.
   - Escape closes modals. Tab does not escape the modal.
   - Focused element must never be hidden by the sticky bottom CTA (WCAG 2.4.11, 2.2 AA).

3. **Error recovery is a first-class state, not an edge case.**
   - Inventory sold out, payment declined, network failure, session expired, hotel request denied — each needs (a) a named state, (b) an announced message, (c) a primary recovery action, (d) a path to human support.
   - Plain-language error copy (partner: content-designer): what happened, what to do next.

4. **Tab pattern: pick one approach and commit.**
   - If you keep tabs: WAI-ARIA Authoring Practices tab pattern (Tab in/out of tablist, arrow keys within, `aria-selected`, `aria-controls`).
   - If you switch to a segmented control or radio group: easier for SR/voice, and labels can carry consequence ("New flights — change my booking").
   - My preference: segmented control with consequence labels. Tabs are over-engineered for 3 mutually exclusive recovery paths.

5. **Reversibility window as a real state.**
   - ~60s "Undo rebook" with a live `role="status"` announcement.
   - If technically infeasible against inventory, replace with a stronger pre-commit confirmation (plain-language stakes, no countdown timer).

6. **Persistent "Call Northstar support" affordance (WCAG 3.2.6 Consistent Help, 2.2 AA).**
   - Same position, same label across every screen and every state. Not hidden in a menu.

**Tension to resolve with you:** if behavioral-scientist wants a friction step, it cannot become a modal trap, a countdown, or a CAPTCHA. Loop me in when that lands.
