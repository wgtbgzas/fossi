# FOSSiBOT F106 Pro extracted configuration summary

## Sources
- `real_fossibot/vendor.img` (ext4; extracted with `debugfs rdump`).
- `real_fossibot/vendor_boot.img` (unpacked with `unpack_bootimg.py`).
- `real_fossibot/boot.img` (unpacked with `unpack_bootimg.py`).
- `real_fossibot/init_boot.img` (all-zero image; no content).

## Key discoveries
- `vendor/etc/fstab.mt6768` and `vendor/etc/fstab.enableswap` (swap on zram).
- `system/etc/ueventd.rc` inside vendor_boot ramdisk.
- Vendor init rc files such as `vendor/etc/init/hw/init.fingerprint.rc` and `vendor/etc/init/hw/init.stnfc.rc`.
- Permissions XMLs under `vendor/etc/permissions/` (NFC, fingerprint, sensors, camera, etc.).
- VINTF manifests under `vendor/etc/vintf/`.

## Implemented overlays
- Updated `device/motorola/mt6768-common/rootdir/etc/fstab.mt6768` to match the extracted
  fstab, including the `resize` mount flag on `/data`.
- Added `device/motorola/mt6768-common/rootdir/etc/fstab.enableswap` derived from
  `vendor/etc/fstab.enableswap`.
- Added `device/motorola/mt6768-common/rootdir/etc/ueventd.mt6768.rc` based on the
  vendor_boot `system/etc/ueventd.rc`.
- Added vendor property overlays sourced from `vendor/build.prop` and `props.txt`.

## Notes
This summary tracks text-level configs only; full binary blobs remain in `out/extract/`.
