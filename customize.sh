#!/system/bin/sh
# ZN-Assistant customize.sh
# Safe installer check for Magisk Alpha 30700/31000 + Zygisk Next v1.5.2

ui_print " "
ui_print "############################################"
ui_print "#                                          #"
ui_print "#             ZN-Assistant v1.1            #"
ui_print "#      Zygisk Next Optimizer / Cleaner     #"
ui_print "#                                          #"
ui_print "############################################"
ui_print " "

# ---------------------------------------------------------------
# Deteksi Zygisk Next secara fleksibel.
# Tidak abort jika tidak terdeteksi, hanya warning.
# ---------------------------------------------------------------
ZYGISK_FOUND=0
ZYGISK_ID=""

for MODULE_DIR in /data/adb/modules/*/; do
    [ -d "$MODULE_DIR" ] || continue
    [ -f "${MODULE_DIR}module.prop" ] || continue

    # Lewati module yang di-disable
    [ -f "${MODULE_DIR}disable" ] && continue

    PROP_ID=$(grep '^id=' "${MODULE_DIR}module.prop" 2>/dev/null | cut -d'=' -f2 | tr -d '\r')

    case "$PROP_ID" in
        *zygisk*|*Zygisk*|*ZYGISK*)
            ZYGISK_FOUND=1
            ZYGISK_ID="$PROP_ID"
            break
            ;;
    esac
done

if [ "$ZYGISK_FOUND" -eq 1 ]; then
    ui_print "[+] Zygisk Next terdeteksi: $ZYGISK_ID"
else
    ui_print "[!] WARNING: Zygisk Next tidak terdeteksi otomatis."
    ui_print "[!] Module tetap diizinkan install."
    ui_print "[!] Pastikan Zygisk Next v1.5.2 sudah aktif."
fi

ui_print " "

# ---------------------------------------------------------------
# Deteksi versi Magisk Alpha.
# Hanya informasi, tidak memblokir install.
# ---------------------------------------------------------------
MAGISK_VER_CODE=$(magisk -V 2>/dev/null)
MAGISK_VER=$(magisk -v 2>/dev/null)

if [ -n "$MAGISK_VER_CODE" ]; then
    ui_print "[i] Magisk version code: $MAGISK_VER_CODE"
    ui_print "[i] Magisk version: $MAGISK_VER"
else
    ui_print "[!] Tidak bisa membaca versi Magisk. Lanjut install."
fi

if [ -n "$MAGISK_VER_CODE" ]; then
    if [ "$MAGISK_VER_CODE" -ge 30700 ] 2>/dev/null; then
        ui_print "[+] Kompatibel dengan Magisk Alpha 30700/31000+."
    else
        ui_print "[!] Disarankan menggunakan Magisk Alpha 30700 atau 31000+."
    fi
fi

ui_print " "
ui_print "[+] Installing ZN-Assistant..."
ui_print "[+] Module will optimize Zygisk Next hiding and clean traces."
ui_print " "

exit 0
