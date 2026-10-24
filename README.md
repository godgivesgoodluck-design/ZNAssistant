# ZN-Assistant (Zygisk Next Optimizer)

[![Release](https://img.shields.io/github/v/release/USERNAME_ANDA/ZN-Assistant?label=Release&color=blue)](https://github.com/USERNAME_ANDA/ZN-Assistant/releases)
[![Magisk Alpha](https://img.shields.io/badge/Magisk-Alpha%2030700%2F31000+-orange)](https://github.com/vvb2060/Magisk)
[![Zygisk Next](https://img.shields.io/badge/Zygisk%20Next-v1.5.2+-green)](https://github.com/Dr-TSNG/ZygiskNext)

**ZN-Assistant** adalah module pendamping (companion module) untuk **Zygisk Next v1.5.2+**. Module ini dirancang khusus untuk memaksimalkan kemampuan penyembunyian root (*stealth mode*) dan secara agresif menghapus jejak (*trace removal*) yang ditinggalkan oleh Magisk dan Zygisk selama proses booting.

Module ini dioptimalkan secara khusus untuk pengguna **Magisk Alpha (v30700 / v31000+)** yang membutuhkan tingkat penyamaran tertinggi untuk menembus deteksi aplikasi perbankan, game, atau aplikasi keamanan tingkat lanjut.

---

## ✨ Fitur Utama

- 🧹 **Aggressive Trace Removal**: Membersihkan file log (`magisk.log`, `zygisk_next.log`) dan file sementara di `/data/local/tmp` secara otomatis saat booting.
- 🎭 **Advanced Property Spoofing**: Menggunakan `resetprop` dan `system.prop` untuk menyamarkan status `bootloader locked`, `verified boot state`, dan `build type` agar terlihat seperti perangkat stok resmi.
- ⚡ **Optimized for Magisk Alpha**: Menargetkan path logging dan perilaku spesifik Magisk Alpha untuk mencegah kebocoran jejak yang sering terjadi pada versi Alpha.
- 🛡️ **Zygisk Next Synergy**: Bekerja secara simbiosis dengan Zygisk Next untuk memastikan lingkungan sistem bersih sebelum injeksi Zygote terjadi.

---

## 📋 Prasyarat (Wajib)

Sebelum menginstal module ini, pastikan perangkat Anda memenuhi syarat berikut:
1. **Magisk Alpha** versi `30700` atau `31000+` sudah terinstal dan berfungsi.
2. **Zygisk Next** versi `1.5.2` atau lebih baru sudah terinstal dan diaktifkan.
3. *(Sangat Direkomendasikan)* Module **Shamiko** (versi terbaru) untuk menyembunyikan status DenyList.
4. *(Opsional)* Module **Play Integrity Fix** (oleh chiteroman) untuk lulus deteksi Play Integrity API.

---

## 📥 Cara Instalasi

### Opsi 1: Instalasi via GitHub Release (Direkomendasikan)
1. Kunjungi halaman **[Releases](https://github.com/godgivesgoodluck-design/ZNAssistant/releases)** repository ini.
2. Unduh file ZIP terbaru (`zn_assistant-vX.X.zip`).
3. Buka aplikasi **Magisk Alpha** > Menu **Modules**.
4. Ketuk **Install from storage** dan pilih file ZIP yang baru diunduh.
5. Setelah instalasi selesai, ketuk **Reboot**.

### Opsi 2: Build Manual via GitHub Actions
Jika Anda ingin membuild versi terbaru langsung dari source code:
1. Fork repository ini ke akun GitHub Anda.
2. Pergi ke tab **Actions** > Pilih workflow **Build and Release ZN-Assistant**.
3. Klik **Run workflow** > **Run workflow**.
4. Setelah selesai (centang hijau), unduh file ZIP dari bagian **Artifacts** di bawah halaman workflow tersebut.

---

## ⚙️ Konfigurasi Wajib Pasca-Instalasi

Agar module ini bekerja secara maksimal, lakukan pengaturan berikut di Magisk Alpha:

1. **Matikan Zygisk Bawaan Magisk**:  
   Buka *Settings* > Matikan toggle **Zygisk**. (Zygisk Next akan mengambil alih fungsi ini secara independen. Menggunakan keduanya secara bersamaan akan menyebabkan konflik).
2. **Konfigurasi DenyList**:  
   Aktifkan **Enforce DenyList** > Masuk ke **Configure DenyList** > Centang aplikasi target (Banking, Game, dll).  
   *(Catatan: Jika Anda menggunakan **Shamiko**, matikan "Enforce DenyList", tetapi tetap isi daftar aplikasinya. Shamiko akan menangani penyembunyian secara stealth).*
3. **Clear Data Aplikasi Target**:  
   Setelah reboot, bersihkan *Cache* dan *Data* pada aplikasi yang sebelumnya mendeteksi root untuk menghapus cache deteksi lama.

---

## ⚙️ Cara Kerja Teknis

Module ini beroperasi pada berbagai tahap booting Android untuk memastikan kebersihan sistem:

| File Script | Tahap Eksekusi | Fungsi Utama |
| :--- | :--- | :--- |
| `customize.sh` | Saat Instalasi | Memvalidasi keberadaan Zygisk Next. Membatalkan instalasi jika Zygisk Next tidak ditemukan. |
| `post-fs-data.sh` | Early Boot | Menghapus log booting sebelumnya dan membersihkan `/data/local/tmp` sebelum aplikasi sistem dimuat. |
| `service.sh` | Late Boot | Menunggu boot selesai, lalu menjalankan `resetprop` untuk menyamarkan status bootloader/build, dan membersihkan `logcat` serta log baru yang dibuat saat booting. |
| `system.prop` | System Init | Menyuntikkan properti sistem palsu secara persisten sebagai lapisan pertahanan ganda terhadap pembacaan properti agresif oleh aplikasi. |

---

## ⚠️ Disclaimer & Peringatan

- Module ini memodifikasi properti sistem dan menghapus file log secara otomatis. 
- **SELALU** lakukan backup (Nandroid/TWRP) atau pastikan Anda memiliki akses pemulihan sebelum menginstal module apa pun.
- Penulis tidak bertanggung jawab atas *bootloop*, kehilangan data, atau kerusakan perangkat yang terjadi akibat penggunaan module ini. Gunakan dengan risiko Anda sendiri (*Use at your own risk*).
- Module ini dibuat untuk tujuan edukasi dan peningkatan privasi. Jangan gunakan untuk aktivitas ilegal.

---

## 🙏 Credits & Acknowledgements

- **[topjohnwu](https://github.com/topjohnwu)** - Pencipta Magisk.
- **[vvb2060](https://github.com/vvb2060)** - Pencipta Magisk Alpha.
- **[Dr-TSNG](https://github.com/Dr-TSNG)** - Pencipta Zygisk Next.
- **[LSPosed](https://github.com/LSPosed)** - Pencipta Shamiko.
- **[chiteroman](https://github.com/chiteroman)** - Pencipta Play Integrity Fix.

---

> 💡 **Tips**: Jika Anda memiliki pertanyaan, bug report, atau permintaan fitur, silakan buka [Issue](https://github.com/USERNAME_ANDA/ZN-Assistant/issues) di repository ini.
