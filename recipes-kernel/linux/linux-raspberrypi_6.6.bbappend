FILESEXTRAPATHS:prepend := "${THISDIR}/files:"
COMPATIBLE_MACHINE:raspberrypi5 = "(raspberrypi5)"

DOMU_DT_NAME = "${RPI_SOC_FAMILY}-${MACHINE}-domd"
XEN_DT_NAME = "${RPI_SOC_FAMILY}-${MACHINE}-xen"
USB_DT_NAME = "${RPI_SOC_FAMILY}-${MACHINE}-usb"
MMC_DT_NAME = "${RPI_SOC_FAMILY}-${MACHINE}-mmc"
PCIE1_DT_NAME = "${RPI_SOC_FAMILY}-${MACHINE}-pcie1"

RPI_KERNEL_DEVICETREE:append = " \
    broadcom/${DOMU_DT_NAME}.dtb \
    broadcom/${XEN_DT_NAME}.dtbo \
    broadcom/${USB_DT_NAME}.dtbo \
    broadcom/${MMC_DT_NAME}.dtbo \
    broadcom/${PCIE1_DT_NAME}.dtbo \
    broadcom/mmc-passthrough.dtbo \
    broadcom/usb-passthrough.dtbo \
    broadcom/pcie1-passthrough.dtbo \
"

KERNEL_IMAGETYPES:append = " Image.gz"

SRC_URI:append = " \
    ${@bb.utils.contains("DISTRO_FEATURES", "xen", "file://xen-config.cfg", "", d)} \
    file://${DOMU_DT_NAME}.dts;subdir=git/arch/${ARCH}/boot/dts/broadcom \
    file://${XEN_DT_NAME}.dtso;subdir=git/arch/${ARCH}/boot/dts/broadcom \
    file://${USB_DT_NAME}.dtso;subdir=git/arch/${ARCH}/boot/dts/broadcom \
    file://${MMC_DT_NAME}.dtso;subdir=git/arch/${ARCH}/boot/dts/broadcom \
    file://${PCIE1_DT_NAME}.dtso;subdir=git/arch/${ARCH}/boot/dts/broadcom \
    file://mmc-passthrough.dtso;subdir=git/arch/${ARCH}/boot/dts/broadcom \
    file://usb-passthrough.dtso;subdir=git/arch/${ARCH}/boot/dts/broadcom \
    file://pcie1-passthrough.dtso;subdir=git/arch/${ARCH}/boot/dts/broadcom \
    file://0001-drivers-mmc-host-sdhci-brcmstb-fix-no-pinctrl-case.patch \
"

SRC_URI:append = "${@bb.utils.contains('MACHINE_FEATURES', 'scmi', ' file://scmi-config.cfg', '', d)}"

SRC_URI:append = " \
    file://0001-firmware-arm_scmi-Increase-the-maximum-opp-count-in-.patch \
    file://0002-firmware-arm_scmi-Add-protocol-versioning-checks.patch \
    file://0003-firmware-arm_scmi-Add-optional-flags-to-extended-nam.patch \
    file://0004-firmware-arm_scmi-Add-support-for-multiple-vendors-c.patch \
    file://0005-firmware-arm_scmi-Introduce-get_max_msg_size-helper-.patch \
    file://0006-dt-bindings-firmware-Support-SCMI-pinctrl-protocol.patch \
    file://0007-firmware-arm_scmi-Add-basic-support-for-SCMI-v3.2-pi.patch \
    file://0008-pinctrl-Implementation-of-the-generic-scmi-pinctrl-d.patch \
"
