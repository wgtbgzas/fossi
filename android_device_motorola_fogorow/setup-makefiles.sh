#!/bin/bash
#
# SPDX-FileCopyrightText: 2016 The CyanogenMod Project
# SPDX-FileCopyrightText: 2017-2024 The LineageOS Project
# SPDX-License-Identifier: Apache-2.0
#

set -e

export DEVICE=F106_Pro
export DEVICE_COMMON=mt6768-common
export VENDOR=fossibot

"./../../${VENDOR}/${DEVICE_COMMON}/extract-files.sh" "$@"
