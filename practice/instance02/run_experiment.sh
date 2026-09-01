#!/usr/bin/env bash
set -euo pipefail
ROOT=$(cd "$(dirname "$0")/../.." && pwd)
cd "$(dirname "$0")"
{
  echo "=== INSTANCE 02: real console exit-code baseline ==="
  "$ROOT/.venv-dev/bin/python" test_console_exit_codes.py
  echo "verification=passed"
} 2>&1 | tee experiment.log

