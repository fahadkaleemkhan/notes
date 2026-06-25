# GBA Ticket Tool

A self-built, mobile-first **ticket & project tracker** for a 5-person team delivering the **Bengaluru 100-Day Program** (Greater Bengaluru Authority). The team tracks work as tickets under programs, self-updates progress, and the lead reviews and signs work off. Must look like an executive's desk and work equally on phone and desktop.

## Start here
1. **[spec.md](spec.md)** — the authoritative build brief (requirements, workflow, data model, stack).
2. **[fahad_notes.md](fahad_notes.md)** — original UI sketches and feel; authoritative for layout.
3. **[build-plan.md](build-plan.md)** — milestones to execute against.

## At a glance
- **Stack:** Next.js (PWA) + Supabase (Postgres / Auth / Realtime), deployed on DigitalOcean.
- **Workflow:** Planned → In-action → Needs review → Resolved (resolve via a comment).
- **Key features:** multi-assignee tickets, sub-tickets, Persons-to-Contact, separate Updates & Comments streams, document-style mobile-first UI.
- **Team:** Atheeq (lead), Tejas, Teju, Sidesh Pottakati, Girish.

## Where things live
- **Specs & planning:** this folder (`gba-task-tool/`).
- **Code:** `repos/gba-task-tool/`.
