FILESEXTRAPATHS:prepend := "${THISDIR}/files:"

SRC_URI:append = " \
    file://0001-xen-arm-dom0less-build-Alloc-magic-pages-for-Dom0les.patch \
    file://0002-xen-arm-tools-Add-a-new-HVM_PARAM_MAGIC_BASE_PFN-key.patch \
    file://0003-tools-init-dom0less-Avoid-hardcoding-GUEST_MAGIC_BAS.patch \
    file://0004-arm-dom0less-add-TEE-support.patch \
"
