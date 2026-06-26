#
# SPDX-FileCopyrightText: The LineageOS Project
# SPDX-License-Identifier: Apache-2.0
#

# Inherit common sm8350 product configuration
$(call inherit-product, device/xiaomi/sm8350-common/common.mk)

# Inherit proprietary targets
$(call inherit-product, vendor/xiaomi/taoyao/taoyao-vendor.mk)

# Inherit camera proprietary targets
$(call inherit-product-if-exists, device/xiaomi/taoyao-camera/device.mk)

# API (taoyao ships API 31)
PRODUCT_SHIPPING_API_LEVEL := 31

# Audio (taoyao-specific overrides — different xml content)
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/audio/audio_effects.xml:$(TARGET_COPY_OUT_VENDOR)/etc/audio/sku_lahaina/audio_effects.xml \
    $(LOCAL_PATH)/audio/audio_policy_configuration.xml:$(TARGET_COPY_OUT_VENDOR)/etc/audio/sku_lahaina/audio_policy_configuration.xml

PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/audio/audio_effects.xml:$(TARGET_COPY_OUT_VENDOR)/etc/audio/sku_shima/audio_effects.xml \
    $(LOCAL_PATH)/audio/audio_policy_configuration.xml:$(TARGET_COPY_OUT_VENDOR)/etc/audio/sku_shima/audio_policy_configuration.xml

PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/audio/audio_effects.xml:$(TARGET_COPY_OUT_VENDOR)/etc/audio/sku_yupik/audio_effects.xml \
    $(LOCAL_PATH)/audio/audio_policy_configuration.xml:$(TARGET_COPY_OUT_VENDOR)/etc/audio/sku_yupik/audio_policy_configuration.xml

# Camera (taoyao-specific config)
PRODUCT_PACKAGES += \
    android.hardware.graphics.common-V4-ndk

PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/configs/camera_cnf.txt:$(TARGET_COPY_OUT_VENDOR)/etc/camera/camera_cnf.txt

# Device-specific settings
PRODUCT_PACKAGES += \
    DSPVolumeSynchronizer \
    XiaomiDolby \
    XiaomiDolbyResCommon \
    XiaomiParts

# Display
PRODUCT_PACKAGES += \
    android.hardware.graphics.allocator@3.0

# Dolby Vision
$(call soong_config_set, dolby_vision, enabled, true)

# Health (taoyao uses hidl compat)
PRODUCT_PACKAGES += \
    libhidltransport \
    libhwbinder

# IR (taoyao uses @1.0-impl/service, not lineage service)
PRODUCT_PACKAGES += \
    android.hardware.ir@1.0-impl \
    android.hardware.ir@1.0-service

# Kernel
$(call inherit-product-if-exists, device/xiaomi/taoyao-kernel/device.mk)

# Media (taoyao-specific dolby audio codec)
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/media/media_codecs_c2_dolby_audio.xml:$(TARGET_COPY_OUT_VENDOR)/etc/media_codecs_c2_dolby_audio.xml

# Overlays (taoyao-specific overlays in addition to sm8350-common overlays)
DEVICE_PACKAGE_OVERLAYS += \
    $(LOCAL_PATH)/overlay \
    $(LOCAL_PATH)/overlay-lineage

PRODUCT_PACKAGES += \
    SettingsProviderOverlay \
    DeviceAsWebcamOverlaySM8350 \
    WifiOverlay

# Power (taoyao-specific powerhint overrides common's)
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/configs/powerhint.json:$(TARGET_COPY_OUT_VENDOR)/etc/powerhint.json

# PowerShare (always enabled on taoyao)
$(call soong_config_set,lineage_powershare,powershare_path,/sys/class/qcom-battery/reverse_chg_mode)

# RIL
PRODUCT_PACKAGES += \
    CarrierConfigOverlay

# Sensors (taoyao hals.conf)
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/sensors/hals.conf:$(TARGET_COPY_OUT_VENDOR)/etc/sensors/hals.conf

# Soong namespaces (taoyao-specific additions)
PRODUCT_SOONG_NAMESPACES += \
    $(LOCAL_PATH) \
    device/xiaomi/sm8350-common

# WiFi (taoyao has an extra WCNSS qca6750 config)
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/wifi/WCNSS_qcom_cfg.ini:$(TARGET_COPY_OUT_VENDOR)/etc/wifi/qca6750/WCNSS_qcom_cfg.ini

PRODUCT_PACKAGES += \
    firmware_WCNSS_qcom_cfg_qca6750.ini_symlink
