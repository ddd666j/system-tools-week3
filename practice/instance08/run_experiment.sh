#!/usr/bin/env bash
set -euo pipefail
ROOT=$(cd "$(dirname "$0")/../.." && pwd); cd "$(dirname "$0")"
{ "$ROOT/.venv-torch/bin/python" eval_no_grad.py | tee evaluation_result.txt; } 2>&1 | tee experiment.log
