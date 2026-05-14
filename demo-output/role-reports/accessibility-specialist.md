# Accessibility Specialist Role Report — Northstar Canceled-Flight Recovery

## 1. Summary

The prototype is in good a11y shape for a single-screen review artifact: skip link, landmarks, labeled sections, single-h1-per-section pattern, verb-based CTAs, 48px primary buttons, visible global `:focus-visible`, `prefers-reduced-motion` honored, and one consistent accent that clears 4.5:1 in nearly every pair I sampled. The blockers below are real but small in number and scope — the kind a Visual Designer can fix in one surgical pass. The biggest risks are (a) the page has five `<h1>` elements because each "screen" is a section, which is technically allowed but will confuse a screen reader scrolling top-to-bottom, (b) the SMS hero may be announced confusingly, and (c) the filter row's pressed-state focus ring fails 1.4.11. Everything else is recommendations, not blockers.

## 2. BLOCKERS

| # | Issue | WCAG | Location | Required fix |
|---|---|---|---|---|
| B1 | Five `<h1>` elements on one page. A screen-reader user navigating by heading will hear five "level 1" landmarks with no parent. The prototype is a stacked walkthrough, not five separate documents. | 1.3.1 Info & Relationships; 2.4.6 Headings & Labels | `#s1-h … #s5-h` | Demote screens 2–5 to `<h2>` (and the existing `<h2>`s inside those screens to `<h3>`). Keep `#s1-h` as the only `<h1>`. Alternatively, add a single visually-hidden page `<h1>` "Northstar canceled-flight recovery walkthrough" and demote all five screen titles to `<h2>`. |
| B2 | Filter row pressed-state focus ring fails non-text contrast. When a `.filter` is `aria-pressed="true"` the background becomes `#0F1419` and the global `:focus-visible` ring is `#1E40AF` — indigo on near-black is ~2.2:1, below 3:1. | 1.4.11 Non-text Contrast; 2.4.7 Focus Visible | `.filter[aria-pressed="true"]:focus-visible` | Add a dedicated focus style: white or `#EEF2FF` 2px outline with 2px offset when the filter is pressed (or invert the outline color on dark filter background). |
| B3 | Duplicate `id="footer-support"` collision risk and dead-loop link. The same id is set on a `<p>` on Screen 5, and that paragraph contains an `<a href="#footer-support">` pointing to itself. Six other links across the prototype also point to this id. Screen-reader users following "Talk to an agent" land on the paragraph that announces them landing on themselves. | 4.1.1 Parsing (residual); 2.4.4 Link Purpose; 3.2.4 Consistent Identification | line 384 | Move the `id="footer-support"` to a real support landing target (e.g., a small `<aside id="page-support">` section), and rewrite the self-link inside the paragraph to be plain text or point elsewhere. |
| B4 | The SMS hero is wrapped in `role="group" aria-label="Text message received"`, which a screen reader may announce as if a real SMS just arrived in the user's messaging app. Under stress at 10:46 p.m., this is misleading. | 1.3.1 Info & Relationships; 4.1.2 Name, Role, Value | line 173 | Change `aria-label` to `"Example of the SMS the traveler received"` and add a visually-hidden prefix sentence inside the bubble: `<span class="sr-only">Example text message from Northstar Air. The bubble text reads:</span>`. The `sr-only` utility class needs to be added. |

## 3. RECOMMENDATIONS (non-blocking)

- **R1.** The `.chip` element with `aria-hidden="true"` on Screens 1 and 5 (`Canceled`, `Confirmed`) is fine because the H1 immediately states the same thing in words. Keep it.
- **R2.** Option cards on Screen 2 use `role="list"` on a `<div>` and `role="listitem"` on `<a>`s. Prefer a real `<ul>` of `<li><a>` — semantics survive when CSS fails (1.3.1).
- **R3.** Entitlement chips on Screen 4 all say `{eligibility per booking}`. To a screen reader this is "open brace eligibility per booking close brace" five times in a row. Add visually-hidden helper: `<span class="sr-only">eligibility, value supplied per booking</span>` and `aria-hidden` the braces token, OR accept the literal reading as a known placeholder convention — name the choice in the lead's claim-lint pass.
- **R4.** The `:focus-visible` global rule sets `border-radius:6px` on the outline — fine on rectangles, but the `.btn` (10px radius) and `.opt` (12px) will have a focus ring that doesn't trace the shape. Add `:focus-visible` overrides per component matching their radii (cosmetic, not a 1.4.11 failure).
- **R5.** Footer step counters ("Step 1 of 5") are decorative duplication of the sticky step-nav. Either wrap in `aria-hidden="true"` or keep — but they will be announced inside every section.
- **R6.** The `.tiny` text (`#6B7280` ~ `#FAFAFB`) computes ~4.6:1 — above 4.5 but tight. If any tinier text is added later, this baseline will fail. Keep ≥12px.
- **R7.** Anchor "buttons" (Screens 2 and 3 use `<a>` with `role="listitem"` and `<a>` for flight cards) work but cannot be activated with Space; only Enter. For walkthrough-only this is acceptable; for shipping code these should be `<button>` (or stay anchors with `data-` based navigation).
- **R8.** Filters are `<button>` with `aria-pressed` — correct. But the group of four reads as four independent toggles; if "Arrive by" and "Nonstop" are mutually exclusive sort modes, use radio semantics or `aria-pressed` with explicit relationship.

## 4. SCREEN-READER NARRATIVE (Screens 1 → 5, mobile, VoiceOver-style)

1. **Screen 1:** Banner reads "Northstar Air, Canceled flight recovery." Step nav reads as five links. Then "Text message received, group" — a screen-reader user may briefly think a real SMS arrived (Blocker B4). The H1 "Your flight was canceled" lands hard and clearly. The "What happens next" ordered list reads naturally as "List, three items." Primary button announces "See your recovery options, link" — good.
2. **Screen 2:** Second H1 "Choose how to recover." The user has now heard two level-1 headings (Blocker B1). The option list reads "List, four items" if the standby card is counted — the dashed standby tile sits outside the list role, so it reads as a fifth thing without list framing. Confusing.
3. **Screen 3:** Third H1. Filters announce "Arrive by, toggle button, pressed; Nonstop, toggle button, not pressed…" — clean. Flight cards announce by their `aria-label`s ("NS612, arrives 3:20 PM, nonstop"). Note: card 1's `aria-label` says "arrives 3:20 PM" but the visible text says "11:05 a.m." — mismatch between visible label and accessible name (2.5.3 Label in Name risk). **Add to blockers if confirmed**; I'm calling it out here.
4. **Screen 4:** Fourth H1. Entitlement list reads "Overnight accommodation, open brace eligibility per booking close brace" then description. Repeated five times — fatigue-inducing but technically present. The review card "Your selection" announces correctly.
5. **Screen 5:** Fifth H1. The decorative checkmark chip is `aria-hidden` (good). The trip summary is in a `<dl>` — read as "Description list, six items." Action buttons "Save as PDF, Add to wallet, Text this summary to me" — clear verbs. Re-entry link reads "Start recovery over." Done.

**Update — promote to Blocker B5:** Screen 3 card 1 `aria-label="NS612, arrives 3:20 PM, nonstop"` does not match visible "7:10 a.m. → 11:05 a.m., 1 stop." The accessible name must contain the visible text (2.5.3 Label in Name, Level A). Visual Designer: rewrite all three `aria-label`s to match the visible time/stop content, or drop them and let the card content be the accessible name.

## 5. CLAIM-PROVENANCE NOTE (a11y lens, not a full lint pass)

- Screen 5 says "A copy of this plan has been sent to `{contact channel}`." The brief is silent on whether confirmations are sent. The token covers the *channel*, not the *act*. The verb "has been sent" is an operational promise the brief does not authorize. Flag to lead.
- Screen 5 step 3: "Head to your gate (shown in the app closer to departure)." The brief is silent on a Northstar mobile app. Flag to lead.
- Screen 5: "Bag tags reprint there." The brief is silent on bag-tag policy. Flag to lead.
- Screen 4 "Rebooking assistance" is hard-coded as `chip-ok "Included"`. The brief does not establish this as a universal entitlement. Consider rendering as `{eligibility per booking}` like the other rows for provenance consistency.

## 6. WHAT MUST CHANGE THE HTML (for the Visual Designer)

- Demote screen-title `<h1>`s on screens 2–5 to `<h2>` (and the in-screen `<h2>`s become `<h3>`). Keep one `<h1>` on screen 1. (B1)
- Add a `.filter[aria-pressed="true"]:focus-visible` rule with a light-colored outline that clears 3:1 on `#0F1419`. (B2)
- Resolve the `id="footer-support"` duplication and self-referential link on line 384. (B3)
- Rewrite SMS container `aria-label` to "Example of the SMS the traveler received" and add an `sr-only` prefix inside the bubble; add an `.sr-only` utility class to the stylesheet. (B4)
- Rewrite the three Screen 3 flight-card `aria-label`s so the accessible name matches the visible departure-arrival text. (B5)
- Convert Screen 2 option list and Screen 4 entitlement list from `role="list"` divs to real `<ul>/<li>`.
- Consider rendering Screen 4 "Rebooking assistance" eligibility as a token for provenance parity.
- Consider rewording or removing Screen 5 "A copy of this plan has been sent…" "shown in the app…" and "Bag tags reprint there." pending lead lint pass.

---

**Blocker count: 5.**

**Top 3 blockers (one line each):**
1. Five `<h1>` elements on one page — demote screens 2–5 to `<h2>` (1.3.1, 2.4.6).
2. Pressed-filter focus ring is indigo on near-black, fails 3:1 — add an override (1.4.11).
3. Screen 3 flight-card `aria-label`s announce times that do not match the visible label — rewrite to match (2.5.3 Label in Name).

**Best-in-class:** The prototype treats the `{system-supplied}` tokens as visible, monospaced, contrast-clearing pills rather than hiding them — which means a screen-reader user, a sighted reviewer, and a claim-provenance auditor all see the *same* uncertainty in the *same* place. That is rare, and it is exactly what accessible disruption-recovery copy should look like.
