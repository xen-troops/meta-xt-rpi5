SUMMARY = "U-boot boot script for Xen on Raspberry Pi 5"
LICENSE = "MIT"
LIC_FILES_CHKSUM = "file://${COMMON_LICENSE_DIR}/MIT;md5=0835ade698e0bcf8506ecda2f7b4f302"
COMPATIBLE_MACHINE = "^raspberrypi5$"

DEPENDS = "u-boot-mkimage-native"

INHIBIT_DEFAULT_DEPS = "1"

TEMPLATE_FILE = "boot.cmd.xen.in"

SRC_URI = "file://${TEMPLATE_FILE}"

RPI_DOM0_MEM ??= "256M"
RPI_DEBUG_XEN_ARGS ??= "sync_console bootscrub=0"
BOOT_MEDIA ?= "mmc"
DOM0_IMAGE = "zephyr.bin"
#DOM0_IMAGE = "Image"
XEN_IMAGE = "xen"
UBOOT_BOOT_SCRIPT ?= "boot.scr"

do_compile() {
    sed -e 's/@@DOM0_IMAGE@@/${DOM0_IMAGE}/' \
        -e 's/@@XEN_IMAGE@@/${XEN_IMAGE}/' \
        -e 's/@@XEN_DTB@@/${XENdd_DTB}/' \
        -e 's/@@KERNEL_BOOTCMD@@/${KERNEL_BOOTCMD}/' \
        -e 's/@@BOOT_MEDIA@@/${BOOT_MEDIA}/' \
        -e 's/@@RPI_DOM0_MEM@@/${RPI_DOM0_MEM}/' \
        -e 's/@@RPI_DEBUG_XEN_ARGS@@/${RPI_DEBUG_XEN_ARGS}/' \
        "${WORKDIR}/${TEMPLATE_FILE}" > "${WORKDIR}/boot.cmd"

    mkimage -A ${UBOOT_ARCH} -T script -C none -n "Boot script" -d "${WORKDIR}/boot.cmd" ${UBOOT_BOOT_SCRIPT}
}

inherit kernel-arch deploy nopackages

do_deploy() {
    install -d ${DEPLOYDIR}
    install -m 0644 ${UBOOT_BOOT_SCRIPT} ${DEPLOYDIR}
}

addtask do_deploy after do_compile before do_build

PROVIDES += "u-boot-default-script"
