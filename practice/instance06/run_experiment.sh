#!/usr/bin/env bash
set -euo pipefail
ROOT=$(cd "$(dirname "$0")/../.." && pwd)
PY="$ROOT/.venv-torch/bin/python"
cd "$(dirname "$0")"
{
  echo "=== INSTANCE 06: deterministic PyTorch training ==="
  "$PY" -c 'import torch; print("torch=", torch.__version__); print("threads=", torch.get_num_threads())'
  "$PY" reproducible_training.py | tee training_comparison.txt
} 2>&1 | tee experiment.log

