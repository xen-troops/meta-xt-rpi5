FILESEXTRAPATHS:prepend := "${THISDIR}/files:"
COMPATIBLE_MACHINE:raspberrypi5 = "(raspberrypi5)"

RPI_KERNEL_DEVICETREE:append = " broadcom/bcm2712-${MACHINE}-xen.dtb"

SRC_URI:append = " \
    ${@bb.utils.contains("DISTRO_FEATURES", "xen", "file://xen-console.cfg", "", d)} \
    file://set-cmdline.cfg \
    file://bcm2712-${MACHINE}-xen.dts;subdir=git/arch/${ARCH}/boot/dts/broadcom \
"
