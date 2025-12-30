# Fossibot F106 Pro stock extraction summary (Phase 1)

Source files:
- `real fossibot/lpdump_super.txt`
- `real fossibot/fstab.mt6768`
- `real fossibot/props.txt`
- `real fossibot/boot.img`
- `real fossibot/vendor_boot.img`
- `real fossibot/dtbo.img`
Derived via local parsing of `boot.img` header and `strings` scans of `dtbo.img` (outputs were not committed).
Vendor boot details below were extracted locally from the stock `vendor_boot.img` (outputs were not committed).

## Dynamic partitions (from `lpdump_super.txt`)
- **Metadata**: version 10.2, slot count 3, header flags `virtual_ab_device`.
- **Groups**:
  - `main_a` max size: 8,587,837,440 bytes
  - `main_b` max size: 8,587,837,440 bytes
- **Partition table (logical)**:
  - `product_a` (group `main_a`, readonly) extents `0 .. 5006575` on `super` @ sector 2048
  - `product_b` (group `main_b`, readonly) no extents listed
  - `system_a` (group `main_a`, readonly) extents `0 .. 2295671` on `super` @ sector 5009408
  - `system_b` (group `main_b`, readonly) extents `0 .. 104663` on `super` @ sector 7305216
  - `system_ext_a` (group `main_a`, readonly) extents `0 .. 1806647` on `super` @ sector 7411712
  - `system_ext_b` (group `main_b`, readonly) no extents listed
  - `vendor_a` (group `main_a`, readonly) extents `0 .. 980831` on `super` @ sector 9220096
  - `vendor_b` (group `main_b`, readonly) no extents listed
- **Super partition layout**:
  - `super: 2048 .. 5008624` → `product_a`
  - `super: 5009408 .. 7305080` → `system_a`
  - `super: 7305216 .. 7409880` → `system_b`
  - `super: 7411712 .. 9218360` → `system_ext_a`
  - `super: 9220096 .. 10200928` → `vendor_a`

## fstab mounts/options (from `fstab.mt6768`)

### Logical/system partitions
- `/system` (ext4): `ro wait,slotselect,avb=vbmeta_system,logical,first_stage_mount,avb_keys=/avb/q-gsi.avbpubkey:/avb/r-gsi.avbpubkey:/avb/s-gsi.avbpubkey`
- `/system_ext` (ext4): `ro wait,slotselect,avb=vbmeta_system,logical,first_stage_mount,avb_keys=/avb/q-gsi.avbpubkey:/avb/r-gsi.avbpubkey:/avb/s-gsi.avbpubkey`
- `/vendor` (ext4): `ro wait,slotselect,avb,logical,first_stage_mount`
- `/product` (ext4): `ro wait,slotselect,avb,logical,first_stage_mount`

### Metadata/data
- `/metadata` (ext4): `/dev/block/by-name/md_udc` `noatime,nosuid,nodev,discard wait,check,formattable,first_stage_mount`
- `/data` (f2fs): `/dev/block/by-name/userdata` `noatime,nosuid,nodev,discard,noflush_merge,fsync_mode=nobarrier,reserve_root=134217,resgid=1065,inlinecrypt wait,check,formattable,quota,latemount,resize,readahead_size_kb=512,reservedsize=128m,checkpoint=fs,fileencryption=aes-256-xts:aes-256-cts:v2,keydirectory=/metadata/vold/metadata_encryption`

### Vendor-specific mounts
- `/mnt/vendor/protect_f` (ext4): `/dev/block/by-name/protect1` `noatime,nosuid,nodev,noauto_da_alloc,commit=1,nodelalloc wait,check,formattable`
- `/mnt/vendor/protect_s` (ext4): `/dev/block/by-name/protect2` `noatime,nosuid,nodev,noauto_da_alloc,commit=1,nodelalloc wait,check,formattable`
- `/mnt/vendor/nvdata` (ext4): `/dev/block/by-name/nvdata` `noatime,nosuid,nodev,noauto_da_alloc,commit=1,nodelalloc wait,check,formattable`
- `/mnt/vendor/nvcfg` (ext4): `/dev/block/by-name/nvcfg` `noatime,nosuid,nodev,noauto_da_alloc,commit=1,nodelalloc wait,check,formattable`
- `/mnt/vendor/persist` (ext4): `/dev/block/by-name/persist` `noatime,nosuid,nodev,noauto_da_alloc,commit=1,nodelalloc wait,check,formattable`

### Removable media
- `/devices/platform/11240000.mmc*` (auto): `defaults voldmanaged=sdcard1:auto,encryptable=userdata`
- `/devices/platform/mt_usb*` (vfat): `defaults voldmanaged=usbotg:auto`

### Boot/AVB-related and misc partitions
- `/boot` (emmc): `/dev/block/by-name/boot` `defaults first_stage_mount,nofail,slotselect`
- `/vendor_boot` (emmc): `/dev/block/by-name/vendor_boot` `defaults`
- `/vbmeta_vendor` (emmc): `/dev/block/by-name/vbmeta_vendor` `defaults first_stage_mount,nofail,slotselect`
- `/vbmeta_system` (emmc): `/dev/block/by-name/vbmeta_system` `defaults first_stage_mount,nofail,slotselect,avb=vbmeta`
- `/vbmeta` (emmc): `/dev/block/by-name/vbmeta` `defaults`
- `/dtbo` (emmc): `/dev/block/by-name/dtbo` `defaults`
- `/bootloader` (emmc): `/dev/block/by-name/lk` `defaults`
- `/bootloader2` (emmc): `/dev/block/by-name/lk2` `defaults`
- `/misc` (emmc): `/dev/block/by-name/misc` `defaults`
- `/para` (emmc): `/dev/block/by-name/para` `defaults`
- `/logo` (emmc): `/dev/block/by-name/logo` `defaults`
- `/expdb` (emmc): `/dev/block/by-name/expdb` `defaults`
- `/seccfg` (emmc): `/dev/block/by-name/seccfg` `defaults`
- `/tee1` (emmc): `/dev/block/by-name/tee1` `defaults`
- `/tee2` (emmc): `/dev/block/by-name/tee2` `defaults`
- `/scp1` (emmc): `/dev/block/by-name/scp1` `defaults`
- `/scp2` (emmc): `/dev/block/by-name/scp2` `defaults`
- `/sspm_1` (emmc): `/dev/block/by-name/sspm_1` `defaults`
- `/sspm_2` (emmc): `/dev/block/by-name/sspm_2` `defaults`
- `/md1img` (emmc): `/dev/block/by-name/md1img` `defaults`
- `/md1dsp` (emmc): `/dev/block/by-name/md1dsp` `defaults`
- `/gz1` (emmc): `/dev/block/by-name/gz1` `defaults`
- `/gz2` (emmc): `/dev/block/by-name/gz2` `defaults`
- `/spmfw` (emmc): `/dev/block/by-name/spmfw` `defaults`
- `/boot_para` (emmc): `/dev/block/by-name/boot_para` `defaults`
- `/persistent` (emmc): `/dev/block/by-name/frp` `defaults`
- `/nvram` (emmc): `/dev/block/by-name/nvram` `defaults`
- `/proinfo` (emmc): `/dev/block/by-name/proinfo` `defaults`

## Kernel cmdline (stock boot header)
- `boot.img` header version: **4** (boot image v4 style) with **empty cmdline** (`""`).
- `vendor_boot.img` header version: **4**, page size **4096**, cmdline: `bootopt=64S3,32N2,64N2`.

## Vendor ramdisk (from `vendor_boot.img`)
- Vendor ramdisk format: **LZ4 legacy** (uncompressed size **3,464,627 bytes**).
- Extracted files (no other `fstab*`, `init*.rc`, or `ueventd*` present):
  - `first_stage_ramdisk/fstab.mt6768`

## AVB / verity hints
- Vendor ramdisk fstab entries for `/system`, `/system_ext`, `/product`, `/vendor` are `ro` and have **AVB** enabled (`avb`/`avb=vbmeta_system`).
- `vbmeta_system` is mounted with `avb=vbmeta` and `first_stage_mount`.
- Vendor ramdisk fstab for `/data` uses `inlinecrypt` and `fileencryption=aes-256-xts:aes-256-cts:v2` with `keydirectory=/metadata/vold/metadata_encryption`.
- `props.txt` shows:
  - `ro.boot.avb_version = 1.2`
  - `ro.boot.verifiedbootstate = orange`

## DTBO overlay summary (strings from `dtbo.img`)
> Parsed via `strings` only (no `dtc` available). Identifiers below are extracted from string tables and node names.

### Panel/display
- Panel drivers/compatibles: `ili7807_dsi_vdo_fhdp_sarp_lcm_drv`, `ili7807,hdplus2408,lcd`.
- Panel nodes: `panel1@0`, `panel2@1`, `panel3@2` (with endpoints under `ports`).

### Touch
- Touch compatibles/nodes: `mediatek,cap_touch_ilitek`, `cap_touch_ilitek@41`, `mediatek,cap_touch_ft`, `cap_touch_ft@38`, `mediatek,ektd6600_touch` (Elan), `mediatek,cap_touch_himax`, `cap_touch_himax@48`.
- Additional touch strings: `chipone_tddi`, `jadard@68`, `focaltech,max-touch-number`.

### Camera
- Sensor ID strings in overlay table: `ova0b40_mipi_raw`, `ov48b_mipi_raw`, `imx616_mipi_raw`, `imx471_mipi_raw`, `ov5670_mipi_raw`, `imx350_mipi_raw`.
- Camera nodes: `camera_main@1a`, `camera_main_two@10`, `camera_sub@2d`, `auxiliarycamera@4c`, plus `camera_main_eeprom@50`, `camera_sub_eeprom@52`, `camera_main_two_eeprom@50`, `camera_main_af@0c`, `camera_main_two_af@30`.

### Audio
- Audio/speaker strings: `mediatek,speaker_amp` (`speaker_amp@34`), `mediatek,speaker-codec`.
