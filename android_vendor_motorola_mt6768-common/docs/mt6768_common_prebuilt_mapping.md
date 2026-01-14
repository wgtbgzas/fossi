# MT6768 common prebuilt extraction mapping

This document records where common MT6768 blobs and configs originate for the F106 Pro.

## Sources
- Primary extraction input: `real_fossibot/vendor.img` for common vendor blobs.
- Supplemental inputs: `real_fossibot/vendor_boot.img`, `real_fossibot/boot.img`, and
  `real_fossibot/init_boot.img` for ramdisk and early-boot configs shared across MT6768 devices.

## Mapping notes
- Shared HAL binaries and init rc files are extracted into
  `vendor/motorola/mt6768-common/proprietary/vendor/`.
- VINTF manifests and permissions XMLs are pulled from vendor and mapped into
  `vendor/motorola/mt6768-common/proprietary/vendor/etc/` entries.

## Next steps
Use the MT6768 common extraction scripts when regenerating `proprietary-files.txt`.
