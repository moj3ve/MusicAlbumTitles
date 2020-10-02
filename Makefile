PACKAGE_VERSION = 1.0
TARGET := iphone:clang:latest:7.0
INSTALL_TARGET_PROCESSES = SpringBoard


include $(THEOS)/makefiles/common.mk

TWEAK_NAME = MusicAlbumTitles

MusicAlbumTitles_FILES = Tweak.x
MusicAlbumTitles_CFLAGS = -fobjc-arc

include $(THEOS_MAKE_PATH)/tweak.mk
