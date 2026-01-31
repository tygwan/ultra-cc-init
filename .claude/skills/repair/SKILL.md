---
name: repair
description: cc-initializer 자동 복구 및 문제 해결. Hook 실패, 문서 손상, 설정 오류를 진단하고 수정합니다.
---

# /repair - System Recovery

## Usage

```bash
/repair [mode] [options]
```

| Mode | Description |
|------|-------------|
| `--diagnose` | 문제 진단만 수행 (기본) |
| `--auto` | 자동 복구 실행 |
| `--hooks` | Hook 관련 문제만 수정 |
| `--docs` | 문서 구조만 수정 |
| `--config` | 설정 파일만 수정 |
| `--full` | 전체 복구 (모든 항목) |
| `--report` | 복구 보고서 생성 |

## Workflow

```
1. 시스템 진단 → 2. 문제 분류 (CRITICAL/WARNING/INFO) → 3. 자동 복구 → 4. 수동 복구 안내 → 5. 보고서
```

## Diagnosable Issues

### Hook Issues

| Problem | Description | Auto-Fix |
|---------|-------------|----------|
| `permission_denied` | 실행 권한 없음 | `chmod +x` |
| `file_missing` | Hook 파일 누락 | 기본 템플릿 복원 |
| `syntax_error` | 스크립트 문법 오류 | Manual |
| `dependency_missing` | 의존성 누락 | Manual |

### Document Issues

| Problem | Description | Auto-Fix |
|---------|-------------|----------|
| `missing_directory` | docs/, phases/, sprints/ 누락 | `mkdir -p` |
| `missing_required` | PROGRESS.md, CONTEXT.md 누락 | 기본 문서 생성 |
| `broken_links` | 내부 링크 손상 | 링크 수정 |
| `invalid_format` | 마크다운 형식 오류 | Manual |

### Configuration Issues

| Problem | Description | Auto-Fix |
|---------|-------------|----------|
| `invalid_json` | settings.json 문법 오류 | 기본값 복원 |
| `missing_section` | 필수 섹션 누락 | 누락 섹션 추가 |
| `invalid_reference` | 존재하지 않는 파일 참조 | Manual |
| `deprecated_setting` | 지원 종료 설정 | 설정 마이그레이션 |

## Quick Commands

| Task | Command |
|------|---------|
| Hook 권한 일괄 수정 | `/repair --hooks` |
| 문서 구조 복구 | `/repair --docs` |
| 설정 검증 및 수정 | `/repair --config` |
| 전체 진단 + 자동 복구 | `/repair --full` |
| 진단만 수행 | `/repair --diagnose` |
| 복구 후 검증 | `/repair --auto && /validate --full` |

## Integration

| Target | Trigger | Action |
|--------|---------|--------|
| `/validate` | validate 실패 시 | `/repair --auto` → `/validate --full` |
| Error Recovery Hook | Hook 실패 시 | `auto_recover_on_hook_failure: true` |
| `quality-gate` | Pre-commit 실패 시 | `quality-gate pre-commit \|\| /repair --auto` |

## Configuration

```json
{
  "recovery": {
    "enabled": true,
    "auto_recover_on_hook_failure": true,
    "max_retry_count": 3,
    "log_retention_days": 7,
    "critical_hooks": ["pre-tool-use-safety.sh"],
    "auto_fixable": { "hook_permissions": true, "missing_directories": true, "log_rotation": true },
    "manual_required": { "missing_docs": ["PROGRESS.md", "CONTEXT.md"], "config_validation": true }
  }
}
```

## Error Codes

| Code | Meaning |
|------|---------|
| 0 | All repairs successful |
| 1 | Some repairs needed manual action |
| 2 | Critical errors (repair failed) |
| 3 | System in unrecoverable state |

## Related

| Command | Purpose |
|---------|---------|
| `/validate` | System validation |
| `/init` | Initialize/restore configuration |
| `/agile-sync` | Sync documentation |
