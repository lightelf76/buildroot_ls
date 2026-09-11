################################################################################
#
# ffmpeg
#
################################################################################

FFMPEG81_VERSION = n8.1
FFMPEG81_SITE = https://github.com/lightelf76/
FFMPEG81_SOURCE = $(FFMPEG81_VERSION).tar.gz
FFMPEG_INSTALL_STAGING = YES

FFMPEG81_LICENSE = LGPL-2.1+, libjpeg license
FFMPEG_LICENSE_FILES = LICENSE.md COPYING.LGPLv2.1
ifeq ($(BR2_PACKAGE_FFMPEG81_GPL),y)
FFMPEG81_LICENSE += and GPL-2.0+
FFMPEG81_LICENSE_FILES += COPYING.GPLv2
endif

FFMPEG81_CPE_ID_VENDOR = ffmpeg

FFMPEG81_CONF_OPTS = \
	--prefix=/usr \
	--enable-avfilter \
	--disable-version3 \
	--enable-logging \
	--enable-optimizations \
	--disable-extra-warnings \
	--enable-avdevice \
	--enable-avcodec \
	--enable-avformat \
	--enable-network \
	--disable-gray \
	--enable-swscale-alpha \
	--disable-small \
	--disable-crystalhd \
	--disable-dxva2 \
	--enable-runtime-cpudetect \
	--disable-hardcoded-tables \
	--disable-mipsdsp \
	--disable-mipsdspr2 \
	--disable-msa \
	--enable-hwaccels \
	--disable-cuda \
	--disable-cuvid \
	--disable-nvenc \
	--disable-avisynth \
	--disable-frei0r \
	--disable-libopencore-amrnb \
	--disable-libopencore-amrwb \
	--disable-libdc1394 \
	--disable-libgsm \
	--disable-libilbc \
	--disable-libvo-amrwbenc \
	--disable-symver \
	--disable-doc \
	--disable-mmal \
	--disable-omx \
	--disable-omx-rpi

FFMPEG81_DEPENDENCIES += host-pkgconf

ifeq ($(BR2_PACKAGE_FFMPEG81_GPL),y)
FFMPEG81_CONF_OPTS += --enable-gpl
else
FFMPEG81_CONF_OPTS += --disable-gpl
endif

ifeq ($(BR2_PACKAGE_FFMPEG81_NONFREE),y)
FFMPEG81_CONF_OPTS += --enable-nonfree
else
FFMPEG81_CONF_OPTS += --disable-nonfree
endif

ifeq ($(BR2_PACKAGE_FFMPEG81_FFMPEG),y)
FFMPEG81_CONF_OPTS += --enable-ffmpeg
else
FFMPEG81_CONF_OPTS += --disable-ffmpeg
endif

ifeq ($(BR2_PACKAGE_FFMPEG81_FFPLAY),y)
FFMPEG81_DEPENDENCIES += sdl2
FFMPEG81_CONF_OPTS += --enable-ffplay
FFMPEG81_CONF_ENV += SDL_CONFIG=$(STAGING_DIR)/usr/bin/sdl2-config
else
FFMPEG81_CONF_OPTS += --disable-ffplay
endif

ifeq ($(BR2_PACKAGE_JACK1),y)
FFMPEG81_CONF_OPTS += --enable-libjack
FFMPEG81_DEPENDENCIES += jack1
else ifeq ($(BR2_PACKAGE_JACK2),y)
FFMPEG81_CONF_OPTS += --enable-libjack
FFMPEG81_DEPENDENCIES += jack2
else
FFMPEG81_CONF_OPTS += --disable-libjack
endif

ifeq ($(BR2_PACKAGE_PULSEAUDIO),y)
FFMPEG81_DEPENDENCIES += pulseaudio
FFMPEG81_CONF_OPTS += --enable-libpulse
else
FFMPEG81_CONF_OPTS += --disable-libpulse
endif

ifeq ($(BR2_PACKAGE_LIBV4L),y)
FFMPEG81_DEPENDENCIES += libv4l
FFMPEG81_CONF_OPTS += --enable-libv4l2
else
FFMPEG81_CONF_OPTS += --disable-libv4l2
endif

ifeq ($(BR2_PACKAGE_FFMPEG81_FFPROBE),y)
FFMPEG81_CONF_OPTS += --enable-ffprobe
else
FFMPEG81_CONF_OPTS += --disable-ffprobe
endif

ifeq ($(BR2_PACKAGE_FFMPEG81_XCBGRAB),y)
FFMPEG81_CONF_OPTS += \
	--enable-libxcb \
	--enable-libxcb-shape \
	--enable-libxcb-shm \
	--enable-libxcb-xfixes
FFMPEG81_DEPENDENCIES += libxcb
else
FFMPEG81_CONF_OPTS += --disable-libxcb
endif

ifeq ($(BR2_PACKAGE_FFMPEG81_POSTPROC),y)
FFMPEG81_CONF_OPTS += --enable-postproc
else
FFMPEG81_CONF_OPTS += --disable-postproc
endif

ifeq ($(BR2_PACKAGE_FFMPEG81_SWSCALE),y)
FFMPEG81_CONF_OPTS += --enable-swscale
else
FFMPEG81_CONF_OPTS += --disable-swscale
endif

ifneq ($(call qstrip,$(BR2_PACKAGE_FFMPEG81_ENCODERS)),all)
FFMPEG81_CONF_OPTS += --disable-encoders \
	$(foreach x,$(call qstrip,$(BR2_PACKAGE_FFMPEG81_ENCODERS)),--enable-encoder=$(x))
endif

ifneq ($(call qstrip,$(BR2_PACKAGE_FFMPEG81_DECODERS)),all)
FFMPEG81_CONF_OPTS += --disable-decoders \
	$(foreach x,$(call qstrip,$(BR2_PACKAGE_FFMPEG81_DECODERS)),--enable-decoder=$(x))
endif

ifneq ($(call qstrip,$(BR2_PACKAGE_FFMPEG81_MUXERS)),all)
FFMPEG81_CONF_OPTS += --disable-muxers \
	$(foreach x,$(call qstrip,$(BR2_PACKAGE_FFMPEG81_MUXERS)),--enable-muxer=$(x))
endif

ifneq ($(call qstrip,$(BR2_PACKAGE_FFMPEG81_DEMUXERS)),all)
FFMPEG81_CONF_OPTS += --disable-demuxers \
	$(foreach x,$(call qstrip,$(BR2_PACKAGE_FFMPEG81_DEMUXERS)),--enable-demuxer=$(x))
endif

ifneq ($(call qstrip,$(BR2_PACKAGE_FFMPEG81_PARSERS)),all)
FFMPEG81_CONF_OPTS += --disable-parsers \
	$(foreach x,$(call qstrip,$(BR2_PACKAGE_FFMPEG81_PARSERS)),--enable-parser=$(x))
endif

ifneq ($(call qstrip,$(BR2_PACKAGE_FFMPEG81_BSFS)),all)
FFMPEG81_CONF_OPTS += --disable-bsfs \
	$(foreach x,$(call qstrip,$(BR2_PACKAGE_FFMPEG81_BSFS)),--enable-bsf=$(x))
endif

ifneq ($(call qstrip,$(BR2_PACKAGE_FFMPEG81_PROTOCOLS)),all)
FFMPEG81_CONF_OPTS += --disable-protocols \
	$(foreach x,$(call qstrip,$(BR2_PACKAGE_FFMPEG81_PROTOCOLS)),--enable-protocol=$(x))
endif

ifneq ($(call qstrip,$(BR2_PACKAGE_FFMPEG81_FILTERS)),all)
FFMPEG81_CONF_OPTS += --disable-filters \
	$(foreach x,$(call qstrip,$(BR2_PACKAGE_FFMPEG81_FILTERS)),--enable-filter=$(x))
endif

ifeq ($(BR2_PACKAGE_FFMPEG81_INDEVS),y)
FFMPEG81_CONF_OPTS += --enable-indevs
ifeq ($(BR2_PACKAGE_ALSA_LIB),y)
FFMPEG81_CONF_OPTS += --enable-alsa
FFMPEG81_DEPENDENCIES += alsa-lib
else
FFMPEG81_CONF_OPTS += --disable-alsa
endif
else
FFMPEG81_CONF_OPTS += --disable-indevs
endif

ifeq ($(BR2_PACKAGE_FFMPEG81_OUTDEVS),y)
FFMPEG81_CONF_OPTS += --enable-outdevs
ifeq ($(BR2_PACKAGE_ALSA_LIB),y)
FFMPEG81_DEPENDENCIES += alsa-lib
endif
else
FFMPEG81_CONF_OPTS += --disable-outdevs
endif

ifeq ($(BR2_TOOLCHAIN_HAS_THREADS),y)
FFMPEG81_CONF_OPTS += --enable-pthreads
else
FFMPEG81_CONF_OPTS += --disable-pthreads
endif

ifeq ($(BR2_PACKAGE_ZLIB),y)
FFMPEG81_CONF_OPTS += --enable-zlib
FFMPEG81_DEPENDENCIES += zlib
else
FFMPEG81_CONF_OPTS += --disable-zlib
endif

ifeq ($(BR2_PACKAGE_BZIP2),y)
FFMPEG81_CONF_OPTS += --enable-bzlib
FFMPEG81_DEPENDENCIES += bzip2
else
FFMPEG81_CONF_OPTS += --disable-bzlib
endif

ifeq ($(BR2_PACKAGE_FDK_AAC)$(BR2_PACKAGE_FFMPEG81_NONFREE),yy)
FFMPEG81_CONF_OPTS += --enable-libfdk-aac
FFMPEG81_DEPENDENCIES += fdk-aac
else
FFMPEG81_CONF_OPTS += --disable-libfdk-aac
endif

ifeq ($(BR2_PACKAGE_FFMPEG81_GPL)$(BR2_PACKAGE_LIBCDIO_PARANOIA),yy)
FFMPEG81_CONF_OPTS += --enable-libcdio
FFMPEG81_DEPENDENCIES += libcdio-paranoia
else
FFMPEG81_CONF_OPTS += --disable-libcdio
endif

ifeq ($(BR2_PACKAGE_GNUTLS),y)
FFMPEG81_CONF_OPTS += --enable-gnutls --disable-openssl
FFMPEG81_DEPENDENCIES += gnutls
else
FFMPEG81_CONF_OPTS += --disable-gnutls
ifeq ($(BR2_PACKAGE_OPENSSL),y)
# openssl isn't license compatible with GPL
ifeq ($(BR2_PACKAGE_FFMPEG81_GPL)x$(BR2_PACKAGE_FFMPEG81_NONFREE),yx)
FFMPEG81_CONF_OPTS += --disable-openssl
else
FFMPEG81_CONF_OPTS += --enable-openssl
FFMPEG81_DEPENDENCIES += openssl
endif
else
FFMPEG81_CONF_OPTS += --disable-openssl
endif
endif

ifeq ($(BR2_PACKAGE_LIBDRM),y)
FFMPEG81_CONF_OPTS += --enable-libdrm
FFMPEG81_DEPENDENCIES += libdrm
else
FFMPEG81_CONF_OPTS += --disable-libdrm
endif

ifeq ($(BR2_PACKAGE_LIBOPENH264),y)
FFMPEG81_CONF_OPTS += --enable-libopenh264
FFMPEG81_DEPENDENCIES += libopenh264
else
FFMPEG81_CONF_OPTS += --disable-libopenh264
endif

ifeq ($(BR2_PACKAGE_LIBVORBIS),y)
FFMPEG81_DEPENDENCIES += libvorbis
FFMPEG81_CONF_OPTS += \
	--enable-libvorbis \
	--enable-muxer=ogg \
	--enable-encoder=libvorbis
endif

ifeq ($(BR2_PACKAGE_LIBVA),y)
FFMPEG81_CONF_OPTS += --enable-vaapi
FFMPEG81_DEPENDENCIES += libva
else
FFMPEG81_CONF_OPTS += --disable-vaapi
endif

ifeq ($(BR2_PACKAGE_LIBVDPAU),y)
FFMPEG81_CONF_OPTS += --enable-vdpau
FFMPEG81_DEPENDENCIES += libvdpau
else
FFMPEG81_CONF_OPTS += --disable-vdpau
endif

# To avoid a circular dependency only use opencv if opencv itself does
# not depend on ffmpeg.
ifeq ($(BR2_PACKAGE_OPENCV4_LIB_IMGPROC)x$(BR2_PACKAGE_OPENCV4_WITH_FFMPEG81),yx)
FFMPEG81_CONF_OPTS += --enable-libopencv \
	--extra-cflags=-I$(STAGING_DIR)/usr/include/opencv4
FFMPEG81_DEPENDENCIES += opencv4
else
FFMPEG81_CONF_OPTS += --disable-libopencv
endif

ifeq ($(BR2_PACKAGE_OPUS),y)
FFMPEG81_CONF_OPTS += --enable-libopus
FFMPEG81_DEPENDENCIES += opus
else
FFMPEG81_CONF_OPTS += --disable-libopus
endif

ifeq ($(BR2_PACKAGE_LIBVPX),y)
FFMPEG81_CONF_OPTS += --enable-libvpx
FFMPEG81_DEPENDENCIES += libvpx
else
FFMPEG81_CONF_OPTS += --disable-libvpx
endif

ifeq ($(BR2_PACKAGE_LIBASS),y)
FFMPEG81_CONF_OPTS += --enable-libass
FFMPEG81_DEPENDENCIES += libass
else
FFMPEG81_CONF_OPTS += --disable-libass
endif

ifeq ($(BR2_PACKAGE_LIBBLURAY),y)
FFMPEG81_CONF_OPTS += --enable-libbluray
FFMPEG81_DEPENDENCIES += libbluray
else
FFMPEG81_CONF_OPTS += --disable-libbluray
endif

ifeq ($(BR2_PACKAGE_LIBVPL),y)
FFMPEG81_CONF_OPTS += --enable-libvpl --disable-libmfx
FFMPEG81_DEPENDENCIES += libvpl
else ifeq ($(BR2_PACKAGE_INTEL_MEDIASDK),y)
FFMPEG81_CONF_OPTS += --disable-libvpl --enable-libmfx
FFMPEG81_DEPENDENCIES += intel-mediasdk
else
FFMPEG81_CONF_OPTS += --disable-libvpl --disable-libmfx
endif

ifeq ($(BR2_PACKAGE_RTMPDUMP),y)
FFMPEG81_CONF_OPTS += --enable-librtmp
FFMPEG81_DEPENDENCIES += rtmpdump
else
FFMPEG81_CONF_OPTS += --disable-librtmp
endif

ifeq ($(BR2_PACKAGE_LAME),y)
FFMPEG81_CONF_OPTS += --enable-libmp3lame
FFMPEG81_DEPENDENCIES += lame
else
FFMPEG81_CONF_OPTS += --disable-libmp3lame
endif

ifeq ($(BR2_PACKAGE_LIBMODPLUG),y)
FFMPEG81_CONF_OPTS += --enable-libmodplug
FFMPEG81_DEPENDENCIES += libmodplug
else
FFMPEG81_CONF_OPTS += --disable-libmodplug
endif

ifeq ($(BR2_PACKAGE_LIBOPENMPT),y)
FFMPEG81_CONF_OPTS += --enable-libopenmpt
FFMPEG81_DEPENDENCIES += libopenmpt
else
FFMPEG81_CONF_OPTS += --disable-libopenmpt
endif

ifeq ($(BR2_PACKAGE_LIBSOXR),y)
FFMPEG81_CONF_OPTS += --enable-libsoxr
FFMPEG81_DEPENDENCIES += libsoxr
else
FFMPEG81_CONF_OPTS += --disable-libsoxr
endif

ifeq ($(BR2_PACKAGE_SPEEX),y)
FFMPEG81_CONF_OPTS += --enable-libspeex
FFMPEG81_DEPENDENCIES += speex
else
FFMPEG81_CONF_OPTS += --disable-libspeex
endif

ifeq ($(BR2_PACKAGE_LIBTHEORA),y)
FFMPEG81_CONF_OPTS += --enable-libtheora
FFMPEG81_DEPENDENCIES += libtheora
else
FFMPEG81_CONF_OPTS += --disable-libtheora
endif

ifeq ($(BR2_PACKAGE_LIBICONV),y)
FFMPEG81_CONF_OPTS += --enable-iconv
FFMPEG81_DEPENDENCIES += libiconv
else
FFMPEG81_CONF_OPTS += --disable-iconv
endif

ifeq ($(BR2_PACKAGE_LIBXML2),y)
FFMPEG81_CONF_OPTS += --enable-libxml2
FFMPEG81_DEPENDENCIES += libxml2
else
FFMPEG81_CONF_OPTS += --disable-libxml2
endif

# ffmpeg freetype support require fenv.h which is only
# available/working on glibc.
# The microblaze variant doesn't provide the needed exceptions
ifeq ($(BR2_PACKAGE_FREETYPE)$(BR2_TOOLCHAIN_USES_GLIBC)x$(BR2_microblaze),yyx)
FFMPEG81_CONF_OPTS += --enable-libfreetype
FFMPEG81_DEPENDENCIES += freetype
else
FFMPEG81_CONF_OPTS += --disable-libfreetype
endif

ifeq ($(BR2_PACKAGE_FONTCONFIG),y)
FFMPEG81_CONF_OPTS += --enable-fontconfig
FFMPEG81_DEPENDENCIES += fontconfig
else
FFMPEG81_CONF_OPTS += --disable-fontconfig
endif

ifeq ($(BR2_PACKAGE_HARFBUZZ),y)
FFMPEG81_CONF_OPTS += --enable-libharfbuzz
FFMPEG81_DEPENDENCIES += harfbuzz
else
FFMPEG81_CONF_OPTS += --disable-libharfbuzz
endif

ifeq ($(BR2_PACKAGE_LIBFRIBIDI),y)
FFMPEG81_CONF_OPTS += --enable-libfribidi
FFMPEG81_DEPENDENCIES += libfribidi
else
FFMPEG81_CONF_OPTS += --disable-libfribidi
endif

ifeq ($(BR2_PACKAGE_OPENJPEG),y)
FFMPEG81_CONF_OPTS += --enable-libopenjpeg
FFMPEG81_DEPENDENCIES += openjpeg
else
FFMPEG81_CONF_OPTS += --disable-libopenjpeg
endif

ifeq ($(BR2_PACKAGE_X264)$(BR2_PACKAGE_FFMPEG81_GPL),yy)
FFMPEG81_CONF_OPTS += --enable-libx264
FFMPEG81_DEPENDENCIES += x264
else
FFMPEG81_CONF_OPTS += --disable-libx264
endif

ifeq ($(BR2_PACKAGE_X265)$(BR2_PACKAGE_FFMPEG81_GPL),yy)
FFMPEG81_CONF_OPTS += --enable-libx265
FFMPEG81_DEPENDENCIES += x265
else
FFMPEG81_CONF_OPTS += --disable-libx265
endif

ifeq ($(BR2_PACKAGE_DAV1D),y)
FFMPEG81_CONF_OPTS += --enable-libdav1d
FFMPEG81_DEPENDENCIES += dav1d
else
FFMPEG81_CONF_OPTS += --disable-libdav1d
endif

ifeq ($(BR2_X86_CPU_HAS_MMX),y)
FFMPEG81_CONF_OPTS += --enable-x86asm
FFMPEG81_DEPENDENCIES += host-nasm
else
FFMPEG81_CONF_OPTS += --disable-x86asm
FFMPEG81_CONF_OPTS += --disable-mmx
endif

ifeq ($(BR2_X86_CPU_HAS_SSE),y)
FFMPEG81_CONF_OPTS += --enable-sse
else
FFMPEG81_CONF_OPTS += --disable-sse
endif

ifeq ($(BR2_X86_CPU_HAS_SSE2),y)
FFMPEG81_CONF_OPTS += --enable-sse2
else
FFMPEG81_CONF_OPTS += --disable-sse2
endif

ifeq ($(BR2_X86_CPU_HAS_SSE3),y)
FFMPEG81_CONF_OPTS += --enable-sse3
else
FFMPEG81_CONF_OPTS += --disable-sse3
endif

ifeq ($(BR2_X86_CPU_HAS_SSSE3),y)
FFMPEG81_CONF_OPTS += --enable-ssse3
else
FFMPEG81_CONF_OPTS += --disable-ssse3
endif

ifeq ($(BR2_X86_CPU_HAS_SSE4),y)
FFMPEG81_CONF_OPTS += --enable-sse4
else
FFMPEG81_CONF_OPTS += --disable-sse4
endif

ifeq ($(BR2_X86_CPU_HAS_SSE42),y)
FFMPEG81_CONF_OPTS += --enable-sse42
else
FFMPEG81_CONF_OPTS += --disable-sse42
endif

ifeq ($(BR2_X86_CPU_HAS_AVX),y)
FFMPEG81_CONF_OPTS += --enable-avx
else
FFMPEG81_CONF_OPTS += --disable-avx
endif

ifeq ($(BR2_X86_CPU_HAS_AVX2),y)
FFMPEG81_CONF_OPTS += --enable-avx2
else
FFMPEG81_CONF_OPTS += --disable-avx2
endif

# Explicitly disable everything that doesn't match for ARM
# FFMPEG "autodetects" by compiling an extended instruction via AS
# This works on compilers that aren't built for generic by default
ifeq ($(BR2_ARM_CPU_ARMV4),y)
FFMPEG81_CONF_OPTS += --disable-armv5te
endif
ifeq ($(BR2_ARM_CPU_ARMV6)$(BR2_ARM_CPU_ARMV7A),y)
FFMPEG81_CONF_OPTS += --enable-armv6
else
FFMPEG81_CONF_OPTS += --disable-armv6 --disable-armv6t2
endif
ifeq ($(BR2_ARM_CPU_HAS_VFPV2),y)
FFMPEG81_CONF_OPTS += --enable-vfp
else
FFMPEG81_CONF_OPTS += --disable-vfp
endif
ifeq ($(BR2_ARM_CPU_HAS_NEON),y)
FFMPEG81_CONF_OPTS += --enable-neon
else ifeq ($(BR2_aarch64),y)
FFMPEG81_CONF_OPTS += --enable-neon
else
FFMPEG81_CONF_OPTS += --disable-neon
endif

ifeq ($(BR2_mips)$(BR2_mipsel)$(BR2_mips64)$(BR2_mips64el),y)
ifeq ($(BR2_MIPS_SOFT_FLOAT),y)
FFMPEG81_CONF_OPTS += --disable-mipsfpu
else
FFMPEG81_CONF_OPTS += --enable-mipsfpu
endif

# Fix build failure on several missing assembly instructions
FFMPEG81_CONF_OPTS += --disable-asm
endif # MIPS

ifeq ($(BR2_POWERPC_CPU_HAS_ALTIVEC):$(BR2_powerpc64le),y:)
FFMPEG81_CONF_OPTS += --enable-altivec
else ifeq ($(BR2_POWERPC_CPU_HAS_VSX):$(BR2_powerpc64le),y:y)
# On LE, ffmpeg AltiVec support needs VSX intrinsics, and VSX
# is an extension to AltiVec.
FFMPEG81_CONF_OPTS += --enable-altivec
else
FFMPEG81_CONF_OPTS += --disable-altivec
endif

# Fix build failure on several missing assembly instructions
ifeq ($(BR2_RISCV_32),y)
FFMPEG81_CONF_OPTS += --disable-rvv --disable-asm
endif

# Uses __atomic_fetch_add_4
ifeq ($(BR2_TOOLCHAIN_HAS_LIBATOMIC),y)
FFMPEG81_CONF_OPTS += --extra-libs=-latomic
endif

ifeq ($(BR2_STATIC_LIBS),)
FFMPEG81_CONF_OPTS += --enable-pic
else
FFMPEG81_CONF_OPTS += --disable-pic
endif

# Default to --cpu=generic for MIPS architecture, in order to avoid a
# warning from ffmpeg's configure script.
ifeq ($(BR2_mips)$(BR2_mipsel)$(BR2_mips64)$(BR2_mips64el),y)
FFMPEG81_CONF_OPTS += --cpu=generic
else ifneq ($(GCC_TARGET_CPU),)
FFMPEG81_CONF_OPTS += --cpu="$(GCC_TARGET_CPU)"
else ifneq ($(GCC_TARGET_ARCH),)
FFMPEG81_CONF_OPTS += --cpu="$(GCC_TARGET_ARCH)"
endif

FFMPEG81_CFLAGS = $(TARGET_CFLAGS)

ifeq ($(BR2_TOOLCHAIN_HAS_GCC_BUG_85180),y)
FFMPEG81_CONF_OPTS += --disable-optimizations
FFMPEG81_CFLAGS += -O0
endif

ifeq ($(BR2_TOOLCHAIN_HAS_GCC_BUG_68485),y)
FFMPEG81_CONF_OPTS += --disable-optimizations
FFMPEG81_CFLAGS += -O0
endif

ifeq ($(BR2_ARM_INSTRUCTIONS_THUMB),y)
FFMPEG81_CFLAGS += -marm
endif

FFMPEG81_CONF_ENV += CFLAGS="$(FFMPEG81_CFLAGS)"
FFMPEG81_CONF_OPTS += $(call qstrip,$(BR2_PACKAGE_FFMPEG81_EXTRACONF))

# Override FFMPEG81_CONFIGURE_CMDS: FFmpeg does not support --target and others
define FFMPEG81_CONFIGURE_CMDS
	(cd $(FFMPEG81_SRCDIR) && rm -rf config.cache && \
	$(TARGET_CONFIGURE_OPTS) \
	$(TARGET_CONFIGURE_ARGS) \
	$(FFMPEG81_CONF_ENV) \
	./configure \
		--enable-cross-compile \
		--cross-prefix=$(TARGET_CROSS) \
		--sysroot=$(STAGING_DIR) \
		--host-cc="$(HOSTCC)" \
		--arch=$(BR2_ARCH) \
		--target-os="linux" \
		--disable-stripping \
		--pkg-config="$(PKG_CONFIG_HOST_BINARY)" \
		$(SHARED_STATIC_LIBS_OPTS) \
		$(FFMPEG81_CONF_OPTS) \
	)
endef

define FFMPEG81_REMOVE_EXAMPLE_SRC_FILES
	rm -rf $(TARGET_DIR)/usr/share/ffmpeg/examples
endef
FFMPEG81_POST_INSTALL_TARGET_HOOKS += FFMPEG81_REMOVE_EXAMPLE_SRC_FILES

$(eval $(autotools-package))
