# logcat summary

## DTBO extraction
- dtbo_new.img extraction offset: 64
- dtbo_new.img totalsize: 61186

## DTC compile
- Command: dtc -@ -I dts -O dtb -o /tmp/mt6768-fossibot-f106pro-overlay.dtb android_kernel_alps-5.10/arch/arm64/boot/dts/mediatek/fossibot/mt6768-fossibot-f106pro-overlay.dts
- Result: completed with warnings (see full log)

## vendor.img filesystem
- Detected ext4 (magic 0xEF53) via debugfs

## Key extracted paths (top 50)
- out/extract/vendor_fs/etc/partition_permission.sh:8:/system/bin/chown root:system /mtd@bootimg
- out/extract/vendor_fs/etc/partition_permission.sh:9:/system/bin/chmod 0640 /mtd@bootimg
- out/extract/vendor_fs/etc/audio_device.xml
- out/extract/vendor_fs/etc/ecc_list_preference.xml
- out/extract/vendor_fs/etc/media_codecs_mediatek_video.xml
- out/extract/vendor_fs/etc/media_codecs.xml
- out/extract/vendor_fs/etc/MNL_Config.xml
- out/extract/vendor_fs/etc/gnss/carrier/agps_profiles_conf2_carrier_Claro_Peru.xml
- out/extract/vendor_fs/etc/gnss/carrier/agps_profiles_conf2_carrier_SK_Telecom.xml
- out/extract/vendor_fs/etc/gnss/carrier/agps_profiles_conf2_carrier_ATnT_US.xml
- out/extract/vendor_fs/etc/gnss/carrier/agps_profiles_conf2_carrier_SoftBank.xml
- out/extract/vendor_fs/etc/gnss/carrier/agps_profiles_conf2_carrier_KDDI.xml
- out/extract/vendor_fs/etc/gnss/carrier/agps_profiles_conf2_carrier_Entel_Peru.xml
- out/extract/vendor_fs/etc/gnss/carrier/agps_profiles_conf2_carrier_Test_SIM1.xml
- out/extract/vendor_fs/etc/gnss/carrier/agps_profiles_conf2_carrier_Sprint.xml
- out/extract/vendor_fs/etc/gnss/carrier/agps_profiles_conf2_carrier_ATnT_Mexico.xml
- out/extract/vendor_fs/etc/gnss/carrier/agps_profiles_conf2_carrier_T-Mobile_US.xml
- out/extract/vendor_fs/etc/gnss/carrier/agps_profiles_conf2_carrier_Test_SIM2.xml
- out/extract/vendor_fs/etc/gnss/carrier/agps_profiles_conf2_carrier_Verizon_Wireless.xml
- out/extract/vendor_fs/etc/gnss/agps_profiles_conf2.xml
- out/extract/vendor_fs/etc/virtual-spn-conf-by-efgid1.xml
- out/extract/vendor_fs/etc/ecc_list_OP02.xml
- out/extract/vendor_fs/etc/media_codecs_mediatek_audio.xml
- out/extract/vendor_fs/etc/ecc_list_OP20.xml
- out/extract/vendor_fs/etc/aurisys_config_rv.xml
- out/extract/vendor_fs/etc/aurisys_config.xml
- out/extract/vendor_fs/etc/special_pws_channel.xml
- out/extract/vendor_fs/etc/ueventd.rc
- out/extract/vendor_fs/etc/AudioLog_dynamic.xml
- out/extract/vendor_fs/etc/power_app_cfg.xml
- out/extract/vendor_fs/etc/ecc_list_OP12.xml
- out/extract/vendor_fs/etc/smsdbvisitor.xml
- out/extract/vendor_fs/etc/virtual-spn-conf-by-efpnn.xml
- out/extract/vendor_fs/etc/fstab.mt6768
- out/extract/vendor_fs/etc/usb_audio_accessory_only_policy_configuration.xml
- out/extract/vendor_fs/etc/mtk_platform_codecs_config.xml
- out/extract/vendor_fs/etc/VideoLog_dynamic.xml
- out/extract/vendor_fs/etc/selinux/vendor_mac_permissions.xml
- out/extract/vendor_fs/etc/media_codecs_performance.xml
- out/extract/vendor_fs/etc/media_codecs_google_audio.xml
- out/extract/vendor_fs/etc/a2dp_in_audio_policy_configuration.xml
- out/extract/vendor_fs/etc/fstab.enableswap
- out/extract/vendor_fs/etc/ecc_list_OP18.xml
- out/extract/vendor_fs/etc/r_submix_audio_policy_configuration.xml
- out/extract/vendor_fs/etc/permissions/android.hardware.usb.accessory.xml
- out/extract/vendor_fs/etc/permissions/android.hardware.sensor.compass.xml
- out/extract/vendor_fs/etc/permissions/android.hardware.sensor.proximity.xml
- out/extract/vendor_fs/etc/permissions/android.hardware.fingerprint.xml
- out/extract/vendor_fs/etc/permissions/android.hardware.camera.xml
- out/extract/vendor_fs/etc/permissions/android.hardware.vulkan.level.xml

## Implemented files
- android_device_motorola_fogorow/BoardConfig.mk
- android_device_motorola_fogorow/configs/properties/system.prop
- android_device_motorola_fogorow/configs/properties/vendor.prop
- android_device_motorola_fogorow/configs/f106pro_partition_info.md
- android_device_motorola_mt6768-common/BoardConfigCommon.mk
- android_device_motorola_mt6768-common/rootdir/Android.bp
- android_device_motorola_mt6768-common/rootdir/etc/fstab.mt6768
- android_device_motorola_mt6768-common/rootdir/etc/fstab.enableswap
- android_device_motorola_mt6768-common/rootdir/etc/ueventd.mt6768.rc
- android_kernel_alps-5.10/arch/arm64/boot/dts/mediatek/Makefile
- android_kernel_alps-5.10/arch/arm64/boot/dts/mediatek/fossibot/mt6768-fossibot-f106pro-overlay.dts
- android_kernel_alps-5.10/arch/arm64/configs/f106pro.fragment
- android_vendor_motorola_fogorow/overlay/f106pro-vendor.prop
- android_vendor_motorola_fogorow/docs/f106pro_prebuilt_mapping.md
- android_vendor_motorola_mt6768-common/overlay/mt6768-common-vendor.prop
- android_vendor_motorola_mt6768-common/docs/mt6768_common_prebuilt_mapping.md
- device_motorola_fogorow-kernel/README.f106pro.md
- docs/f106pro_missing_configs.md
- docs/f106pro_extracted_config.md
- docs/f106pro_adaptation_plan.md

## Log sizes
- logcat.log size: 354180 bytes
- out/logs/logcat.log.gz size: 50488 bytes

## Compressed log checksum
- d8bf14a4e82ba5d24cf8f3e91245a569fed274b7ee7ab6b1b19b6604dd403202  out/logs/logcat.log.gz

Full compressed log is in workspace at out/logs/logcat.log.gz (not committed).
