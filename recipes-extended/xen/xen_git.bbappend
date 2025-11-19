FILESEXTRAPATHS:prepend := "${THISDIR}/files:"

require xen.inc
require xen-source.inc

SRC_URI:append = " \
    file://xen-config.cfg \
    ${@bb.utils.contains("XT_EARLY_PRINTK", "enable", " file://xen-early-printk.cfg", "", d)} \
"

PACKAGECONFIG:append = " xsm"
