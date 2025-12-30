#
# Copyright (C) 2025 The LineageOS Project
#
# SPDX-License-Identifier: Apache-2.0
#

DEVICE_PATH := device/motorola/fogorow
KERNEL_PATH := device/motorola/fogorow-kernel

# Inherit from mt6768-common
-include device/motorola/mt6768-common/BoardConfigCommon.mk

# Kernel
BOARD_PREBUILT_DTBIMAGE_DIR := $(KERNEL_PATH)/dtb
BOARD_MKBOOTIMG_ARGS += --dtb $(BOARD_PREBUILT_DTBIMAGE_DIR)/dtb.img

TARGET_KERNEL_SOURCE := device/motorola/fogorow-kernel/kernel-headers

LOCAL_KERNEL := $(KERNEL_PATH)/$(BOARD_KERNEL_IMAGE_NAME)
PRODUCT_COPY_FILES += \
	$(LOCAL_KERNEL):kernel

BOARD_PREBUILT_DTBIMAGE_DIR := $(KERNEL_PATH)/dtb
BOARD_MKBOOTIMG_ARGS += --dtb $(BOARD_PREBUILT_DTBIMAGE_DIR)/dtb.img

## vendor_boot modules
BOARD_VENDOR_RAMDISK_KERNEL_MODULES_LOAD := $(strip $(shell cat $(KERNEL_PATH)/modules.load.vendor_boot))
BOARD_VENDOR_RAMDISK_KERNEL_MODULES := $(addprefix $(KERNEL_PATH)/vendor_ramdisk/, $(BOARD_VENDOR_RAMDISK_KERNEL_MODULES_LOAD))

## recovery modules
BOARD_VENDOR_RAMDISK_RECOVERY_KERNEL_MODULES_LOAD := $(strip $(shell cat $(KERNEL_PATH)/modules.load.recovery))
RECOVERY_MODULES := $(addprefix $(KERNEL_PATH)/vendor_ramdisk/, $(BOARD_VENDOR_RAMDISK_RECOVERY_KERNEL_MODULES_LOAD))

## Prevent duplicated entries (to solve duplicated build rules problem)
BOARD_VENDOR_RAMDISK_KERNEL_MODULES := $(sort $(BOARD_VENDOR_RAMDISK_KERNEL_MODULES) $(RECOVERY_MODULES))

## vendor modules
BOARD_VENDOR_KERNEL_MODULES_LOAD := $(strip $(shell cat $(KERNEL_PATH)/modules.load.vendor))
BOARD_VENDOR_KERNEL_MODULES := $(wildcard $(KERNEL_PATH)/vendor/*.ko)

# HIDL
DEVICE_MANIFEST_FILE += $(DEVICE_PATH)/configs/vintf/manifest.xml

# Properties
TARGET_SYSTEM_PROP += $(DEVICE_PATH)/configs/properties/system.prop
TARGET_VENDOR_PROP += $(DEVICE_PATH)/configs/properties/vendor.prop

# SKU
ODM_MANIFEST_SKUS += nfc_ss nonfc_ss nonfc_dsds nfc_dsds
ODM_MANIFEST_NFC_SS_FILES := $(DEVICE_PATH)/configs/vintf/sku/manifest_nfc_ss.xml
ODM_MANIFEST_NONFC_SS_FILES := $(DEVICE_PATH)/configs/vintf/sku/manifest_nonfc_ss.xml
ODM_MANIFEST_NONFC_DSDS_FILES := $(DEVICE_PATH)/configs/vintf/sku/manifest_nonfc_dsds.xml
ODM_MANIFEST_NFC_DSDS_FILES := $(DEVICE_PATH)/configs/vintf/sku/manifest_nfc_dsds.xml

# Inherit the proprietary files
include vendor/motorola/fogorow/BoardConfigVendor.mk
