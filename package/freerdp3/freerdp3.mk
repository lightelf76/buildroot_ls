################################################################################
#
# freerdp3
#
################################################################################

FREERDP3_VERSION = 3.31.1
FREERDP3_SITE = https://pub.freerdp.com/releases
FREERDP3_SOURCE = freerdp-$(FREERDP3_VERSION).tar.xz
FREERDP3_LICENSE = Apache-2.0
FREERDP3_LICENSE_FILES = LICENSE
FREERDP3_INSTALL_STAGING = YES

# Отключаем всё лишнее, включаем только SDL2
FREERDP3_CONF_OPTS = \
    -DWITH_MANPAGES=OFF \
    -DWITH_SDL2=ON \
    -DWITH_X11=OFF \
    -DWITH_WAYLAND=OFF \
    -DWITH_OPENSLES=OFF \
    -DWITH_FFMPEG=OFF \
    -DWITH_GSTREAMER_0_10=OFF \
    -DWITH_GSTREAMER_1_0=OFF \
    -DWITH_CUPS=OFF \
    -DWITH_PULSEAUDIO=OFF \
    -DWITH_ALSA=OFF \
    -DWITH_OPENGL=OFF         # принудительно отключаем OpenGL, чтобы не тянуть EGL/GBM

FREERDP3_DEPENDENCIES = \
    sdl2 \
    openssl \
    zlib \
    libglib2 \
    libdrm

$(eval $(cmake-package))
