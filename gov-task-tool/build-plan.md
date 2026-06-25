# GBA Ticket Tool — Build Plan & Tracker

Status legend: ⬜ not started · 🟡 in progress · ✅ done · ⏸ Phase 2

Read [spec.md](spec.md) first, then [fahad_notes.md](fahad_notes.md) for layout/feel. Code lives in `repos/gba-task-tool/`.

---

## Milestone 1 — Foundation
- ⬜ Scaffold Next.js (App Router, mobile-first, PWA-ready) in `repos/gba-task-tool/`
- ⬜ Supabase project + schema from [spec §9](spec.md#9-data-model) (tickets, sub-tickets, assignees, contacts, entries, activity_log)
- ⬜ Magic-link auth; seed the 5 profiles (Atheeq = lead) and a "Bengaluru 100-Day Program"
- ⬜ Row-level security (members edit their own; lead sees all)
- ⬜ DB triggers writing `activity_log` on status changes

## Milestone 2 — Tickets core
- ⬜ Create / edit ticket (title, particulars, program, assignees, due date)
- ⬜ Multi-assignee picker
- ⬜ Sub-tickets (create under a parent, nested display)
- ⬜ Status flow Planned → In-action (stamp started_at) → Needs review → Resolved
- ⬜ Resolution requires a Resolved comment; reopening (→ In-action) allowed

## Milestone 3 — Ticket detail (fan-out)
- ⬜ Document-style detail view with re-assign + assignee chips, dates, particulars (double-tap to edit)
- ⬜ **Persons to Contact**: contact dropdown, purpose field with cycling placeholders, phone/email chips with fan-out actions (Call / Copy / Save / Email)
- ⬜ Contacts import from phone (Contact Picker API where supported) + manual-add fallback
- ⬜ **Updates** stream (add update)
- ⬜ **Comments** stream (add comment; mark Resolved)

## Milestone 4 — Board & review views
- ⬜ Ticket-stub board, desktop + mobile layouts
- ⬜ Organise by: status (default) / date (asc-desc + buckets) / assignee
- ⬜ Past-due dates render red
- ⬜ List truncation with "… more" expander on all lists
- ⬜ Lead review flow (resolve / send back)

## Milestone 5 — Mobile polish & ship
- ⬜ PWA install (add-to-home-screen, icons, offline shell)
- ⬜ "Executive's desk" visual pass — document-like stubs, beautiful & simple, mobile-first
- ⬜ Seed the canonical ticket end-to-end: *Bengaluru 100-Day Program → "Set up a committee to review the management structure of GBA" → Atheeq + Tejas*
- ⬜ Deploy to DigitalOcean (self-hosted Supabase via Docker + Next.js app)

## Phase 2 (parked)
- ⏸ Weekly digest email for the lead
- ⏸ Push notifications
- ⏸ File attachments
- ⏸ Capacitor native-app wrap (same codebase)
