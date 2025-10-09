FILESEXTRAPATHS:prepend := "${THISDIR}/files:"

require xen.inc
require xen-source.inc

SRC_URI:append = " \
    file://xen-config.cfg \
    file://xen-early-printk.cfg \
"

PACKAGECONFIG:append = " xsm"
