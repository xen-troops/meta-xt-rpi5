SUMMARY = "A small image just capable of allowing a device to boot."

require recipes-core/images/core-image-minimal.bb

# Enable package manager
EXTRA_IMAGE_FEATURES += "package-management"

RDEPENDS += "rpi-bootfiles"

# Basic packages
PACKAGE_INSTALL:append = " \
    coreutils \
    u-boot \
    xen \
    xen-tools \
"

IMAGE_FSTYPES:remove = "wic.bz2 wic.bmap ext3"
IMAGE_FSTYPES:append = " ext4"
