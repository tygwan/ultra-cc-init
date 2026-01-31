---
name: agile-sync
description: Synchronize all agile development artifacts in one command. Updates CHANGELOG, README stats, progress tracking, and validates documentation completeness.
---

# Agile Sync Skill

One-command synchronization of all agile development artifacts.

## Usage

```bash
/agile-sync [--full|--quick|--validate]
```

| Option | Description |
|--------|-------------|
| `--full` | Complete sync: changelog + readme + progress + validation |
| `--quick` | Quick sync: readme stats + recent changes only |
| `--validate` | Validate only: check for inconsistencies without changes |
| (default) | Standard sync: changelog + readme + progress |

## Workflow Steps

| Step | Action | Input | Output |
|------|--------|-------|--------|
| 1 | Analyze Git State | `git log`, `git status` | Branch, commits, uncommitted files |
| 2 | Update CHANGELOG.md | Commits grouped by type | `feat`/`fix`/`refactor`/`docs` entries |
| 3 | Sync README Stats | Component counts via `find` | Updated Stats table |
| 4 | Update Progress | Phase TASKS.md scan | PROGRESS.md with progress bar |
| 5 | Validate Docs | Link/file checks | Validation report |
| 6 | Generate Report | All above | Sync summary with recommendations |

### Step 2: CHANGELOG Groups

| Commit Type | CHANGELOG Section |
|-------------|------------------|
| `feat` | Added |
| `fix` | Fixed |
| `refactor` | Changed |
| `docs` | Documentation |

### Step 3: README Stats

```bash
agents_count=$(find .claude/agents -name "*.md" | wc -l)
skills_count=$(find .claude/skills -name "SKILL.md" -o -name "*.md" | wc -l)
```

### Step 4: Progress (Phase-Integrated)

Source: `docs/phases/phase-*/TASKS.md`
Target: `docs/PROGRESS.md`
Format: `[████████████░░░░░░░░] 60% (Phase 2 of 5)`

> Uses Phase system. Legacy `docs/progress/status.md` is deprecated.

## Integration

| Context | Command |
|---------|---------|
| After feature implementation | `/agile-sync` |
| Before creating PR | `/agile-sync --full` |
| Quick check before commit | `/agile-sync --validate` |
| With active sprint | Auto-includes sprint metrics |
| Auto-triggered by | `auto-doc-sync` hook, `.claude/` changes |

## Configuration

```json
{
  "agile": {
    "auto_changelog": true,
    "auto_readme_sync": true,
    "sprint_tracking": true,
    "velocity_tracking": true,
    "sync_on_commit": true
  }
}
```

## Best Practices

| DO | DON'T |
|----|-------|
| Run before PR creation | Skip validation before releases |
| Run `--validate` before releases | Manually edit generated sections |
| Keep CHANGELOG under version control | Ignore sync warnings |
| Use conventional commits | - |

## Troubleshooting

| Error | Fix |
|-------|-----|
| CHANGELOG.md not found | `/agile-sync` creates automatically |
| README stats section missing | Add `## Stats` table to README.md |
| Progress tracking failed | `mkdir -p docs/progress && touch docs/progress/status.md` |

## Related

| Skill | Purpose |
|-------|---------|
| `/sprint` | Sprint lifecycle management |
| `/readme-sync` | Detailed README synchronization |
| `/changelog` | Manual changelog management |
| `/doc-validate` | Comprehensive doc validation |
