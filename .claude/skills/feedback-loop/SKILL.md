---
name: feedback-loop
description: Automated feedback collection and learning documentation. Captures learnings from issues, generates ADRs for architecture decisions, and prompts for retrospective insights.
---

# Feedback Loop Skill

Automates collection of learnings, architectural decisions, and retrospective insights.

## Usage

```bash
/feedback <command> [options]
```

| Command | Description | Output Location |
|---------|-------------|-----------------|
| `learning` | Record learning from issue/bug | `docs/feedback/LEARNINGS.md` |
| `adr` | Create Architecture Decision Record | `docs/adr/ADR-{N}-{slug}.md` |
| `retro` | Generate retrospective template | `docs/retros/sprint-N-retro.md` |
| `review` | Review recent learnings/decisions | Console output |

## /feedback learning

```bash
/feedback learning "Database connection pooling prevents timeout errors"
/feedback learning --from-issue ISS-042
```

**Prompts**: What was the problem? → Root cause? → What learned? → Future prevention?

### Learning Format

```markdown
## LRN-{N}: {Title}
**Date**: {date} | **Category**: {category} | **Related**: {issue_id}
### Context / Problem / Root Cause / Learning / Application
### Tags: `{tag1}` `{tag2}`
```

## /feedback adr

```bash
/feedback adr "Use PostgreSQL over MySQL"
/feedback adr --title "Authentication Strategy" --status proposed
```

| Option | Values |
|--------|--------|
| `--title` | ADR title |
| `--status` | proposed, accepted, deprecated, superseded |
| `--supersedes` | ADR number this replaces |

**Prompts**: Context/problem? → Options considered? → Decision? → Consequences?

### ADR Format

```markdown
# ADR-{N}: {Title}
**Status**: {status} | **Date**: {date} | **Deciders**: {names}
## Context → Decision Drivers → Considered Options → Decision → Consequences
```

## /feedback retro

```bash
/feedback retro                    # Current sprint
/feedback retro --milestone "v1.0" # For milestone
/feedback retro --quick            # Quick 3-question
```

| Mode | Sections |
|------|----------|
| Quick | What went well? / What could improve? / What to try? |
| Full | Keep / Problem / Try / Action items / Velocity analysis |

## /feedback review

```bash
/feedback review                   # Last 10 items
/feedback review --category bugs   # Filter by category
/feedback review --last 30d        # Last 30 days
```

## Auto-Triggers

| Trigger | When | Action |
|---------|------|--------|
| Issue Resolution | `fix:` or `closes #` commit | Prompt for learning |
| Architecture Change | Core infrastructure modified | Prompt for ADR |

## Categories

### Learning Categories

| Category | Keywords | Example |
|----------|----------|---------|
| `bugs` | fix, error, crash | Memory leak patterns |
| `performance` | slow, optimize, cache | Query optimization |
| `security` | auth, vulnerability | Input validation |
| `architecture` | design, pattern | Event sourcing |
| `tooling` | build, deploy, ci | Docker multi-stage |
| `process` | workflow, team | Code review practices |

### ADR Categories

| Category | When to Use |
|----------|-------------|
| `infrastructure` | Database, hosting, scaling |
| `architecture` | Patterns, structure, modules |
| `security` | Auth, encryption, compliance |
| `integration` | APIs, third-party, protocols |
| `process` | Development workflow, tools |

## File Structure

```
docs/
├── feedback/LEARNINGS.md, INDEX.md
├── adr/INDEX.md, ADR-{N}-{slug}.md, template.md
└── retros/sprint-N-retro.md, milestone-{name}-retro.md
```

## Configuration

```json
{
  "feedback": {
    "auto_prompt_on_fix": true,
    "auto_prompt_on_arch_change": true,
    "learning_categories": ["bugs", "performance", "security", "architecture"],
    "adr_auto_number": true,
    "retro_template": "full",
    "review_default_count": 10
  }
}
```

## Best Practices

| Type | DO | DON'T |
|------|-----|-------|
| Learning | Record immediately, include examples, tag for search | Skip "obvious" learnings, be too brief |
| ADR | Create before implementation, include rejected options | Create for trivial decisions, forget consequences |
| Retro | Hold within 24h, assign owners to actions | Blame individuals, skip action items |

## Related

| Skill | Purpose |
|-------|---------|
| `/sprint` | Sprint management with retro |
| `/agile-sync` | Include feedback in sync |
| `/doc` | General documentation |
