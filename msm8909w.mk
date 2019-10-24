DEVICE_PACKAGE_OVERLAYS := device/quanta/dorado/overlay

BOARD_COMMON_DIR := device/quanta/dorado/common
BOARD_SEPOLICY_8909W_DIR := device/quanta/dorado/sepolicy
BOARD_OPENSOURCE_DIR := device/quanta/dorado/opensource
BOARD_DLKM_DIR := device/quanta/dorado/common/dlkm

BOARD_GPS_HAL := hardware/qcom/gps/msm8909
BOARD_DISPLAY_HAL := hardware/qcom/display/msm8909
BOARD_BT_HAL := hardware/qcom/bt/msm8909
BOARD_WLAN_HAL := hardware/qcom/wlan/msm8909

TARGET_USES_QCOM_BSP := true
ifeq ($(TARGET_USES_QCOM_BSP), true)
# Add QC Video Enhancements flag
TARGET_ENABLE_QC_AV_ENHANCEMENTS := true
endif #TARGET_USES_QCOM_BSP
TARGET_USES_NQ_NFC := false

# Flag to be used when applicable for both LW and LAW
TARGET_SUPPORTS_WEARABLES := true

#QTIC flag
-include $(QCPATH)/common/config/qtic-config.mk

# media_profiles and media_codecs xmls for msm8909
ifeq ($(TARGET_ENABLE_QC_AV_ENHANCEMENTS), true)
PRODUCT_COPY_FILES += device/quanta/dorado/media/media_profiles_8909.xml:system/etc/media_profiles.xml \
                      device/quanta/dorado/media/media_codecs_8909.xml:system/etc/media_codecs.xml
endif

$(call inherit-product, $(BOARD_COMMON_DIR)/common.mk)

PRODUCT_NAME := full_dorado
PRODUCT_DEVICE := dorado
PRODUCT_BRAND := Android
PRODUCT_MODEL := dorado
PRODUCT_MANUFACTURER := Quanta

ifeq ($(strip $(TARGET_USES_QTIC)),true)
# font rendering engine feature switch
-include $(QCPATH)/common/config/rendering-engine.mk
ifneq (,$(strip $(wildcard $(PRODUCT_RENDERING_ENGINE_REVLIB))))
    MULTI_LANG_ENGINE := REVERIE
#   MULTI_LANG_ZAWGYI := REVERIE
endif
endif

#Android EGL implementation
PRODUCT_PACKAGES += libGLES_android

PRODUCT_BOOT_JARS += tcmiface
#PRODUCT_BOOT_JARS += qcmediaplayer

ifneq ($(strip $(QCPATH)),)
PRODUCT_BOOT_JARS += com.qti.dpmframework
PRODUCT_BOOT_JARS += dpmapi
endif

# Feature definition files for msm8909w
PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.hardware.audio.output.xml:system/etc/permissions/android.hardware.audio.output.xml \
    frameworks/native/data/etc/android.hardware.bluetooth_le.xml:system/etc/permissions/android.hardware.bluetooth_le.xml \
    frameworks/native/data/etc/android.hardware.screen.portrait.xml:system/etc/permissions/android.hardware.screen.portrait.xml \
    frameworks/native/data/etc/android.software.connectionservice.xml:system/etc/permissions/android.software.connectionservice.xml

# Feature definition files for msm8909w
PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.hardware.sensor.stepcounter.xml:system/etc/permissions/android.hardware.sensor.stepcounter.xml \
    frameworks/native/data/etc/android.hardware.sensor.stepdetector.xml:system/etc/permissions/android.hardware.sensor.stepdetector.xml \
    frameworks/native/data/etc/android.hardware.sensor.accelerometer.xml:system/etc/permissions/android.hardware.sensor.accelerometer.xml \
    frameworks/native/data/etc/android.hardware.sensor.compass.xml:system/etc/permissions/android.hardware.sensor.compass.xml \
    frameworks/native/data/etc/android.hardware.sensor.gyroscope.xml:system/etc/permissions/android.hardware.sensor.gyroscope.xml \
    frameworks/native/data/etc/android.hardware.sensor.light.xml:system/etc/permissions/android.hardware.sensor.light.xml \
    frameworks/native/data/etc/android.hardware.sensor.proximity.xml:system/etc/permissions/android.hardware.sensor.proximity.xml

#fstab.qcom
PRODUCT_PACKAGES += fstab.qcom

PRODUCT_PACKAGES += \
    libqcomvisualizer \
    libqcompostprocbundle \
    libqcomvoiceprocessing

#OEM Services library
PRODUCT_PACKAGES += oem-services
PRODUCT_PACKAGES += libsubsystem_control
PRODUCT_PACKAGES += libSubSystemShutdown
ifneq ($(strip $(QCPATH)),)
PRODUCT_BOOT_JARS += com.qti.location.sdk
endif

PRODUCT_PACKAGES += contextualmodedozeservice
PRWATCH_PACKAGES += watchwifi
PRWATCH_PACKAGES += qwcontextualmodelib.xml
PRWATCH_PACKAGES += qwcontextualmodelib

# To remove telephony and some other core packages this empty apk overrides them.
PRODUCT_PACKAGES += remove-core-packages

PRODUCT_PACKAGES += wcnss_service

# NFC
ifeq ($(strip $(TARGET_USES_NQ_NFC)),true)
PRODUCT_PACKAGES += \
    NQNfcNci \
    libnqnfc-nci \
    libnqnfc_nci_jni \
    nfc_nci.nqx.default \
    libp61-jcop-kit \
    com.nxp.nfc.nq \
    com.nxp.nfc.nq.xml \
    libpn547_fw.so \
    libpn548ad_fw.so \
    libnfc-brcm.conf \
    libnfc-nxp.conf \
    nqnfcee_access.xml \
    nqnfcse_access.xml \
    Tag \
    com.android.nfc_extras

PRODUCT_COPY_FILES += \
    packages/apps/Nfc/migrate_nfc.txt:system/etc/updatecmds/migrate_nfc.txt \
    frameworks/native/data/etc/com.nxp.mifare.xml:system/etc/permissions/com.nxp.mifare.xml \
    frameworks/native/data/etc/com.android.nfc_extras.xml:system/etc/permissions/com.android.nfc_extras.xml \
    frameworks/native/data/etc/android.hardware.nfc.xml:system/etc/permissions/android.hardware.nfc.xml \
    frameworks/native/data/etc/android.hardware.nfc.hce.xml:system/etc/permissions/android.hardware.nfc.hce.xml
endif # TARGET_USES_NQ_NFC

# Listen configuration file
PRODUCT_COPY_FILES += \
    device/quanta/dorado/listen_platform_info.xml:system/etc/listen_platform_info.xml

# Audio configuration file
PRODUCT_COPY_FILES += \
    device/quanta/dorado/audio_policy.conf:system/etc/audio_policy.conf \
    device/quanta/dorado/audio_effects.conf:system/vendor/etc/audio_effects.conf \
    device/quanta/dorado/mixer_paths_qrd_skuh.xml:system/etc/mixer_paths_qrd_skuh.xml \
    device/quanta/dorado/mixer_paths_qrd_skui.xml:system/etc/mixer_paths_qrd_skui.xml \
    device/quanta/dorado/mixer_paths.xml:system/etc/mixer_paths.xml \
    device/quanta/dorado/mixer_paths_msm8909_pm8916.xml:system/etc/mixer_paths_msm8909_pm8916.xml \
    device/quanta/dorado/mixer_paths_skua.xml:system/etc/mixer_paths_skua.xml \
    device/quanta/dorado/mixer_paths_skuc.xml:system/etc/mixer_paths_skuc.xml \
    device/quanta/dorado/mixer_paths_skue.xml:system/etc/mixer_paths_skue.xml \
    device/quanta/dorado/mixer_paths_qrd_skut.xml:system/etc/mixer_paths_qrd_skut.xml \
    device/quanta/dorado/sound_trigger_mixer_paths.xml:system/etc/sound_trigger_mixer_paths.xml \
    device/quanta/dorado/sound_trigger_platform_info.xml:system/etc/sound_trigger_platform_info.xml

#wlan driver
PRODUCT_COPY_FILES += \
    device/quanta/dorado/WCNSS_qcom_cfg.ini:system/etc/wifi/WCNSS_qcom_cfg.ini \
    device/quanta/dorado/WCNSS_wlan_dictionary.dat:persist/WCNSS_wlan_dictionary.dat \
    device/quanta/dorado/WCNSS_qcom_wlan_nv.bin:persist/WCNSS_qcom_wlan_nv.bin

# Sensor HAL conf file
PRODUCT_COPY_FILES += \
    device/quanta/dorado/sensors/hals.conf:system/etc/sensors/hals.conf

# Set hardware type to watch
PRODUCT_COPY_FILES += \
    device/quanta/dorado/wearable_core_hardware.xml:system/etc/permissions/wearable_core_hardware.xml

PRODUCT_CHARACTERISTICS := nosdcard,watch

PRODUCT_PACKAGES += \
    wpa_supplicant_overlay.conf \
    p2p_supplicant_overlay.conf
#ANT+ stack
PRODUCT_PACKAGES += \
AntHalService \
libantradio \
antradio_app

# Defined the locales
PRODUCT_LOCALES += th_TH vi_VN tl_PH hi_IN ar_EG ru_RU tr_TR pt_BR bn_IN mr_IN ta_IN te_IN zh_HK \
        in_ID my_MM km_KH sw_KE uk_UA pl_PL sr_RS sl_SI fa_IR kn_IN ml_IN ur_IN gu_IN or_IN en_ZA

# Add the overlay path
PRODUCT_PACKAGE_OVERLAYS := $(QCPATH)/qrdplus/Extension/res-overlay \
        $(QCPATH)/qrdplus/globalization/multi-language/res-overlay \
        $(PRODUCT_PACKAGE_OVERLAYS)

# Add the overlay path
PRODUCT_PACKAGE_OVERLAYS := $(QCPATH)/qrdplus/Extension/res-overlay \
        $(QCPATH)/qrdplus/globalization/multi-language/res-overlay \
        device/quanta/dorado/product/overlay \
        $(PRODUCT_PACKAGE_OVERLAYS)

#Enable DM_VERITY support
PRODUCT_SUPPORTS_VERITY := true
PRODUCT_SYSTEM_VERITY_PARTITION := /dev/block/bootdevice/by-name/system

TARGET_WEAR_OUT := $(subst $(ANDROID_BUILD_TOP)/,,$(ANDROID_PRODUCT_OUT))
BOARD_KERNEL_HEADER_DEPENDENCIES := $(TARGET_WEAR_OUT)/obj/KERNEL_OBJ/usr
BOARD_KERNEL_HEADER_DIR := $(BOARD_KERNEL_HEADER_DEPENDENCIES)/include

$(call inherit-product, device/google/clockwork/build/wearable-mdpi-512-dalvik-heap.mk)
