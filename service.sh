#!/system/bin/sh
# ZN-Assistant service.sh

MODDIR=${0%/*}

# Tunggu hingga boot selesai
until [ "$(getprop sys.boot_completed)" = "1" ]; do
    sleep 1
done

# Beri jeda tambahan untuk memastikan Zygisk Next selesai inject
sleep 5

# 1. Reset Properti untuk menyembunyikan Bootloader Unlock & Root
resetprop sys.bootloader.locked 1
resetprop ro.boot.verified_bootstate green
resetprop ro.boot.veritymode enforcing
resetprop ro.boot.vbmeta.device_state locked
resetprop ro.debuggable 0
resetprop ro.secure 1
resetprop ro.build.tags release-keys
resetprop ro.build.type user
resetprop ro.build.flavor $(getprop ro.build.flavor | sed 's/-userdebug/-user/g' | sed 's/-eng/-user/g')

# 2. Sembunyikan trace Zygisk Next di properti
resetprop ro.zygisk.next 0
resetprop persist.zygisk.next 0

# 3. Pembersihan Log Tahap Akhir (Aggressive Trace Removal)
# Magisk Alpha sering membuat log baru saat service berjalan
rm -f /data/cache/magisk.log
rm -f /data/cache/magisk.log.bak
rm -f /data/cache/zygisk_next.log
rm -rf /data/local/tmp/*

# Kosongkan logcat yang mungkin mengandung kata kunci 'magisk', 'zygisk', 'su'
logcat -c 2>/dev/null
