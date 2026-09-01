#!/usr/bin/env bash
set -euo pipefail
ROOT=$(cd "$(dirname "$0")/../.." && pwd)
PY="$ROOT/.venv-dev/bin/python"
SOURCE="$ROOT/q09"
cd "$(dirname "$0")"
rm -rf build_a build_b
mkdir build_a build_b
{
  echo "=== INSTANCE 03: reproducible wheel build ==="
  echo "SOURCE_DATE_EPOCH=1700000000"
  (
    cd "$SOURCE"
    rm -rf build dist-repro src/*.egg-info
    SOURCE_DATE_EPOCH=1700000000 "$PY" -m build --wheel --no-isolation --outdir dist-repro
  )
  cp "$SOURCE"/dist-repro/*.whl build_a/
  sleep 2
  (
    cd "$SOURCE"
    rm -rf build dist-repro src/*.egg-info
    SOURCE_DATE_EPOCH=1700000000 "$PY" -m build --wheel --no-isolation --outdir dist-repro
  )
  cp "$SOURCE"/dist-repro/*.whl build_b/
  echo "=== SHA-256 COMPARISON ==="
  sha256sum build_a/*.whl build_b/*.whl | tee hashes.txt
  hash_a=$(sha256sum build_a/*.whl | awk '{print $1}')
  hash_b=$(sha256sum build_b/*.whl | awk '{print $1}')
  test "$hash_a" = "$hash_b"
  cmp build_a/*.whl build_b/*.whl
  echo "byte_identical=True"
  echo "reproducible_build=passed"
} 2>&1 | tee experiment.log

