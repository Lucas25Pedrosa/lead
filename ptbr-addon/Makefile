# Standalone Lead 2.0.2 PT-BR companion library. Does not rebuild Lead itself.
ARCHS = arm64 arm64e
TARGET = iphone:16.5:14.0

include $(THEOS)/makefiles/common.mk

LIBRARY_NAME = LeadPTBR
LeadPTBR_FILES = src/LeadPTBR.m
LeadPTBR_CFLAGS = -fobjc-arc -O2 -Wno-deprecated-declarations
LeadPTBR_FRAMEWORKS = Foundation UIKit
LeadPTBR_LDFLAGS = -Wl,-dead_strip -Wl,-install_name,@rpath/LeadPTBR.dylib

include $(THEOS_MAKE_PATH)/library.mk
