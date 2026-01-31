---
name: prompt-enhancer
description: Enhance user prompts by analyzing project context (code structure, dependencies, conventions, existing patterns). Use when users provide brief development requests that would benefit from project-specific context to generate more accurate, contextually-aware prompts.
---

# Prompt Enhancer

Transform brief development requests into clear, detailed requirements by analyzing project context. Present enhanced requirements to the user for confirmation before implementation.

## When to Use

- User provides a brief request like "로그인 기능 만들어줘", "API 추가해줘"
- Request lacks specific implementation details
- Task requires understanding project architecture

## Core Workflow

| Step | Action |
|------|--------|
| 1. Analyze | Project structure, tech stack, patterns, conventions |
| 2. Extract | Feature type, scope, dependencies |
| 3. Build | Structured requirements with project context |
| 4. Present | Show to user for confirmation before implementing |

### Output Format
```markdown
# [기능명] 구현 요구사항

## 📋 프로젝트 컨텍스트
- Framework / Architecture / State / Libraries

## 🎯 구현 범위
- 주요 기능 목록 + 파일 구조

## 📝 상세 요구사항
- 레이어별 구현 내용 + 기존 패턴 참조

## ✅ 성공 기준
## 🔍 확인 사항
```

### Critical: Do NOT implement until user confirms.

## Supported Stacks

| Stack | Detect | Key Context |
|-------|--------|------------|
| Flutter | pubspec.yaml | State mgmt, Architecture, Navigation |
| Next.js/React | package.json | Router, State, Styling, TypeScript |
| Python | requirements.txt | Framework, ORM, Auth, API docs |

---

> **Full implementation**: Load [references/DETAIL.md](references/DETAIL.md) for stack-specific analysis patterns, full example enhancement, and tips.

## Reference Files
- references/enhancement-patterns.md
- references/framework-guides.md
