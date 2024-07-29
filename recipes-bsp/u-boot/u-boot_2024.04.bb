require recipes-bsp/u-boot/u-boot.inc
require recipes-bsp/u-boot/u-boot-common.inc
require u-boot-src.inc

DEPENDS += "bc-native dtc-native python3-pyelftools-native"

SRC_URI += "\
  file://0001-bcm2712-enable-linux-kernel-image-header.patch \
"
