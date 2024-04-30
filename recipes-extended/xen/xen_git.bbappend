FILESEXTRAPATHS:prepend := "${THISDIR}/files:"

require xen-source.inc

SRC_URI:append = " \
    file://xen-config.cfg \
"
