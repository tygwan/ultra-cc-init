<p align="center">
  <img src="https://img.shields.io/badge/Ultra-CC--Init-Token_Optimized-FF6B35?style=for-the-badge&logo=anthropic&logoColor=white" alt="Ultra CC-Init"/>
</p>

<h1 align="center">ultra-cc-init</h1>

<p align="center">
  <strong>Token-Optimized Claude Code Framework</strong><br/>
  <sub>cc-initializer + Incremental Context Loading + Agent MANIFEST + Lean Templates</sub>
</p>

<p align="center">
  <a href="https://github.com/tygwan/ultra-cc-init/releases"><img src="https://img.shields.io/badge/version-5.0.0-FF6B35?style=flat-square" alt="Version"/></a>
  <a href="https://github.com/tygwan/cc-initializer"><img src="https://img.shields.io/badge/base-cc--initializer_4.5-5A67D8?style=flat-square" alt="Base"/></a>
  <a href="LICENSE"><img src="https://img.shields.io/badge/license-MIT-green?style=flat-square" alt="License"/></a>
  <a href="https://github.com/tygwan/ultra-cc-init/stargazers"><img src="https://img.shields.io/github/stars/tygwan/ultra-cc-init?style=flat-square" alt="Stars"/></a>
</p>

<p align="center">
  <img src="https://img.shields.io/badge/Agents-25-blue?style=flat-square" alt="Agents"/>
  <img src="https://img.shields.io/badge/Skills-25-blue?style=flat-square" alt="Skills"/>
  <img src="https://img.shields.io/badge/Commands-6-blue?style=flat-square" alt="Commands"/>
  <img src="https://img.shields.io/badge/Hooks-6-blue?style=flat-square" alt="Hooks"/>
  <img src="https://img.shields.io/badge/Token_Savings-82%25-success?style=flat-square" alt="Token Savings"/>
</p>

---

## What is Ultra?

**ultra-cc-init** is the token-optimized evolution of [cc-initializer](https://github.com/tygwan/cc-initializer). Same 25 agents, 25 skills, 6 commands, 6 hooks -- but with an intelligent context loading system that cuts per-session token consumption by up to 82%.

```
cc-initializer (v4.5)           ultra-cc-init (v5.0)
─────────────────────           ─────────────────────
Session start: ~38K tokens      Session start: ~1.1K tokens
CLAUDE.md: ~1,700 tokens/turn   CLAUDE.md: ~300 tokens/turn
Agent routing: load all 25      Agent routing: MANIFEST index
Context: load everything        Context: incremental, on-demand
```

---

## Token Optimization Architecture

```
                        ┌──────────────────────────────┐
                        │        ultra-cc-init          │
                        │                               │
                        │   Turn 1: ~1.1K tokens        │
                        │   ┌─────────────────────┐     │
                        │   │ CLAUDE.lean.md ~300  │     │
                        │   │ MANIFEST.md    ~500  │     │
                        │   │ CONTEXT.md     ~300  │     │
                        │   └────────┬────────────┘     │
                        │            │                   │
                        │            ▼                   │
                        │   Turn 2: Intent Detection     │
                        │   ┌─────────────────────┐     │
                        │   │ "Phase 2 T2-03 작업"  │     │
                        │   │  → +TASKS row  ~50   │     │
                        │   │  → +source    ~2K    │     │
                        │   │  → +SPEC/TASKS ~2K   │     │
                        │   └────────┬────────────┘     │
                        │            │                   │
                        │            ▼                   │
                        │   Turn 3+: On-Demand           │
                        │   ┌─────────────────────┐     │
                        │   │ Only what you need   │     │
                        │   │ SPEC? → +SPEC.md     │     │
                        │   │ PRD?  → +PRD section │     │
                        │   └─────────────────────┘     │
                        └──────────────────────────────┘
```

### Three Pillars

<table>
<tr>
<td width="33%" valign="top">

**Agent MANIFEST**

```
Before: ~38,000 tokens
 Load all 25 agent files

After:  ~500 tokens
 1 routing table
 + load matched agent
```

`MANIFEST.md` maps keywords to agents. Only the matched agent file is loaded on demand.

</td>
<td width="33%" valign="top">

**Lean CLAUDE.md**

```
Before: ~1,700 tokens/turn
 200+ lines loaded every turn

After:  ~300 tokens/turn
 25-35 lines, structured
 82% savings per turn
```

Template with 8 variables auto-filled from project docs.

</td>
<td width="33%" valign="top">

**Incremental Loading**

```
Before: ~50K+ upfront
 Everything at session start

After:  ~1.1K initial
 Expand only on reference
 Budget-aware loading
```

4-tier budget: Quick 2K, Standard 10K, Deep 30K, Full 50K.

</td>
</tr>
</table>

---

## Quick Start

```bash
git clone https://github.com/tygwan/ultra-cc-init.git ~/dev/ultra-cc-init
cd your-project && claude
```

```bash
/init --full          # New project: Discovery -> Docs -> Phase structure
/init --sync          # Sync framework to existing project
/init --update        # Update ultra-cc-init to latest
```

---

## Component Overview

<table>
<tr>
<td width="50%" valign="top">

### Agents `25`

| Category | Agents |
|:--------:|--------|
| **Discovery** | `project-discovery` |
| **Tracking** | `progress-tracker` `phase-tracker` |
| **Docs** | `dev-docs-writer` `doc-splitter` `doc-validator` `doc-generator` |
| **Git** | `commit-helper` `pr-creator` `branch-manager` `git-troubleshooter` |
| **GitHub** | `github-manager` |
| **Quality** | `code-reviewer` `test-helper` `refactor-assistant` |
| **Analytics** | `analytics-reporter` |
| **Config** | `config-validator` `work-unit-manager` |
| **Research** | `google-searcher` `project-analyzer` `file-explorer` |
| **Writing** | `prd-writer` `tech-spec-writer` `readme-helper` `agent-writer` |

</td>
<td width="50%" valign="top">

### Skills `25`

| Category | Skills |
|:--------:|--------|
| **Init** | `/init` `/validate` `/repair` |
| **Agile** | `/sprint` `/phase` `/agile-sync` |
| **Git** | `/feature` `/bugfix` `/release` `/git-workflow` |
| **GitHub** | `/gh` |
| **Docs** | `/dev-doc-system` `/doc-confirm` `/readme-sync` |
| **Quality** | `/quality-gate` `/feedback-loop` |
| **Context** | `/context-optimizer` |
| **Create** | `/skill-creator` `/subagent-creator` `/hook-creator` |
| **Utils** | `/analytics` `/sync-fix` `/brainstorming` `/prompt-enhancer` |

</td>
</tr>
</table>

---

## Ultra Features

### 1. Agent MANIFEST Routing

```
.claude/agents/MANIFEST.md
```

Instead of loading all 25 agent files (~38K tokens), MANIFEST provides a compact lookup table:

```
| Agent            | Keywords (KO)              | Keywords (EN)                  | Purpose                        |
|------------------|----------------------------|--------------------------------|--------------------------------|
| progress-tracker | 진행상황, 진척, 완료율       | progress, status, completion   | Phase+Sprint 통합 진행률 추적  |
| phase-tracker    | phase, 단계, 페이즈         | phase, current phase, next     | Phase별 진행 추적              |
| commit-helper    | 커밋, 저장, 올려            | commit, save changes, staged   | Conventional Commits 작성      |
| ...              | ...                        | ...                            | ...                            |
```

**Flow**: User intent -> keyword match in MANIFEST (~500 tokens) -> load only matched agent (~1-3K)

### 2. Lean CLAUDE.md Template

```
.claude/templates/CLAUDE.lean.md
```

```markdown
# {{PROJECT_NAME}}
> {{PROJECT_TYPE}} | {{TECH_STACK}} | Phase {{CURRENT_PHASE}}/{{TOTAL_PHASES}}

## Commands
| Dev | Manage | Track |
|-----|--------|-------|
| /feature | /phase | /sprint |
| /bugfix | /validate | /analytics |

## Focus
Phase {{CURRENT_PHASE}}: {{PHASE_NAME}} ({{PHASE_PROGRESS}}%)
Files: {{ACTIVE_FILES}}
```

Variables auto-filled from `DISCOVERY.md` and `PROGRESS.md` during `/init`.

### 3. Incremental Context Protocol

| Turn | What Loads | Tokens |
|------|-----------|--------|
| **Turn 1** | CLAUDE.lean + MANIFEST + CONTEXT.md | ~1.1K |
| **Turn 2** | + Task-specific row + source files | +2-5K |
| **Turn 3+** | + Referenced docs on demand | +varies |

### 4. Task-Scoped Context Boundary

```
Level 1: Task-Active (default)        ~3-6K
  Current task + related source files

Level 2: Phase-Full (on request)      ~8-10K
  + SPEC.md + CHECKLIST.md

Level 3: Cross-Phase (architecture)   ~12-15K
  + Adjacent Phase specs + TECH-SPEC
```

### 5. Session Checkpoint Protocol

Auto-saves at 80% context budget:

```
docs/sessions/checkpoint-{{TIMESTAMP}}.md
  ├── Current Task ID
  ├── Modified files
  ├── Key decisions
  └── Resume instructions

After /clear: CLAUDE.lean (~300) + checkpoint (~1.6K) = ~2K instant recovery
```

---

## Workflow

```
┌─────────────────────────────────────────────────────────────────────────────┐
│                                                                              │
│    /init ─────────────────────────────────────────────────▶ Setup           │
│      │                                                                      │
│      ├──▶ project-discovery ──▶ DISCOVERY.md                               │
│      │                              │                                       │
│      └──▶ dev-docs-writer ◀─────────┘                                      │
│                 │                                                            │
│                 ├──▶ PRD.md                                                 │
│                 ├──▶ TECH-SPEC.md      ┌─────────────────┐                 │
│                 ├──▶ PROGRESS.md  ◀────│  phase-tracker  │◀── Hooks        │
│                 ├──▶ CONTEXT.md        └─────────────────┘                 │
│                 └──▶ CLAUDE.lean.md (auto-filled template)                 │
│                                                                             │
│    /feature ────▶ branch-manager ──▶ commit-helper ──▶ pr-creator          │
│                                                                             │
│    /gh ─────────▶ github-manager ──▶ Issues / PRs / CI / Releases          │
│                                                                             │
│    /analytics ──▶ analytics-reporter ──▶ CLI Charts & Reports              │
│                                                                             │
└─────────────────────────────────────────────────────────────────────────────┘
```

---

## Phase & Sprint

```
Phase 1 ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ 100%
  └── Sprint 1.1 ████████████████████ Done
  └── Sprint 1.2 ████████████████████ Done

Phase 2 ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━  65%
  └── Sprint 2.1 ████████████████████ Done
  └── Sprint 2.2 ████████████░░░░░░░░ In Progress
```

```bash
/phase status           # Phase progress
/sprint start           # Start sprint
/sprint complete        # Complete sprint + retrospective
```

---

## GitHub Integration

```bash
/gh status              # Dashboard: issues, PRs, mentions, CI
/gh issue list          # Issue listing
/gh pr create           # Create PR
/gh ci watch            # Real-time CI monitoring
/gh release create      # Create release
```

---

## Analytics

```bash
/analytics              # Full summary
/analytics tools        # Tool usage chart
/analytics agents       # Agent call frequency
/analytics errors       # Error pattern analysis
```

```
Tool Usage (Last 7 days)
───────────────────────────────────────
Read        ████████████████████████████ 142
Edit        ██████████████████           89
Bash        ███████████████              74
Grep        █████████                    45
Write       ███████                      35
```

---

## Directory Structure

```
.claude/
├── settings.json          ─── 17-section config hub (315 lines)
├── agents/           26   ─── 25 agents + MANIFEST routing index
├── skills/           25   ─── 18 directory-based + 7 file-based
├── commands/          6   ─── Integrated dev workflows
├── hooks/             6   ─── Auto-trigger shell scripts
├── templates/             ─── CLAUDE.lean.md + phase templates
├── scripts/               ─── analytics-visualizer.sh
├── analytics/             ─── Usage metrics (JSONL, 30d retention)
├── docs/              6   ─── Framework architecture docs
└── logs/                  ─── Error & recovery logs
```

---

## Token Budget Reference

| Session Type | Budget | What Loads | Use Case |
|:------------:|:------:|-----------|----------|
| **Quick** | ~2K | CONTEXT + PROGRESS | Status check |
| **Standard** | ~10K | + Phase docs + active files | Normal dev |
| **Deep** | ~30K | + Adjacent phases + source | Architecture work |
| **Full** | ~50K+ | Complete project load | Major refactor |

---

## vs cc-initializer

| | cc-initializer | ultra-cc-init |
|---|:---:|:---:|
| **Session init** | ~38K tokens | ~1.1K tokens |
| **CLAUDE.md** | ~1,700/turn | ~300/turn |
| **Agent routing** | Load all | MANIFEST index |
| **Context strategy** | Eager load | Incremental |
| **Session recovery** | Manual | Auto-checkpoint |
| **Context boundary** | Project-wide | Task-scoped |
| **Agents** | 25 | 25 |
| **Skills** | 25 | 25 |
| **Commands** | 6 | 6 |
| **Hooks** | 6 | 6 |

---

## Changelog

| Version | Changes |
|:-------:|---------|
| `5.0.0` | Token optimization: MANIFEST, Lean CLAUDE.md, Incremental Loading, Context Boundary, Checkpoints |
| `4.5.0` | README Helper & Agent Writer |
| `4.4.0` | Community Project Discovery |
| `4.3.0` | GitHub CLI Integration |
| `4.2.0` | Analytics Visualization |
| `4.1.0` | Framework Update System |
| `4.0.0` | Framework Setup & Sync |

---

<p align="center">
  <strong>Built on</strong> <a href="https://github.com/tygwan/cc-initializer">cc-initializer</a>
</p>

<p align="center">
  <a href="https://github.com/tygwan/ultra-cc-init/issues">Issues</a> &bull;
  <a href=".claude/docs/">Documentation</a> &bull;
  <a href="LICENSE">MIT License</a>
</p>
