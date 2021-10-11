# Build fingerprint
ifeq ($(BUILD_FINGERPRINT),)
BUILD_NUMBER_CUSTOM := $(shell date -u +%H%M)
ifneq ($(filter OFFICIAL,$(ARCANE_BUILD_TYPE)),)
BUILD_SIGNATURE_KEYS := release-keys
else
BUILD_SIGNATURE_KEYS := test-keys
endif
BUILD_FINGERPRINT := $(PRODUCT_BRAND)/$(ARCANE_DEVICE)/$(ARCANE_DEVICE):$(PLATFORM_VERSION)/$(BUILD_ID)/$(BUILD_NUMBER_CUSTOM):$(TARGET_BUILD_VARIANT)/$(BUILD_SIGNATURE_KEYS)
endif
ADDITIONAL_BUILD_PROPERTIES += \
    ro.build.fingerprint=$(BUILD_FINGERPRINT)

# AOSP recovery flashing
ifeq ($(TARGET_USES_AOSP_RECOVERY),true)
ADDITIONAL_BUILD_PROPERTIES += \
    persist.sys.recovery_update=true
endif

# build type
ifeq ($(BUILD_TYPE_IS_OFFICIAL),true)
ARCANE_BUILD_TYPE ?= OFFICIAL
else
ARCANE_BUILD_TYPE ?= UNOFFICIAL
endif

PLATFORM_ARCANE_CODENAME := EXORT
CUSTOM_DATE_YEAR := $(shell date -u +%Y)
CUSTOM_DATE_MONTH := $(shell date -u +%m)
CUSTOM_DATE_DAY := $(shell date -u +%d)
CUSTOM_DATE_HOUR := $(shell date -u +%H)
CUSTOM_DATE_MINUTE := $(shell date -u +%M)
CUSTOM_BUILD_DATE_UTC := $(shell date -d '$(CUSTOM_DATE_YEAR)-$(CUSTOM_DATE_MONTH)-$(CUSTOM_DATE_DAY) $(CUSTOM_DATE_HOUR):$(CUSTOM_DATE_MINUTE) UTC' +%s)
CUSTOM_BUILD_DATE := $(CUSTOM_DATE_YEAR)$(CUSTOM_DATE_MONTH)$(CUSTOM_DATE_DAY)-$(CUSTOM_DATE_HOUR)$(CUSTOM_DATE_MINUTE)

CUSTOM_PLATFORM_VERSION := R

TARGET_PRODUCT_SHORT := $(subst aosp_,,$(CUSTOM_BUILD))

CUSTOM_VERSION := ArcaneOS_$(ARCANE_DEVICE)-$(PLATFORM_ARCANE_CODENAME)-$(ARCANE_BUILD_TYPE)-$(CUSTOM_BUILD_DATE)

ADDITIONAL_BUILD_PROPERTIES += \
    org.arcane.version=$(PLATFORM_ARCANE_CODENAME) \
    org.arcane.version.display=$(CUSTOM_VERSION) \
    org.arcane.build_date=$(CUSTOM_BUILD_DATE) \
    org.arcane.build_date_utc=$(CUSTOM_BUILD_DATE_UTC) \
    org.arcane.build_type=$(ARCANE_BUILD_TYPE)
