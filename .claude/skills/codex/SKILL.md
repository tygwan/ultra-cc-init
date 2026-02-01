---
name: codex
description: Use when the user asks to run Codex CLI (codex exec, codex resume) or references OpenAI Codex for code analysis, refactoring, or automated editing. "codex", "코덱스", "codex 실행", "codex exec", "코드 검증", "AI 리뷰" 키워드에 반응.
---

# Codex CLI Skill

Codex CLI를 통한 코드 분석, 리팩토링, 자동 편집 실행.

## Available Models

| Model | Description | Use Case |
|-------|-------------|----------|
| `gpt-5.2-codex` | 최신 에이전틱 코딩 모델 (기본값) | 일반 코딩, 리팩토링, 분석 |
| `gpt-5.1-codex-mini` | 경량 비용 효율 모델 | 빠른 리뷰, 간단한 작업 |
| `gpt-5.1-codex-max` | 확장 에이전틱 코딩 모델 | 대규모 리팩토링, 장시간 작업 |

## Running a Task

| Step | Action |
|------|--------|
| 1 | AskUserQuestion: model (`gpt-5.2-codex` (Recommended), `gpt-5.1-codex-mini`, `gpt-5.1-codex-max`) |
| 2 | AskUserQuestion: reasoning effort (`low`, `medium`, `high`) |
| 3 | Select sandbox mode (default: `read-only`) |
| 4 | Assemble and run command |
| 5 | Capture output, summarize for user |

## Command Flags

| Flag | Purpose |
|------|---------|
| `-m, --model <MODEL>` | Model selection |
| `--config model_reasoning_effort="<level>"` | Reasoning effort |
| `--sandbox <mode>` | Sandbox mode |
| `--full-auto` | Full automation |
| `-C, --cd <DIR>` | Working directory |
| `--skip-git-repo-check` | Skip git check |

## Sandbox Modes

| Use Case | Mode | Flags |
|----------|------|-------|
| Read-only review | `read-only` | `--sandbox read-only` |
| Apply local edits | `workspace-write` | `--sandbox workspace-write --full-auto` |
| Network/broad access | `danger-full-access` | `--sandbox danger-full-access --full-auto` |
| Resume session | Inherited | `echo "prompt" \| codex exec resume --last` |

> **Resume**: Cannot specify flags — inherits all from original session.

## Follow-Up

- After every `codex` command → `AskUserQuestion` for next steps
- Resume: `echo "new prompt" | codex exec resume --last`
- Restate model/effort/sandbox when proposing follow-up

## Error Handling

| Situation | Action |
|-----------|--------|
| Non-zero exit | Stop, report, ask direction |
| High-impact flags | AskUserQuestion for permission first |
| Warnings/partial results | Summarize, ask how to adjust |
