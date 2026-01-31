---
name: context-optimizer
description: Optimize context loading for efficient token usage. Use when working with large codebases, context limits, or when the user mentions "context", "token", "optimize", "summarize", or asks to reduce context size.
---

# Context Optimizer

Optimize AI context loading for efficient token usage and focused development sessions.

## When to Use This Skill

Use this skill when:
- Working with large codebases (>50 files)
- Context window is approaching limits
- User mentions "context", "token", "optimize"
- Need to focus on specific subsystem
- Starting a new development session

## Core Workflow

### Step 1: Analyze Current Context

**Identify loaded files:**
- Recently read files
- Referenced documentation
- Active working files

**Assess relevance:**
- Current task requirements
- File dependencies
- Historical usage patterns

### Step 2: Context Scoring

Score files by relevance (1-10):

| Factor | Weight | Description |
|--------|--------|-------------|
| Direct relevance | 40% | Directly related to current task |
| Dependency chain | 25% | Required by relevant files |
| Recent access | 20% | Recently read or modified |
| Reference frequency | 15% | Often referenced in codebase |

### Step 3: Optimization Strategies

#### Strategy A: Essential Only
```
Load only:
- Files directly being modified
- Critical type definitions
- Immediate dependencies
Token savings: 60-80%
```

#### Strategy B: Focused Context
```
Load:
- Working files + 1 level dependencies
- Relevant documentation
- Key configuration
Token savings: 40-60%
```

#### Strategy C: Summarized Context
```
Load:
- Full working files
- Summaries of related files
- Index of available resources
Token savings: 30-50%
```

## Context Summary Format

### File Summary Template
```markdown
## [filename] Summary
**Purpose:** [one-line description]
**Key exports:** [list of main functions/classes]
**Dependencies:** [key imports]
**Size:** [lines] lines

### Key Sections
- [Section 1]: Lines X-Y - [description]
- [Section 2]: Lines X-Y - [description]
```

### Project Context Template
```markdown
# Project Context Summary

## Architecture
- Pattern: [MVVM/MVC/etc]
- Language: [language + version]
- Framework: [framework details]

## Key Files
| File | Purpose | Priority |
|------|---------|----------|
| file1.cs | Main entry | High |
| file2.cs | Core logic | High |
| file3.cs | Utilities | Medium |

## Current Focus
Working on: [current task]
Relevant files: [list]
```

## Output Format

### Context Analysis Report
```markdown
## Context Optimization Analysis

### Current Context
- Files loaded: 25
- Estimated tokens: ~45,000
- Utilization: 75%

### Recommended Optimization

**Strategy:** Focused Context
**Expected savings:** 40%

#### Keep (High Priority)
- ViewModel.cs - direct modification
- Model.cs - type definitions
- Services/*.cs - active dependencies

#### Summarize (Medium Priority)
- Utils/*.cs - create summaries
- Helpers/*.cs - create summaries

#### Defer (Low Priority)
- Tests/*.cs - load on demand
- Docs/*.md - reference only

### Action
Apply optimization? [Yes/No]
```

## Integration with dev-docs-writer

This skill works with the `dev-docs-writer` agent for optimal context management:

### Document Priority Loading

```yaml
Priority 1 (Always Load):
  - docs/CONTEXT.md      # Quick reference, architecture snapshot
  - docs/PROGRESS.md     # Current phase, active tasks

Priority 2 (Phase-Specific):
  - docs/phases/phase-N/SPEC.md     # Current phase details
  - docs/phases/phase-N/TASKS.md    # Phase tasks
  - src/[active-module]/*           # Active development files

Priority 3 (On-Demand):
  - docs/PRD.md          # Requirements reference
  - docs/TECH-SPEC.md    # Technical details
  - src/**/*             # Specific files as needed
```

### Session Continuity

```markdown
## Starting a new session:

1. Load: docs/CONTEXT.md
2. Check: Current phase from PROGRESS.md
3. Load: Phase-specific files (docs/phases/phase-N/)
4. Resume: Work from last checkpoint
```

### Token Budget Guidelines

| Session Type | Token Budget | Loading Strategy |
|--------------|--------------|------------------|
| Quick check | ~2K | CONTEXT.md only |
| Standard dev | ~10K | CONTEXT + PROGRESS + active files |
| Deep dive | ~30K | All docs + relevant source |
| Full context | ~50K+ | Complete project load |

## Phase-Aware Context Loading

### 자동 Phase 감지

```yaml
# settings.json
context-optimizer:
  auto_load_phase_docs: true
  token_budget:
    quick: 2000
    standard: 10000
    deep: 30000
    full: 50000
```

### Phase 문서 로딩 전략

```
Phase 감지 흐름:
1. PROGRESS.md에서 현재 Phase 확인
2. 해당 Phase 디렉토리 로드
3. SPEC.md → 범위 및 요구사항
4. TASKS.md → 현재 작업 목록
5. CHECKLIST.md → 완료 체크
```

### Phase별 컨텍스트 템플릿

```markdown
# Phase {{N}} Context Summary

## 현재 상태
- Phase: {{PHASE_NAME}}
- 진행률: {{PROGRESS}}%
- 활성 Task: {{ACTIVE_TASKS}}

## 핵심 파일
{{PRIORITY_FILES}}

## 현재 작업
{{CURRENT_WORK}}

## 참조 문서
- [SPEC.md](docs/phases/phase-{{N}}/SPEC.md)
- [TASKS.md](docs/phases/phase-{{N}}/TASKS.md)
```

### 세션 복구 워크플로우

```
새 세션 시작 시:

┌─────────────────────┐
│  CONTEXT.md 로드    │◀─── 필수
└─────────┬───────────┘
          │
          ▼
┌─────────────────────┐
│ PROGRESS.md 확인    │◀─── Phase N 감지
└─────────┬───────────┘
          │
          ▼
┌─────────────────────┐
│ Phase N 문서 로드   │◀─── SPEC + TASKS
└─────────┬───────────┘
          │
          ▼
┌─────────────────────┐
│ 작업 재개           │
└─────────────────────┘
```

### 토큰 예산별 Phase 로딩

| 예산 | 로드 범위 | 토큰 |
|------|----------|------|
| Quick | CONTEXT.md + PROGRESS.md | ~2K |
| Standard | + 현재 Phase (SPEC, TASKS) | ~10K |
| Deep | + 인접 Phase + 소스 코드 | ~30K |
| Full | 모든 Phase + 전체 문서 | ~50K+ |

## Sprint 통합

Phase와 Sprint 동시 사용 시:

```yaml
Context Loading Priority:
  1. CONTEXT.md
  2. PROGRESS.md
  3. 현재 Sprint (sprints/sprint-N/)
  4. 연결된 Phase (phases/phase-N/)
  5. 소스 코드
```

## Incremental Context Protocol

Turn-by-turn progressive loading to minimize initial token cost.

### Loading Sequence

```
Turn 1: Ultra-lean entry (~800 tokens)
  CLAUDE.md (lean, ~300 tokens)
  + agents/MANIFEST.md (~500 tokens)
  → User intent detection ready

Turn 2: Intent-scoped expansion
  User: "Phase 2의 T2-03 작업"
  → Load: TASKS.md에서 T2-03 행만 (~50 tokens)
  → Load: T2-03 관련 소스 파일 (~2K tokens)

Turn 3+: On-demand expansion
  "SPEC 확인 필요" → +SPEC.md
  "PRD 참조" → +PRD.md 관련 섹션
```

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

Narrower than Phase-level: focus on individual Task for maximum efficiency.

### Boundary Levels

```
Level 1: Task-Active (default, ~3-6K)
  ├── CONTEXT.md (structured summary)     ~300 tokens
  ├── Current Task row from TASKS.md      ~50 tokens
  ├── Task-related source files           ~2-5K tokens
  └── Direct dependencies only

Level 2: Phase-Full (on request, ~8-10K)
  ├── Level 1
  ├── + SPEC.md (full phase scope)
  └── + CHECKLIST.md (completion criteria)

Level 3: Cross-Phase (architecture work, ~12-15K)
  ├── Level 2
  ├── + Adjacent Phase SPEC.md only
  └── + TECH-SPEC.md relevant sections
```

### Task Context Extraction

```markdown
## Task T2-03 Context
Source: docs/phases/phase-2/TASKS.md (row 3 only)

| ID | Task | Status | Priority | Est |
|----|------|--------|----------|-----|
| T2-03 | API endpoint 구현 | 🔄 | P0 | 3h |

Related files:
- server/src/routes/api.ts
- server/src/models/schema.ts

Dependencies: T2-01 (DB schema), T2-02 (auth middleware)
```

## Session Checkpoint Protocol

Auto-save on context threshold for seamless recovery.

### Checkpoint Trigger

```
Context usage > 80% of budget
    ↓
Auto-generate checkpoint:
  docs/sessions/checkpoint-{timestamp}.md
    ├── Current Task ID: T2-03
    ├── Modified files: [list]
    ├── Decisions made: [key decisions]
    ├── Next steps: [TODO items]
    └── ~200 lines, ~1.6K tokens
    ↓
After /clear:
  CLAUDE.md (300) + checkpoint (1.6K) = ~2K for instant recovery
```

### Checkpoint Template

```markdown
# Session Checkpoint
Date: {{TIMESTAMP}}
Phase: {{PHASE}} | Task: {{TASK_ID}} | Progress: {{PROGRESS}}%

## State
- Working on: {{TASK_DESCRIPTION}}
- Modified: {{FILE_LIST}}
- Status: {{TASK_STATUS}}

## Decisions
{{KEY_DECISIONS}}

## Next
{{TODO_ITEMS}}

## Resume Command
Read this file + docs/phases/phase-{{N}}/TASKS.md
```

## CLAUDE.md Lean Template

Projects using cc-initializer should use the lean CLAUDE.md template at:
`.claude/templates/CLAUDE.lean.md`

### Template Variables

| Variable | Source | Example |
|----------|--------|---------|
| `{{PROJECT_NAME}}` | DISCOVERY.md | "Resumely" |
| `{{PROJECT_TYPE}}` | DISCOVERY.md | "Web App" |
| `{{TECH_STACK}}` | DISCOVERY.md | "Next.js+Supabase" |
| `{{CURRENT_PHASE}}` | PROGRESS.md | "2" |
| `{{TOTAL_PHASES}}` | PROGRESS.md | "4" |
| `{{PHASE_NAME}}` | phase SPEC.md | "Core Features" |
| `{{PHASE_PROGRESS}}` | TASKS.md calc | "60" |
| `{{ACTIVE_FILES}}` | CONTEXT.md | "src/app/, src/lib/" |

### Token Comparison

| Format | Lines | Tokens | Savings |
|--------|-------|--------|---------|
| Standard CLAUDE.md | 200+ | ~1,700+ | baseline |
| Lean CLAUDE.md | 25-35 | ~300 | ~82% |

## Agent MANIFEST Pattern

Agents use `.claude/agents/MANIFEST.md` as routing index.

### How It Works

```
1. MANIFEST.md loaded (~500 tokens, 25 agents × 1 row)
2. Match user intent → keyword lookup
3. Load only matched agent file (~1-3K tokens)
4. Execute agent with full prompt

Total: ~1.5-3.5K per agent invocation
vs. Previous: ~38K if all agents loaded
```

## Best Practices

1. **Start Lean**: Ultra-lean CLAUDE.md + MANIFEST only
2. **Task-First**: Scope context to current Task, not entire Phase
3. **Expand Incrementally**: Add files only when referenced
4. **Structured > Prose**: Use tables/key-value over paragraphs
5. **Checkpoint Often**: Auto-save before context exhaustion
6. **Phase-Scoped Loading**: Load current Phase docs by default
7. **Summarize Adjacents**: Only SPEC.md from neighboring Phases
8. **Update on Transition**: Refresh CONTEXT.md on Phase change
9. **Budget Awareness**: Match loading strategy to session type
