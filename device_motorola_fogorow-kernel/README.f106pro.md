# FOSSiBOT F106 Pro kernel notes

This prebuilt kernel tree is paired with the source overlay DTS added under
`android_kernel_alps-5.10/arch/arm64/boot/dts/mediatek/fossibot/`.

## Notes
- DT overlay: `mt6768-fossibot-f106pro-overlay.dts` (built in the kernel source tree).
- Config fragment: `arch/arm64/configs/f106pro.fragment` (source tree) captures NFC and touchscreen toggles.

The prebuilt Image.gz and DTB assets are intentionally left unchanged here.
