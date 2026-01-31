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
- `path`: Optional. Project root path (default: current directory)
- `--discover`: **Discovery only** - Engage in conversation to understand project, create DISCOVERY.md
- `--generate`: **Generate only** - Create docs from existing DISCOVERY.md
- `--full`: **Complete flow** - Framework setup → Discovery → Confirmation → Generate (RECOMMENDED for new projects)
- `--quick`: Quick analysis for existing codebases, CLAUDE.md only
- `--sync`: **Sync only** - Apply cc-initializer framework to existing project with .claude (MERGE mode)
- `--update`: **Update & Sync** - Pull latest cc-initializer from GitHub, then sync to current project

### Examples
```bash
/init                      # Quick analysis of current directory
/init --full               # Full workflow with discovery (NEW PROJECT)
/init --discover           # Discovery conversation only
/init --generate           # Generate docs from existing DISCOVERY.md
/init --sync               # Sync cc-initializer to existing project
/init --update             # Update cc-initializer from GitHub + sync
/init ./my-project --full  # Initialize specific path
```

## Workflow Chain

```
┌─────────────────────────────────────────────────────────────────────────────┐
│                        /INIT WORKFLOW CHAIN (v4.0)                           │
├─────────────────────────────────────────────────────────────────────────────┤
│                                                                              │
│  /init --full (RECOMMENDED for new projects)                                 │
│    │                                                                         │
│    ├── Step 0: Framework Setup                                              │
│    │     ├── Copy cc-initializer's .claude/ to target project               │
│    │     ├── Includes: agents, skills, commands, hooks, templates           │
│    │     ├── Merge with existing .claude/ if present                        │
│    │     └── Detect project repo (git remote) → update settings.json       │
│    │                                                                         │
│    ├── Step 0.5: Project Repo Detection (CRITICAL)                          │
│    │     ├── Run: git remote get-url origin                                 │
│    │     ├── Parse owner/repo from SSH or HTTPS URL                         │
│    │     ├── If not found: Ask user for their repo URL                      │
│    │     └── Update settings.json "project" section                         │
│    │                                                                         │
│    ├── Step 1: Project Discovery                                            │
│    │     ├── Trigger: project-discovery agent                               │
│    │     ├── Engage in conversation with user                               │
│    │     ├── Understand goals, requirements, tech stack                     │
│    │     └── Output: docs/DISCOVERY.md                                      │
│    │                                                                         │
│    ├── Step 2: Document Generation Preview                                  │
│    │     ├── Show preview of documents to be generated                      │
│    │     ├── Display: PRD, TECH-SPEC, PROGRESS, CONTEXT                    │
│    │     └── Ask: Submit / Edit / Cancel                                   │
│    │                                                                         │
│    ├── Step 3: Structure Analysis (if existing code)                        │
│    │     └── Detect tech stack, frameworks, patterns                        │
│    │                                                                         │
│    ├── Step 4: Generate CLAUDE.md (Lean Template)                           │
│    │     ├── Use .claude/templates/CLAUDE.lean.md as base                  │
│    │     ├── Fill {{variables}} from DISCOVERY.md                          │
│    │     └── ~300 tokens vs ~1,700+ (82% savings per turn)                │
│    │                                                                         │
│    ├── Step 5: Trigger dev-docs-writer                                      │
│    │     ├── Input: DISCOVERY.md (required!)                                │
│    │     └── Output: PRD.md, TECH-SPEC.md, PROGRESS.md, CONTEXT.md         │
│    │                                                                         │
│    ├── Step 6: Project-specific Agents (NEW!)                               │
│    │     └── Create additional agents based on project needs                │
│    │                                                                         │
│    └── Step 7: Trigger doc-splitter (if HIGH complexity)                    │
│          └── Create Phase structure in docs/phases/                         │
│                                                                              │
│  /init --sync (for existing projects with partial .claude)                  │
│    │                                                                         │
│    ├── Step 1: Analyze existing .claude/                                    │
│    │     └── Detect what's missing from cc-initializer                      │
│    │                                                                         │
│    ├── Step 2: Merge cc-initializer components                              │
│    │     ├── Add missing agents (preserve existing)                         │
│    │     ├── Add missing skills (preserve existing)                         │
│    │     ├── Add missing commands (preserve existing)                       │
│    │     ├── Add missing hooks (preserve existing)                          │
│    │     └── Merge settings.json (smart merge)                              │
│    │                                                                         │
│    └── Step 3: Validate and report                                          │
│          └── Show what was added/updated                                    │
│                                                                              │
│  /init --update (update cc-initializer from GitHub + sync)                  │
│    │                                                                         │
│    ├── Step 1: Locate cc-initializer                                        │
│    │     └── Find at ~/dev/cc-initializer or CC_INITIALIZER_PATH            │
│    │                                                                         │
│    ├── Step 2: Git pull latest                                              │
│    │     ├── Check current branch (main)                                    │
│    │     ├── git fetch origin                                               │
│    │     ├── Show what's new (commits, changes)                             │
│    │     ├── User confirmation                                              │
│    │     └── git pull origin main                                           │
│    │                                                                         │
│    ├── Step 3: Run --sync                                                   │
│    │     └── Apply updated components to current project                    │
│    │                                                                         │
│    └── Step 4: Report                                                       │
│          └── Show update summary + sync results                             │
│                                                                              │
└─────────────────────────────────────────────────────────────────────────────┘
```

## Critical Rule: Discovery First!

> **IMPORTANT**: For new projects, ALWAYS start with discovery.
>
> ```
> ❌ Wrong: Immediately generate documents without understanding
> ✅ Right: First ask "어떤 프로젝트를 만드시려고 하나요?"
> ```

## Mode Details

### --discover Mode

**Purpose**: Only run the discovery conversation

```
/init --discover
    │
    ▼
┌────────────────────────────────────┐
│      project-discovery agent        │
│                                    │
│  1. "어떤 프로젝트를 시작하시나요?"   │
│  2. 프로젝트 유형/목표 논의          │
│  3. 기술 스택 논의                  │
│  4. 복잡도 평가                     │
│  5. 요약 및 확인                    │
│                                    │
└────────────────────────────────────┘
    │
    ▼
Output: docs/DISCOVERY.md
```

**When to use**:
- 사용자가 아이디어 단계인 경우
- 먼저 논의만 하고 문서 생성은 나중에 하고 싶은 경우
- 프로젝트 범위를 먼저 정리하고 싶은 경우

### --generate Mode

**Purpose**: Generate docs from existing DISCOVERY.md

```
/init --generate
    │
    ▼
Check: docs/DISCOVERY.md exists?
    │
    ├── Yes → Proceed
    │
    └── No → Error: "DISCOVERY.md not found. Run /init --discover first."

    │
    ▼
┌────────────────────────────────────┐
│       dev-docs-writer agent         │
│                                    │
│  Read DISCOVERY.md                  │
│  Generate:                          │
│  - docs/PRD.md                      │
│  - docs/TECH-SPEC.md               │
│  - docs/PROGRESS.md                │
│  - docs/CONTEXT.md                 │
│                                    │
└────────────────────────────────────┘
    │
    ▼
If complexity = HIGH → doc-splitter
```

**When to use**:
- 이미 discovery가 완료된 경우
- DISCOVERY.md를 수동으로 작성한 경우
- discovery 후 수정을 거쳐 문서를 생성하려는 경우

### --full Mode (RECOMMENDED)

**Purpose**: Complete workflow with framework setup, discovery, and generation

```
/init --full
    │
    ▼
┌─────────────────────────────────────────────────────────────┐
│                    FULL WORKFLOW (v4.0)                       │
│                                                               │
│  Phase 0: Framework Setup (NEW!)                             │
│  ───────────────────────────                                 │
│  Copy cc-initializer .claude/ to target project              │
│  → agents/, skills/, commands/, hooks/, templates/           │
│  → Merge with existing .claude/ if present                   │
│                                                               │
│  Phase 1: Discovery                                          │
│  ─────────────────                                           │
│  project-discovery agent conducts conversation               │
│  → Creates docs/DISCOVERY.md                                 │
│                                                               │
│  Phase 2: Confirmation                                       │
│  ─────────────────                                           │
│  "이 내용이 맞나요? 수정할 부분이 있으신가요?"                    │
│  → User confirms or requests changes                         │
│                                                               │
│  Phase 3: Generation                                         │
│  ─────────────────                                           │
│  dev-docs-writer uses DISCOVERY.md                           │
│  → Creates PRD, TECH-SPEC, PROGRESS, CONTEXT                │
│                                                               │
│  Phase 4: Project-specific Agents (NEW!)                     │
│  ───────────────────────────────                             │
│  Based on tech stack, create additional agents               │
│  → E.g., react-component-generator, api-designer             │
│                                                               │
│  Phase 5: Structure (if needed)                              │
│  ─────────────────                                           │
│  doc-splitter for HIGH complexity                            │
│  → Creates Phase structure                                   │
│                                                               │
└─────────────────────────────────────────────────────────────┘
```

**When to use**:
- 새 프로젝트 시작 시 (RECOMMENDED)
- 프로젝트를 처음부터 체계적으로 세팅하고 싶을 때

### --sync Mode (NEW!)

**Purpose**: Synchronize cc-initializer framework to existing project

```
/init --sync
    │
    ▼
┌─────────────────────────────────────────────────────────────┐
│                    SYNC WORKFLOW                              │
│                                                               │
│  Step 1: Analyze Existing .claude/                           │
│  ─────────────────────────────────                           │
│  - Check what components exist                               │
│  - Identify missing agents, skills, hooks, commands          │
│  - Compare settings.json                                     │
│                                                               │
│  Step 2: Merge Components                                    │
│  ────────────────────────                                    │
│  - Copy missing agents (preserve existing)                   │
│  - Copy missing skills (preserve existing)                   │
│  - Copy missing commands (preserve existing)                 │
│  - Copy missing hooks (preserve existing)                    │
│  - Smart merge settings.json                                 │
│                                                               │
│  Step 3: Validate & Report                                   │
│  ─────────────────────────                                   │
│  - Run /validate --full                                      │
│  - Report added/updated components                           │
│                                                               │
└─────────────────────────────────────────────────────────────┘
```

**When to use**:
- 기존 프로젝트에 cc-initializer 구성이 일부만 적용된 경우
- cc-initializer 업데이트 후 기존 프로젝트에 새 기능 적용 시
- 프로젝트별 커스텀 agents는 유지하면서 기본 구성 동기화 시

**Merge Strategy**:
```yaml
Agents:
  - cc-initializer agents: ALWAYS add if missing
  - Project agents: ALWAYS preserve
  - Conflict: Project version takes precedence (no overwrite)

Skills:
  - cc-initializer skills: ALWAYS add if missing
  - Project skills: ALWAYS preserve
  - Conflict: Project version takes precedence

Hooks:
  - cc-initializer hooks: ALWAYS add if missing
  - settings.json hooks: Smart merge (append, don't replace)

Settings:
  - Deep merge: cc-initializer defaults + project overrides
  - Project settings take precedence for conflicts
```

### --update Mode (NEW!)

**Purpose**: Update cc-initializer from GitHub and sync to current project

```
/init --update
    │
    ▼
┌─────────────────────────────────────────────────────────────┐
│                    UPDATE WORKFLOW                            │
│                                                               │
│  Step 1: Locate cc-initializer                               │
│  ─────────────────────────────                               │
│  - Check ~/dev/cc-initializer                                │
│  - Or use CC_INITIALIZER_PATH environment variable           │
│  - Error if not found                                        │
│                                                               │
│  Step 2: Check for Updates                                   │
│  ─────────────────────────────                               │
│  - git fetch origin                                          │
│  - Compare local vs remote (commits behind)                  │
│  - Show changelog preview                                    │
│                                                               │
│  Step 3: User Confirmation                                   │
│  ─────────────────────────────                               │
│  - "N개의 새 커밋이 있습니다. 업데이트할까요?"                    │
│  - Show what will change                                     │
│                                                               │
│  Step 4: Pull Updates                                        │
│  ─────────────────────────────                               │
│  - git pull origin main                                      │
│  - Handle conflicts if any                                   │
│                                                               │
│  Step 5: Sync to Current Project                             │
│  ─────────────────────────────                               │
│  - Run --sync workflow                                       │
│  - Apply new/updated components                              │
│                                                               │
│  Step 6: Report                                              │
│  ─────────────────────────────                               │
│  - Show update summary                                       │
│  - List added/updated components                             │
│                                                               │
└─────────────────────────────────────────────────────────────┘
```

**When to use**:
- cc-initializer에 새 기능이 추가되었을 때
- 버그 수정이나 개선사항을 받고 싶을 때
- 정기적으로 프레임워크 최신 상태 유지

**Update Commands (executed internally)**:
```bash
# Step 1: Locate
CC_INIT="${CC_INITIALIZER_PATH:-$HOME/dev/cc-initializer}"

# Step 2: Fetch and check
cd $CC_INIT
git fetch origin
git log HEAD..origin/main --oneline  # Show new commits

# Step 3: Pull (after user confirmation)
git pull origin main

# Step 4: Sync (return to project and run --sync)
cd $PROJECT_ROOT
# ... run sync workflow ...
```

### --quick Mode

**Purpose**: Fast analysis for existing codebases

```
/init --quick
    │
    ▼
┌────────────────────────────────────┐
│       Quick Structure Analysis       │
│                                    │
│  - Detect tech stack                │
│  - Identify key files              │
│  - Generate CLAUDE.md only         │
│  - No discovery, no full docs      │
│                                    │
└────────────────────────────────────┘
```

**When to use**:
- 기존 코드베이스 탐색 시
- 빠른 프로젝트 컨텍스트만 필요할 때
- 문서 생성이 필요 없을 때

## Step Details

### Step 0: Framework Setup (NEW!)

```yaml
Trigger: --full or --sync mode
Source: cc-initializer's .claude/ directory
Target: Project's .claude/ directory

Attribution Badge:
  Target: Project's README.md (if exists)
  Badge: [![Powered by cc-initializer](https://img.shields.io/badge/Powered%20by-cc--initializer-blue)](https://github.com/tygwan/cc-initializer)
  Placement: After title (first # heading) or at the top if no title
  Skip: If badge already exists in README.md

Components to Copy:
  agents/:
    - file-explorer.md
    - tech-spec-writer.md
    - progress-tracker.md
    - phase-tracker.md
    - doc-generator.md
    - project-analyzer.md
    - code-reviewer.md
    - doc-splitter.md
    - test-helper.md
    - git-troubleshooter.md
    - google-searcher.md
    - prd-writer.md
    - dev-docs-writer.md
    - config-validator.md
    - pr-creator.md
    - commit-helper.md
    - doc-validator.md
    - work-unit-manager.md
    - branch-manager.md
    - refactor-assistant.md
    - project-discovery.md
    - MANIFEST.md  # Agent routing index (token optimization)

  skills/:
    - init.md, validate/, sprint/, agile-sync/
    - brainstorming/, context-optimizer/, feedback-loop/
    - hook-creator/, subagent-creator/, skill-creator/
    - prompt-enhancer/, dev-doc-system/, quality-gate/
    - sync-fix/, repair/, readme-sync/

  commands/:
    - feature.md, bugfix.md, release.md, phase.md
    - git-workflow.md, dev-doc-planner.md

  hooks/:
    - phase-progress.sh, pre-tool-use-safety.sh
    - post-tool-use-tracker.sh, notification-handler.sh
    - auto-doc-sync.sh

  templates/:
    - phase/, README.md, CLAUDE.lean.md

Merge Logic:
  - If target file exists: SKIP (preserve project customization)
  - If target file missing: COPY from cc-initializer
  - settings.json: Deep merge (see below)

Post-Copy Actions:
  - chmod +x .claude/hooks/*.sh  # CRITICAL: Grant execute permission to all hooks
  - This prevents "Permission denied" errors when hooks are triggered
```

### Step 1: Project Discovery

```yaml
Agent: project-discovery
Trigger: --full or --discover mode
Process:
  1. 시작 질문: "어떤 프로젝트를 시작하시나요?"
  2. 심층 질문: 유형, 목표, 사용자, 핵심 기능
  3. 기술 논의: 스택, 아키텍처, 제약사항
  4. 복잡도 평가: LOW/MEDIUM/HIGH 판단
  5. 요약 및 확인: 정리된 내용 사용자 확인
Output: docs/DISCOVERY.md
```

### Step 2: Document Generation Preview

```yaml
Trigger: After DISCOVERY.md is created
Purpose: Show user what will be generated, get confirmation

Display:
  - Project name, type, complexity from DISCOVERY.md
  - Documents to generate: PRD.md, TECH-SPEC.md, PROGRESS.md, CONTEXT.md
  - Phase structure (if HIGH complexity)

User Options:
  - Submit: Proceed with document generation
  - Edit: Go back to modify DISCOVERY.md, then re-show preview
  - Cancel: Stop here, DISCOVERY.md saved only

If Submit → Continue to Step 3
If Edit → Back to Step 1 refinement, then repeat Step 2
If Cancel → Exit (show: "Run '/init --generate' later")
```

### Step 3: Structure Analysis (if existing code)

```bash
# Find root indicators
Glob: package.json, requirements.txt, *.csproj, go.mod, Cargo.toml, pom.xml

# Find source directories
Glob: src/**, lib/**, app/**

# Find config files
Glob: *.config.*, .env*, tsconfig.json, setup.py
```

### Step 4: Tech Stack Detection

| File | Stack |
|------|-------|
| package.json | Node.js |
| tsconfig.json | TypeScript |
| requirements.txt | Python |
| *.csproj | .NET/C# |
| go.mod | Go |
| Cargo.toml | Rust |

### Step 5: Trigger dev-docs-writer

```yaml
Condition: --full or --generate mode
Input: docs/DISCOVERY.md (required for quality output)
Output:
  - docs/PRD.md
  - docs/TECH-SPEC.md
  - docs/PROGRESS.md
  - docs/CONTEXT.md
```

### Step 6: Trigger doc-splitter

```yaml
Condition: Complexity = HIGH
Input: dev-docs-writer output + DISCOVERY.md
Output:
  docs/phases/
  ├── phase-1/
  │   ├── SPEC.md
  │   ├── TASKS.md
  │   └── CHECKLIST.md
  └── phase-N/
```

## Output Structure

```
After /init --full:

[project-root]/
├── README.md              # Badge added: "Powered by cc-initializer"
├── CLAUDE.md              # Project context file
├── .claude/               # Framework components (NEW!)
│   ├── settings.json      # Unified configuration
│   ├── agents/            # 21 core agents + project-specific
│   │   ├── file-explorer.md
│   │   ├── progress-tracker.md
│   │   ├── phase-tracker.md
│   │   ├── dev-docs-writer.md
│   │   ├── ... (all cc-initializer agents)
│   │   └── [project-specific-agent].md  # Created based on tech stack
│   ├── skills/            # All workflow skills
│   ├── commands/          # Workflow commands
│   ├── hooks/             # Automation hooks
│   └── templates/         # Document templates
└── docs/
    ├── DISCOVERY.md       # Discovery report (from conversation)
    ├── PRD.md             # Product requirements
    ├── TECH-SPEC.md       # Technical specification
    ├── PROGRESS.md        # Progress tracking
    ├── CONTEXT.md         # AI context optimization
    └── phases/            # (if HIGH complexity)
        ├── phase-1/
        └── ...

After /init --sync:

[project-root]/
├── .claude/
│   ├── settings.json      # Merged (cc-initializer + project)
│   ├── agents/            # cc-initializer agents + existing project agents
│   ├── skills/            # cc-initializer skills + existing project skills
│   ├── commands/          # Merged commands
│   ├── hooks/             # Merged hooks
│   └── [existing-content] # All existing content preserved
└── [existing-project-files]
```

## Decision Flow

```
/init called
    │
    ├── --quick? → Structure Analysis → CLAUDE.md only → END
    │
    ├── --discover? → project-discovery → DISCOVERY.md → END
    │
    ├── --generate?
    │       │
    │       ├── DISCOVERY.md exists?
    │       │       │
    │       │       ├── Yes → dev-docs-writer → docs/ → END
    │       │       │
    │       │       └── No → ERROR: Run /init --discover first
    │       │
    ├── --sync?
    │       │
    │       ├── .claude/ exists?
    │       │       │
    │       │       ├── Yes → Analyze → Merge → Validate → Report → END
    │       │       │
    │       │       └── No → Full copy of .claude/ → END
    │       │
    ├── --update? (NEW!)
    │       │
    │       ├── Find cc-initializer location
    │       │       │
    │       │       ├── Found → git fetch → Show updates → User confirm
    │       │       │                                           │
    │       │       │           ├── Yes → git pull → --sync → Report → END
    │       │       │           │
    │       │       │           └── No → END (no changes)
    │       │       │
    │       │       └── Not found → ERROR: Set CC_INITIALIZER_PATH
    │       │
    └── --full? (or default for new project)
            │
            ▼
        Framework Setup + Repo Detection (Step 0)
            │
            ▼
        project-discovery → DISCOVERY.md
            │
            ▼
        Document Generation Preview (Step 2)
            │
            ├── Submit? → dev-docs-writer → Project Agents → docs/ → END
            │
            ├── Edit? → Update DISCOVERY.md → Loop back to Preview
            │
            └── Cancel? → END (DISCOVERY.md saved)
```

## Best Practices

### For New Projects
```bash
# RECOMMENDED: Full discovery workflow
/init --full
# This will:
# 1. Copy all cc-initializer components to .claude/
# 2. Run discovery conversation
# 3. Generate documentation
# 4. Create project-specific agents if needed

# Alternative: Separate steps
/init --discover    # First: understand project
# ... review and edit DISCOVERY.md if needed ...
/init --generate    # Then: generate docs
```

### For Existing Codebases (with partial .claude/)
```bash
# RECOMMENDED: Sync cc-initializer framework
/init --sync
# This will:
# 1. Analyze existing .claude/
# 2. Add missing agents, skills, commands, hooks
# 3. Preserve your custom components
# 4. Merge settings.json intelligently
```

### For Existing Codebases (without .claude/)
```bash
# Quick context
/init --quick

# Or full analysis
/init --full   # Will still do discovery to understand YOUR goals
```

### When to Re-run
- After major scope changes: `/init --discover` then `/init --generate`
- After tech stack changes: `/init --generate`
- For quick refresh: `/init --quick`
- After cc-initializer update: `/init --sync` (keeps your customizations)

## Integration Points

### With project-discovery
- First step in --full and --discover modes
- Creates foundational DISCOVERY.md

### With dev-docs-writer
- Triggered in --full and --generate modes
- Requires DISCOVERY.md for quality output

### With doc-splitter
- Triggered for HIGH complexity projects
- Creates Phase-based structure

### With phase-tracker
- Activated after Phase structure is created
- Begins tracking development progress

### With context-optimizer
- CONTEXT.md created for token optimization
- Phase documents structured for efficient loading

### With config-validator
- Called after --sync to validate merged configuration
- Ensures all components are properly integrated

### With /validate skill
- Auto-triggered after --sync mode
- Reports any issues with the merged setup

## Framework Sync Details

### cc-initializer Source Location
```bash
# cc-initializer must be available at one of these locations:
~/dev/cc-initializer/
~/.cc-initializer/
# Or specify via CC_INITIALIZER_PATH environment variable
```

### Sync Report Example
```
/init --sync completed!

📦 Components Added:
  Agents: +5 (progress-tracker, phase-tracker, dev-docs-writer, commit-helper, pr-creator)
  Skills: +3 (sprint, agile-sync, quality-gate)
  Commands: +2 (feature, release)
  Hooks: +1 (phase-progress.sh)

🔒 Preserved (not overwritten):
  Agents: 2 (custom-api-generator, custom-db-migrator)
  Skills: 1 (custom-deploy)

⚙️ Settings Merged:
  - Added: phase, sprint, quality-gate sections
  - Preserved: Custom project settings

✅ Validation: Passed
```

### Troubleshooting

**Q: Sync didn't add expected components?**
```bash
# Check if component already exists
ls .claude/agents/
# Sync only adds MISSING components

# Force re-sync (will backup existing)
/init --sync --force
```

**Q: Settings merge conflicts?**
```bash
# Project settings always take precedence
# Review merged result in .claude/settings.json
# Backup saved at .claude/settings.json.backup
```

**Q: Hook permission denied errors?**
```bash
# Error: .claude/hooks/auto-doc-sync.sh: Permission denied
# Solution: Add execute permission to all hooks
chmod +x .claude/hooks/*.sh

# For global hooks
chmod +x ~/.claude/hooks/*.sh
```

## Attribution Badge

cc-initializer로 초기화된 프로젝트에는 자동으로 출처 배지가 추가됩니다.

### Badge Format
```markdown
[![Powered by cc-initializer](https://img.shields.io/badge/Powered%20by-cc--initializer-blue)](https://github.com/tygwan/cc-initializer)
```

### Insertion Rules
1. **Target**: 프로젝트의 `README.md` 파일
2. **Placement**: 첫 번째 `#` 제목 바로 다음 줄에 삽입
3. **Skip Condition**: 이미 배지가 있으면 삽입하지 않음
4. **No README**: README.md가 없으면 건너뜀

### Insertion Process
```yaml
Step 1: Check README.md exists
  - Path: [project-root]/README.md
  - If not exists: Skip badge insertion

Step 2: Check existing badge
  - Search: "Powered by cc-initializer" or "cc-initializer" badge URL
  - If found: Skip (already attributed)

Step 3: Find insertion point
  - Look for first "# " (H1 heading)
  - Insert badge on the line after the heading
  - If no heading: Insert at the very top

Step 4: Insert badge
  - Add blank line before badge
  - Add badge markdown
  - Add blank line after badge
```

### Example
**Before:**
```markdown
# My Awesome Project

A description of my project.
```

**After:**
```markdown
# My Awesome Project

[![Powered by cc-initializer](https://img.shields.io/badge/Powered%20by-cc--initializer-blue)](https://github.com/tygwan/cc-initializer)

A description of my project.
```

### Manual Addition
배지를 수동으로 추가하려면:
```markdown
[![Powered by cc-initializer](https://img.shields.io/badge/Powered%20by-cc--initializer-blue)](https://github.com/tygwan/cc-initializer)
```

## Community Registration

cc-initializer를 사용하는 프로젝트는 커뮤니티 쇼케이스에 등록할 수 있습니다.

### Auto-discovery (Recommended)

GitHub repo에 `uses-cc-initializer` topic을 추가하면 자동으로 발견됩니다.

```
GitHub Repository → Settings → Topics → "uses-cc-initializer" 추가
```

등록된 프로젝트는 cc-initializer README의 "Projects Using cc-initializer" 섹션에 자동 표시됩니다.

### Manual Registration

PR을 통해 직접 등록:
1. [PROJECTS.json](https://github.com/tygwan/cc-initializer/blob/main/PROJECTS.json) 파일 수정
2. 프로젝트 정보 추가:
```json
{
  "name": "owner/repo",
  "url": "https://github.com/owner/repo",
  "description": "프로젝트 설명"
}
```
3. PR 제출

### Post-init Reminder

`/init --full` 완료 후 표시되는 안내:
```
✅ 초기화 완료!

💡 프로젝트를 커뮤니티에 공유하세요:
   GitHub repo → Settings → Topics → "uses-cc-initializer" 추가

   등록된 프로젝트는 cc-initializer README에 자동 표시됩니다.
```
