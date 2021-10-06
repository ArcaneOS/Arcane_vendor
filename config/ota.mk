ifneq ($(filter OFFICIAL CI,$(ARCANE_BUILD_TYPE)),)
PRODUCT_PACKAGES += \
    Updates
endif
