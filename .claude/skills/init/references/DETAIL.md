# Init Skill - Full Implementation Detail

> Loaded on-demand when /init is invoked. Header: [../SKILL.md](../SKILL.md)

## Workflow Chain (v4.0)

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
/init --discover → project-discovery agent → docs/DISCOVERY.md
```

**When to use**:
- 사용자가 아이디어 단계인 경우
- 먼저 논의만 하고 문서 생성은 나중에 하고 싶은 경우

### --generate Mode

**Purpose**: Generate docs from existing DISCOVERY.md

```
/init --generate → Check DISCOVERY.md → dev-docs-writer → docs/
  └── No DISCOVERY.md → Error: "Run /init --discover first."
```

**When to use**:
- 이미 discovery가 완료된 경우
- DISCOVERY.md를 수동으로 작성한 경우

### --full Mode (RECOMMENDED)

**Purpose**: Complete workflow with framework setup, discovery, and generation

```
Phase 0: Framework Setup → Copy .claude/ to target
Phase 1: Discovery → project-discovery → DISCOVERY.md
Phase 2: Confirmation → User review
Phase 3: Generation → dev-docs-writer → PRD, TECH-SPEC, PROGRESS, CONTEXT
Phase 4: Project Agents → Create based on tech stack
Phase 5: Structure → doc-splitter for HIGH complexity → Phase dirs
```

**When to use**: 새 프로젝트 시작 시 (RECOMMENDED)

### --sync Mode

**Purpose**: Synchronize cc-initializer framework to existing project

```
Step 1: Analyze existing .claude/ → Identify missing components
Step 2: Merge → Add missing agents/skills/commands/hooks + Smart merge settings.json
Step 3: Validate & Report → /validate --full
```

**Merge Strategy**:
```yaml
Agents:   cc-initializer ALWAYS add if missing, Project version takes precedence
Skills:   cc-initializer ALWAYS add if missing, Project version takes precedence
Hooks:    ALWAYS add if missing, settings.json hooks: Smart merge (append)
Settings: Deep merge: cc-initializer defaults + project overrides
```

### --update Mode

**Purpose**: Update cc-initializer from GitHub and sync to current project

```
Step 1: Locate → ~/dev/cc-initializer or CC_INITIALIZER_PATH
Step 2: git fetch → Show new commits → User confirmation
Step 3: git pull origin main
Step 4: Run --sync → Apply updated components
Step 5: Report → Show update summary
```

### --quick Mode

**Purpose**: Fast analysis for existing codebases
- Detect tech stack, identify key files
- Generate CLAUDE.md only
- No discovery, no full docs

## Step Details

### Step 0: Framework Setup

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
    - file-explorer.md, tech-spec-writer.md, progress-tracker.md
    - phase-tracker.md, doc-generator.md, project-analyzer.md
    - code-reviewer.md, doc-splitter.md, test-helper.md
    - git-troubleshooter.md, google-searcher.md, prd-writer.md
    - dev-docs-writer.md, config-validator.md, pr-creator.md
    - commit-helper.md, doc-validator.md, work-unit-manager.md
    - branch-manager.md, refactor-assistant.md, project-discovery.md
    - MANIFEST.md

  skills/:
    - init/, validate/, sprint/, agile-sync/
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
  - settings.json: Deep merge

Post-Copy Actions:
  - chmod +x .claude/hooks/*.sh  # CRITICAL: Grant execute permission
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
Display: Project name, type, complexity, documents to generate
User Options:
  - Submit: Proceed with document generation
  - Edit: Go back to modify DISCOVERY.md
  - Cancel: Stop here, DISCOVERY.md saved only
```

### Step 3-4: Structure Analysis & Tech Stack Detection

| File | Stack |
|------|-------|
| package.json | Node.js |
| tsconfig.json | TypeScript |
| requirements.txt | Python |
| *.csproj | .NET/C# |
| go.mod | Go |
| Cargo.toml | Rust |

### Step 5-6: Document Generation & Phase Split

```yaml
Step 5:
  Condition: --full or --generate mode
  Input: docs/DISCOVERY.md (required)
  Output: PRD.md, TECH-SPEC.md, PROGRESS.md, CONTEXT.md

Step 6:
  Condition: Complexity = HIGH
  Input: dev-docs-writer output + DISCOVERY.md
  Output: docs/phases/phase-N/ (SPEC.md, TASKS.md, CHECKLIST.md)
```

## Output Structure

```
After /init --full:

[project-root]/
├── README.md              # Badge added: "Powered by cc-initializer"
├── CLAUDE.md              # Project context file (lean template)
├── .claude/               # Framework components
│   ├── settings.json
│   ├── agents/            # 25 core agents + MANIFEST + project-specific
│   ├── skills/
│   ├── commands/
│   ├── hooks/
│   └── templates/
└── docs/
    ├── DISCOVERY.md
    ├── PRD.md
    ├── TECH-SPEC.md
    ├── PROGRESS.md
    ├── CONTEXT.md
    └── phases/            # (if HIGH complexity)

After /init --sync:

[project-root]/
├── .claude/
│   ├── settings.json      # Merged (cc-initializer + project)
│   ├── agents/            # cc-initializer + existing project agents
│   └── [existing-content] # All existing content preserved
└── [existing-project-files]
```

## Decision Flow

```
/init called
    │
    ├── --quick? → Structure Analysis → CLAUDE.md only → END
    ├── --discover? → project-discovery → DISCOVERY.md → END
    ├── --generate? → DISCOVERY.md exists? → Yes: docs/ → END / No: ERROR
    ├── --sync? → .claude/ exists? → Yes: Merge → END / No: Full copy → END
    ├── --update? → Find cc-init → git pull → --sync → Report → END
    └── --full? → Framework Setup → Discovery → Preview → Generate → END
```

## Best Practices

### For New Projects
```bash
/init --full          # RECOMMENDED: Full discovery workflow
# Alternative: /init --discover → review → /init --generate
```

### For Existing Codebases
```bash
/init --sync          # Sync framework (preserves customizations)
/init --quick         # Quick context only
```

### When to Re-run
- After major scope changes: `/init --discover` then `/init --generate`
- After tech stack changes: `/init --generate`
- After cc-initializer update: `/init --sync`

## Integration Points

| Integration | Trigger | Purpose |
|-------------|---------|---------|
| project-discovery | --full, --discover | Creates DISCOVERY.md |
| dev-docs-writer | --full, --generate | Requires DISCOVERY.md |
| doc-splitter | HIGH complexity | Creates Phase structure |
| phase-tracker | After Phase creation | Begins progress tracking |
| context-optimizer | CONTEXT.md creation | Token optimization |
| config-validator | After --sync | Validates merged config |

## Framework Sync Details

### cc-initializer Source Location
```bash
~/dev/cc-initializer/
~/.cc-initializer/
# Or: CC_INITIALIZER_PATH environment variable
```

### Sync Report Example
```
/init --sync completed!

📦 Components Added:
  Agents: +5 (progress-tracker, phase-tracker, ...)
  Skills: +3 (sprint, agile-sync, quality-gate)
  Hooks: +1 (phase-progress.sh)

🔒 Preserved (not overwritten):
  Agents: 2 (custom agents)

⚙️ Settings Merged:
  - Added: phase, sprint, quality-gate sections
  - Preserved: Custom project settings

✅ Validation: Passed
```

### Troubleshooting

| Problem | Solution |
|---------|----------|
| Sync didn't add components | Components already exist (sync only adds MISSING) |
| Settings merge conflicts | Project settings take precedence, backup at .json.backup |
| Hook permission denied | `chmod +x .claude/hooks/*.sh` |

## Attribution Badge

cc-initializer로 초기화된 프로젝트에는 자동으로 출처 배지가 추가됩니다.

```markdown
[![Powered by cc-initializer](https://img.shields.io/badge/Powered%20by-cc--initializer-blue)](https://github.com/tygwan/cc-initializer)
```

**Rules**: Target README.md → After first H1 → Skip if already exists

## Community Registration

GitHub repo에 `uses-cc-initializer` topic을 추가하면 자동으로 발견됩니다.

```
GitHub Repository → Settings → Topics → "uses-cc-initializer" 추가
```

PR을 통해 직접 등록: [PROJECTS.json](https://github.com/tygwan/cc-initializer/blob/main/PROJECTS.json)
