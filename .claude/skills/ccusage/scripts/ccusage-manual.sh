#!/usr/bin/env bash

set -euo pipefail

SCRIPT_NAME=$(basename "$0")

usage() {
  cat <<'EOF'
Manual ccusage runner (no hooks)

Usage:
  ccusage-manual.sh today [common-args...]
  ccusage-manual.sh daily [common-args...]
  ccusage-manual.sh monthly [common-args...]
  ccusage-manual.sh session [common-args...]
  ccusage-manual.sh codex <daily|monthly|session> [args...]
  ccusage-manual.sh claude <daily|monthly|weekly|session|blocks|statusline> [args...]

Examples:
  ccusage-manual.sh today --offline
  ccusage-manual.sh daily --since 20260201 --until 20260206 --offline
  ccusage-manual.sh codex session --json --since 20260201
  ccusage-manual.sh claude daily --json --since 20260201
EOF
}

require_bin() {
  local bin="$1"
  if ! command -v "$bin" >/dev/null 2>&1; then
    echo "[${SCRIPT_NAME}] missing required binary: ${bin}" >&2
    exit 1
  fi
}

run_codex() {
  npx -y @ccusage/codex@latest "$@"
}

run_claude() {
  npx -y ccusage@latest "$@"
}

combined_report() {
  local scope="$1"
  shift

  local codex_json
  local claude_json
  codex_json=$(mktemp)
  claude_json=$(mktemp)

  run_codex "$scope" --json "$@" >"$codex_json"
  run_claude "$scope" --json "$@" >"$claude_json"

  node - "$codex_json" "$claude_json" "$scope" <<'NODE'
const fs = require("node:fs");

const [codexPath, claudePath, scope] = process.argv.slice(2);

function loadJson(path) {
  try {
    return JSON.parse(fs.readFileSync(path, "utf8"));
  } catch {
    return {};
  }
}

function n(v) {
  return Number.isFinite(v) ? v : 0;
}

function parseCodex(obj) {
  const t = (obj && obj.totals) || {};
  return {
    totalTokens: n(t.totalTokens),
    costUSD: n(t.costUSD),
  };
}

function parseClaude(obj) {
  const t = (obj && obj.totals) || {};
  return {
    totalTokens: n(t.totalTokens),
    costUSD: n(t.totalCost),
  };
}

function fmtInt(v) {
  return Math.round(v).toLocaleString("en-US");
}

function fmtCost(v) {
  return `$${v.toFixed(4)}`;
}

function row(label, totalTokens, costUSD) {
  const col1 = label.padEnd(12, " ");
  const col2 = fmtInt(totalTokens).padStart(16, " ");
  const col3 = fmtCost(costUSD).padStart(12, " ");
  return `${col1} ${col2} ${col3}`;
}

const codex = parseCodex(loadJson(codexPath));
const claude = parseClaude(loadJson(claudePath));

const totalTokens = codex.totalTokens + claude.totalTokens;
const totalCost = codex.costUSD + claude.costUSD;

console.log(`\nccusage manual summary (${scope})`);
console.log("Source         Total Tokens    Cost (USD)");
console.log("------------  --------------  ----------");
console.log(row("Codex", codex.totalTokens, codex.costUSD));
console.log(row("Claude", claude.totalTokens, claude.costUSD));
console.log(row("Combined", totalTokens, totalCost));
NODE

  rm -f "$codex_json" "$claude_json"
}

main() {
  require_bin npx
  require_bin node

  local command="${1:-today}"
  shift || true

  case "$command" in
    -h|--help|help)
      usage
      ;;
    today)
      local today
      today=$(date +%Y%m%d)
      combined_report daily --since "$today" "$@"
      ;;
    daily|monthly|session)
      combined_report "$command" "$@"
      ;;
    codex)
      if [[ $# -lt 1 ]]; then
        echo "[${SCRIPT_NAME}] missing codex subcommand" >&2
        usage
        exit 1
      fi
      run_codex "$@"
      ;;
    claude)
      if [[ $# -lt 1 ]]; then
        echo "[${SCRIPT_NAME}] missing claude subcommand" >&2
        usage
        exit 1
      fi
      run_claude "$@"
      ;;
    *)
      echo "[${SCRIPT_NAME}] unknown command: ${command}" >&2
      usage
      exit 1
      ;;
  esac
}

main "$@"
