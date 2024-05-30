SUMMARY = "U-boot boot script for Xen on Raspberry Pi 5"
LICENSE = "MIT"
LIC_FILES_CHKSUM = "file://${COMMON_LICENSE_DIR}/MIT;md5=0835ade698e0bcf8506ecda2f7b4f302"
COMPATIBLE_MACHINE = "^raspberrypi5$"

DEPENDS = "u-boot-mkimage-native"

INHIBIT_DEFAULT_DEPS = "1"

TEMPLATE_FILE = "boot.cmd.xen.in"

SRC_URI = "file://${TEMPLATE_FILE}"

BOOT_MEDIA ?= "mmc"
DOM0_IMAGE ?= "zephyr.bin"
DOM0_IMG_ADDR ?= "0xe00000"
# DOM0 image max size = 2M
DOMD_IMAGE ?= "Image.gz"
DOMD_IMG_ADDR ?= "0x1200000"
# DOMD image max size = 10M
DOMD_DTB ?= "${RPI_SOC_FAMILY}-${MACHINE}-domd.dtb"
DOMD_DTB_ADDR = "0x1c00000"
XEN_IMAGE ?= "xen"
XEN_IMG_ADDR ?= "0x2000000"
# XEN image max size = 2M
XEN_DTBO ?= "${RPI_SOC_FAMILY}-${MACHINE}-xen.dtbo"
XEN_DTBO_ADDR ?= "0x2200000"
# XEN DTB max size = 1M
XENPOLICY_IMAGE ?= "xenpolicy"
XENPOLICY_IMG_ADDR ?= "0x2300000"
UBOOT_BOOT_SCRIPT ?= "boot.scr"
UBOOT_BOOT_SCRIPT_SOURCE ?= "boot.cmd"
XEN_BOOTARGS ?= "console=dtuart dtuart=\/soc\/serial@7d001000 dom0_mem=128M dom0_max_vcpus=1 xsm=flask flask=permissive"
DOM0_BOOTARGS ?= "console=hvc0 earlycon=xen earlyprintk=xen clk_ignore_unused root=\/dev\/ram0"
DOMD_BOOTARGS ?= "console=ttyAMA0 earlycon=xen earlyprintk=xen clk_ignore_unused root=\/dev\/mmcblk0p2 rootfstype=ext4 rootwait"

do_compile() {
    sed -e 's/@@BOOT_MEDIA@@/${BOOT_MEDIA}/g' \
        -e 's/@@DOM0_IMAGE@@/${DOM0_IMAGE}/g' \
        -e 's/@@DOM0_IMG_ADDR@@/${DOM0_IMG_ADDR}/g' \
        -e 's/@@XEN_IMAGE@@/${XEN_IMAGE}/g' \
        -e 's/@@XEN_IMG_ADDR@@/${XEN_IMG_ADDR}/g' \
        -e 's/@@XEN_DTBO@@/${XEN_DTBO}/g' \
        -e 's/@@XEN_DTBO_ADDR@@/${XEN_DTBO_ADDR}/g' \
        -e 's/@@XENPOLICY_IMAGE@@/${XENPOLICY_IMAGE}/g' \
        -e 's/@@XENPOLICY_IMG_ADDR@@/${XENPOLICY_IMG_ADDR}/g' \
        -e 's/@@DOMD_DTB@@/${DOMD_DTB}/g' \
        -e 's/@@DOMD_DTB_ADDR@@/${DOMD_DTB_ADDR}/g' \
        -e 's/@@DOMD_IMAGE@@/${DOMD_IMAGE}/g' \
        -e 's/@@DOMD_IMG_ADDR@@/${DOMD_IMG_ADDR}/g' \
        -e 's/@@XEN_BOOTARGS@@/${XEN_BOOTARGS}/g' \
        -e 's/@@DOM0_BOOTARGS@@/${DOM0_BOOTARGS}/g' \
        -e 's/@@DOMD_BOOTARGS@@/${DOMD_BOOTARGS}/g' \
        "${WORKDIR}/${TEMPLATE_FILE}" > "${WORKDIR}/${UBOOT_BOOT_SCRIPT_SOURCE}"

    mkimage -A ${UBOOT_ARCH} -T script -C none -n "Boot script" -d "${WORKDIR}/${UBOOT_BOOT_SCRIPT_SOURCE}" ${UBOOT_BOOT_SCRIPT}
}

inherit kernel-arch deploy nopackages

do_deploy() {
    install -d ${DEPLOYDIR}
    install -m 0644 ${UBOOT_BOOT_SCRIPT} ${DEPLOYDIR}
    install -m 0644 ${WORKDIR}/${UBOOT_BOOT_SCRIPT_SOURCE} ${DEPLOYDIR}
}

addtask do_deploy after do_compile before do_build

PROVIDES += "u-boot-default-script"
