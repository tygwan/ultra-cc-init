# cc-initializer

> **Type**: Claude Code Configuration Framework
> **Stack**: Markdown + Shell + JSON
> **Docs**: [.claude/docs/](.claude/docs/)

## Overview

cc-initializer는 Claude Code를 위한 통합 개발 워크플로우 프레임워크입니다.
Agents, Skills, Hooks, Commands를 유기적으로 연결하여 효율적인 개발 환경을 제공합니다.

## Quick Start

```bash
# 새 프로젝트 초기화 (전체 .claude/ 복사 + Discovery + 문서 생성)
/init --full

# 기존 프로젝트에 cc-initializer 동기화 (기존 설정 유지하며 병합)
/init --sync

# 설정 검증
/validate --full

# 기능 개발 시작
/feature start "기능명"
```

## Component Structure

```
.claude/
├── settings.json          # 통합 설정
├── agents/                # 25 specialized agents
│   ├── progress-tracker.md
│   ├── phase-tracker.md
│   ├── dev-docs-writer.md
│   ├── analytics-reporter.md
│   └── ...
├── skills/                # 12 skills
│   ├── init/
│   ├── validate/
│   ├── sprint/
│   └── ...
├── commands/              # 6 workflow commands
│   ├── feature.md
│   ├── bugfix.md
│   ├── release.md
│   └── ...
├── hooks/                 # 5 automation hooks
│   ├── phase-progress.sh
│   ├── pre-tool-use-safety.sh
│   └── ...
├── analytics/             # Usage metrics (JSONL)
│   └── metrics.jsonl
└── docs/                  # Framework documentation
    ├── DOCUMENT-STRUCTURE.md
    └── SPRINT-PHASE-INTEGRATION.md
```

## Key Components

| Category | Count | Purpose |
|----------|-------|---------|
| Agents | 25 | 전문화된 작업 수행 |
| Skills | 27 | 워크플로우 자동화 (Codex 듀얼 AI 포함) |
| Commands | 6 | 통합 개발 플로우 |
| Hooks | 5 | 자동 트리거 작업 |

## Core Workflows

### 1. 새 프로젝트 초기화 (v4.0)

```
/init --full
    ↓
Framework Setup (.claude/ 전체 복사)
    ↓
project-discovery → DISCOVERY.md
    ↓
dev-docs-writer → PRD, TECH-SPEC, PROGRESS, CONTEXT
    ↓
doc-splitter (HIGH complexity) → Phase 구조
```

### 2. 기존 프로젝트 동기화

```
/init --sync → .claude/ 분석 → 누락 컴포넌트 병합 → 검증
```

### 3. Sprint 실행

```
/sprint start --phase N → Task 선택 → /sprint complete → Phase 업데이트
```

### 4. 기능 개발

```
/feature start → 개발 → /feature progress → /feature complete
```

## Document Locations

| Document | Location | Purpose |
|----------|----------|---------|
| Progress | `docs/PROGRESS.md` | 통합 진행 현황 |
| Context | `docs/CONTEXT.md` | AI 컨텍스트 |
| Phases | `docs/phases/` | Phase 기반 개발 |
| Sprints | `docs/sprints/` | Sprint 실행 |

**상세**: [.claude/docs/DOCUMENT-STRUCTURE.md](.claude/docs/DOCUMENT-STRUCTURE.md)

## Quick Reference

### Primary Skills

| Skill | Usage |
|-------|-------|
| `/init --full` | 새 프로젝트 전체 초기화 |
| `/init --sync` | 기존 프로젝트 동기화 |
| `/init --update` | cc-initializer 업데이트 + 동기화 |
| `/validate` | 설정 검증 |
| `/phase` | Phase 관리 |
| `/sprint` | Sprint 관리 |
| `/agile-sync` | 문서 동기화 |
| `/analytics` | 사용 통계 시각화 |
| `/gh` | GitHub CLI 통합 (이슈, PR, CI/CD, 릴리스) |
| `/codex` | Codex CLI 실행 (코드 분석, 리뷰) |
| `/codex-claude-loop` | Claude+Codex 듀얼 AI 엔지니어링 루프 |

### Workflow Commands

| Command | Usage |
|---------|-------|
| `/feature` | 기능 개발 워크플로우 |
| `/bugfix` | 버그 수정 워크플로우 |
| `/release` | 릴리스 워크플로우 |

### Key Agents

| Agent | Purpose |
|-------|---------|
| `progress-tracker` | 전체 진행률 관리 |
| `phase-tracker` | Phase별 상세 추적 |
| `dev-docs-writer` | 개발 문서 생성 |
| `commit-helper` | 커밋 메시지 작성 |
| `config-validator` | 설정 검증 |
| `analytics-reporter` | 사용 통계 및 리포트 |
| `github-manager` | GitHub 통합 (이슈, PR, CI/CD, 릴리스) |
| `readme-helper` | README 작성 및 개선 |
| `agent-writer` | Agent 작성 및 검증 |

## Integration Map

```
┌──────────────────────────────────────────────────────────────┐
│                    cc-initializer                             │
├──────────────────────────────────────────────────────────────┤
│                                                               │
│  [Skills]              [Agents]              [Hooks]          │
│  /init --full ───────► Framework Setup + project-discovery    │
│  /init --sync ───────► config-validator (merge & validate)    │
│  /validate ──────────► config-validator                       │
│  /phase ─────────────► phase-tracker ◄───── phase-progress.sh │
│  /sprint ────────────► progress-tracker                       │
│  /agile-sync ────────► doc-generator                          │
│  /gh ────────────────► github-manager (gh CLI)                │
│  /analytics ─────────► analytics-reporter                     │
│                                                               │
│  [Commands]            [Integration]                          │
│  /feature ───────────► Git + Phase + Sprint + Quality Gate   │
│  /bugfix ────────────► Git + Sprint + Analyzer               │
│  /release ───────────► Quality Gate + Sprint + Phase         │
│                                                               │
│  [Framework Setup]     [Components Copied]                    │
│  .claude/ ───────────► agents/ + skills/ + commands/          │
│                        hooks/ + templates/ + settings.json    │
│                                                               │
└──────────────────────────────────────────────────────────────┘
```

## Configuration

핵심 설정: `.claude/settings.json`

```json
{
  "phase": { "enabled": true },
  "sprint": { "enabled": true, "phase_integration": { "enabled": true } },
  "sync": {
    "enabled": true,
    "merge_strategy": { "agents": "add_missing", "settings": "deep_merge" },
    "preserve_project_customizations": true
  },
  "analytics": {
    "enabled": true,
    "metrics_file": ".claude/analytics/metrics.jsonl",
    "retention_days": 30
  },
  "github": {
    "enabled": true,
    "default_base_branch": "main",
    "pr": { "squash_merge": true },
    "release": { "generate_notes": true }
  },
  "validation": { "auto_check_on_start": false }
}
```

## Links

- [Document Structure](.claude/docs/DOCUMENT-STRUCTURE.md)
- [Sprint-Phase Integration](.claude/docs/SPRINT-PHASE-INTEGRATION.md)
- [Settings](.claude/settings.json)
