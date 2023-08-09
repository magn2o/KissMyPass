TARGET = iphone:clang:latest:8.0
ARCHS = armv7 armv7s arm64

include $(THEOS)/makefiles/common.mk

BUNDLE_NAME = KissMyPassPrefs
KissMyPassPrefs_FILES = KissMyPassPrefs.mm KMPActionCell.mm
KissMyPassPrefs_INSTALL_PATH = /Library/PreferenceBundles
KissMyPassPrefs_FRAMEWORKS = UIKit CoreGraphics
KissMyPassPrefs_PRIVATE_FRAMEWORKS = Preferences

include $(THEOS_MAKE_PATH)/bundle.mk

internal-stage::
	$(ECHO_NOTHING)mkdir -p $(THEOS_STAGING_DIR)/Library/PreferenceLoader/Preferences$(ECHO_END)
	$(ECHO_NOTHING)cp entry.plist $(THEOS_STAGING_DIR)/Library/PreferenceLoader/Preferences/KissMyPassPrefs.plist$(ECHO_END)
