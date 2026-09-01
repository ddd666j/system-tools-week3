#!/usr/bin/env bash
set -euo pipefail
cd "$(dirname "$0")"
{
  echo "=== Q11: executable collaboration material ==="
  cat communication.md
  echo
  echo "=== VALIDATION ==="
  chars=$(python3 -c 'import io; print(len(io.open("communication.md", encoding="utf-8").read()))')
  echo "character_count=$chars"
  test "$chars" -le 400
  grep -q '环境：' communication.md
  grep -q '复现：' communication.md
  grep -q '期望：' communication.md
  grep -q '实际：' communication.md
  grep -q '待确认' communication.md
  grep -q 'Blocking' communication.md
  echo "required_sections=passed"
  echo "length_limit=passed"
} 2>&1 | tee experiment.log

