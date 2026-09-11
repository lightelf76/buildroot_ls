################################################################################
#
# libva-v4l2
#
################################################################################

#LIBVA_V4L2_DRIVER_VERSION = 74b336a
LIBVA_V4L2_DRIVER_VERSION = master
LIBVA_V4L2_DRIVER_SITE = https://github.com/mxsrc/libva-v4l2.git
LIBVA_V4L2_DRIVER_SITE_METHOD = git
LIBVA_V4L2_DRIVER_LICENSE = MIT
LIBVA_V4L2_DRIVER_LICENSE_FILES = COPYING
LIBVA_V4L2_DRIVER_DEPENDENCIES = host-pkgconf libdrm libva libudev
LIBVA_V4L2_DRIVER_CONF_OPTS = -Dkernel_headers=$(STAGING_DIR)/usr/include

$(eval $(meson-package))
