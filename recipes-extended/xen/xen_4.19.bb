FILESEXTRAPATHS:prepend := "${THISDIR}/files:"

SRC_URI = " \
    ${XEN_URL} \
    file://xen-config.cfg \
"
SRCREV = "${XEN_REV}"

S = "${WORKDIR}/git"

DEFAULT_PREFERENCE ??= "-1"

require recipes-extended/xen/xen.inc
require recipes-extended/xen/xen-hypervisor.inc
require xen-source.inc
