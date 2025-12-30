#
# Copyright (C) 2025 The LineageOS Project
#
# SPDX-License-Identifier: Apache-2.0
#

# Inherit from mt6768-common
$(call inherit-product, device/motorola/mt6768-common/mt6768.mk)

# NFC
PRODUCT_PACKAGES += \
    android.hardware.nfc@1.2-service \
    nfc_nci_nxp

# Rootdir
PRODUCT_PACKAGES += \
    init.fogorow.rc \
    init.sku.rc

# Soong namespaces
PRODUCT_SOONG_NAMESPACES += \
    $(LOCAL_PATH)

# Inherit the proprietary files
$(call inherit-product, vendor/motorola/fogorow/fogorow-vendor.mk)
