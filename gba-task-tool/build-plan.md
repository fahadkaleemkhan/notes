# GBA Task Tool — Build Plan & Tracker

Status legend: ⬜ not started · 🟡 in progress · ✅ done · ⏸ parked

## Current state
🟡 **Milestone 0 — Spec review.** Awaiting Fahad's comments on the [spec](spec.md) before writing code.

---

## Milestone 0 — Spec sign-off
- ✅ Buy-vs-build decided (build)
- ✅ Stack chosen (Next.js PWA + Supabase)
- ✅ Spec drafted
- ⬜ Fahad reviews spec + answers open decisions
- ⬜ Lock the data model

## Milestone 1 — Foundation
- ⬜ Scaffold Next.js (PWA-ready, mobile-first) in `repos/gba-task-tool/`
- ⬜ Supabase project (free cloud tier) + schema (tables from spec §5)
- ⬜ Auth: magic-link login, seed the 5 team profiles
- ⬜ Row-level security so people only edit what they should

## Milestone 2 — Core task flow (MVP)
- ⬜ Create / edit / list tasks
- ⬜ Assign to one or more people (multi-assignee)
- ⬜ Group under a program
- ⬜ Status: Open → In Progress → Resolved
- ⬜ Comment thread per task (update / resolution)
- ⬜ Require a resolution comment to mark Resolved
- ⬜ Auto activity log (DB triggers) feeding the task timeline

## Milestone 3 — Review views
- ⬜ Task timeline (history + comments)
- ⬜ "My Tasks" per person
- ⬜ Program board (grouped by status)

## Milestone 4 — Mobile polish & ship
- ⬜ PWA install (add-to-home-screen, icons, offline shell)
- ⬜ Mobile layout pass (the Huly lesson — phone-first)
- ⬜ Seed the canonical GBA committee task end-to-end
- ⬜ Migrate Supabase to self-host before go-live

## Phase 2 (post-MVP, parked)
- ⏸ Push notifications
- ⏸ Weekly digest email for Atheeq
- ⏸ File attachments
- ⏸ Capacitor wrap for native App Store apps (same codebase)
- ⏸ Chat ↔ task tying (revisit only if the team wants chat in here)

---

## Log
- **2026-06-20** — Project kicked off. Spec + plan drafted. Repo folder created at `repos/gba-task-tool/` (git initialized, empty). Blockers removed from scope per Atheeq.
