---
name: dev-doc-system
description: 개발 문서 통합 관리 시스템. 개발 방향, 진행 상황, 계획, 변경 사항, 피드백을 체계적으로 기록하고 관리. "문서 시스템", "개발 기록", "방향 설정", "회고", "변경 이력" 키워드에 반응.
---

# Dev Doc System - 개발 문서 통합 관리 시스템

프로젝트의 개발 방향성, 진행 상황, 변경 사항, 피드백을 체계적으로 기록하고 일관성을 유지하는 통합 문서 관리 시스템입니다.

## 핵심 가치

| 가치 | 설명 |
|------|------|
| 일관성 | 개발 방향과 결정 사항을 기록하여 방향성 유지 |
| 추적성 | 모든 변경과 결정의 이유를 기록하여 맥락 보존 |
| 투명성 | 현재 상황과 계획을 명확히 공유 |
| 학습 | 문제와 피드백을 기록하여 반복 실수 방지 |

## 문서 구조

```
docs/
├── direction/     # 개발 방향 (VISION, ROADMAP, DECISIONS)
├── status/        # 현재 상황 (CURRENT, CHANGELOG)
├── planning/      # 계획 (BACKLOG, NEXT-SPRINT)
├── changes/       # 변경 (SCOPE-CHANGES, PIVOT-LOG)
├── feedback/      # 피드백 (ISSUES, RETRO, LEARNINGS)
├── prd/           # PRD 문서
├── tech-specs/    # 기술 설계서
└── progress/      # 진행상황 체크
```

## 주요 명령어

| Command | Purpose |
|---------|---------|
| `/dev-doc-system init` | 전체 문서 구조 초기화 |
| `/dev-doc-system vision` | 비전 문서 작성 |
| `/dev-doc-system roadmap` | 로드맵 업데이트 |
| `/dev-doc-system decision` | ADR 기록 추가 |
| `/dev-doc-system current` | 현재 상황 업데이트 |
| `/dev-doc-system retro` | 회고 생성 |
| `/dev-doc-system status` | 문서 상태 요약 |

## 관련 도구

| 도구 | 용도 |
|------|------|
| `prd-writer` | PRD 작성 |
| `tech-spec-writer` | 기술 설계서 |
| `progress-tracker` | 진행상황 추적 |
| `doc-validator` | 문서 완성도 검증 |

---

> **Full implementation**: Load [references/DETAIL.md](references/DETAIL.md) for document type templates, tool combinations, automation workflows, and best practices.

## 참조 문서
- `references/document-templates.md`
- `references/workflow-diagrams.md`
- `references/integration-guide.md`
