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
$(call inherit-product, $(SRC_TARGET_DIR)/product/full_base.mk)
$(call inherit-product, device/quanta/dorado/device.mk)

PRODUCT_NAME := full_dorado
PRODUCT_DEVICE := dorado
PRODUCT_BRAND := Android
PRODUCT_MODEL := dorado
PRODUCT_MANUFACTURER := Quanta

PLATFORM_VERSION_CODENAME=REL
PLATFORM_VERSION=8.1.0

# PRODUCT_COPY_FILES += \
#     device/quanta/dorado/copy/system/media/bootanimation.zip:system/media/bootanimation.zip
