#!/bin/bash

# Initialize LineageOS 24.0
repo init --depth=1 -u https://github.com/LineageOS/android.git -b lineage-24.0 --git-lfs
echo "=================="
echo "Repo init success"
echo "=================="

# Local manifest
git clone --depth=1 -b main \
https://github.com/tony-3k-lv-u/local_manifests.git \
.repo/local_manifests
echo "============================"
echo "Local manifests clone success"
echo "============================"

# Build sync

echo ">>> Syncing source..."
/opt/crave/resync.sh
echo "============="
echo "Sync success"
echo "============="


# Set up build environment.
source build/envsetup.sh
echo "============="

## Select build target
lunch lineage_marble-cp2a-userdebug

# Build ROM
mka bacon