################################################################################
#
# libva-v4l2-driver
#
################################################################################

LIBVA_V4L2_DRIVER_VERSION = 11.09.2026
LIBVA_V4L2_DRIVER_SOURCE = libva-v4l2-$(LIBVA_V4L2_DRIVER_VERSION).tar.gz
LIBVA_V4L2_DRIVER_SITE = \
	https://github.com/lightelf76/libva-v4l2/releases/download/
LIBVA_V4L2_DRIVER_LICENSE = MIT
LIBVA_V4L2_DRIVER_LICENSE_FILES = COPYING
LIBVA_V4L2_DRIVER_DEPENDENCIES = host-pkgconf libdrm libva

ifeq ($(BR2_PACKAGE_XORG7),y)
LIBVA_V4L2_DRIVER_DEPENDENCIES += xlib_libX11 xlib_libXext xlib_libXfixes
LIBVA_V4L2_DRIVER_CONF_OPTS += --enable-x11
else
LIBVA_V4L2_DRIVER_CONF_OPTS += --disable-x11
endif

ifeq ($(BR2_PACKAGE_WAYLAND),y)
LIBVA_V4L2_DRIVER_DEPENDENCIES += wayland
LIBVA_V4L2_DRIVER_CONF_OPTS += --enable-wayland
else
LIBVA_V4L2_DRIVER_CONF_OPTS += --disable-wayland
endif

$(eval $(autotools-package))
