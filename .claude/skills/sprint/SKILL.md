---
name: sprint
description: Complete sprint lifecycle management. Start sprints, track velocity, generate burndown charts, and automate retrospectives.
---

# Sprint Management Skill

Complete agile sprint lifecycle management with Phase system integration.

## Usage

```bash
/sprint <command> [options]
```

### Commands

| Command | Description |
|---------|-------------|
| `start` | Start a new sprint |
| `status` | Show current sprint status |
| `end` | End sprint + generate retro |
| `add` | Add item to sprint |
| `complete` | Mark item as complete |
| `velocity` | Show velocity history |
| `burndown` | Generate burndown chart |

## Sprint Lifecycle

```
/sprint start     /sprint status      /sprint end
     ↓                  ↓                   ↓
┌─────────┐      ┌───────────┐       ┌──────────┐
│ PLANNING│  →   │ IN PROGRESS│  →    │ COMPLETE │
│ • Goals │      │ • Daily   │       │ • Retro  │
│ • Items │      │ • Burndown│       │ • Velocity│
└─────────┘      └───────────┘       └──────────┘
```

### Phase Integration

```bash
/sprint start --phase 2       # Phase Task를 Sprint에 추가
/sprint complete T2-03         # Phase TASKS.md도 자동 ✅
```

> **상세**: `.claude/docs/SPRINT-PHASE-INTEGRATION.md`

## Configuration

```json
{
  "sprint": {
    "default_duration": "2w",
    "point_scale": [1, 2, 3, 5, 8, 13],
    "auto_velocity_track": true,
    "burndown_chart": "ascii"
  }
}
```

## Related Skills

| Skill | Purpose |
|-------|---------|
| `/agile-sync` | Full agile artifact sync |
| `/phase` | Phase management |

---

> **Full implementation**: Load [references/DETAIL.md](references/DETAIL.md) for command details, templates, file structure, integration patterns, and best practices.
