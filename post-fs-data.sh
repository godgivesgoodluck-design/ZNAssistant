#!/system/bin/sh
# ZN-Assistant post-fs-data.sh

MODDIR=${0%/*}

# 1. Hapus jejak log Magisk dan Zygisk Next yang tertinggal dari boot sebelumnya
rm -f /data/cache/magisk.log
rm -f /data/cache/magisk.log.bak
rm -f /data/cache/zygisk_next.log
rm -rf /data/local/tmp/*
rm -rf /data/misc/magisk

# 2. Pastikan path biner su disembunyikan dari pemeriksaan dasar
# (Zygisk Next sudah menangani ini di level zygote, tapi ini sebagai lapis ganda)
if [ -d "/system/xbin" ]; then
    # Unmount jika ada yang mencoba membaca
    umount /system/xbin/su 2>/dev/null
fi

# 3. Bersihkan trace instalasi module
rm -f /data/adb/modules/zn_assistant/install.log
