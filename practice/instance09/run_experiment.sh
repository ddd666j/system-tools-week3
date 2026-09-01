#!/usr/bin/env bash
set -euo pipefail
R=$(cd "$(dirname "$0")/../.."&&pwd);cd "$(dirname "$0")";"$R/.venv-dev/bin/python" verify_record.py|tee experiment.log
