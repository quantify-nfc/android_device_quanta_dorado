#
# This empty Android.mk file exists to prevent the build system from
# automatically including any other Android.mk files under this directory.
#

ifneq ($(filter dorado, $(TARGET_DEVICE)),)

LOCAL_PATH := $(call my-dir)
include $(call first-makefiles-under,$(LOCAL_PATH))

endif