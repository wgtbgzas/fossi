#
# Copyright (C) 2025 The LineageOS Project
#
# SPDX-License-Identifier: Apache-2.0
#

# Inherit from those products. Most specific first.
$(call inherit-product, $(SRC_TARGET_DIR)/product/core_64_bit.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/product/full_base_telephony.mk)

# Inherit some common Lineage stuff.
$(call inherit-product, vendor/lineage/config/common_full_phone.mk)

# Inherit from fogorow device
$(call inherit-product, device/motorola/fogorow/device.mk)

PRODUCT_DEVICE := fogorow
PRODUCT_NAME := lineage_fogorow
PRODUCT_BRAND := motorola
PRODUCT_MODEL := moto g24
PRODUCT_MANUFACTURER := motorola

PRODUCT_GMS_CLIENTID_BASE := android-motorola

PRODUCT_BUILD_PROP_OVERRIDES += \
    PRIVATE_BUILD_DESC="fogorow_g-user 14 UTAS34.82-97-3 82-97-3 release-keys"

BUILD_FINGERPRINT := motorola/fogorow_g/fogorow:14/UTAS34.82-97-3/82-97-3:user/release-keys
