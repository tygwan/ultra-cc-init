# Dev Doc System - Full Implementation Detail

> Loaded on-demand. Header: [../SKILL.md](../SKILL.md)

## 문서 유형별 가이드

### 1. Direction (개발 방향)

#### VISION.md - 프로젝트 비전
```markdown
# 프로젝트 비전

## 미션
{한 문장으로 프로젝트의 존재 이유}

## 핵심 가치
1. {가치 1}: {설명}
2. {가치 2}: {설명}

## 성공 지표 (KPI)
| 지표 | 목표 | 현재 | 상태 |
|------|------|------|------|
| {지표 1} | {목표값} | {현재값} | 🔄 |

## 비전 변경 이력
| 날짜 | 변경 내용 | 이유 |
|------|----------|------|
```

#### ROADMAP.md - 개발 로드맵
```markdown
# 개발 로드맵

## 현재 Phase: {Phase N} - {Phase 이름}

### Phase 1: {이름} ✅
- 기간: YYYY-MM-DD ~ YYYY-MM-DD
- 목표: {목표}
- 결과: {결과 요약}

### Phase 2: {이름} 🔄
- 진행률: `████████░░░░░░░░░░░░` 40%
```

#### DECISIONS.md - 아키텍처 결정 기록 (ADR)
```markdown
# 아키텍처 결정 기록 (ADR)

## ADR-001: {결정 제목}
- **날짜**: YYYY-MM-DD
- **상태**: 승인됨 | 대체됨 | 폐기됨

### 맥락
{이 결정이 필요한 배경}

### 결정
{내린 결정}

### 대안
1. {대안 1}: {장단점}

### 결과
{예상되는 결과 및 영향}
```

### 2. Status (현재 상황)

#### CURRENT.md
```markdown
# 현재 진행 상황

**마지막 업데이트**: YYYY-MM-DD HH:MM

## 이번 주 목표
- [ ] {목표 1}

## 진행 중인 작업
| 작업 | 담당 | 시작일 | 상태 | 블로커 |
|------|------|--------|------|--------|
| {작업} | {담당} | {날짜} | 🔄 | {없음} |

## 블로커/이슈
| 이슈 | 영향 | 해결책 | 상태 |
|------|------|--------|------|
```

#### CHANGELOG.md
```markdown
# 변경 이력

## [Unreleased]
### Added
### Changed
### Fixed
### Removed

## [1.0.0] - YYYY-MM-DD
```

### 3. Planning (앞으로의 계획)

#### BACKLOG.md
```markdown
# 백로그

## 우선순위: P0(크리티컬), P1(높음), P2(중간), P3(낮음)

### P0 - 크리티컬
| ID | 항목 | 예상 공수 | 의존성 |
|----|------|----------|--------|

### Ice Box (보류)
| ID | 항목 | 보류 이유 |
|----|------|----------|
```

#### NEXT-SPRINT.md
```markdown
# 다음 스프린트 계획

## 스프린트 정보
- **기간**: YYYY-MM-DD ~ YYYY-MM-DD
- **목표**: {스프린트 목표}

## 스프린트 범위
| 항목 | 우선순위 | 예상 공수 | 담당 |
|------|----------|----------|------|

## 리스크
| 리스크 | 확률 | 영향 | 대응책 |
|--------|------|------|--------|
```

### 4. Changes (중간 변경 사항)

#### SCOPE-CHANGES.md
```markdown
## SC-001: {변경 제목}
- **유형**: 추가 | 제거 | 수정

### 영향 분석
- **일정/비용/품질/리스크**: {영향}

### 승인
- [ ] PM 승인
- [ ] 기술 리드 승인
```

#### PIVOT-LOG.md
```markdown
## PV-001: {전환 제목}
- **전환 유형**: 기술 | 제품 | 비즈니스
- 이전 방향 → 새 방향
- 폐기되는 것 / 새로 필요한 것
- 교훈
```

### 5. Feedback (문제 및 피드백)

#### ISSUES.md
```markdown
### ISS-001: {이슈 제목} 🔴
- **심각도**: 크리티컬 | 높음 | 중간 | 낮음
- 증상 → 근본 원인 → 해결 방안 → 진행 상황
```

#### RETRO.md
```markdown
## 회고: {Phase/Sprint} #{번호}
### 잘한 것 (Keep) / 개선할 것 (Problem) / 시도할 것 (Try)
### 액션 아이템
| 액션 | 담당 | 기한 | 상태 |
```

#### LEARNINGS.md
```markdown
### LRN-001: {교훈 제목}
- **카테고리**: 아키텍처 | 코드 | 테스트 | 배포
- 상황 → 교훈 → 적용 방법
```

## 도구 조합 (Tool Combinations)

| 워크플로우 | 문서 | 도구 조합 |
|-----------|------|----------|
| 프로젝트 시작 | VISION, ROADMAP | `prd-writer` + `dev-doc-system` |
| 기능 기획 | PRD, BACKLOG | `prd-writer` |
| 기술 설계 | DECISIONS, tech-spec | `tech-spec-writer` |
| 개발 진행 | CURRENT, progress | `progress-tracker` |
| 스코프 변경 | SCOPE-CHANGES | `dev-doc-system` |
| 이슈 발생 | ISSUES | `dev-doc-system` + `git-troubleshooter` |
| 스프린트 완료 | RETRO, CHANGELOG | `dev-doc-system` + `commit-helper` |

### Hook 통합
```yaml
on_commit: update CURRENT.md + CHANGELOG.md
on_milestone: create RETRO.md + update ROADMAP.md
on_scope_change: create SCOPE-CHANGES entry + update BACKLOG.md
```

## 명령어

```bash
/dev-doc-system init [--category direction]   # 초기화
/dev-doc-system vision "설명"                   # 비전 문서
/dev-doc-system roadmap --phase 2 --status 40%  # 로드맵
/dev-doc-system decision "결정 제목"            # ADR 추가
/dev-doc-system current                         # 현재 상황
/dev-doc-system scope-change "변경 제목"        # 스코프 변경
/dev-doc-system retro --sprint 3                # 회고
/dev-doc-system learning "교훈 제목"            # 교훈 기록
/dev-doc-system status                          # 문서 상태 요약
```

## 자동화 워크플로우

| 주기 | 작업 |
|------|------|
| 매일 | CURRENT.md 갱신, ISSUES.md 체크, NEXT-SPRINT.md 진행률 |
| 매주 금요일 | CHANGELOG.md 주간 정리, ROADMAP.md 진행률, BACKLOG.md 우선순위 |
| 마일스톤 완료 | RETRO.md 생성, LEARNINGS.md 추가, ROADMAP.md 완료 표시 |

## Best Practices

### DO
- 결정할 때마다 DECISIONS.md에 기록
- 스코프 변경 시 SCOPE-CHANGES.md에 기록
- 문제 해결 후 LEARNINGS.md에 교훈 기록
- 마일스톤마다 RETRO.md 작성

### DON'T
- 결정 이유 없이 변경
- 스코프 변경을 기록 없이 진행
- 회고 없이 다음 단계 진행

## 관련 도구

| 도구 | 유형 | 용도 |
|------|------|------|
| `prd-writer` | Agent | PRD 작성 |
| `tech-spec-writer` | Agent | 기술 설계서 |
| `progress-tracker` | Agent | 진행상황 추적 |
| `doc-validator` | Agent | 문서 완성도 검증 |

## 참조 문서
- `references/document-templates.md`
- `references/workflow-diagrams.md`
- `references/integration-guide.md`
