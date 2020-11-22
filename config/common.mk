PRODUCT_BRAND ?= ArcaneOS

PRODUCT_BUILD_PROP_OVERRIDES += BUILD_UTC_DATE=0

ifeq ($(PRODUCT_GMS_CLIENTID_BASE),)
PRODUCT_SYSTEM_DEFAULT_PROPERTIES += \
    ro.com.google.clientidbase=android-google
else
PRODUCT_SYSTEM_DEFAULT_PROPERTIES += \
    ro.com.google.clientidbase=$(PRODUCT_GMS_CLIENTID_BASE)
endif

PRODUCT_SYSTEM_DEFAULT_PROPERTIES += \
    dalvik.vm.debug.alloc=0 \
    ro.url.legal=http://www.google.com/intl/%s/mobile/android/basic/phone-legal.html \
    ro.url.legal.android_privacy=http://www.google.com/intl/%s/mobile/android/basic/privacy.html \
    ro.error.receiver.system.apps=com.google.android.gms \
    ro.setupwizard.enterprise_mode=1 \
    ro.com.android.dataroaming=false \
    ro.atrace.core.services=com.google.android.gms,com.google.android.gms.ui,com.google.android.gms.persistent \
    ro.com.android.dateformat=MM-dd-yyyy \
    persist.sys.disable_rescue=true \
    ro.setupwizard.rotation_locked=true

ifeq ($(TARGET_BUILD_VARIANT),eng)
# Disable ADB authentication
PRODUCT_SYSTEM_DEFAULT_PROPERTIES += ro.adb.secure=0
else
# Enable ADB authentication
PRODUCT_SYSTEM_DEFAULT_PROPERTIES += ro.adb.secure=1

# Disable extra StrictMode features on all non-engineering builds
PRODUCT_SYSTEM_DEFAULT_PROPERTIES += persist.sys.strictmode.disable=true
endif

# Lawnchair
include packages/apps/Lawnchair/lawnchair.mk

# Some permissions
PRODUCT_COPY_FILES += \
    vendor/aosp/config/permissions/backup.xml:system/etc/sysconfig/backup.xml \
    vendor/aosp/config/permissions/privapp-permissions-lineagehw.xml:$(TARGET_COPY_OUT_SYSTEM_EXT)/etc/permissions/privapp-permissions-lineagehw.xml

# Copy all custom init rc files
$(foreach f,$(wildcard vendor/aosp/prebuilt/common/etc/init/*.rc),\
    $(eval PRODUCT_COPY_FILES += $(f):system/etc/init/$(notdir $f)))

# Enable Android Beam on all targets
PRODUCT_COPY_FILES += \
    vendor/aosp/config/permissions/android.software.nfc.beam.xml:$(TARGET_COPY_OUT_SYSTEM)/etc/permissions/android.software.nfc.beam.xml

# Enable SIP+VoIP on all targets
PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.software.sip.voip.xml:system/etc/permissions/android.software.sip.voip.xml

# Enable wireless Xbox 360 controller support
PRODUCT_COPY_FILES += \
    frameworks/base/data/keyboards/Vendor_045e_Product_028e.kl:system/usr/keylayout/Vendor_045e_Product_0719.kl

# Enforce privapp-permissions whitelist
PRODUCT_SYSTEM_DEFAULT_PROPERTIES += \
    ro.control_privapp_permissions=enforce

# Power whitelist
PRODUCT_COPY_FILES += \
    vendor/aosp/config/permissions/custom-power-whitelist.xml:system/etc/sysconfig/custom-power-whitelist.xml

# Do not include art debug targets
PRODUCT_ART_TARGET_INCLUDE_DEBUG_BUILD := false

# Fonts to copy
PRODUCT_COPY_FILES += \
    vendor/aosp/prebuilt/fonts/fonts_shishufied.xml:$(TARGET_COPY_OUT_PRODUCT)/etc/fonts_customization.xml \
    vendor/aosp/prebuilt/fonts/gobold/Gobold.ttf:$(TARGET_COPY_OUT_PRODUCT)/fonts/Gobold.ttf \
    vendor/aosp/prebuilt/fonts/gobold/Gobold-Italic.ttf:$(TARGET_COPY_OUT_PRODUCT)/fonts/Gobold-Italic.ttf \
    vendor/aosp/prebuilt/fonts/gobold/GoboldBold.ttf:$(TARGET_COPY_OUT_PRODUCT)/fonts/GoboldBold.ttf \
    vendor/aosp/prebuilt/fonts/gobold/GoboldBold-Italic.ttf:$(TARGET_COPY_OUT_PRODUCT)/fonts/GoboldBold-Italic.ttf \
    vendor/aosp/prebuilt/fonts/gobold/GoboldThinLight.ttf:$(TARGET_COPY_OUT_PRODUCT)/fonts/GoboldThinLight.ttf \
    vendor/aosp/prebuilt/fonts/gobold/GoboldThinLight-Italic.ttf:$(TARGET_COPY_OUT_PRODUCT)/fonts/GoboldThinLight-Italic.ttf \
    vendor/aosp/prebuilt/fonts/roadrage/road_rage.ttf:$(TARGET_COPY_OUT_PRODUCT)/fonts/RoadRage-Regular.ttf \
    vendor/aosp/prebuilt/fonts/snowstorm/snowstorm.ttf:$(TARGET_COPY_OUT_PRODUCT)/fonts/Snowstorm-Regular.ttf \
    vendor/aosp/prebuilt/fonts/vcrosd/vcr_osd_mono.ttf:$(TARGET_COPY_OUT_PRODUCT)/fonts/ThemeableClock-vcrosd.ttf \
    vendor/aosp/prebuilt/fonts/googlesans/GoogleSans-Regular.ttf:$(TARGET_COPY_OUT_PRODUCT)/fonts/GoogleSans-Regular.ttf \
    vendor/aosp/prebuilt/fonts/googlesans/GoogleSans-Medium.ttf:$(TARGET_COPY_OUT_PRODUCT)/fonts/GoogleSans-Medium.ttf \
    vendor/aosp/prebuilt/fonts/fontage/AdamCGPro-Regular.ttf:$(TARGET_COPY_OUT_PRODUCT)/fonts/AdamCGPro-Regular.ttf \
    vendor/aosp/prebuilt/fonts/fontage/AlexanaNeue-Regular.ttf:$(TARGET_COPY_OUT_PRODUCT)/fonts/AlexanaNeue-Regular.ttf \
    vendor/aosp/prebuilt/fonts/fontage/AlienLeague-Regular.ttf:$(TARGET_COPY_OUT_PRODUCT)/fonts/AlienLeague-Regular.ttf \
    vendor/aosp/prebuilt/fonts/fontage/Azedo-Light.ttf:$(TARGET_COPY_OUT_PRODUCT)/fonts/Azedo-Light.ttf \
    vendor/aosp/prebuilt/fonts/fontage/BigNoodleTilting-Italic.ttf:$(TARGET_COPY_OUT_PRODUCT)/fonts/BigNoodleTilting-Italic.ttf \
    vendor/aosp/prebuilt/fonts/fontage/BigNoodleTilting-Regular.ttf:$(TARGET_COPY_OUT_PRODUCT)/fonts/BigNoodleTilting-Regular.ttf \
    vendor/aosp/prebuilt/fonts/fontage/Biko-Regular.ttf:$(TARGET_COPY_OUT_PRODUCT)/fonts/Biko-Regular.ttf \
    vendor/aosp/prebuilt/fonts/fontage/Blern-Regular.ttf:$(TARGET_COPY_OUT_PRODUCT)/fonts/Blern-Regular.ttf \
    vendor/aosp/prebuilt/fonts/fontage/CoCoBiker-Regular.ttf:$(TARGET_COPY_OUT_PRODUCT)/fonts/CoCoBiker-Regular.ttf \
    vendor/aosp/prebuilt/fonts/fontage/Fester-Medium.ttf:$(TARGET_COPY_OUT_PRODUCT)/fonts/Fester-Medium.ttf \
    vendor/aosp/prebuilt/fonts/fontage/GinoraSans-Regular.ttf:$(TARGET_COPY_OUT_PRODUCT)/fonts/GinoraSans-Regular.ttf \
    vendor/aosp/prebuilt/fonts/fontage/Inkferno-Regular.ttf:$(TARGET_COPY_OUT_PRODUCT)/fonts/Inkferno-Regular.ttf \
    vendor/aosp/prebuilt/fonts/fontage/Instruction-Regular.ttf:$(TARGET_COPY_OUT_PRODUCT)/fonts/Instruction-Regular.ttf \
    vendor/aosp/prebuilt/fonts/fontage/JackLane-Regular.ttf:$(TARGET_COPY_OUT_PRODUCT)/fonts/JackLane-Regular.ttf \
    vendor/aosp/prebuilt/fonts/fontage/Metropolis1920-Regular.ttf:$(TARGET_COPY_OUT_PRODUCT)/fonts/Metropolis1920-Regular.ttf \
    vendor/aosp/prebuilt/fonts/fontage/Monad-Regular.ttf:$(TARGET_COPY_OUT_PRODUCT)/fonts/Monad-Regular.ttf \
    vendor/aosp/prebuilt/fonts/fontage/Neoneon-Regular.ttf:$(TARGET_COPY_OUT_PRODUCT)/fonts/Neoneon-Regular.ttf \
    vendor/aosp/prebuilt/fonts/fontage/Noir-Regular.ttf:$(TARGET_COPY_OUT_PRODUCT)/fonts/Noir-Regular.ttf \
    vendor/aosp/prebuilt/fonts/fontage/North-Regular.ttf:$(TARGET_COPY_OUT_PRODUCT)/fonts/North-Regular.ttf \
    vendor/aosp/prebuilt/fonts/fontage/OutrunFuture-Regular.ttf:$(TARGET_COPY_OUT_PRODUCT)/fonts/OutrunFuture-Regular.ttf \
    vendor/aosp/prebuilt/fonts/fontage/Qontra-Regular.ttf:$(TARGET_COPY_OUT_PRODUCT)/fonts/Qontra-Regular.ttf \
    vendor/aosp/prebuilt/fonts/fontage/Riviera-Regular.ttf:$(TARGET_COPY_OUT_PRODUCT)/fonts/Riviera-Regular.ttf \
    vendor/aosp/prebuilt/fonts/fontage/FoxAndCat-Regular.ttf:$(TARGET_COPY_OUT_PRODUCT)/fonts/ThemeableDate-fc.ttf \
    vendor/aosp/prebuilt/fonts/fontage/FoxAndCat-Regular.ttf:$(TARGET_COPY_OUT_PRODUCT)/fonts/ThemeableOwner-fc.ttf \
    vendor/aosp/prebuilt/fonts/fontage/TheOutbox-Regular.ttf:$(TARGET_COPY_OUT_PRODUCT)/fonts/TheOutbox-Regular.ttf \
    vendor/aosp/prebuilt/fonts/fontage/Union-Regular.ttf:$(TARGET_COPY_OUT_PRODUCT)/fonts/Union-Regular.ttf \
    vendor/aosp/prebuilt/fonts/fontagev2/Abel-Regular.ttf:$(TARGET_COPY_OUT_PRODUCT)/fonts/Abel-Regular.ttf \
    vendor/aosp/prebuilt/fonts/fontagev2/AdventPro-Regular.ttf:$(TARGET_COPY_OUT_PRODUCT)/fonts/AdventPro-Regular.ttf \
    vendor/aosp/prebuilt/fonts/fontagev2/ArchivoNarrow-Regular.ttf:$(TARGET_COPY_OUT_PRODUCT)/fonts/ArchivoNarrow-Regular.ttf \
    vendor/aosp/prebuilt/fonts/fontagev2/AutourOne-Regular.ttf:$(TARGET_COPY_OUT_PRODUCT)/fonts/AutourOne-Regular.ttf \
    vendor/aosp/prebuilt/fonts/fontagev2/Bariol-Regular.ttf:$(TARGET_COPY_OUT_PRODUCT)/fonts/Bariol-Regular.ttf \
    vendor/aosp/prebuilt/fonts/fontagev2/BadScript-Regular.ttf:$(TARGET_COPY_OUT_PRODUCT)/fonts/BadScript-Regular.ttf \
    vendor/aosp/prebuilt/fonts/fontagev2/CherrySwash-Regular.ttf:$(TARGET_COPY_OUT_PRODUCT)/fonts/CherrySwash-Regular.ttf \
    vendor/aosp/prebuilt/fonts/fontagev2/Codystar.ttf:$(TARGET_COPY_OUT_PRODUCT)/fonts/Codystar.ttf \
    vendor/aosp/prebuilt/fonts/fontagev2/din1451alt.ttf:$(TARGET_COPY_OUT_PRODUCT)/fonts/din1451alt.ttf \
    vendor/aosp/prebuilt/fonts/fontagev2/Hanken-Light.ttf:$(TARGET_COPY_OUT_PRODUCT)/fonts/Hanken-Light.ttf \
    vendor/aosp/prebuilt/fonts/fontagev2/IBMPlexMono.ttf:$(TARGET_COPY_OUT_PRODUCT)/fonts/IBMPlexMono.ttf \
    vendor/aosp/prebuilt/fonts/fontagev2/IBMPlexMono-Light.ttf:$(TARGET_COPY_OUT_PRODUCT)/fonts/IBMPlexMono-Light.ttf \
    vendor/aosp/prebuilt/fonts/fontagev2/Jura-Regular.ttf:$(TARGET_COPY_OUT_PRODUCT)/fonts/Jura-Regular.ttf \
    vendor/aosp/prebuilt/fonts/fontagev2/KellySlab-Regular.ttf:$(TARGET_COPY_OUT_PRODUCT)/fonts/KellySlab-Regular.ttf \
    vendor/aosp/prebuilt/fonts/fontagev2/Pompiere-Regular.ttf:$(TARGET_COPY_OUT_PRODUCT)/fonts/Pompiere-Regular.ttf \
    vendor/aosp/prebuilt/fonts/fontagev2/Raleway-Light.ttf:$(TARGET_COPY_OUT_PRODUCT)/fonts/Raleway-Light.ttf \
    vendor/aosp/prebuilt/fonts/fontagev2/ReemKufi-Regular.ttf:$(TARGET_COPY_OUT_PRODUCT)/fonts/ReemKufi-Regular.ttf \
    vendor/aosp/prebuilt/fonts/fontagev2/Satisfy-Regular.ttf:$(TARGET_COPY_OUT_PRODUCT)/fonts/Satisfy-Regular.ttf \
    vendor/aosp/prebuilt/fonts/fontagev2/SeaweedScript-Regular.ttf:$(TARGET_COPY_OUT_PRODUCT)/fonts/SeaweedScript-Regular.ttf \
    vendor/aosp/prebuilt/fonts/fontagev2/SedgwickAveDisplay-Regular.ttf:$(TARGET_COPY_OUT_PRODUCT)/fonts/SedgwickAveDisplay-Regular.ttf \
    vendor/aosp/prebuilt/fonts/fontagev2/Vibur.ttf:$(TARGET_COPY_OUT_PRODUCT)/fonts/Vibur.ttf \
    vendor/aosp/prebuilt/fonts/fontagev2/Voltaire.ttf:$(TARGET_COPY_OUT_PRODUCT)/fonts/Voltaire.ttf \
    vendor/aosp/prebuilt/fonts/fontagev3/AuthenticSans-Medium.ttf:$(TARGET_COPY_OUT_PRODUCT)/fonts/AuthenticSans-Medium.ttf \
    vendor/aosp/prebuilt/fonts/fontagev3/AuthenticSans-Regular.ttf:$(TARGET_COPY_OUT_PRODUCT)/fonts/AuthenticSans-Regular.ttf \
    vendor/aosp/prebuilt/fonts/fontagev3/ComicNeue-Bold.ttf:$(TARGET_COPY_OUT_PRODUCT)/fonts/ComicNeue-Bold.ttf \
    vendor/aosp/prebuilt/fonts/fontagev3/ComicNeue-Regular.ttf:$(TARGET_COPY_OUT_PRODUCT)/fonts/ComicNeue-Regular.ttf \
    vendor/aosp/prebuilt/fonts/fontagev3/Decalotype-Medium.ttf:$(TARGET_COPY_OUT_PRODUCT)/fonts/Decalotype-Medium.ttf \
    vendor/aosp/prebuilt/fonts/fontagev3/Decalotype-Regular.ttf:$(TARGET_COPY_OUT_PRODUCT)/fonts/Decalotype-Regular.ttf \
    vendor/aosp/prebuilt/fonts/fontagev3/Exo2-Regular.ttf:$(TARGET_COPY_OUT_PRODUCT)/fonts/Exo2-Regular.ttf \
    vendor/aosp/prebuilt/fonts/fontagev3/Exo2-SemiBold.ttf:$(TARGET_COPY_OUT_PRODUCT)/fonts/Exo2-SemiBold.ttf \
    vendor/aosp/prebuilt/fonts/fontagev3/FantasqueMono-Regular.ttf:$(TARGET_COPY_OUT_PRODUCT)/fonts/FantasqueMono-Regular.ttf \
    vendor/aosp/prebuilt/fonts/fontagev3/Fleuron-Regular.ttf:$(TARGET_COPY_OUT_PRODUCT)/fonts/Fleuron-Regular.ttf \
    vendor/aosp/prebuilt/fonts/fontagev3/Finlandica-Regular.ttf:$(TARGET_COPY_OUT_PRODUCT)/fonts/Finlandica-Regular.ttf \
    vendor/aosp/prebuilt/fonts/fontagev3/Gothamono-Regular.ttf:$(TARGET_COPY_OUT_PRODUCT)/fonts/Gothamono-Regular.ttf \
    vendor/aosp/prebuilt/fonts/fontagev3/Gravity-Regular.ttf:$(TARGET_COPY_OUT_PRODUCT)/fonts/Gravity-Regular.ttf \
    vendor/aosp/prebuilt/fonts/fontagev3/IgnazioText-Regular.ttf:$(TARGET_COPY_OUT_PRODUCT)/fonts/IgnazioText-Regular.ttf \
    vendor/aosp/prebuilt/fonts/fontagev3/Inter-Regular.ttf:$(TARGET_COPY_OUT_PRODUCT)/fonts/Inter-Regular.ttf \
    vendor/aosp/prebuilt/fonts/fontagev3/Inter-MediumItalic.ttf:$(TARGET_COPY_OUT_PRODUCT)/fonts/Inter-MediumItalic.ttf \
    vendor/aosp/prebuilt/fonts/fontagev3/JakartaPlus-Medium.ttf:$(TARGET_COPY_OUT_PRODUCT)/fonts/JakartaPlus-Medium.ttf \
    vendor/aosp/prebuilt/fonts/fontagev3/JakartaPlus-Regular.ttf:$(TARGET_COPY_OUT_PRODUCT)/fonts/JakartaPlus-Regular.ttf \
    vendor/aosp/prebuilt/fonts/fontagev3/LeagueMono-RegularNarrow.ttf:$(TARGET_COPY_OUT_PRODUCT)/fonts/LeagueMono-RegularNarrow.ttf \
    vendor/aosp/prebuilt/fonts/fontagev3/LeagueMono-MediumNarrow.ttf:$(TARGET_COPY_OUT_PRODUCT)/fonts/LeagueMono-MediumNarrow.ttf \
    vendor/aosp/prebuilt/fonts/fontagev3/LeagueMono-BoldNarrow.ttf:$(TARGET_COPY_OUT_PRODUCT)/fonts/LeagueMono-BoldNarrow.ttf \
    vendor/aosp/prebuilt/fonts/fontagev3/LeagueMono-SemiBoldNarrow.ttf:$(TARGET_COPY_OUT_PRODUCT)/fonts/LeagueMono-SemiBoldNarrow.ttf \
    vendor/aosp/prebuilt/fonts/fontagev3/LeonSans-Regular.ttf:$(TARGET_COPY_OUT_PRODUCT)/fonts/LeonSans-Regular.ttf \
    vendor/aosp/prebuilt/fonts/fontagev3/Lumie-Regular.ttf:$(TARGET_COPY_OUT_PRODUCT)/fonts/Lumie-Regular.ttf \
    vendor/aosp/prebuilt/fonts/fontagev3/mescla_regular.ttf:$(TARGET_COPY_OUT_PRODUCT)/fonts/mescla_regular.ttf \
    vendor/aosp/prebuilt/fonts/fontagev3/Millimetre-Regular.ttf:$(TARGET_COPY_OUT_PRODUCT)/fonts/Millimetre-Regular.ttf \
    vendor/aosp/prebuilt/fonts/fontagev3/Now-Medium.ttf:$(TARGET_COPY_OUT_PRODUCT)/fonts/Now-Medium.ttf \
    vendor/aosp/prebuilt/fonts/fontagev3/Now-Regular.ttf:$(TARGET_COPY_OUT_PRODUCT)/fonts/Now-Regular.ttf \
    vendor/aosp/prebuilt/fonts/fontagev3/OdibeeSans-Regular.ttf:$(TARGET_COPY_OUT_PRODUCT)/fonts/OdibeeSans-Regular.ttf \
    vendor/aosp/prebuilt/fonts/fontagev3/OpenSauceSans-Medium.ttf:$(TARGET_COPY_OUT_PRODUCT)/fonts/OpenSauceSans-Medium.ttf \
    vendor/aosp/prebuilt/fonts/fontagev3/OpenSauceSans-Regular.ttf:$(TARGET_COPY_OUT_PRODUCT)/fonts/OpenSauceSans-Regular.ttf \
    vendor/aosp/prebuilt/fonts/fontagev3/Panamericana-Display.ttf:$(TARGET_COPY_OUT_PRODUCT)/fonts/Panamericana-Display.ttf \
    vendor/aosp/prebuilt/fonts/fontagev3/PTSans-Regular.ttf:$(TARGET_COPY_OUT_PRODUCT)/fonts/PTSans-Regular.ttf \
    vendor/aosp/prebuilt/fonts/fontagev3/PTMono-Regular.ttf:$(TARGET_COPY_OUT_PRODUCT)/fonts/PTMono-Regular.ttf \
    vendor/aosp/prebuilt/fonts/fontagev3/QTVagaRound-Bold.ttf:$(TARGET_COPY_OUT_PRODUCT)/fonts/QTVagaRound-Bold.ttf \
    vendor/aosp/prebuilt/fonts/fontagev3/QTVagaRound-Regular.ttf:$(TARGET_COPY_OUT_PRODUCT)/fonts/QTVagaRound-Regular.ttf \
    vendor/aosp/prebuilt/fonts/fontagev3/routed-gothic-narrow.ttf:$(TARGET_COPY_OUT_PRODUCT)/fonts/routed-gothic-narrow.ttf \
    vendor/aosp/prebuilt/fonts/fontagev3/routed-gothic-narrow-half-italic.ttf:$(TARGET_COPY_OUT_PRODUCT)/fonts/routed-gothic-narrow-half-italic.ttf \
    vendor/aosp/prebuilt/fonts/fontagev3/Scientifica-Regular.ttf:$(TARGET_COPY_OUT_PRODUCT)/fonts/Scientifica-Regular.ttf \
    vendor/aosp/prebuilt/fonts/fontagev3/SofiaSans-Regular.ttf:$(TARGET_COPY_OUT_PRODUCT)/fonts/SofiaSans-Regular.ttf \
    vendor/aosp/prebuilt/fonts/fontagev3/SofiaSans-Medium.ttf:$(TARGET_COPY_OUT_PRODUCT)/fonts/SofiaSans-Medium.ttf \
    vendor/aosp/prebuilt/fonts/fontagev3/SofiaSansSemiCond-Regular.ttf:$(TARGET_COPY_OUT_PRODUCT)/fonts/SofiaSansSemiCond-Regular.ttf \
    vendor/aosp/prebuilt/fonts/fontagev3/SofiaSansSemiCond-Medium.ttf:$(TARGET_COPY_OUT_PRODUCT)/fonts/SofiaSansSemiCond-Medium.ttf \
    vendor/aosp/prebuilt/fonts/fontagev3/Universalis-Bold.ttf:$(TARGET_COPY_OUT_PRODUCT)/fonts/Universalis-Bold.ttf \
    vendor/aosp/prebuilt/fonts/fontagev3/Universalis-Regular.ttf:$(TARGET_COPY_OUT_PRODUCT)/fonts/Universalis-Regular.ttf \
    vendor/aosp/prebuilt/fonts/fontagev3/UniversalisCond-Bold.ttf:$(TARGET_COPY_OUT_PRODUCT)/fonts/UniversalisCond-Bold.ttf \
    vendor/aosp/prebuilt/fonts/fontagev3/UniversalisCond-Regular.ttf:$(TARGET_COPY_OUT_PRODUCT)/fonts/UniversalisCond-Regular.ttf \
    vendor/aosp/prebuilt/fonts/fontagev3/VG5000-Regular.ttf:$(TARGET_COPY_OUT_PRODUCT)/fonts/VG5000-Regular.ttf \
    vendor/aosp/prebuilt/fonts/fontagev3/Vladisvostok-Regular.ttf:$(TARGET_COPY_OUT_PRODUCT)/fonts/Vladisvostok-Regular.ttf \
    vendor/aosp/prebuilt/fonts/fontagev3/Volte-Bold.ttf:$(TARGET_COPY_OUT_PRODUCT)/fonts/Volte-Bold.ttf \
    vendor/aosp/prebuilt/fonts/fontagev3/Volte-Medium.ttf:$(TARGET_COPY_OUT_PRODUCT)/fonts/Volte-Medium.ttf

# Strip the local variable table and the local variable type table to reduce
# the size of the system image. This has no bearing on stack traces, but will
# leave less information available via JDWP.
PRODUCT_MINIMIZE_JAVA_DEBUG_INFO := true

# Charger
PRODUCT_PACKAGES += \
    charger_res_images \
    product_charger_res_images

# Filesystems tools
PRODUCT_PACKAGES += \
    fsck.ntfs \
    mke2fs \
    mkfs.ntfs \
    mount.ntfs
    
# Config
PRODUCT_PACKAGES += \
    SimpleDeviceConfig

# Gaming mode
PRODUCT_PACKAGES += \
    GamingMode

# Storage manager
PRODUCT_SYSTEM_DEFAULT_PROPERTIES += \
    ro.storage_manager.enabled=true

# Media
PRODUCT_SYSTEM_DEFAULT_PROPERTIES += \
    media.recorder.show_manufacturer_and_model=true

# Overlays
PRODUCT_ENFORCE_RRO_EXCLUDED_OVERLAYS += \
    vendor/aosp/overlay \
    vendor/aosp/overlay-pixel \

PRODUCT_PACKAGE_OVERLAYS += \
    vendor/aosp/overlay/common \
    vendor/aosp/overlay-pixel/common

# Cutout control overlay
PRODUCT_PACKAGES += \
    NoCutoutOverlay

# TouchGestures
PRODUCT_PACKAGES += \
    TouchGestures

# Customizations
PRODUCT_PACKAGES += \
    NavigationBarMode2ButtonOverlay

# Hide navigation bar hint
PRODUCT_PACKAGES += \
    NavigationBarNoHintOverlay

# Arcane Packages
PRODUCT_PACKAGES += \
    ThemePicker \
    Dialer \
    StitchImage \
    ArcaneThemesStub

# SystemUI plugins
PRODUCT_PACKAGES += \
    QuickAccessWallet

# Gboard configuration
PRODUCT_PRODUCT_PROPERTIES += \
    ro.com.google.ime.bs_theme=true \
    ro.com.google.ime.theme_id=5 \
    ro.com.google.ime.system_lm_dir=/product/usr/share/ime/google/d3_lms

# Gboard
PRODUCT_PRODUCT_PROPERTIES += \
    ro.com.google.ime.kb_pad_port_b=1

# SetupWizard configuration
PRODUCT_PRODUCT_PROPERTIES += \
    setupwizard.feature.baseline_setupwizard_enabled=true \
    ro.setupwizard.enterprise_mode=1 \
    ro.setupwizard.rotation_locked=true \
    setupwizard.enable_assist_gesture_training=true \
    setupwizard.theme=glif_v3_light \
    setupwizard.feature.skip_button_use_mobile_data.carrier1839=true \
    setupwizard.feature.show_pai_screen_in_main_flow.carrier1839=false \
    setupwizard.feature.show_pixel_tos=false

# StorageManager configuration
PRODUCT_PRODUCT_PROPERTIES += \
    ro.storage_manager.show_opt_in=false

# OPA configuration
PRODUCT_PRODUCT_PROPERTIES += \
    ro.opa.eligible_device=true

# Google legal
PRODUCT_PRODUCT_PROPERTIES += \
    ro.url.legal=http://www.google.com/intl/%s/mobile/android/basic/phone-legal.html \
    ro.url.legal.android_privacy=http://www.google.com/intl/%s/mobile/android/basic/privacy.html

# Google Play services configuration
PRODUCT_PRODUCT_PROPERTIES += \
    ro.com.google.clientidbase=android-google \
    ro.error.receiver.system.apps=com.google.android.gms \
    ro.atrace.core.services=com.google.android.gms,com.google.android.gms.ui,com.google.android.gms.persistent

# TextClassifier
PRODUCT_PACKAGES += \
	libtextclassifier_annotator_en_model \
	libtextclassifier_annotator_universal_model \
	libtextclassifier_actions_suggestions_universal_model \
	libtextclassifier_lang_id_model

# Use gestures by default
PRODUCT_PRODUCT_PROPERTIES += \
    ro.boot.vendor.overlay.theme=com.android.internal.systemui.navbar.gestural

# IORap app launch prefetching using Perfetto traces and madvise
PRODUCT_PRODUCT_PROPERTIES += \
    iorapd.perfetto.enable=true \
    iorapd.readahead.enable=true \
    persist.device_config.runtime_native_boot.iorap_perfetto_enable=true \
    persist.device_config.runtime_native_boot.iorap_readahead_enable=true \
    ro.iorapd.enable=true

# Fling Sysprops
PRODUCT_PRODUCT_PROPERTIES += \
    ro.min.fling_velocity=160 \
    ro.max.fling_velocity=20000
    
# Disable Deep Press touch video heatmaps 
PRODUCT_PRODUCT_PROPERTIES += \
    ro.input.video_enabled=false

# Enable blurs based on targets
ifeq ($(TARGET_SUPPORTS_BLUR),true)
PRODUCT_PRODUCT_PROPERTIES += \
    ro.surface_flinger.supports_background_blur=1 \
    ro.sf.blurs_are_expensive=1
endif

# ArcaneOS Versioning
PRODUCT_PRODUCT_PROPERTIES += \
    ro.arcane.version=3.5 \
    ro.arcane.device_name=$(ARCANE_DEVICE) \
    ro.arcane.maintainer=$(ARCANE_MAINTAINER)
    
# Face Unlock
TARGET_FACE_UNLOCK_SUPPORTED ?= true
ifeq ($(TARGET_FACE_UNLOCK_SUPPORTED),true)
PRODUCT_PACKAGES += \
    FaceUnlockService
PRODUCT_SYSTEM_DEFAULT_PROPERTIES += \
    ro.face_unlock_service.enabled=$(TARGET_FACE_UNLOCK_SUPPORTED)
PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.hardware.biometrics.face.xml:$(TARGET_COPY_OUT_SYSTEM)/etc/permissions/android.hardware.biometrics.face.xml
endif

# Overlays
PRODUCT_PACKAGES += \
    CustomConfigOverlay \
    CustomLauncherOverlay \
    CustomSettingsOverlay
    
# Ignore overlays on RRO builds
PRODUCT_ENFORCE_RRO_EXCLUDED_OVERLAYS += \
    packages/overlays/Shishufied/Overlays


# Audio
$(call inherit-product, vendor/aosp/config/audio.mk)

# Bootanimation
$(call inherit-product, vendor/aosp/config/bootanimation.mk)

# GApps
$(call inherit-product, vendor/gapps/config.mk)

# Plugins
include packages/apps/Plugins/plugins.mk

# OTA
#$(call inherit-product, vendor/aosp/config/ota.mk)

# Inherit dalvik options
include vendor/aosp/config/dalvik.mk

# RRO Overlays
$(call inherit-product, vendor/aosp/config/rro_overlays.mk)

-include $(WORKSPACE)/build_env/image-auto-bits.mk
