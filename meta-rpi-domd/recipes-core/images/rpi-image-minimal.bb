SUMMARY = "A small image just capable of allowing a device to boot."

require recipes-core/images/core-image-minimal.bb

#COMPATIBLE_MACHINE = "(falcon|condor|eagle|whitehawk|grayhawk)"

# Enable package manager
EXTRA_IMAGE_FEATURES += "package-management"

# Basic packages
IMAGE_INSTALL:append = " \
    bash \
    v4l-utils \
    i2c-tools \
    coreutils \
    xen \
    xen-tools \
    xen-tools-devd \
    xen-tools-xenstore \
    dnsmasq \
    openssh \
"
#DEPENDS += "perl-native libarchive-zip-perl-native"
