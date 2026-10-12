#!/bin/bash

set -e

# Initialize LineageOS
repo init -u https://github.com/LineageOS/android.git -b lineage-24.0 --git-lfs --depth=1

# Sync source
/opt/crave/resync.sh

# Device tree
git clone -b lineage-24.0 https://github.com/tony-3k-lv-u/android_device_xiaomi_marble device/xiaomi/marble

# Common device tree
git clone -b lineage-24.0 https://github.com/tony-3k-lv-u/android_device_xiaomi_sm8450-common device/xiaomi/sm8450-common

# Common vendor
git clone -b lineage-24.0 https://github.com/tony-3k-lv-u/proprietary_vendor_xiaomi_sm8450-common vendor/xiaomi/sm8450-common

# Device vendor
git clone -b lineage-24.0 https://github.com/tony-3k-lv-u/proprietary_vendor_xiaomi_marble vendor/xiaomi/marble

# Xiaomi hardware
git clone -b lineage-24.0 https://github.com/tony-3k-lv-u/android_hardware_xiaomi hardware/xiaomi

# Kernel
git clone -b lineage-24.0 https://github.com/tony-3k-lv-u/android_kernel_xiaomi_sm8450 kernel/xiaomi/sm8450

# Kernel device trees
git clone -b lineage-24.0 https://github.com/tony-3k-lv-u/android_kernel_xiaomi_sm8450-devicetrees kernel/xiaomi/sm8450-devicetrees

# Kernel modules
git clone -b lineage-24.0 https://github.com/tony-3k-lv-u/android_kernel_xiaomi_sm8450-modules kernel/xiaomi/sm8450-modules

# Setup build environment
source build/envsetup.sh

# Select build target
lunch lineage_marble-cp2a-userdebug

# Build ROM
mka bacon
