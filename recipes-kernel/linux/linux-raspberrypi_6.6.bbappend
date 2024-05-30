FILESEXTRAPATHS:prepend := "${THISDIR}/files:"
COMPATIBLE_MACHINE:raspberrypi5 = "(raspberrypi5)"

DOMU_DTB_NAME = "${RPI_SOC_FAMILY}-${MACHINE}-domd"
XEN_DTB_NAME = "${RPI_SOC_FAMILY}-${MACHINE}-xen"
RPI_KERNEL_DEVICETREE:append = " \
    broadcom/${DOMU_DTB_NAME}.dtb \
    broadcom/${XEN_DTB_NAME}.dtbo \
"

KERNEL_IMAGETYPES:append = " Image.gz"

SRC_URI:append = " \
    ${@bb.utils.contains("DISTRO_FEATURES", "xen", "file://xen-config.cfg", "", d)} \
    file://${DOMU_DTB_NAME}.dts;subdir=git/arch/${ARCH}/boot/dts/broadcom \
    file://${XEN_DTB_NAME}.dtso;subdir=git/arch/${ARCH}/boot/dts/broadcom \
    file://0001-drivers-mmc-host-sdhci-brcmstb-fix-no-pinctrl-case.patch \
"
