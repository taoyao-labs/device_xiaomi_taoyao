#
# SPDX-FileCopyrightText: The LineageOS Project
# SPDX-License-Identifier: Apache-2.0
#

DEVICE_PATH := device/xiaomi/taoyao

# Inherit common sm8350 board configuration
include device/xiaomi/sm8350-common/BoardConfigCommon.mk

# Architecture (taoyao uses cortex-a76, overriding sm8350-common's generic)
TARGET_ARCH_VARIANT := armv8-2a-dotprod
TARGET_CPU_VARIANT := cortex-a76
TARGET_CPU_VARIANT_RUNTIME := cortex-a76

TARGET_2ND_CPU_VARIANT := cortex-a76
TARGET_2ND_CPU_VARIANT_RUNTIME := cortex-a76

# Audio
TARGET_PROVIDES_AUDIO_EXTNS := true

# Bluetooth
BOARD_BLUETOOTH_BDROID_BUILDCFG_INCLUDE_DIR := $(DEVICE_PATH)/bluetooth/include

# Build broken
BUILD_BROKEN_DUP_RULES := true
BUILD_BROKEN_ELF_PREBUILT_PRODUCT_COPY_FILES := true

# Camera
TARGET_CAMERA_SERVICE_EXT_LIB := //$(DEVICE_PATH):libcameraservice_extension.xiaomi_sm8350

# Filesystem


# HIDL (taoyao-specific manifest additions)
DEVICE_MANIFEST_FILE += \
    $(DEVICE_PATH)/hidl/manifest_taoyao.xml

DEVICE_FRAMEWORK_COMPATIBILITY_MATRIX_FILE += \
    hardware/qcom-caf/common/vendor_framework_compatibility_matrix.xml

# Kernel (taoyao-specific)
TARGET_KERNEL_ADDITIONAL_FLAGS := TARGET_PRODUCT=$(PRODUCT_DEVICE)
TARGET_KERNEL_SOURCE := kernel/xiaomi/taoyao
TARGET_KERNEL_CONFIG := vendor/taoyao-qgki_defconfig

BOARD_KERNEL_CMDLINE += androidboot.init_fatal_reboot_target=recovery

-include device/xiaomi/taoyao-kernel/BoardConfig.mk

# Partitions (taoyao-specific sizes)
BOARD_DTBOIMG_PARTITION_SIZE := 25165824

BOARD_ODMIMAGE_FILE_SYSTEM_TYPE := ext4
BOARD_PRODUCTIMAGE_FILE_SYSTEM_TYPE := ext4
BOARD_SYSTEM_EXTIMAGE_FILE_SYSTEM_TYPE := ext4
BOARD_SYSTEMIMAGE_FILE_SYSTEM_TYPE := ext4
BOARD_VENDOR_DLKMIMAGE_FILE_SYSTEM_TYPE := ext4

# Properties (taoyao-specific)
TARGET_ODM_PROP += $(DEVICE_PATH)/odm.prop
TARGET_SYSTEM_PROP += $(DEVICE_PATH)/system.prop
TARGET_SYSTEM_EXT_PROP += $(DEVICE_PATH)/system_ext.prop
TARGET_VENDOR_PROP += $(DEVICE_PATH)/vendor.prop

# Recovery
TARGET_RECOVERY_FSTAB := $(DEVICE_PATH)/rootdir/etc/fstab.qcom

# Security patch level
VENDOR_SECURITY_PATCH := 2026-06-05

# Sepolicy (taoyao-specific additions on top of common)
SYSTEM_EXT_PRIVATE_SEPOLICY_DIRS += $(DEVICE_PATH)/sepolicy/private
SYSTEM_EXT_PUBLIC_SEPOLICY_DIRS += $(DEVICE_PATH)/sepolicy/public
BOARD_VENDOR_SEPOLICY_DIRS += $(DEVICE_PATH)/sepolicy/vendor
SELINUX_IGNORE_NEVERALLOWS := true

# Inherit proprietary blobs
include vendor/xiaomi/taoyao/BoardConfigVendor.mk

# Inherit camera proprietary blobs
-include device/xiaomi/taoyao-camera/BoardConfig.mk
