#!/system/bin/sh
# ZN-Assistant post-fs-data.sh
# Early boot trace cleaner

MODDIR=${0%/*}

# ---------------------------------------------------------------
# Hapus log lama dari boot sebelumnya
# ---------------------------------------------------------------
rm -f /data/cache/magisk.log 2>/dev/null
rm -f /data/cache/magisk.log.bak 2>/dev/null
rm -f /data/cache/zygisk_next.log 2>/dev/null
rm -f /data/cache/zygisk-next.log 2>/dev/null
rm -f /data/cache/zygisk.log 2>/dev/null

# ---------------------------------------------------------------
# Bersihkan file mencurigakan di /data/local/tmp
# Tidak menghapus seluruh isi tmp agar lebih aman.
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
# Hapus log instalasi module jika ada
# ---------------------------------------------------------------
rm -f "${MODDIR}/install.log" 2>/dev/null
rm -f "${MODDIR}/remove.log" 2>/dev/null

exit 0
