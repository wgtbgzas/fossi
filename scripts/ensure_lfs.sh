#!/usr/bin/env bash
set -euo pipefail

# Usage:
#   scripts/ensure_lfs.sh [paths...]
# If no paths given, auto-detect your repo layout (prefers "real_fossibot/").

is_lfs_pointer() {
  local f="$1"
  head -n 1 "$f" 2>/dev/null | grep -q "git-lfs.github.com/spec"
}

# If no args, pick the images in your "real_fossibot/" folder (handles the space)
if [ "$#" -eq 0 ]; then
  if [ -d "real_fossibot" ]; then
    set -- \
      "real_fossibot/vendor_boot.img" \
      "real_fossibot/boot.img" \
      "real_fossibot/init_boot.img" \
      "real_fossibot/dtbo.img" \
      "real_fossibot/vendor.img"
  else
    mapfile -t files < <(find . -maxdepth 3 -type f -name "*.img" 2>/dev/null | sort)
    set -- "${files[@]}"
  fi
fi

need_pull=0
for f in "$@"; do
  [ -f "$f" ] || continue
  if is_lfs_pointer "$f"; then
    echo "Pointer: $f"
    need_pull=1
  fi
done

if [ "$need_pull" -eq 1 ]; then
  echo "Fetching Git LFS objects..."
  git lfs install --local --force || true
  git lfs pull
  git lfs checkout
fi

check_min() {
  local f="$1" min="$2"
  if [ ! -f "$f" ]; then
    echo "WARN: missing: $f"
    return 0
  fi
  if is_lfs_pointer "$f"; then
    echo "ERROR: still LFS pointer: $f"
    return 1
  fi
  local sz
  sz="$(wc -c < "$f" | tr -d ' ')"
  if [ "$sz" -lt "$min" ]; then
    echo "ERROR: too small ($sz < $min): $f"
    return 1
  fi
  echo "OK: $f ($sz bytes)"
}

fail=0
check_min "real_fossibot/vendor_boot.img" 1000000 || fail=1
check_min "real_fossibot/dtbo.img"        100000  || fail=1

if [ "$fail" -ne 0 ]; then
  echo "LFS blobs still not real"
  exit 2
fi

echo "OK: LFS blobs present."
