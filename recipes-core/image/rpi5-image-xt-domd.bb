require rpi5-image-minimal-domd.bb

PACKAGE_INSTALL:append = " \
    kernel-modules \
"
