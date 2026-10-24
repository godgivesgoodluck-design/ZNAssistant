#!/system/bin/sh
# ZN-Assistant service.sh
# Late boot property spoofing and trace cleanup

MODDIR=${0%/*}

# ---------------------------------------------------------------
# Tunggu boot completed dengan timeout agar tidak hang
# ---------------------------------------------------------------
WAIT_COUNT=0
MAX_WAIT=180

while [ "$(getprop sys.boot_completed)" != "1" ]; do
    WAIT_COUNT=$((WAIT_COUNT + 1))

    if [ "$WAIT_COUNT" -ge "$MAX_WAIT" ]; then
        break
    fi

    sleep 1
done

# Jeda tambahan agar Zygisk Next selesai inject
sleep 5

# ---------------------------------------------------------------
# Fungsi resetprop aman
# ---------------------------------------------------------------
safe_resetprop() {
    if command -v resetprop >/dev/null 2>&1; then
        resetprop "$1" "$2" 2>/dev/null || true
    fi
}

# ---------------------------------------------------------------
# Sembunyikan tanda bootloader unlock / root
# ---------------------------------------------------------------
safe_resetprop ro.debuggable 0
safe_resetprop ro.secure 1
safe_resetprop ro.build.type user
safe_resetprop ro.build.tags release-keys

safe_resetprop ro.boot.verifiedbootstate green
safe_resetprop ro.boot.vbmeta.device_state locked
safe_resetprop ro.boot.veritymode enforcing
safe_resetprop ro.boot.flash.locked 1
safe_resetprop sys.bootloader.locked 1

# ---------------------------------------------------------------
# Bersihkan log pasca-boot
# ---------------------------------------------------------------
rm -f /data/cache/magisk.log 2>/dev/null
rm -f /data/cache/magisk.log.bak 2>/dev/null
rm -f /data/cache/zygisk_next.log 2>/dev/null
rm -f /data/cache/zygisk-next.log 2>/dev/null
rm -f /data/cache/zygisk.log 2>/dev/null

# ---------------------------------------------------------------
# Bersihkan file mencurigakan di tmp
# ---------------------------------------------------------------
for FILE in /data/local/tmp/*; do
    [ -e "$FILE" ] || continue

    case "$FILE" in
        *magisk*|*Magisk*|*MAGISK*)
            rm -rf "$FILE" 2>/dev/null
            ;;
        *zygisk*|*Zygisk*|*ZYGISK*)
            rm -rf "$FILE" 2>/dev/null
            ;;
        */su|*/supolicy|*/busybox|*/resetprop)
            rm -rf "$FILE" 2>/dev/null
            ;;
    esac
done

# ---------------------------------------------------------------
# Kosongkan logcat agar tidak ada jejak text log
# ---------------------------------------------------------------
logcat -c 2>/dev/null || true

exit 0
