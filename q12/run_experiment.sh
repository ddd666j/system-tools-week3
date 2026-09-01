#!/usr/bin/env bash
set -euo pipefail
ROOT=$(cd "$(dirname "$0")/.." && pwd)
PY="$ROOT/.venv-torch/bin/python"
cd "$(dirname "$0")"
{
  echo "=== Q12 STEP 1: environment and source ==="
  "$PY" -c 'import sys, torch; print(sys.version.split()[0]); print("torch=", torch.__version__); print("device=cpu")'
  nl -ba train.py
  echo "=== Q12 STEP 2: deterministic CPU training ==="
  "$PY" train.py | tee training_result.txt
  echo "=== Q12 STEP 3: result validation ==="
  "$PY" -c 'from pathlib import Path; values=dict(line.split("=") for line in Path("training_result.txt").read_text().splitlines()); loss=float(values["final_loss"]); w=float(values["weight"]); b=float(values["bias"]); assert loss < 0.001; assert abs(w-3) < 0.05; assert abs(b+1) < 0.05; print("loss_below_0.001=True"); print("parameters_learned=True")'
} 2>&1 | tee experiment.log

