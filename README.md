<p align="center">
  <img src="https://img.shields.io/badge/⚡_Ultra-CC--Init-FF6B35?style=for-the-badge&logo=anthropic&logoColor=white" alt="Ultra CC-Init"/>
</p>

<h1 align="center">ultra-cc-init</h1>

<p align="center">
  <strong>97% fewer tokens. Same 25 agents. Zero compromise.</strong>
</p>

<p align="center">
  <a href="https://github.com/tygwan/ultra-cc-init/releases"><img src="https://img.shields.io/badge/version-5.1.0-FF6B35?style=flat-square" alt="Version"/></a>
  <a href="https://github.com/tygwan/cc-initializer"><img src="https://img.shields.io/badge/base-cc--initializer_4.5-5A67D8?style=flat-square" alt="Base"/></a>
  <a href="LICENSE"><img src="https://img.shields.io/badge/license-MIT-green?style=flat-square" alt="License"/></a>
</p>

<p align="center">
  <img src="https://img.shields.io/badge/Agents-25-blue?style=flat-square" alt="Agents"/>
  <img src="https://img.shields.io/badge/Skills-27-blue?style=flat-square" alt="Skills"/>
  <img src="https://img.shields.io/badge/Commands-6-blue?style=flat-square" alt="Commands"/>
  <img src="https://img.shields.io/badge/Hooks-6-blue?style=flat-square" alt="Hooks"/>
  <img src="https://img.shields.io/badge/Lines_Saved-5,400+-success?style=flat-square" alt="Lines Saved"/>
</p>

---

## Before & After

```
                cc-initializer              ultra-cc-init
                ──────────────              ──────────────
Session init    ~38,000 tokens    ──97%──▶  ~1,100 tokens
CLAUDE.md       ~1,700/turn       ──82%──▶  ~300/turn
Agent routing   load all 25       ──97%──▶  MANIFEST → 1
File headers    ~3,700 lines      ──moved─▶ on-demand detail
Prose content   ~1,700 lines      ──73%──▶  tables only
```

---

## Projects Using cc-initializer

### Community Showcase

| Project | Description |
|---------|-------------|
| [tygwan/dxtnavis](https://github.com/tygwan/dxtnavis) | DXT Navigator - Real-world example project |

> **Add your project**: Add `uses-cc-initializer` topic to your repo or [submit a PR](PROJECTS.json)

_Last updated: 2026-03-08_
---

## Five Pillars

<table>
<tr>
<td width="20%" align="center">

**1. MANIFEST**

```
38K → 500
tokens
```

1 routing table
for 25 agents

</td>
<td width="20%" align="center">

**2. Lean CLAUDE**

```
1,700 → 300
per turn
```

8-variable
template

</td>
<td width="20%" align="center">

**3. Incremental**

```
50K+ → 1.1K
initial load
```

4-tier budget
system

</td>
<td width="20%" align="center">

**4. 2-Tier Docs**

```
3,700 lines
→ on-demand
```

Header+Detail
split pattern

</td>
<td width="20%" align="center">

**5. Structured**

```
1,700 lines
deleted (73%)
```

Prose → tables
everywhere

</td>
</tr>
</table>

---

## How It Works

```
Turn 1 (~1.1K tokens)
├── CLAUDE.lean.md ........... ~300    Project context snapshot
├── agents/MANIFEST.md ....... ~500    25-agent routing index
└── docs/CONTEXT.md .......... ~300    Architecture + current state
    │
    ▼  User: "Phase 2의 T2-03 작업해줘"
Turn 2 (+2-5K tokens)
├── MANIFEST → phase-tracker matched
├── phase-tracker.md ......... ~100    Header only (2-Tier)
├── TASKS.md row T2-03 ....... ~50     Single task row
└── source files ............. ~2K     Related code
    │
    ▼  "SPEC 확인해볼게"
Turn 3+ (on-demand)
└── phase-2/SPEC.md .......... +2K     Loaded only when referenced
```

---

## 2-Tier Document Architecture

Every large file is split into a compact **Header** (always loaded, ~50 lines) and a **Detail** file (loaded on-demand).

```
.claude/
├── agents/
│   ├── github-manager.md ............. Header (~50 lines)
│   ├── dev-docs-writer.md ............ Header
│   ├── project-discovery.md .......... Header
│   └── details/
│       ├── github-manager-detail.md .. Full reference
│       ├── dev-docs-writer-detail.md . Full reference
│       └── project-discovery-detail.md Full reference
│
└── skills/
    ├── init/SKILL.md ................. Header (~40 lines)
    │   └── references/DETAIL.md ...... Full reference
    ├── sprint/SKILL.md ............... Header
    │   └── references/DETAIL.md ...... Full reference
    ├── quality-gate/SKILL.md ......... Header
    ├── dev-doc-system/SKILL.md ....... Header
    └── prompt-enhancer/SKILL.md ...... Header
```

| File | Before | Header | Detail | Savings |
|------|:------:|:------:|:------:|:-------:|
| init.md | 880 | 40 | ~300 | 95% header |
| dev-doc-system | 560 | 60 | ~500 | 89% header |
| github-manager | 488 | 50 | ~440 | 90% header |
| quality-gate | 447 | 45 | ~400 | 90% header |
| sprint | 428 | 50 | ~380 | 88% header |
| prompt-enhancer | 406 | 50 | ~360 | 88% header |
| dev-docs-writer | 402 | 58 | ~350 | 86% header |
| project-discovery | 340 | 64 | ~280 | 81% header |

---

## Structured Data Format

All remaining files converted from prose to tables. Zero paragraphs.

| File | Before | After | Reduction |
|------|:------:|:-----:|:---------:|
| context-optimizer | 465 | 180 | 61% |
| feedback-loop | 377 | 150 | 60% |
| repair | 302 | 115 | 62% |
| agile-sync | 301 | 95 | 68% |
| readme-helper | 190 | 115 | 39% |
| commit-helper | 160 | 85 | 47% |
| phase-tracker | 161 | 85 | 47% |
| work-unit-manager | 149 | 80 | 46% |
| progress-tracker | 141 | 85 | 40% |

---

## Quick Start

```bash
git clone https://github.com/tygwan/ultra-cc-init.git
cd your-project && claude
```

| Command | Action |
|---------|--------|
| `/init --full` | New project: Discovery → Docs → Phase structure |
| `/init --sync` | Sync framework to existing project |
| `/init --update` | Update ultra-cc-init + sync |
| `/validate` | Verify configuration |

---

## Components

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

### Skills `27`

| Category | Skills |
|:--------:|--------|
| **Init** | `/init` `/validate` `/repair` |
| **Agile** | `/sprint` `/phase` `/agile-sync` |
| **Git** | `/feature` `/bugfix` `/release` `/git-workflow` |
| **GitHub** | `/gh` |
| **Dual AI** | `/codex` `/codex-claude-loop` |
| **Docs** | `/dev-doc-system` `/doc-confirm` `/readme-sync` |
| **Quality** | `/quality-gate` `/feedback-loop` |
| **Context** | `/context-optimizer` |
| **Create** | `/skill-creator` `/subagent-creator` `/hook-creator` |
| **Utils** | `/analytics` `/sync-fix` `/brainstorming` `/prompt-enhancer` |

</td>
</tr>
</table>

---

## Token Budget

| Tier | Budget | Loads | Use Case |
|:----:|:------:|-------|----------|
| **Quick** | ~2K | CONTEXT + PROGRESS | Status check |
| **Standard** | ~10K | + Phase docs + active files | Normal dev |
| **Deep** | ~30K | + Adjacent phases + source | Architecture |
| **Full** | ~50K+ | Complete project load | Major refactor |

### Context Boundary Levels

| Level | Scope | Tokens |
|:-----:|-------|:------:|
| 1 | Task-Active: task row + source + deps | ~3-6K |
| 2 | Phase-Full: + SPEC + CHECKLIST | ~8-10K |
| 3 | Cross-Phase: + adjacent SPECs + TECH-SPEC | ~12-15K |

### Session Checkpoint

```
Context > 80% budget → auto-save checkpoint
After /clear: CLAUDE.lean (300) + checkpoint (1.6K) = ~2K instant recovery
```

---

## Workflow

```
/init ──────▶ project-discovery ──▶ DISCOVERY.md
                                        │
             dev-docs-writer ◀──────────┘
                  │
                  ├──▶ PRD.md, TECH-SPEC.md, PROGRESS.md, CONTEXT.md
                  └──▶ CLAUDE.lean.md (auto-filled)

/feature ───▶ branch-manager ──▶ commit-helper ──▶ pr-creator
/gh ────────▶ github-manager ──▶ Issues / PRs / CI / Releases
/sprint ────▶ progress-tracker ◀──── phase-tracker ◀── hooks
/analytics ─▶ analytics-reporter ──▶ CLI charts
```

---

## Directory

```
.claude/
├── settings.json ................. 17-section config hub
├── agents/ ............... 25+3   25 agents + MANIFEST + 3 detail files
│   ├── MANIFEST.md                Routing index (~500 tokens)
│   ├── details/                   On-demand detail files
│   └── *.md                       Compact headers
├── skills/ ............... 25     18 directory + 7 file-based
│   └── */references/DETAIL.md     On-demand detail files
├── commands/ ............. 6      Integrated dev workflows
├── hooks/ ................ 6      Auto-trigger scripts
├── templates/                     CLAUDE.lean.md + phase templates
├── analytics/                     Usage metrics (JSONL, 30d)
├── docs/                          Framework architecture docs
└── logs/                          Error & recovery logs
```

---

## vs cc-initializer

| | cc-initializer | ultra-cc-init | Delta |
|---|:---:|:---:|:---:|
| **Session init** | ~38K tokens | ~1.1K tokens | **-97%** |
| **CLAUDE.md/turn** | ~1,700 | ~300 | **-82%** |
| **Agent routing** | Load all 25 | MANIFEST → 1 | **-97%** |
| **File headers** | Full files | 2-Tier split | **-90% avg** |
| **Content format** | Prose | Tables | **-73%** |
| **Context strategy** | Eager load | Incremental | 4-tier budget |
| **Session recovery** | Manual | Auto-checkpoint | ~2K recovery |
| **Context boundary** | Project-wide | Task-scoped | 3-level scope |

---

## Changelog

| Version | Changes |
|:-------:|---------|
| **5.1.0** | 2-Tier Document split (8 files), Structured Data conversion (9 files), ~5,400 lines optimized |
| **5.0.0** | Agent MANIFEST, Lean CLAUDE.md, Incremental Loading, Context Boundary, Checkpoints |
| 4.5.0 | README Helper & Agent Writer |
| 4.4.0 | Community Project Discovery |
| 4.3.0 | GitHub CLI Integration |
| 4.2.0 | Analytics Visualization |
| 4.0.0 | Framework Setup & Sync |

---

<p align="center">
  <strong>Built on</strong> <a href="https://github.com/tygwan/cc-initializer">cc-initializer</a> &bull;
  Token-optimized with <a href="https://claude.ai">Claude</a>
</p>

<p align="center">
  <a href="https://github.com/tygwan/ultra-cc-init/issues">Issues</a> &bull;
  <a href=".claude/docs/">Docs</a> &bull;
  <a href="LICENSE">MIT License</a>
</p>
