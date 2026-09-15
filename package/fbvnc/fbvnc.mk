################################################################################
#
# fbvnc
#
################################################################################

FBVNC_VERSION = 1.0
FBVNC_SITE = $(call github,lightelf76,fbvnc,v$(FBVNC_VERSION))
FBVNC_LICENSE = ISC
FBVNC_LICENSE_FILES = README

define FBVNC_BUILD_CMDS
	$(TARGET_MAKE_ENV) $(MAKE) CC="$(TARGET_CC)" CFLAGS="$(TARGET_CFLAGS)" \
		LDFLAGS="$(TARGET_LDFLAGS)" -C $(@D)
endef

define FBVNC_INSTALL_TARGET_CMDS
	$(INSTALL) -D -m 0755 $(@D)/fbvnc $(TARGET_DIR)/usr/bin/fbvnc
endef

$(eval $(generic-package))