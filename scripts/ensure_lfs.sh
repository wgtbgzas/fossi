#!/usr/bin/env bash
set -euo pipefail
if grep -q "git-lfs.github.com/spec" vendor_boot.img 2>/dev/null; then
  echo "LFS pointer detected. Fetching LFS objects..."
  git lfs install --local || true
  git lfs pull
  git lfs checkout
fi
test "$(wc -c < vendor_boot.img)" -gt 1000000 || { echo "vendor_boot.img still not real"; exit 1; }
echo "OK: LFS blobs present."

