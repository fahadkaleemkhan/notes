# GBA Task Tool — Spec

> **How to use this doc:** comment inline anywhere. Anything marked **❓DECISION** is something I want your call on. Everything else I've defaulted to a sensible choice and noted why — overrule freely.

---

## 1. What it's for
A lightweight task & project tracker for Atheeq's 5-person team delivering the Bengaluru 100-Day Program. The team self-updates their own tasks. Must work well on **both phone and desktop** — that's a hard requirement (it's the thing Huly got wrong).

**Users (the team):** Atheeq (lead), Tejas, Teju, Sidesh Pottakati, Girish.
You (Fahad) are building it but are *not* a team member.

## 2. Core requirements
1. Create a list of **tasks** (title + description).
2. Group tasks under a **program / initiative** (e.g. "Bengaluru 100-Day Program").
3. **Assign each task to one or more people** (e.g. Atheeq *and* Tejas).
4. Track **status**: Open → In Progress → Resolved.
5. **Updates** as text comments on a task.
6. **Resolve** a task by leaving a text comment (resolution).
7. A **review mechanism** — see what happened: per-task history, per-person view, per-program view.
8. Good **mobile** experience (installable, works on a phone).

### Removed
- ~~Blockers~~ — **dropped at Atheeq's request.** No blocked status, no blocker comment type.

### Example task (the canonical test case)
- **Program:** Bengaluru 100-Day Program
- **Task:** Set up a committee to review the management structure of GBA
- **Assignees:** Atheeq + Tejas
- **Status:** Open → In Progress → Resolved
- **Resolution:** a closing text comment

## 3. Status & comments
- **Status values:** `Open` · `In Progress` · `Resolved`. (Three states. Simple on purpose.)
- **Comment types:** `update` (progress note) · `resolution` (the closing comment that accompanies marking Resolved).
- Marking a task Resolved **requires** a resolution comment — that's your "resolve via text comment" rule.

**❓DECISION:** Do you want a way to *reopen* a Resolved task (e.g. Atheeq reviews and it's not actually done)? I'd default to **yes** — Resolved → In Progress with a comment. OK?

## 4. The review mechanism
Three views cover "what happened":
1. **Task timeline** — every task shows its full history: status changes + all comments, newest-relevant ordering, with author + time. This *is* the audit trail.
2. **My Tasks** — each person sees their assigned tasks grouped by status. Their home screen.
3. **Program board** — Atheeq's overview: all tasks in a program, grouped by status, who's on what.

**❓DECISION:** Do you want a **weekly digest** (auto email/summary of what moved this week)? Useful for Atheeq, but it's Phase 2. Flag if it's a day-one must.

## 5. Data model
```
profiles        one per team member (Atheeq, Tejas, Teju, Sidesh, Girish), linked to a login
programs        e.g. "Bengaluru 100-Day Program"   (name, description)
tasks           title, description, program_id,
                status: open | in_progress | resolved,
                priority (optional), due_date (optional),
                created_by, created_at
task_assignees  task_id × profile_id   ← many-to-many = native multi-assignee
comments        task_id, author_id, body,
                type: update | resolution,
                created_at
activity_log    task_id, actor, action, from→to, created_at
                (status changes etc. — auto-generated, powers the timeline)
```
Notes:
- **Multi-assignee** is handled by `task_assignees` (not a single-owner field), so "assign to Atheeq and Tejas" is first-class.
- **Resolution** = status set to `resolved` + a `comments` row of type `resolution`.
- **activity_log** is written automatically (database triggers) so the timeline is reliable and nobody has to maintain it.

**❓DECISION:** Keep `priority` and `due_date`? They're optional and easy to ignore, but add fields to the form. I'd keep both but hidden-unless-set. OK?

## 6. Tech stack
| Layer               | Choice                                                                                  | Why                                                                                                     |
| ------------------- | --------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------- |
| Frontend            | **Next.js + React, mobile-first, installable PWA**                                      | One responsive codebase = phone + desktop. Directly fixes Huly's gap. No separate native apps to build. |
| Backend / DB / Auth | **Supabase** (Postgres + Auth + Realtime + Storage + row-level security)                | Removes most of the backend grind — no hand-written auth or APIs. Live updates across devices for free. |
| Login               | **Magic link** (email, no password)                                                     | Lowest friction for non-technical staff.                                                                |
| Hosting             | Start on Supabase **free cloud tier**; migrate to **self-host** (Docker) before go-live | Move fast now, own the data later.                                                                      |

**Mobile strategy:** ship as a **PWA** (add-to-home-screen, push notifications, works on a phone). If you ever want true App Store apps, the same React code wraps into Capacitor later — no rewrite. We do *not* build native apps now.

**❓DECISION — login method.** Magic link is simplest but needs each person to have an email they check. Alternative: phone/OTP. Which fits this team better?

## 7. Explicitly out of scope (for now)
- Blockers (removed).
- WhatsApp integration (dropped — a good mobile app covers the need).
- File attachments, push notifications, weekly digest → **Phase 2**, not MVP.
- Chat ↔ task tying (you were curious about this — parked; per-task comment threads already give a light version).

## 8. How we got here
Short decision log so this makes sense weeks from now:
1. Need: simple task tracker for Atheeq's team — tasks, multi-assignee, status, comment updates, resolution, review trail. Mobile + desktop.
2. **Buy vs build:** requirements are commodity; the only custom-worthy piece (WhatsApp) got dropped, and the mobile-app requirement argues *against* hand-building (mobile apps are the hardest part — existing tools do it best).
3. So the lean was *adopt*. Shortlist: Monday (best for non-technical) / ClickUp / Plane (free OSS). **Monday ruled out on cost.** Tried **Huly** — loved it, but **no mobile** = dealbreaker.
4. **Conclusion: build a mobile-first PWA** — get the Huly-like feel *with* mobile, self-hosted and free. Stack chosen to minimize build effort (Supabase does the heavy backend lifting).

## 9. Open decisions (summary — your calls)
- [ ] Reopen Resolved tasks? (default: yes)
- [ ] Weekly digest day-one, or Phase 2? (default: Phase 2)
- [ ] Keep priority + due_date? (default: yes, hidden-unless-set)
- [ ] Login: magic link vs phone/OTP?
- [ ] Product name: "Setu" or something else?
