#!/bin/bash
#
# Copyright (C) 2016 The CyanogenMod Project
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
#

set -e

# Load extract_utils and do some sanity checks
MY_DIR="${BASH_SOURCE%/*}"
if [[ ! -d "$MY_DIR" ]]; then MY_DIR="$PWD"; fi

LINEAGE_ROOT="$MY_DIR"/../../..

HELPER="$LINEAGE_ROOT"/vendor/lineage/build/tools/extract_utils.sh
if [ ! -f "$HELPER" ]; then
    echo "Unable to find helper script at $HELPER"
    exit 1
fi
. "$HELPER"

if [ $# -eq 0 ]; then
  SRC=adb
else
  if [ $# -eq 1 ]; then
    SRC=$1
  else
    echo "$0: bad number of arguments"
    echo ""
    echo "usage: $0 [PATH_TO_EXPANDED_ROM]"
    echo ""
    echo "If PATH_TO_EXPANDED_ROM is not specified, blobs will be extracted from"
    echo "the device using adb pull."
    exit 1
  fi
fi

# Initialize the helper
setup_vendor "$DEVICE_COMMON" "$VENDOR" "$LINEAGE_ROOT" true

extract "$MY_DIR"/proprietary-files.txt "$SRC"

if [ -s "$MY_DIR"/../$DEVICE/proprietary-files.txt ]; then
    # Reinitialize the helper for device
    setup_vendor "$DEVICE" "$VENDOR" "$CM_ROOT"
    extract "$MY_DIR"/../$DEVICE/proprietary-files.txt "$SRC"
fi

BLOB_ROOT="$LINEAGE_ROOT"/vendor/"$VENDOR"/"$DEVICE"/proprietary

COMMON_BLOB_ROOT="$LINEAGE_ROOT"/vendor/"$VENDOR"/"$DEVICE_COMMON"/proprietary

echo "Hexing Common: $DEVICE_COMMON libs"

MDMCUTBACK="$COMMON_BLOB_ROOT"/vendor/lib/libmdmcutback.so
sed -i "s|libqsap_sdk.so|libqsapshim.so|g" "$MDMCUTBACK"
sed -i "s|libandroid.so|libshimril.so|g" "$MDMCUTBACK"

MOTSENSOR="$COMMON_BLOB_ROOT"/vendor/lib/libmot_sensorlistener.so
sed -i "s|libcutils.so|libsensor.so|g" "$MOTSENSOR"

echo "Hexing Device: $DEVICE libs"

CAMERAWAVELET="$BLOB_ROOT"/vendor/lib/libmmcamera_wavelet_lib.so
sed -i "s|libcutils.so|libc_util.so|g" "$CAMERAWAVELET"

JPEGENC="$BLOB_ROOT"/vendor/lib/libqomx_jpegenc.so
sed -i "s|libcutils.so|libboring.so|g" "$JPEGENC"

MMQJPEG="$BLOB_ROOT"/vendor/lib/libmmqjpeg_codec.so
sed -i "s|libcutils.so|libboring.so|g" "$MMQJPEG"

JUSTSHOOT="$BLOB_ROOT"/vendor/lib/libjustshoot.so
sed -i "s|libstagefright.so|libshim_camera.so|g" "$JUSTSHOOT"

"$MY_DIR"/setup-makefiles.sh

