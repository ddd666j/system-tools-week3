#!/usr/bin/env bash
set -euo pipefail
cd "$(dirname "$0")"
if command -v tectonic >/dev/null; then tectonic "第三周实验报告_杜铭昊_25020007021.tex"; else /home/dmh/.local/bin/tectonic "第三周实验报告_杜铭昊_25020007021.tex"; fi
