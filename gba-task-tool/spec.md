# GBA Ticket Tool — Spec

A self-built, mobile-first ticket & project tracker for a 5-person team delivering the **Bengaluru 100-Day Program** (Greater Bengaluru Authority). This document is the authoritative build brief. The raw UI sketch it's based on is in [fahad_notes.md](fahad_notes.md) — treat that as the source of truth for layout and feel; treat this doc as the structured specification.

---

## 1. Overview
A lightweight tool where a small government team tracks work as **tickets** grouped under **programs**. Team members self-update their own tickets. The lead reviews progress and signs work off. It must feel like an **executive's desk** — beautiful, simple, document-like — and work equally well on **phone and desktop** (mobile is a hard requirement).

**Terminology:** the user-facing unit of work is a **ticket** (not "task").

## 2. Users & roles
Five members: **Atheeq** (lead), **Tejas**, **Teju**, **Sidesh Pottakati**, **Girish**.

- **Member** — creates/updates their own tickets, logs progress, moves tickets toward review.
- **Lead** — sees everything, reviews tickets in "Needs review," resolves them or sends them back.

Display people by **first name** only throughout the UI.

## 3. Workflow & statuses
Four statuses, three of them shown as columns on the board:

`Planned → In-action → Needs review → Resolved`

| Status | Meaning | Who moves it |
|---|---|---|
| **Planned** | Created, not started | — |
| **In-action** | Work started (sets `started_at`) | Assignee |
| **Needs review** | Assignee considers it done; awaiting lead sign-off | Assignee |
| **Resolved** | Lead has signed off (via a resolution comment) | Lead |

Rules:
- Moving to **In-action** stamps `started_at`.
- **Resolving requires a resolution comment** — a comment in the Comments stream marked **Resolved** (e.g. "MoU has been signed"). This is the "resolve with a text comment" rule.
- **Reopening is allowed:** lead can send **Needs review → In-action**, and **Resolved → In-action**, each with a comment.
- The board (lead view) shows three columns: **Planned · In-action · Needs review**. Resolved tickets drop off the active board and are reachable via a filter/archive.

## 4. Ticket structure
A ticket has:
- **Title**
- **Particulars** — a free-text body ("space to write the particulars"; double-tap to edit).
- **Program** it belongs to.
- **Assignees** — one or more people (e.g. Atheeq *and* Tejas). Native multi-assignee.
- **Started date** (auto when moved to In-action) and **Due date**.
- **Sub-tickets** — a ticket can contain sub-tickets, each with its own assignees, dates, and status. Shown nested under the parent on the board.
- **Persons to Contact** (see §5).
- **Updates** stream and **Comments** stream (see §6).

**Due dates:** render in **red when past due**.

## 5. Persons to Contact
Each ticket carries an ordered list of contacts to reach, each phrased as: **Contact [person] to [purpose].**

- **Person** — a dropdown that can pick an existing contact (e.g. "Mahendra from BBMP") or add a new one.
- **Purpose** — a free-text field. Before the user types, it shows **cycling placeholder suggestions**, e.g. *"to schedule a meeting in office"*, *"to discuss a potential partnership"*, *"to obtain the details from…"*.
- **Contact methods** appear as **chips**: phone, email. Tapping a chip **fans out actions** — Call · Copy · Save to contacts (phone); Email · Copy (email). On the chip, show an **icon + label** (not the raw number); reveal the raw value on tap/fan-out.
- **Contacts source:** import from the device's phone contacts (request permission on first use), with a manual-add fallback. Imported contacts are reusable across tickets.
  - *Technical note:* the Web **Contact Picker API** (`navigator.contacts`) works on Android Chrome only; iOS/desktop have no equivalent. So the manual-add path is required, and contact import is a progressive enhancement where supported.

## 6. Updates vs Comments (two separate streams)
Every ticket has two distinct, dated streams in its detail view:

- **Updates** — the assignee's progress log. Dated entries, newest first. e.g. *"17.04.26 — Completed field-visit to Belgaum"*. An **Add update** action at the bottom.
- **Comments** — discussion and review notes. e.g. *"Needs approval from BDA"*. One comment may be marked **Resolved** to close the ticket (*"**Resolved** — MoU has been signed"*). An **Add comment** action at the bottom.

Both streams are timestamped and attributed. Together with status changes they form the ticket's history.

## 7. Views & layout
See [fahad_notes.md](fahad_notes.md) for the original sketches. Summary:

### 7.1 Board (lead view) — ticket stubs
A list of **ticket-stubs** grouped by the chosen organiser, with an **Organise by [status ▾]** control and an **Add ticket** button (top and bottom).

**Desktop stub** (single row): `{title} | {assignees} | started 12.04.26 due 27.04.26 | [⋯ expand]`
**Mobile stub** (compact): `{title} | {assignee chips}` — fewer columns, dates/detail behind expand.

Sub-tickets render indented beneath their parent.

**Organise by** options:
- **Status** (default) — Planned / In-action / Needs review columns.
- **Date** — sort by due date with ascending/descending toggle when the list is small; group into time buckets (Overdue / This week / Later) when large.
- **Assignee** — group tickets under each person.

### 7.2 Ticket detail — "fan-out"
Tapping a stub **pulls the ticket out in a pleasing, document-like way** into the detail view containing: title, **re-assign** control + assignee chips, started/due dates, the **Particulars** body, **Persons to Contact**, the **Updates** stream, and the **Comments** stream.

### 7.3 List truncation
Every list (ticket-stubs, updates, comments, persons-to-contact) shows a limited number of entries (default ~3–5), then a **"… more"** expander to reveal the rest. Pick the cleanest UI element for this (inline expander / collapse toggle).

## 8. Visual design direction
- Looks and feels like an **executive's desk**: each ticket-stub and the fan-out detail should resemble a **real document or paper stub** — tactile, but **not heavy-handed**. Restrained, elegant.
- **Visually beautiful and simple** above all. Reduce decisions and clutter; mobile-first.

## 9. Data model
```
profiles         first_name, full_name, role: lead | member   (linked to a login)
programs         name, description
tickets          title, particulars, program_id,
                 parent_ticket_id (nullable → sub-tickets),
                 status: planned | in_action | needs_review | resolved,
                 started_at (set on In-action), due_date,
                 created_by, created_at
ticket_assignees ticket_id × profile_id          ← many-to-many = multi-assignee
contacts         name, org, phone, email          (imported from phone or added manually; reusable)
ticket_contacts  ticket_id, contact_id (nullable), name, org, purpose,
                 phone, email, sort_order
entries          ticket_id, author_id, body,
                 type: update | comment,
                 is_resolution (bool; only on a comment),
                 created_at
activity_log     ticket_id, actor, action, from→to, created_at   (auto via DB triggers; powers history)
```
Notes:
- **Multi-assignee** via `ticket_assignees` (no single-owner field).
- **Sub-tickets** via `parent_ticket_id` self-reference.
- **Updates vs Comments** are the same `entries` table split by `type`; the **Resolved** marker is `is_resolution = true` on a comment, which also moves the ticket to `resolved`.
- **activity_log** is written automatically by Postgres triggers so history is reliable and unmaintained by hand.

## 10. Tech stack & deployment
| Layer | Choice |
|---|---|
| Frontend | **Next.js + React**, mobile-first, installable **PWA** (one responsive codebase = phone + desktop) |
| Backend / DB / Auth | **Supabase** — Postgres, Auth, Realtime, Storage, row-level security |
| Auth (MVP) | **Email magic link** (no passwords) |
| Hosting | **DigitalOcean** (account already available). Self-host Supabase via Docker on a Droplet; deploy the Next.js app on DO. Dev may start against Supabase's free cloud tier, then migrate to DO before go-live. |

**Mobile strategy:** ship as a PWA (add-to-home-screen, works on a phone). The same React code can later wrap into Capacitor for native App Store apps with no rewrite — not part of this build.

## 11. Decisions locked
- Unit of work is a **ticket**.
- Statuses: **Planned · In-action · Needs review · Resolved**; resolve via a Resolved comment; reopening allowed.
- **Multi-assignee** and **sub-tickets** are in scope.
- **Due date** is prominent (red when past-due); **started date** auto-set on In-action. No priority field in MVP.
- **Persons to Contact** with phone-contact import (progressive enhancement) + manual fallback.
- Two streams: **Updates** (progress) and **Comments** (discussion + resolution).
- Stack: **Next.js PWA + Supabase**, deployed on **DigitalOcean**, magic-link auth for MVP.

## 12. Out of scope / Phase 2
- **No "Blocked" status** — the flow intentionally has no blocked state.
- Weekly digest email for the lead — Phase 2.
- Push notifications — Phase 2.
- File attachments (beyond contact chips) — Phase 2.
- Capacitor native-app wrap — later.
- Chat ↔ ticket tying, WhatsApp integration — not in scope.

## 13. Reference
- [fahad_notes.md](fahad_notes.md) — original raw UI sketches and notation. The layouts and interaction details there are authoritative; this spec structures them.
