#
# Copyright (C) 2015 The CyanogenMod Project
# Copyright (C) 2017 The LineageOS Project
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
# http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

-include vendor/motorola/msm8916-common/BoardConfigVendor.mk

VENDOR_PATH := device/motorola/msm8916-common

BOARD_VENDOR := motorola-qcom

TARGET_SPECIFIC_HEADER_PATH := $(VENDOR_PATH)/include

TARGET_FS_CONFIG_GEN += \
    $(VENDOR_PATH)/fs_config/file_caps.fs \
    $(VENDOR_PATH)/fs_config/qcom_aids.fs \
    $(VENDOR_PATH)/fs_config/mot_aids.fs

# Platform
TARGET_BOARD_PLATFORM := msm8916
TARGET_BOARD_PLATFORM_GPU := qcom-adreno306

# Bootloader
TARGET_BOOTLOADER_BOARD_NAME := MSM8916
TARGET_NO_BOOTLOADER := true

# Architecture
TARGET_ARCH := arm
TARGET_ARCH_VARIANT := armv8-a
TARGET_CPU_ABI := armeabi-v7a
TARGET_CPU_ABI2 := armeabi
TARGET_CPU_VARIANT := cortex-a53

# Binder API version
TARGET_USES_64_BIT_BINDER := true

# DataServices
DEVICE_SPECIFIC_DATASERVICES := $(VENDOR_PATH)/dataservices
USE_DEVICE_SPECIFIC_DATASERVICES := true

# Kernel
BOARD_KERNEL_CMDLINE := console=ttyHSL0,115200,n8 androidboot.console=ttyHSL0 androidboot.hardware=qcom msm_rtb.filter=0x3F ehci-hcd.park=3 vmalloc=400M androidboot.bootdevice=7824900.sdhci utags.blkdev=/dev/block/bootdevice/by-name/utags utags.backup=/dev/block/bootdevice/by-name/utagsBackup movablecore=160M
BOARD_KERNEL_BASE := 0x80000000
BOARD_KERNEL_IMAGE_NAME := zImage
BOARD_KERNEL_PAGESIZE := 2048
BOARD_KERNEL_SEPARATED_DT := true
BOARD_MKBOOTIMG_ARGS := --ramdisk_offset 0x01000000 --tags_offset 0x00000100
TARGET_KERNEL_ARCH := arm
TARGET_KERNEL_SOURCE := kernel/motorola/msm8916
TARGET_KERNEL_CROSS_COMPILE_PREFIX := $(PWD)/prebuilts/gcc/linux-x86/arm/arm-eabi-7.2/bin/arm-eabi-

# ANT+
BOARD_ANT_WIRELESS_DEVICE := "qualcomm-smd"

# Audio
AUDIO_FEATURE_ENABLED_MULTI_VOICE_SESSIONS := true
BOARD_USES_ALSA_AUDIO := true

# Bluetooth
BOARD_BLUETOOTH_BDROID_BUILDCFG_INCLUDE_DIR := $(VENDOR_PATH)/bluetooth
BOARD_HAVE_BLUETOOTH := true
BOARD_HAVE_BLUETOOTH_QCOM := true
QCOM_BT_READ_ADDR_FROM_PROP := true

# Camera
USE_DEVICE_SPECIFIC_CAMERA := true
TARGET_USES_MEDIA_EXTENSIONS := true
TARGET_PROCESS_SDK_VERSION_OVERRIDE := \
	/vendor/bin/mm-qcamera-daemon=23

# Charger
BACKLIGHT_PATH := /sys/class/leds/lcd-backlight/brightness
BOARD_CHARGER_ENABLE_SUSPEND := true
BOARD_NO_CHARGER_LED := true

# Crypto
TARGET_HW_DISK_ENCRYPTION := true
TARGET_KEYMASTER_WAIT_FOR_QSEE := true
TARGET_LEGACY_HW_DISK_ENCRYPTION := true

# Display
MAX_EGL_CACHE_KEY_SIZE := 12*1024
MAX_EGL_CACHE_SIZE := 2048*1024
NUM_FRAMEBUFFER_SURFACE_BUFFERS := 3
OVERRIDE_RS_DRIVER := libRSDriver_adreno.so
TARGET_USES_C2D_COMPOSITION := true
TARGET_USES_ION := true
USE_OPENGL_RENDERER := true

# Exclude serif fonts for saving system.img size.
EXCLUDE_SERIF_FONTS := true

# UI
TARGET_ADDITIONAL_GRALLOC_10_USAGE_BITS := 0x02000000U

# FM
BOARD_HAVE_QCOM_FM := true
TARGET_QCOM_NO_FM_FIRMWARE := true

# HIDL
DEVICE_MANIFEST_FILE := $(VENDOR_PATH)/manifest.xml

# Keymaster
TARGET_KEYMASTER_WAIT_FOR_QSEE := true

# Lights
TARGET_PROVIDES_LIBLIGHT := true

# Partitions
BOARD_CACHEIMAGE_FILE_SYSTEM_TYPE := ext4
BOARD_FLASH_BLOCK_SIZE := 131072

# Qualcomm support
BOARD_USES_QCOM_HARDWARE := true

# Recovery
BOARD_HAS_NO_SELECT_BUTTON := true
TARGET_RECOVERY_FSTAB := $(VENDOR_PATH)/rootdir/etc/fstab.qcom
TARGET_USERIMAGES_USE_EXT4 := true
TARGET_USERIMAGES_USE_F2FS := true

# Release Tools
TARGET_RELEASETOOLS_EXTENSIONS := $(VENDOR_PATH)

# SELinux
include device/qcom/sepolicy-legacy/sepolicy.mk
BOARD_SEPOLICY_DIRS += $(VENDOR_PATH)/sepolicy

# Shims
TARGET_LD_SHIM_LIBS := \
    /system/lib/libandroid.so|libshim_ril.so \
    /system/lib/libmdmcutback.so|libqsap_shim.so \
    /system/lib/libmot_sensorlistener.so|libsensor.so \
    /system/lib/libjustshoot.so|libshims_camera.so \
    /system/vendor/lib/libmmcamera_wavelet_lib.so|libc_util.so \
    /system/vendor/lib/libizat_core.so|libshims_get_process_name.so \
    /system/vendor/lib/libqomx_jpegenc.so|libboringssl-compat.so \
    /system/vendor/lib/libmmqjpeg_codec.so|libboringssl-compat.so

# Sp-shim
TARGET_LD_PRELOAD := \
    /system/lib/libboringssl-compat.so

# Vendor Interface Manifest
DEVICE_MANIFEST_FILE := $(VENDOR_PATH)/manifest.xml

# Wifi
BOARD_HAS_QCOM_WLAN := true
BOARD_WLAN_DEVICE := qcwcn
BOARD_HOSTAPD_DRIVER := NL80211
BOARD_HOSTAPD_PRIVATE_LIB := lib_driver_cmd_qcwcn
BOARD_WPA_SUPPLICANT_DRIVER := NL80211
BOARD_WPA_SUPPLICANT_PRIVATE_LIB := lib_driver_cmd_qcwcn
PRODUCT_VENDOR_MOVE_ENABLED := true
WIFI_DRIVER_FW_PATH_AP  := "ap"
WIFI_DRIVER_FW_PATH_STA := "sta"
WPA_SUPPLICANT_VERSION := VER_0_8_X
