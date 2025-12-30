#
# Copyright (C) 2025 The LineageOS Project
#
# SPDX-License-Identifier: Apache-2.0
#

# Inherit from those products. Most specific first.
$(call inherit-product, $(SRC_TARGET_DIR)/product/core_64_bit.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/product/full_base_telephony.mk)

# Inherit from f106pro device
$(call inherit-product, device/fossibot/f106pro/device.mk)

PRODUCT_DEVICE := f106pro
PRODUCT_NAME := aosp_f106pro
PRODUCT_BRAND := FOSSiBOT
PRODUCT_MODEL := F106 Pro
PRODUCT_MANUFACTURER := FOSSiBOT

PRODUCT_GMS_CLIENTID_BASE := android-fossibot

PRODUCT_BUILD_PROP_OVERRIDES += \
    PRIVATE_BUILD_DESC="F106_Pro-user 14 UP1A.231005.007 2024134 release-keys"

BUILD_FINGERPRINT := FOSSiBOT/F106_Pro_ROW/F106_Pro:14/UP1A.231005.007/2024134:user/release-keys
