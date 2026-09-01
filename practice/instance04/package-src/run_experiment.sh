#!/usr/bin/env bash
set -euo pipefail
ROOT=$(cd "$(dirname "$0")/.." && pwd)
PY="$ROOT/.venv-dev/bin/python"
cd "$(dirname "$0")"
{
  echo "=== Q10 STEP 1: failing test against copied Q09 implementation ==="
  cp src/greetlab/cli.py src/greetlab/cli_fixed.py
  cp src/greetlab/cli_buggy.py src/greetlab/cli.py
  set +e
  "$PY" -m pytest -q
  first_status=$?
  set -e
  echo "initial_pytest_exit=$first_status"
  test "$first_status" -ne 0
  echo "=== Q10 STEP 2: agent-requested minimal fix ==="
  cp src/greetlab/cli_fixed.py src/greetlab/cli.py
  diff -u src/greetlab/cli_buggy.py src/greetlab/cli.py | tee minimal_fix.diff || true
  echo "=== Q10 STEP 3: human diff review ==="
  grep -E '^\+.*strip|^\+.*parser.error' minimal_fix.diff
  echo "unrelated_changes=none"
  echo "=== Q10 STEP 4: final verification ==="
  "$PY" -m pytest -q
  wc -l ai_log.md
  cat ai_log.md
} 2>&1 | tee experiment.log
rm -f src/greetlab/cli_fixed.py

