# Quality Gate - Full Implementation Detail

> Loaded on-demand. Header: [../SKILL.md](../SKILL.md)

## /quality-gate pre-commit

```bash
/quality-gate pre-commit [--fix] [--skip <check>]
```

| Check | Description | Blocking |
|-------|-------------|:--------:|
| `lint` | Code linting | Yes |
| `format` | Code formatting | Warning |
| `types` | Type checking | Yes |
| `secrets` | Secret detection | Yes |
| `size` | File size limits | Warning |

**Output Example:**
```
🔍 PRE-COMMIT QUALITY GATE
[1/5] Linting...         ✅ No lint errors
[2/5] Formatting...      ⚠️ 2 files need formatting → --fix
[3/5] Type Checking...   ✅ No type errors
[4/5] Secret Detection...✅ No secrets found
[5/5] File Size Check... ✅ All files under limit
━━━━━━━━━━━━━━━━━━━━━━━━━
Result: ⚠️ PASS WITH WARNINGS
```

## /quality-gate pre-merge

```bash
/quality-gate pre-merge [--pr <number>]
```

| Check | Description | Blocking |
|-------|-------------|:--------:|
| `tests` | All tests pass | Yes |
| `coverage` | Test coverage threshold | Warning |
| `review` | Code review approved | Yes |
| `conflicts` | No merge conflicts | Yes |
| `docs` | Documentation updated | Warning |
| `changelog` | CHANGELOG updated | Warning |

**Output Example:**
```
🔍 PRE-MERGE QUALITY GATE
PR: #42 - Add user authentication
[1/6] Tests...       ✅ 127 tests passed
[2/6] Coverage...    ⚠️ 72% (threshold: 80%)
[3/6] Code Review... ✅ Approved
[4/6] Conflicts...   ✅ No conflicts
[5/6] Documentation..⚠️ README.md not updated
[6/6] Changelog...   ✅ Updated
━━━━━━━━━━━━━━━━━━━━━━━━━
Result: ⚠️ PASS WITH WARNINGS
Recommend: /agile-sync before merge
```

## /quality-gate pre-release

```bash
/quality-gate pre-release --version <semver>
```

| Check | Description | Blocking |
|-------|-------------|:--------:|
| `tests` | Full test suite | Yes |
| `coverage` | Coverage threshold | Yes |
| `lint` | Zero lint errors | Yes |
| `security` | Security scan | Yes |
| `docs` | Documentation complete | Yes |
| `changelog` | Version in changelog | Yes |
| `version` | Version consistency | Yes |
| `dependencies` | No vulnerable deps | Warning |
| `build` | Build succeeds | Yes |

**Output Example:**
```
🔍 PRE-RELEASE QUALITY GATE
Version: v1.2.0
[1/9] Tests...        ✅ 342 passed
[2/9] Coverage...     ✅ 84% (threshold: 80%)
[3/9] Lint...         ✅ Zero errors
[4/9] Security...     ✅ No vulnerabilities
[5/9] Docs...         ✅ All present
[6/9] Changelog...    ✅ v1.2.0 entry found
[7/9] Version...      ✅ Consistent across files
[8/9] Dependencies... ⚠️ 1 low severity
[9/9] Build...        ✅ Successful
━━━━━━━━━━━━━━━━━━━━━━━━━
Result: ✅ RELEASE READY
Next: git tag v1.2.0 → git push → /quality-gate post-release
```

## /quality-gate post-release

```bash
/quality-gate post-release --version <semver>
```

| Action | Description |
|--------|-------------|
| Archive sprint | Close active sprint |
| Update docs | Update version references |
| Velocity | Record release velocity |
| Notify | Generate release notes |
| Retro prompt | Suggest retrospective |

## /quality-gate check

```bash
/quality-gate check [--all] [--fix]
```

Auto-detects: Uncommitted → pre-commit / Open PR → pre-merge / Release branch → pre-release

## Configuration

```json
{
  "quality-gate": {
    "pre-commit": { "enabled": true, "checks": ["lint", "format", "types", "secrets"], "auto-fix": false },
    "pre-merge": { "enabled": true, "coverage-threshold": 80, "require-review": true },
    "pre-release": { "enabled": true, "coverage-threshold": 80, "security-scan": true },
    "post-release": { "auto-archive-sprint": true, "generate-release-notes": true }
  }
}
```

### Custom Checks
```yaml
# .claude/quality-checks.yml
custom-checks:
  pre-commit:
    - name: "API Schema"
      command: "npm run validate-schema"
      blocking: true
  pre-release:
    - name: "Bundle Size"
      command: "npm run analyze-bundle"
      threshold: "5MB"
```

## Integration

```bash
# Git hooks
.git/hooks/pre-commit: /quality-gate pre-commit --fail-on-warning

# GitHub Actions
- name: Quality Gate
  run: /quality-gate pre-merge && /quality-gate pre-release --version ${{ github.ref_name }}

# With other skills
/quality-gate pre-merge && /agile-sync
/quality-gate pre-release --version v1.2.0 → git tag → /quality-gate post-release
```

## Check Reference

### By Language
| Language | Lint | Test | Security |
|----------|------|------|----------|
| JS/TS | `eslint .` | `npm test -- --coverage` | `npm audit` |
| Python | `ruff check .` | `pytest --cov` | `safety` |
| Go | `golint ./...` | `go test -cover ./...` | `trivy` |
| Rust | `cargo clippy` | `cargo test` | `cargo audit` |
| C# | `dotnet format --verify-no-changes` | `dotnet test` | - |

## Troubleshooting

| Problem | Solution |
|---------|----------|
| Check failed but code correct | `--skip lint --reason "false positive"` |
| Coverage dropped | `--coverage-details` for uncovered lines |
| Security scan timeout | `--timeout 600` |

## Best Practices
- Run pre-commit before every commit
- Require pre-merge for all PRs
- Run full pre-release before tags
- Document skipped checks with reason
- Fix warnings before they become blockers
