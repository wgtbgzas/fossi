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
# F106 Pro extracted config summary

Source directory: real_fossibot/.

| File | Size (bytes) | SHA-256 |
| --- | ---: | --- |
| MT6768_Android_scatter.txt | 20848 | 902fb3df0775970ca6e856e838ad97af04e8bac6e398d41f7c495e472f1720f4 |
| boot.img | 33554432 | e4bf3e95eff705e8142fadb76c88a987484847fb80450a0b1f9fd990f8171f6f |
| ce92639c-0592-4e49-85d5-0add084ac777.pdf | 119120 | ed39534a70410cc633b8a9b1d1c7bf9fd0c609acfcc2a56b5602b7dfd4fb15c3 |
| defconfig | 181406 | 59b3b3bc1ad1b87718c727796d454455d720a8a56462bc228945bd3f45936c4d |
| dtbo.img | 8388608 | 8cd9ad18ac4281771852d0e6a973f96c102d364a0d763d97921046fed1e28a03 |
| fossibotf106pro.html | 35880 | 91e6550f1ee6b762a1b2335745245bbab443730f47ac5413bfec220763ad8407 |
| fstab.mt6768 | 3796 | 24552999a91e3af83b2b1927719d7c1bcd358be45b6cb2ce2fc93f4cdbc8913c |
| getvar_all.txt | 3242 | 556f31c9ca769d06195fd9afe140a989b58ea485eed6bb19651c9eb8f0f68c02 |
| init_boot.img | 8388608 | 2daeb1f36095b44b318410b3f4e8b5d989dcc7bb023d1426c492dab0a3053e74 |
| lpdump_super.txt | 1906 | 20067d1622a27d66d960f9bcb7272e85cc4c4d1a561ddac600e1e331e8fbd620 |
| odm_selinux.tar | 1024 | 5f70bf18a086007016e948b04aed3b82103a36bea41755b6cddfaf10ace3c6ef |
| props.txt | 51137 | d20519e436b2f0264ba7c28804af568e78023ee5d3589f5b91045a2735172210 |
| selinux.policy | 1167091 | e3fbb3a635415234651a9639334161eeea4ac6756c445a634c583d3abbbae1b7 |
| system_selinux.tar | 3245056 | 2507b461decf01cfa05feb82875b48aabc754f3cfe0995fbeacb773fa6e68315 |
| vendor.img | 502185984 | 9a515349209ba9f9824b73312c7b37df71aa0afb79f721c224ecd931567f4f78 |
| vendor_boot.img | 67108864 | 45245069a03053924f93b8f61c41ecd6fb815b633283ae2a8e2254aed4d942da |
| vendor_selinux.tar | 3239424 | 11f28697bb5c3e64bd0bf86270d2551ac3a543da8547f068faf4bf50cceb7089 |
