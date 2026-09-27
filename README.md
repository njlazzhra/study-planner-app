📚 Study Planner - Aplikasi Aktivitas Belajar
Aplikasi manajemen aktivitas belajar pribadi berbasis Flutter yang dikembangkan untuk memenuhi tugas individu mata kuliah Pemrograman Mobile.

🚀 Fitur Utama
1. **6 Layar Utama:**
   - **Beranda (*Home*):** Ringkasan statistik aktivitas secara *real-time* dan kartu sapaan pengguna.
   - **Daftar Aktivitas (*Activity List*):** Menampilkan seluruh aktivitas dengan fitur pencarian & filter kategori/status.
   - **Detail Aktivitas:** Menampilkan informasi lengkap tugas dengan opsi ubah status atau hapus.
   - **Tambah & Edit Aktivitas:** Form interaktif dengan validasi lengkap dan *Date Picker*.
   - **Favorit:** Akses cepat ke aktivitas penting yang ditandai sebagai favorit.
   - **Profil:** Informasi identitas mahasiswa dan rekapitulasi progres.
2. **CRUD di Memori:** Operasi *Create, Read, Update, Delete* berjalan interaktif di memori aplikasi.
3. **Pencarian & Filter Dinamis:** Pencarian teks bebas digabung dengan filter kategori (*Kuliah, Tugas, Ujian, Pribadi*) dan status (*Selesai, Belum Selesai*).
4. **Dialog Konfirmasi:** Mencegah penghapusan tidak sengaja melalui *AlertDialog*.

🛠️ Teknologi & Arsitektur
- **Framework:** Flutter & Dart
- **State Management:** Provider (`ChangeNotifier`) sebagai *Single Source of Truth*.
- **Routing:** GoRouter (dengan *ShellRoute* untuk *Bottom Navigation Bar*).
- **UI Design:** Material 3, komponen kartu reusable (`ActivityCard`), dan *Responsive Layout*.

📦 Daftar Versi Package (`pubspec.yaml`)
- `flutter`: SDK bawaan
- `provider`: `^6.1.2`
- `go_router`: `^14.2.0`
- `cupertino_icons`: `^1.0.8`

By Najla Az Zahra Tanjung (241401136)
Pemrograman Mobile - Universitas Sumatera Utara 
