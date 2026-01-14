# FOSSiBOT F106 Pro missing configuration checklist

This checklist captures configuration gaps after parsing `real_fossibot` text assets
(`MT6768_Android_scatter.txt`, `fstab.mt6768`, `props.txt`, `getvar_all.txt`,
`lpdump_super.txt`, and `defconfig`).

## Missing items to extract
- [ ] Vendor and system init rc files (e.g. `vendor/etc/init/*.rc`, `init*.rc` in ramdisks).
- [ ] `ueventd*.rc` device permissions rules.
- [ ] Vendor fstab entries beyond `fstab.mt6768` (if present under `vendor/etc/`).
- [ ] VINTF manifests/compatibility XMLs in `vendor/etc/vintf/`.
- [ ] Permissions XMLs under `vendor/etc/permissions/`.
- [ ] SELinux policy locations (`vendor/etc/selinux`, precompiled sepolicy blobs).
- [ ] Audio, camera, NFC, and sensor configuration XMLs in `vendor/etc/`.

## Action
Proceed with image extraction (vendor, vendor_boot, boot, init_boot) to harvest the
missing configs and implement text-level overlays in the device/vendor trees.
