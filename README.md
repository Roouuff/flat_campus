# CampusConnect

ecampus adalah prototipe aplikasi sistem informasi akademik berbasis
Flutter. Aplikasi ini menyediakan satu tempat untuk melihat ringkasan
aktivitas akademik, jadwal kuliah, simulasi presensi, nilai contoh, dan
informasi profil mahasiswa.

## Fitur

- **Dashboard** dengan ringkasan mata kuliah, status presensi, dan jadwal.
- **Jadwal kuliah** yang dapat difilter berdasarkan hari.
- **Presensi simulasi** untuk mengubah status kehadiran mata kuliah.
- **Nilai akademik** dengan daftar nilai contoh dan rata-rata.
- **Profil mahasiswa** yang menampilkan informasi profil dan foto.
- **Tema terang dan gelap**.
- **Tampilan responsif**: navigasi samping pada layar lebar dan navigasi bawah
  pada layar yang lebih kecil.

## Teknologi

- Flutter dan Dart
- Material 3

## Persyaratan

- Flutter SDK dengan Dart SDK yang memenuhi batasan `^3.13.4` di
  `pubspec.yaml`.
- Emulator atau perangkat untuk menjalankan aplikasi. Flutter juga dapat
  digunakan untuk menjalankan target lain yang telah dikonfigurasi, seperti
  web atau desktop.

Periksa instalasi Flutter dengan:

```bash
flutter doctor
```

## Menjalankan aplikasi

1. Clone repository ini dan masuk ke direktori proyek:

   ```bash
   git clone https://github.com/Roouuff/flat_campus.git
   cd ecampus_application
   ```

2. Ambil dependensi:

   ```bash
   flutter pub get
   ```

3. Jalankan aplikasi:

   ```bash
   flutter run
   ```

Untuk menjalankan pengujian widget:

```bash
flutter test
```

## Struktur proyek

```text
lib/
  main.dart                 # Aplikasi dan layar-layar utama
assets/
  profile_photo.png         # Foto profil yang digunakan aplikasi
test/
  widget_test.dart           # Pengujian widget
```

## Catatan

Proyek ini masih berupa prototipe. Data jadwal, presensi, nilai, dan profil
disimpan sebagai data contoh di aplikasi; belum ada backend, autentikasi,
sinkronisasi, atau penyimpanan permanen. Perubahan presensi hanya berlaku
selama aplikasi berjalan, dan nilai yang ditampilkan bukan nilai resmi.
