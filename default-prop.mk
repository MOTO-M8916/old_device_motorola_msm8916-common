# Debug
PRODUCT_DEFAULT_PROPERTY_OVERRIDES += \
    ro.adb.secure=0 \
    ro.secure=0 \
    persist.sys.usb.config=adb,mtp \
    ro.debugable=1
