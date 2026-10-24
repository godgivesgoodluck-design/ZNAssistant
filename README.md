# ZN-Assistant for Zygisk Next

ZN-Assistant adalah companion module untuk **Zygisk Next v1.5.2+**.

Module ini bertujuan:

- Memaksimalkan penyembunyian root bersama Zygisk Next.
- Membersihkan trace/log Magisk dan Zygisk.
- Membersihkan file mencurigakan di `/data/local/tmp`.
- Menyamarkan properti bootloader/root.
- Kompatibel dengan **Magisk Alpha 30700 / 31000+**.

## Prasyarat

Wajib:

1. Magisk Alpha 30700 atau 31000+
2. Zygisk Next v1.5.2 atau lebih baru
3. Zygisk bawaan Magisk dimatikan jika menggunakan Zygisk Next

Direkomendasikan:

- Shamiko
- Play Integrity Fix

## Cara Install

1. Download ZIP dari release atau artifact GitHub Actions.
2. Buka Magisk Alpha.
3. Masuk ke menu Modules.
4. Install from storage.
5. Pilih file ZIP.
6. Tunggu sampai muncul **Done**.
7. Reboot.

## Pengaturan Penting

Karena menggunakan Zygisk Next:

```text
Magisk Settings
Zygisk = OFF
