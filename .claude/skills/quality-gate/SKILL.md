---
name: quality-gate
description: Automated quality gates for development lifecycle. Pre-commit checks, pre-merge validation, release readiness verification, and post-release documentation.
---

# Quality Gate Skill

Automated quality validation at critical development checkpoints.

## Usage

```bash
/quality-gate <checkpoint> [options]
```

### Checkpoints

| Checkpoint | Trigger | Purpose | Key Checks |
|------------|---------|---------|------------|
| `pre-commit` | Before commit | Code quality | lint, format, types, secrets |
| `pre-merge` | Before PR merge | Test & review | tests, coverage, review, docs |
| `pre-release` | Before release | Full validation | all + security, build, version |
| `post-release` | After release | Documentation | archive, notes, velocity, retro |
| `check` | On demand | Auto-detect | Runs applicable checks |

## Quality Gate Flow

```
Code Change → Pre-Commit → Pre-Merge → Pre-Release → Release
     ↓            ↓            ↓            ↓           ↓
  ┌──────┐    ┌──────┐    ┌──────┐    ┌──────┐    ┌──────┐
  │ Edit │ →  │ Lint │ →  │ Test │ →  │ Docs │ →  │ Tag  │
  │      │    │Format│    │Review│    │ Sec  │    │Deploy│
  └──────┘    └──────┘    └──────┘    └──────┘    └──────┘

Gate Status: ✅ Pass   ⚠️ Warning   ❌ Block
```

## Related Skills

| Skill | Purpose |
|-------|---------|
| `/agile-sync` | Sync all agile artifacts |
| `/sprint` | Sprint management |
| `/feedback` | Post-release retrospective |

---

> **Full implementation**: Load [references/DETAIL.md](references/DETAIL.md) for checkpoint details, configuration, integration, check reference tables, and troubleshooting.
