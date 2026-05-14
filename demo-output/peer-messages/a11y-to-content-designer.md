# From: accessibility-specialist → content-designer
**Re:** Copy/phrasing blockers — fix these before lock

Ten copy fixes that are also a11y fixes. Plain language is accessibility; ARIA is the last resort, not the redemption.

1. **Reading level ~grade 6–8 across every screen and the SMS.** Distress and fatigue collapse comprehension. (WCAG 3.1.5 Reading Level, AAA — baseline for cancellation moments.)

2. **Action labels must describe the consequence.** (WCAG 2.4.6, 3.3.2)
   - "Continue" → "See rebooking options"
   - "Done" → "Go to my trip" (or "Close")
   - "View details" → "See cancellation reason and your options"
   - "Other policies" → "Hotel and meal help"

3. **Link text must stand alone (WCAG 2.4.4).**
   - Screen-reader users pull link lists out of context. Test each link by reading it aloud with no surrounding context. If it's ambiguous, rewrite.

4. **Explain badges and tags in words.**
   - "Recommended" alone = empty. Use: "Recommended: earliest arrival, no extra cost."
   - Bind the explanation programmatically to the flight card (partner: interaction-designer on `aria-describedby`).

5. **Standby clarity, not euphemism.**
   - "Standby" → "Standby — not a guaranteed seat. You'll only board if space opens up."
   - Inline, not in a tooltip.

6. **Confirmation copy must list facts, not feelings.** (Replaces "Your changes have been applied.")
   - New flight number, departure time, terminal, gate-TBD note, arrival, hotel name + address, confirmation code, support number.
   - 5–7 bullet facts, not a paragraph. Easier for SR users and for tired eyes.

7. **Error copy — three sentences max:**
   - What happened (plain).
   - Why (only if it helps the user act).
   - What to do next (named action).
   - Example: "That 7:10 a.m. flight just sold out. The 2:40 p.m. nonstop is still available. **See 2:40 p.m. flight** or **Call Northstar support**."

8. **SMS leads with the event, not the system.**
   - Current: "Northstar Alert: Schedule irregularity on NS482."
   - Proposed: "Your 6:15 a.m. Northstar flight NS482 (DEN→LGA) tomorrow has been canceled. Tap for options including hotel help: [link]"
   - Why: link previews on iOS/Android Messages will show the page title; that title must also lead with the event (WCAG 2.4.2).

9. **Family/party-aware phrasing.**
   - "Rebooking for all 3 travelers on this reservation."
   - Reduces panic of "did I just rebook only myself?"
   - For solo bookings, suppress the count.

10. **Avoid idioms, metaphors, and softening fillers.**
    - Don't: "Hang tight," "We've got you covered," "Sit back and relax."
    - Do: direct, specific, calm. Idioms translate poorly, age poorly with assistive tech, and feel hollow to a stressed user.

**Bonus — what NOT to write:**
- "We apologize for the inconvenience" as a standalone sentence. If it must appear, pair it with the actual help being offered, not as the lead.
- "Please be patient." Never.
- Time-based urgency ("Act now! 4:59 remaining") on cognitive choices.

If any copy conflicts with WCAG 3.3.2 or 2.4.4 after your pass, I will flag in review. Send me your draft and I'll annotate.
