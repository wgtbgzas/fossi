# F106 Pro vendor prebuilt extraction mapping

This document records where the vendor blobs and configs originate so the F106 Pro
bring-up can be reproduced.

## Sources
- Primary extraction input: `real_fossibot/vendor.img` for vendor filesystem blobs.
- Supplementary metadata: `real_fossibot/vendor_boot.img`, `real_fossibot/boot.img`, and
  `real_fossibot/init_boot.img` for ramdisk init scripts and early-boot configs.

## Mapping notes
- `vendor/etc/init/*.rc` entries are sourced from `real_fossibot/vendor.img` and should be
  synced into `vendor/motorola/fogorow/proprietary/vendor/etc/init/` via the extract script.
- `vendor/etc/permissions/*.xml`, `vendor/etc/vintf/*.xml`, and `vendor/etc/manifest/*.xml`
  are pulled from the same vendor image and recorded in `proprietary-files.txt`.
- Audio, camera, NFC, and firmware binaries are expected under
  `vendor/motorola/fogorow/proprietary/vendor/etc/` and `vendor/motorola/fogorow/proprietary/vendor/firmware/`.

## Next steps
Ensure the extraction scripts reference the above images when regenerating proprietary file lists.
