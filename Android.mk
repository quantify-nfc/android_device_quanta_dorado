#
# This empty Android.mk file exists to prevent the build system from
# automatically including any other Android.mk files under this directory.
#


LOCAL_PATH := $(call my-dir)
include $(CLEAR_VARS)
include $(call first-makefiles-under,$(LOCAL_PATH))

include $(CLEAR_VARS)
LOCAL_MODULE       := wpa_supplicant.conf
LOCAL_MODULE_TAGS  := optional
LOCAL_MODULE_CLASS := ETC
LOCAL_SRC_FILES    := $(LOCAL_MODULE)
LOCAL_MODULE_PATH  := $(TARGET_OUT_ETC)/wifi
include $(BUILD_PREBUILT)

#include $(call all-makefiles-under,$(LOCAL_PATH))

# Module name should match apk name to be installed.
include $(CLEAR_VARS)
LOCAL_MODULE := remove-core-packages

LOCAL_OVERRIDES_PACKAGES := AlarmClock \
                            BasicSmsReceiver \
                            Browser \
                            Contacts \
                            DeskClock \
                            Dialer \
                            DownloadProviderUi \
                            Email \
                            Exchange2 \
                            ExactCalculator \
                            InCallUI \
                            Launcher2 \
                            MmsService \
                            Phone \
                            PrintSpooler \
                            QuickSearchBox \
                            SpeechRecorder \
                            Telecom \
                            TelephonyProvider \
                            TeleService \
                            UnifiedEmail \
                            VpnDialogs

ifeq ($(TARGET_BUILD_VARIANT),user)
LOCAL_OVERRIDES_PACKAGES += \
                            BTTestApp \
                            HiddTestApp \
                            com.qualcomm.qti.auth.fidocryptosample \
                            NativeAudioLatency \

endif


ifneq ($(TARGET_BUILD_VARIANT),eng)
LOCAL_OVERRIDES_PACKAGES += \
                           BTTestApp \
                           HiddTestApp \
                           BTLogKit \
                           BTLogSave
endif

LOCAL_CERTIFICATE := platform
LOCAL_MODULE_TAGS := optional

LOCAL_SRC_FILES := $(LOCAL_MODULE).apk
LOCAL_MODULE_CLASS := APPS
LOCAL_MODULE_SUFFIX := $(COMMON_ANDROID_PACKAGE_SUFFIX)
LOCAL_DEX_PREOPT := false

include $(BUILD_PREBUILT)