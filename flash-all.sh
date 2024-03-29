#!/bin/bash

#  INSTALLER_DIR="`dirname ${0}`"
INSTALLER_DIR="device/linaro/hikey/installer/hikey960/"

# for cases that don't run "lunch hikey960-userdebug"
if [ -z "${ANDROID_BUILD_TOP}" ]; then
    ANDROID_BUILD_TOP=${INSTALLER_DIR}/../../../../../
fi
ANDROID_PRODUCT_OUT="${ANDROID_BUILD_TOP}/out/target/product/hikey960"

if [ ! -d "${ANDROID_PRODUCT_OUT}" ]; then
    echo "error in locating out directory, check if it exist"
    exit
fi

echo "android out dir:${ANDROID_PRODUCT_OUT}"

fastboot flash xloader "${INSTALLER_DIR}"/hisi-sec_xloader.img
#fastboot flash ptable "${INSTALLER_DIR}"/hisi-ptable.img
fastboot flash fastboot "${INSTALLER_DIR}"/hisi-fastboot.img
fastboot reboot-bootloader
fastboot flash nvme "${INSTALLER_DIR}"/hisi-nvme.img
fastboot flash fw_lpm3   "${INSTALLER_DIR}"/hisi-lpm3.img
fastboot flash trustfirmware   "${INSTALLER_DIR}"/hisi-bl31.bin
fastboot flash boot "${ANDROID_PRODUCT_OUT}"/boot.img
fastboot flash dts "${ANDROID_PRODUCT_OUT}"/dt.img
fastboot flash system "${ANDROID_PRODUCT_OUT}"/system.img
fastboot flash vendor "${ANDROID_PRODUCT_OUT}"/vendor.img
fastboot flash userdata "${ANDROID_PRODUCT_OUT}"/userdata.img
fastboot reboot
