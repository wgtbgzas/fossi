# Fossibot F106 Pro build instructions

## Android 16 build

```bash
source build/envsetup.sh
lunch aosp_f106pro-userdebug
mka bacon
```

## TWRP build

```bash
source build/envsetup.sh
lunch aosp_f106pro-userdebug
mka recoveryimage
```

> Note: This device uses `BOARD_USES_RECOVERY_AS_BOOT := true` with `vendor_boot`/`init_boot` flow.
> The generated recovery bits may be packed into `boot.img` depending on your build system.
> If `out/target/product/f106pro/recovery.img` is not produced, use `out/target/product/f106pro/boot.img`.

## Sanity checklist

- [ ] `out/target/product/f106pro/recovery.fstab` matches the stock `fstab.mt6768` mount points.
- [ ] Logical partitions (`system`, `system_ext`, `vendor`, `product`) mount via dynamic partitions.
- [ ] `vendor_boot` and `init_boot` are present and aligned with the stock boot flow.
- [ ] `dtbo.img` is built and is flashed/applied for recovery.
- [ ] `boot.img`/`recovery.img` boots and `data` decrypt is attempted (FBE metadata present).
