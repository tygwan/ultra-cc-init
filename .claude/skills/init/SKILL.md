---
name: init
description: Initialize and analyze a new project. First engages in discovery conversation to understand user requirements, then generates documentation. Use when starting work on any new codebase.
---

# Project Initialization Skill

## Usage
```
/init [path] [--discover|--generate|--full|--quick|--sync|--update]
```

### Parameters

| Mode | Input | Output | Use When |
|------|-------|--------|----------|
| `--full` | None | .claude/ + DISCOVERY + Docs + Phases | New project (RECOMMENDED) |
| `--discover` | None | DISCOVERY.md | Idea stage only |
| `--generate` | DISCOVERY.md | PRD + TECH-SPEC + PROGRESS + CONTEXT | After discovery |
| `--sync` | .claude/ | Merged .claude/ | Existing project |
| `--update` | None | Updated cc-initializer + sync | Framework update |
| `--quick` | Code | CLAUDE.md | Quick context |

### Examples
```bash
/init --full               # Full workflow (NEW PROJECT)
/init --discover           # Discovery conversation only
/init --generate           # Generate from existing DISCOVERY.md
/init --sync               # Sync framework to existing project
/init --update             # Update cc-initializer + sync
/init ./my-project --full  # Initialize specific path
```

### Workflow Chain
```
/init --full   → Framework Setup → Discovery → Confirmation → Generate → Phase Split
/init --sync   → Analyze .claude/ → Merge missing → Validate → Report
/init --update → Locate source → git pull → Sync → Report
```

### Critical Rule
> For new projects, ALWAYS start with discovery. Never generate docs without understanding.

---

> **Full implementation**: Load [references/DETAIL.md](references/DETAIL.md) for mode details, step implementations, decision flow, best practices, integration points, and framework sync details.
