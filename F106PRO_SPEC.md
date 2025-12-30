Codex prompt (Android 16 + TWRP)

You are working in a repo for Fossibot F106 Pro (MT6768) that currently contains Motorola fogorow trees and a kernel. Your job is to adapt the entire repo so it supports:

Full Android 16 (AOSP/Lineage-style build) for Fossibot F106 Pro

TWRP recovery (bootable recovery image)

Repository layout

Top-level folders:

android_device_motorola_fogorow/

android_device_motorola_mt6768-common/

android_vendor_motorola_fogorow/

android_kernel_alps-5.10/

Stock/reference data in real fossibot/:

boot.img, init_boot.img, vendor_boot.img, vendor.img, dtbo.img

defconfig (stock kernel config)

fstab.mt6768, props.txt, getvar_all.txt, lpdump_super.txt, MT6768_Android_scatter.txt

odm_selinux.tar, system_selinux.tar, vendor_selinux.tar, selinux.policy

fossibotf106pro.html, PDF

Non-negotiable rules

Treat everything under real fossibot/ as authoritative. Do not assume Motorola fogorow values are correct.

If you can’t find a needed value in the trees, extract it from stock (boot/vendor_boot/init_boot/dtbo/vendor).

Keep changes clean: rename device from Motorola to Fossibot F106 Pro properly, don’t leave “fogorow” leftovers.

Part A — Ensure stock binaries are usable

Before extraction, verify the images are NOT LFS pointers:

real fossibot/vendor.img should be ~479MB

real fossibot/vendor_boot.img ~64MB

If any are pointers, run:

git lfs install && git lfs pull && git lfs checkout

Part B — Extract truth from stock images

You MUST extract and use these:

1) boot / init_boot / vendor_boot

Unpack and harvest:

kernel cmdline, base, pagesize, offsets (if relevant)

ramdisk fstab(s), init*.rc, ueventd*, default props

AVB / vbmeta flags, verity, encryption hints

DTB if embedded (check)

2) dtbo.img

Decompile overlays with dtc

Identify panel, touch, cameras, audio, sensors nodes

Extract board-specific overlay requirements and record them

3) vendor.img

Extract:

build props (ro.product., ro.board., ro.boot.*, fingerprint, SKU, etc.)

fstab / init configs in vendor

permissions XMLs, VINTF manifests, hwfeature configs

firmware blobs if needed

Use lpdump_super.txt to define dynamic partitions accurately.

Part C — Convert trees to Fossibot F106 Pro device

Create proper Fossibot naming and structure:

Device tree (Android 16)

Create android_device_fossibot_f106pro/ (or equivalent) and migrate/adapt content from fogorow + mt6768-common.

Update:

AndroidProducts.mk, Android.mk/Android.bp, device.mk, product.mk

BoardConfig.mk (partition sizes, dynamic partitions, AVB, recovery, vendor_boot usage, DTBO usage)

fstab for system and for recovery (must match stock)

VINTF (vendor manifest / matrix) if available from vendor.img

init rc overlays if needed

Target Android version: Android 16

Ensure compatibility with modern partitioning (init_boot/vendor_boot)

Use current init_boot flow (A13+ style) as stock indicates

Vendor tree

Create android_vendor_fossibot_f106pro/ (or keep motorola vendor but adapt to Fossibot; prefer rename)

Only include what is needed for building; if full proprietary extraction isn’t feasible here, generate:

proprietary-files.txt and extraction scripts

correct mounting/copy rules

Prefer deriving file lists from vendor.img.

Part D — Kernel adaptation (alps-5.10)

You MUST adapt android_kernel_alps-5.10 for Fossibot:

Import stock kernel config:

Use real fossibot/defconfig as the base truth.

If repo already has defconfigs, merge or replace appropriately.

Ensure kernel config supports:

Android 16 requirements (binderfs, namespaces, cgroups, etc. as appropriate)

recovery (ramdisk, f2fs/ext4, dm-verity, AVB libs, crypto if required)

DTBO/DTB support consistent with stock

Ensure the build system points device tree to the correct kernel defconfig and produces bootable images.

Document any config diffs vs stock defconfig and why.

Part E — TWRP support

Add TWRP configuration for Fossibot:

BoardConfig + recovery.fstab

Correct handling for dynamic partitions, vendor_boot/init_boot, DTBO

Touch/panel hints from dtbo overlays (if needed for recovery UI)

Decryption strategy: if FBE/FDE is present, document what works and what doesn’t

Goal: buildable recovery.img or bootable recovery (depending on device’s boot flow).

Deliverables (must output)

A clear plan + extracted facts summary (partitions, fstab, cmdline, dtbo notes, props highlights)

The actual repo changes (new Fossibot device/vendor dirs, updated common, updated kernel defconfig integration)

Build instructions:

Android 16 build target/lunch combo

TWRP build target

A concise “sanity checklist”:

partitions mount correctly

dtbo applied / correct

vendor_boot/init_boot flow matches stock

kernel config loaded and built

Proceed now: audit existing trees, extract required info from real fossibot/ images, then implement the Fossibot F106 Pro adaptations for both Android 16 and TWRP.
Do not stop at a high-level plan—apply edits and show diffs/patches for each directory.

