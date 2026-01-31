# Sprint Management - Full Implementation Detail

> Loaded on-demand. Header: [../SKILL.md](../SKILL.md)

## /sprint start

```bash
/sprint start --name "Sprint 1" --duration 2w --goal "Complete auth module"
```

| Option | Description | Default |
|--------|-------------|---------|
| `--name` | Sprint name | "Sprint N" |
| `--duration` | Duration (1w, 2w, 3w) | 2w |
| `--goal` | Sprint goal | (prompted) |
| `--capacity` | Team capacity in points | (calculated) |
| `--phase` | Link to Phase N | - |

**Creates:**
- `docs/sprints/sprint-{N}/SPRINT.md`
- `docs/sprints/sprint-{N}/BACKLOG.md`
- `docs/sprints/sprint-{N}/DAILY.md`

## /sprint status

```bash
/sprint status [--detailed]
```

**Output:**
```
🏃 SPRINT STATUS: Sprint 1
📅 Day: 5 of 14 (36%)
🎯 Goal: Complete authentication module
📊 [████████░░░░░░░░░░░░] 40% (16/40 points)
📉 Burndown:
   Day 5: ████████████░░░░░░░░ 24 pts ← Today
   Ideal: ██████████░░░░░░░░░░ 20 pts
⚠️ Slightly behind (-4 pts)
```

## /sprint end

```bash
/sprint end [--skip-retro]
```

**Actions:**
1. Calculate velocity
2. Move incomplete items to backlog
3. Generate retrospective template
4. Update velocity history
5. Archive sprint documents

## /sprint add

```bash
/sprint add "Implement login form" --points 5 --priority high
```

| Option | Description |
|--------|-------------|
| `--points` | Story points (1, 2, 3, 5, 8, 13) |
| `--priority` | high, medium, low |
| `--assignee` | Team member |

## /sprint complete

```bash
/sprint complete "Implement login form"
/sprint complete --id TASK-001
```

## /sprint velocity

```bash
/sprint velocity [--chart] [--last N]
```

**Output:**
```
📈 VELOCITY REPORT
┌────────────┬────────┬────────────┬───────────┐
│ Sprint     │ Points │ Completed  │ Velocity  │
├────────────┼────────┼────────────┼───────────┤
│ Sprint -2  │ 38     │ 32         │ 32        │
│ Sprint -1  │ 42     │ 35         │ 35        │
│ Sprint 1   │ 40     │ 32         │ 32        │
└────────────┴────────┴────────────┴───────────┘
Average: 31.4 pts | Trend: ↗️ Improving
Next Sprint Capacity: 32-34 pts
```

## /sprint burndown

```
Points │
   40  │●
   36  │  ●───────── Ideal
   32  │    ○
   28  │      ○──── Actual
   24  │        ○
   20  │          ●
    0  │____________________●
       └──────────────────────
        1  2  3  4  5  6  7  8  9  10  Days
```

## File Structure

```
docs/sprints/
├── VELOCITY.md          # Velocity history
├── sprint-1/
│   ├── SPRINT.md        # Sprint plan
│   ├── BACKLOG.md       # Sprint backlog
│   ├── DAILY.md         # Daily log
│   └── RETRO.md         # Retrospective
└── current -> sprint-N/ # Symlink to current
```

## Templates

### SPRINT.md Template
```markdown
# Sprint {N}: {Name}

## Overview
- **Duration**: {start} - {end}
- **Goal**: {goal}
- **Capacity**: {capacity} points

## Sprint Backlog
| ID | Task | Points | Priority | Status |
|----|------|--------|----------|--------|

## Progress
`[░░░░░░░░░░░░░░░░░░░░]` 0%

## Daily Log
### Day 1 ({date})
- Started / Completed / Blockers
```

### RETRO.md Template
```markdown
# Sprint {N} Retrospective

## Summary
- **Completed**: {completed}/{planned} ({percentage}%)
- **Velocity**: {velocity} points

## What Went Well 🌟 / What Could Improve 🔧

## Action Items
| Action | Owner | Due |
|--------|-------|-----|
```

## Integration

### With Phase System
```
Phase TASKS.md ──────► Sprint BACKLOG.md
Sprint complete ──────► Phase CHECKLIST.md auto-update
```

```bash
/sprint start --phase 2 --name "Sprint 3"
/sprint complete T2-03  # → Phase TASKS.md도 ✅ 표시
```

> **상세**: `.claude/docs/SPRINT-PHASE-INTEGRATION.md`

### With Other Tools
```bash
/agile-sync              # Sprint + Phase progress
/sprint complete "task"  # → PROGRESS.md auto-update
git commit -m "feat(auth): login [Sprint-1][Phase-2]"
```

## Configuration

```json
{
  "sprint": {
    "default_duration": "2w",
    "point_scale": [1, 2, 3, 5, 8, 13],
    "auto_velocity_track": true,
    "auto_retro_generate": true,
    "burndown_chart": "ascii",
    "daily_reminder": true
  }
}
```

## Best Practices

| DO | DON'T |
|----|-------|
| Set clear sprint goals | Add items mid-sprint without discussion |
| Keep items small (≤8 pts) | Skip retrospectives |
| Update daily progress | Ignore velocity trends |
| Complete retrospectives | Overcommit beyond velocity |
