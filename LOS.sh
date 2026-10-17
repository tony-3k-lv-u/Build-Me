#!/bin/bash

set -e

# Initialize LineageOS
repo init -u https://github.com/LineageOS/android.git -b lineage-24.0 --git-lfs --depth=1

# Sync source
/opt/crave/resync.sh 

# Apply custom Soong memory fix
SOONG_REPO="https://github.com/tony-3k-lv-u/android_build_soong.git"
SOONG_COMMIT="60d16dbe2cb0c4b569202ef44359362e732884fa"

git -C build/soong fetch "$SOONG_REPO" "$SOONG_COMMIT"

if ! git -C build/soong merge-base --is-ancestor "$SOONG_COMMIT" HEAD; then
    git -C build/soong cherry-pick "$SOONG_COMMIT" || exit 1
fi
# Cleaning 

rm -rf device/xiaomi/marble
rm -rf device/xiaomi/sm8450-common
rm -rf vendor/xiaomi/marble
rm -rf vendor/xiaomi/sm8450-common
rm -rf hardware/xiaomi
rm -rf kernel/xiaomi/sm8450
rm -rf kernel/xiaomi/sm8450-devicetrees
rm -rf kernel/xiaomi/sm8450-modules
rm -rf device/xiaomi/miuicamera-marble
rm -rf vendor/xiaomi/miuicamera-marble
# Device tree
git clone https://github.com/tony-3k-lv-u/android_device_xiaomi_marble device/xiaomi/marble

# Common device tree
git clone https://github.com/tony-3k-lv-u/android_device_xiaomi_sm8450-common device/xiaomi/sm8450-common

# Common vendor
git clone https://github.com/tony-3k-lv-u/proprietary_vendor_xiaomi_sm8450-common vendor/xiaomi/sm8450-common

# Device vendor
git clone https://github.com/tony-3k-lv-u/proprietary_vendor_xiaomi_marble vendor/xiaomi/marble

# Xiaomi hardware
git clone https://github.com/tony-3k-lv-u/android_hardware_xiaomi hardware/xiaomi

# Miui Camera and vendor
git clone https://github.com/Pixelify-devices/device_xiaomi_miuicamera-marble.git device/xiaomi/miuicamera-marble
git clone https://github.com/Pixelify-devices/vendor_xiaomi_miuicamera-marble.git vendor/xiaomi/miuicamera-marble

# Kernel
git clone https://github.com/tony-3k-lv-u/android_kernel_xiaomi_sm8450.git kernel/xiaomi/sm8450

# Kernel device trees
git clone https://github.com/tony-3k-lv-u/android_kernel_xiaomi_sm8450-devicetrees.git kernel/xiaomi/sm8450-devicetrees

# Kernel modules
git clone https://github.com/tony-3k-lv-u/android_kernel_xiaomi_sm8450-modules.git kernel/xiaomi/sm8450-modules

# Setup build environment
source build/envsetup.sh 

# Select build target
lunch lineage_marble-cp2a-userdebug

# Build ROM
mka bacon
