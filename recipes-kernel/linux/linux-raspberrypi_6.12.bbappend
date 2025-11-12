FILESEXTRAPATHS:prepend := "${THISDIR}/files:"
COMPATIBLE_MACHINE:raspberrypi5 = "(raspberrypi5)"

DOMU_DT_NAME = "${RPI_SOC_FAMILY}-${MACHINE}-domd"
XEN_DT_NAME = "${RPI_SOC_FAMILY}-${MACHINE}-xen"
USB_DT_NAME = "${RPI_SOC_FAMILY}-${MACHINE}-usb"
MMC_DT_NAME = "${RPI_SOC_FAMILY}-${MACHINE}-mmc"
PCIE1_DT_NAME = "${RPI_SOC_FAMILY}-${MACHINE}-pcie1"
CAN_DT_NAME = "${RPI_SOC_FAMILY}-${MACHINE}-can-${DOMD_CAN_TYPE}"
HDMI_DT_NAME = "${RPI_SOC_FAMILY}-${MACHINE}-hdmi"
HDMI_PASSTHROUGH_NAME = "hdmi-passthrough"


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
RPI_KERNEL_DEVICETREE:append = " \
    ${@bb.utils.contains('MACHINE_FEATURES', 'domd_can', 'broadcom/${CAN_DT_NAME}.dtbo', '', d)} \
"

RPI_KERNEL_DEVICETREE:append = " \
    ${@bb.utils.contains('MACHINE_FEATURES', 'domd_hdmi', \
                          ' broadcom/${HDMI_DT_NAME}.dtbo \
                            broadcom/${HDMI_PASSTHROUGH_NAME}.dtbo ', '', d)} \
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

SRC_URI:append = " \
    ${@bb.utils.contains('MACHINE_FEATURES', 'domd_can', \
    ' file://${CAN_DT_NAME}.dtso;subdir=git/arch/${ARCH}/boot/dts/broadcom', '', d)}"

SRC_URI:append = " \
    ${@bb.utils.contains('MACHINE_FEATURES', 'domd_hdmi', \
    ' file://${HDMI_DT_NAME}.dtso;subdir=git/arch/${ARCH}/boot/dts/broadcom \
      file://${HDMI_PASSTHROUGH_NAME}.dtso;subdir=git/arch/${ARCH}/boot/dts/broadcom ', '', d)}"

SRC_URI:append = "${@bb.utils.contains('MACHINE_FEATURES', 'scmi', ' file://scmi-config.cfg', '', d)}"

SRC_URI:append = " file://0001-dt-Add-the-range-for-axi-to-fix-the-mipX-ranges-issu.patch"
