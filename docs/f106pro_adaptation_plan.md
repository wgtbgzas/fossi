# FOSSiBOT F106 Pro adaptation plan

## Device tree updates
- Align MT6768 fstab with the extracted device fstab, including `resize` for `/data`.
- Add swap configuration (`fstab.enableswap`) sourced from `vendor/etc/fstab.enableswap`.
- Add ueventd rules from vendor_boot ramdisk (`system/etc/ueventd.rc`).
- Extend system/vendor property overlays with F106 Pro identity values.
- Record partition and dynamic-partition metadata derived from scatter + lpdump.

## Vendor tree updates
- Add F106 Pro vendor property overlay (`vendor/motorola/fogorow/overlay/f106pro-vendor.prop`).
- Add MT6768 common vendor property overlay (`vendor/motorola/mt6768-common/overlay/mt6768-common-vendor.prop`).
- Document extraction mappings for vendor and common blobs.

## Kernel updates
- Add F106 Pro DT overlay DTS in the Mediatek DTS tree and register it in the Makefile.
- Add `arch/arm64/configs/f106pro.fragment` with NFC/touchscreen-related toggles.

## Documentation
- Track extracted configuration sources and missing configuration checklist.
- Keep extraction outputs under `out/` only (no blobs committed).
