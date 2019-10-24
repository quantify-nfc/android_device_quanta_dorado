# #
# # Copyright 2014 The Android Open-Source Project
# #
# # Licensed under the Apache License, Version 2.0 (the "License");
# # you may not use this file except in compliance with the License.
# # You may obtain a copy of the License at
# #
# #      http://www.apache.org/licenses/LICENSE-2.0
# #
# # Unless required by applicable law or agreed to in writing, software
# # distributed under the License is distributed on an "AS IS" BASIS,
# # WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# # See the License for the specific language governing permissions and
# # limitations under the License.
# #

# ifeq ($(TARGET_PREBUILT_KERNEL),)
# LOCAL_KERNEL := device/quanta/dorado-kernel/zImage-dtb
# else
# LOCAL_KERNEL := $(TARGET_PREBUILT_KERNEL)
# endif

# PRODUCT_COPY_FILES := \
# 	$(LOCAL_KERNEL):kernel

# $(call inherit-product-if-exists, vendor/quanta/dorado/device-vendor.mk)

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