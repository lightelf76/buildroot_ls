################################################################################
#
# libva-v4l2
#
################################################################################

LIBVA_V4L2_VERSION = master
LIBVA_V4L2_SITE = https://github.com/mxsrc/libva-v4l2.git
LIBVA_V4L2_SITE_METHOD = git
LIBVA_V4L2_LICENSE = MIT
LIBVA_V4L2_LICENSE_FILES = COPYING
LIBVA_V4L2_DEPENDENCIES = host-pkgconf libdrm libva libudev
LIBVA_V4L2_CONF_OPTS = -Dkernel_headers=$(STAGING_DIR)/usr/include

$(eval $(meson-package))
