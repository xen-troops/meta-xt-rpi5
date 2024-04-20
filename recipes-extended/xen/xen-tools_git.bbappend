# Avoid redundant runtime dependency on python3-core
RDEPENDS:${PN}:remove:class-target = " ${PYTHON_PN}-core" 

require xen-source.inc

PACKAGECONFIG:append = " xsm"

FILES:${PN}-flask = " /boot/xenpolicy-${XEN_REL}*"

# Remove the recommendation for Qemu for non-hvm x86 added in meta-virtualization layer
RRECOMMENDS:${PN}:remove = " qemu"
