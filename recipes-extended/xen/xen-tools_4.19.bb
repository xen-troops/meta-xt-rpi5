# Avoid redundant runtime dependency on python3-core
RDEPENDS:${PN}:remove:class-target = " ${PYTHON_PN}-core" 

SRC_URI = " \
    ${XEN_URL} \
"
SRCREV = "${XEN_REV}"
PACKAGECONFIG:append = " xsm"

FILES:${PN}-flask = " /boot/xenpolicy-${XEN_REL}*"

# Remove the recommendation for Qemu for non-hvm x86 added in meta-virtualization layer
RRECOMMENDS:${PN}:remove = " qemu"
S = "${WORKDIR}/git"

DEFAULT_PREFERENCE ??= "-1"

require recipes-extended/xen/xen.inc
require recipes-extended/xen/xen-tools.inc
require xen-source.inc
