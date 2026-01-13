# Android device tree for FOSSiBOT F106 Pro (F106_Pro)

```
#
# Copyright (C) 2025 The LineageOS Project
#
# SPDX-License-Identifier: Apache-2.0
#
```

## Firmware image extraction

The firmware images in `real fossibot/` can be unpacked with the helper script below. It extracts
the kernel/ramdisk from `boot.img`, the DTB overlays from `dtbo.img`, and skips extraction when
`init_boot.img` is empty. `vendor_boot.img` must be replaced with the real image (the repo contains
a Git LFS pointer). The extracted payloads are written to `real fossibot/extracted` by default.

```bash
python3 device/motorola/fogorow/tools/extract_f106_images.py
```
