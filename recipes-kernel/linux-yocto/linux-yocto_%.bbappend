FILESEXTRAPATHS:prepend := "${THISDIR}/${PN}:"
SRC_URI:append = "  file://adlink-amd-kmeta;type=kmeta;destsuffix=/adlink-amd-kmeta \
"		    
KERNEL_FEATURES:append = " adlink.scc"

#SRCREV_machine = "${AUTOREV}"

#SRCREV_machine = "e6bfde1a9e4ef459ba4b93b0439d1a019e0ad77c"
	    
