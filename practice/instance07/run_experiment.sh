#!/usr/bin/env bash
set -euo pipefail
ROOT=$(cd "$(dirname "$0")/../.." && pwd); cd "$(dirname "$0")"
{ "$ROOT/.venv-torch/bin/python" gradient_accumulation.py | tee gradient_result.txt; } 2>&1 | tee experiment.log
