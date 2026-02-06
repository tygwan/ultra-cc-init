---
name: ccusage
description: Claude Code와 Codex CLI의 토큰 사용량 및 비용 리포트를 조회하는 스킬. "ccusage", "토큰 사용량", "usage report", "codex usage", "claude usage", "비용 리포트", "token usage", "cost report" 키워드에 반응.
---

# ccusage Skill

Claude Code(`ccusage`)와 Codex(`@ccusage/codex`) 토큰/비용 리포트를 수동 실행합니다.

## Usage

```bash
/ccusage [command] [options]
```

### Commands

| Command | Description |
|---------|-------------|
| `today` | 오늘 사용량 요약 (기본값) |
| `daily` | 일별 리포트 |
| `monthly` | 월별 리포트 |
| `session` | 세션별 리포트 |
| `codex <scope>` | Codex 전용 리포트 |
| `claude <scope>` | Claude Code 전용 리포트 |

### Options

| Option | Description |
|--------|-------------|
| `--since YYYYMMDD` | 시작 날짜 |
| `--until YYYYMMDD` | 종료 날짜 |
| `--offline` | 오프라인 모드 (캐시된 가격 데이터 사용) |
| `--json` | JSON 출력 |

## Examples

```bash
# 오늘 요약 (Claude + Codex 합산)
/ccusage today

# 일별 범위 리포트
/ccusage daily --since 20260201 --until 20260206 --offline

# 월별 요약
/ccusage monthly --offline

# 세션별 요약
/ccusage session --offline

# Codex 전용
/ccusage codex daily --json --since 20260201

# Claude Code 전용
/ccusage claude daily --json --since 20260201
```

## Output

```
ccusage manual summary (daily)
Source         Total Tokens    Cost (USD)
------------  --------------  ----------
Codex               1,234,567   $12.3456
Claude              2,345,678   $23.4567
Combined            3,580,245   $35.8023
```

## Implementation

Execute the script:

```bash
bash .claude/skills/ccusage/scripts/ccusage-manual.sh [command] [options]
```

## Requirements

- Node.js (`npx`, `node`)
- `ccusage@latest` (npm)
- `@ccusage/codex@latest` (npm)

## Data Source

- **Claude Code**: `~/.claude/projects/` 내 JSONL 세션 파일
- **Codex**: Codex CLI 로컬 로그

## Related

- **Skill**: `analytics` - 내부 Tool/Agent 사용 통계
- **Agent**: `analytics-reporter` - 상세 분석 및 인사이트
