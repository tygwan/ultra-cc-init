---
name: context-optimizer
description: Optimize context loading for efficient token usage. Use when working with large codebases, context limits, or when the user mentions "context", "token", "optimize", "summarize", or asks to reduce context size.
---

# Context Optimizer

Optimize AI context loading for efficient token usage and focused development sessions.

## When to Use

- Working with large codebases (>50 files)
- Context window approaching limits
- User mentions "context", "token", "optimize"
- Starting a new development session

## Context Scoring

| Factor | Weight | Description |
|--------|--------|-------------|
| Direct relevance | 40% | Directly related to current task |
| Dependency chain | 25% | Required by relevant files |
| Recent access | 20% | Recently read or modified |
| Reference frequency | 15% | Often referenced in codebase |

## Optimization Strategies

| Strategy | Load Scope | Token Savings |
|----------|-----------|---------------|
| A: Essential Only | Modified files + type defs + immediate deps | 60-80% |
| B: Focused Context | Working files + 1-level deps + docs + config | 40-60% |
| C: Summarized | Full working files + summaries + index | 30-50% |

## Document Priority Loading

| Priority | Files | When |
|----------|-------|------|
| 1 (Always) | `docs/CONTEXT.md`, `docs/PROGRESS.md` | Every session |
| 2 (Phase) | `docs/phases/phase-N/SPEC.md`, `TASKS.md` | Phase work |
| 3 (On-Demand) | `docs/PRD.md`, `docs/TECH-SPEC.md`, `src/**/*` | As needed |

## Token Budget Guidelines

| Session Type | Budget | Loading Strategy |
|--------------|--------|------------------|
| Quick check | ~2K | CONTEXT.md + PROGRESS.md |
| Standard dev | ~10K | CONTEXT + PROGRESS + active files |
| Deep dive | ~30K | All docs + relevant source |
| Full context | ~50K+ | Complete project load |

## Incremental Context Protocol

Turn-by-turn progressive loading to minimize initial token cost.

### Loading Sequence

| Turn | Load | Tokens | Purpose |
|------|------|--------|---------|
| 1 | CLAUDE.md (lean) + MANIFEST.md + CONTEXT.md | ~1.1K | User intent detection |
| 2 | Task-specific files (TASKS.md row + source) | +2-3K | Intent-scoped work |
| 3+ | On-demand (SPEC, PRD, etc.) | +varies | As referenced |

> Note: `auto_load_phase_docs` deferred until Turn 2.

### Expansion Triggers

| User Intent | Load Target | Budget Impact |
|-------------|-------------|---------------|
| Phase 작업 | +phase docs (SPEC, TASKS) | +2-3K |
| 아키텍처 논의 | +TECH-SPEC + adjacent phase SPECs | +5-8K |
| 코드 리뷰 | +PRD (requirements) + CHECKLIST | +3-5K |
| 전체 현황 | +PROGRESS + all phase summaries | +5-10K |

### settings.json Configuration

```json
{
  "context-optimizer": {
    "loading_strategy": "incremental",
    "initial_budget": 800,
    "expansion_triggers": {
      "phase_work": "+phase_docs",
      "architecture": "+tech_spec+adjacent_phases",
      "review": "+prd+checklist",
      "full_status": "+progress+all_phase_summaries"
    }
  }
}
```

## Task-Scoped Context Boundary

| Level | Scope | Tokens | Contents |
|-------|-------|--------|----------|
| 1: Task-Active (default) | Single task | ~3-6K | CONTEXT.md + Task row + source + direct deps |
| 2: Phase-Full | Full phase | ~8-10K | Level 1 + SPEC.md + CHECKLIST.md |
| 3: Cross-Phase | Architecture | ~12-15K | Level 2 + adjacent SPEC.md + TECH-SPEC sections |

### Task Context Format

```markdown
## Task T2-03 Context
Source: docs/phases/phase-2/TASKS.md (row 3 only)

| ID | Task | Status | Priority | Est |
|----|------|--------|----------|-----|
| T2-03 | API endpoint 구현 | 🔄 | P0 | 3h |

Related files: server/src/routes/api.ts, server/src/models/schema.ts
Dependencies: T2-01 (DB schema), T2-02 (auth middleware)
```

## Session Checkpoint Protocol

Auto-save on context threshold (>80% budget) for seamless recovery.

### Checkpoint Template

```markdown
# Session Checkpoint
Date: {{TIMESTAMP}}
Phase: {{CURRENT_PHASE}} | Task: {{TASK_ID}} | Progress: {{PHASE_PROGRESS}}%

## State
- Working on: {{TASK_DESCRIPTION}}
- Modified: {{FILE_LIST}}

## Decisions / Next / Resume Command
```

Recovery cost: CLAUDE.md (300) + checkpoint (1.6K) = ~2K for instant recovery.

## CLAUDE.md Lean Template

Location: `.claude/templates/CLAUDE.lean.md`

| Variable | Source | Example |
|----------|--------|---------|
| `{{PROJECT_NAME}}` | DISCOVERY.md | "Resumely" |
| `{{TECH_STACK}}` | DISCOVERY.md | "Next.js+Supabase" |
| `{{CURRENT_PHASE}}` | PROGRESS.md | "2" |
| `{{PHASE_PROGRESS}}` | TASKS.md calc | "60" |

| Format | Tokens | Savings |
|--------|--------|---------|
| Standard CLAUDE.md | ~1,700+ | baseline |
| Lean CLAUDE.md | ~300 | ~82% |

## Agent MANIFEST Pattern

Location: `.claude/agents/MANIFEST.md`

```
1. MANIFEST.md loaded (~500 tokens, 25 agents × 1 row)
2. Match user intent → keyword lookup
3. Load only matched agent file (~1-3K tokens)
Total: ~1.5-3.5K per invocation vs. ~38K if all loaded
```

## Best Practices

| # | Practice |
|---|----------|
| 1 | Start Lean: Ultra-lean CLAUDE.md + MANIFEST only |
| 2 | Task-First: Scope to current Task, not entire Phase |
| 3 | Expand Incrementally: Add files only when referenced |
| 4 | Structured > Prose: Use tables/key-value over paragraphs |
| 5 | Checkpoint Often: Auto-save before context exhaustion |
| 6 | Phase-Scoped Loading: Load current Phase docs by default |
| 7 | Summarize Adjacents: Only SPEC.md from neighboring Phases |
| 8 | Budget Awareness: Match loading strategy to session type |
