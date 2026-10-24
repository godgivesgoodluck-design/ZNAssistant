#!/system/bin/sh
# ZN-Assistant customize.sh

# Cek apakah Zygisk Next terinstal
if [ ! -d "/data/adb/modules/zygisk_next" ] && [ ! -d "/data/adb/modules/zygisk-next" ]; then
    ui_print "================================================"
    ui_print "! ERROR: Zygisk Next tidak terdeteksi!"
    ui_print "! Module ini membutuhkan Zygisk Next v1.5.2"
    ui_print "! Silakan instal Zygisk Next terlebih dahulu."
    ui_print "================================================"
    abort "! Instalasi dibatalkan."
fi

# Cek versi Magisk Alpha (Opsional, hanya peringatan)
MAGISK_VER_CODE=$(magisk -V 2>/dev/null)
if [ "$MAGISK_VER_CODE" -lt 30700 ] 2>/dev/null; then
    ui_print "! Peringatan: Disarankan menggunakan Magisk Alpha 30700 atau 31000+"
fi

ui_print "================================================"
ui_print " ZN-Assistant berhasil diinstal!"
ui_print " Mengoptimalkan Zygisk Next & Membersihkan Jejak"
ui_print "================================================"
