#!/usr/bin/env bash
set -euo pipefail
ROOT=$(cd "$(dirname "$0")/../.." && pwd)
PY="$ROOT/.venv-dev/bin/python"
cd "$(dirname "$0")"
{
  echo "=== INSTANCE 05 STEP 1: reject vague issue ==="
  set +e
  "$PY" check_issue.py issue_bad.md
  bad_exit=$?
  set -e
  echo "bad_issue_exit=$bad_exit"
  test "$bad_exit" -eq 1
  echo "=== INSTANCE 05 STEP 2: verify executable issue ==="
  "$PY" check_issue.py issue_fixed.md
  echo "communication_quality_gate=passed"
} 2>&1 | tee experiment.log

