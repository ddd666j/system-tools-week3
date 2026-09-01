#!/usr/bin/env bash
set -euo pipefail
R=$(cd "$(dirname "$0")/../.."&&pwd);cd "$(dirname "$0")";"$R/.venv-torch/bin/python" learning_rate.py|tee experiment.log
