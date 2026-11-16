# Project Portofolio Mobile

Name: Muh. Agra Putra Davyza Chaniago  
NPM: 2506624833  
Class: PBP B

## About Project

Projek ini dibuat sebagai aplikasi portofolio mobile saya menggunakan Flutter dan bahasa Dart. Tujuan dari projek ini adalah untuk mempelajari pengembangan aplikasi multiplatform, penyusunan tampilan menggunakan widget, serta penggunaan Git untuk menyimpan progres secara bertahap. Pada projek ini akan berfokus pada implementasi bahasa dart untuk membuat aplikasinya
## Local Setup

### 1. Prepare Flutter

Pastikan Flutter SDK sudah terpasang dan folder `flutter/bin` sudah ditambahkan ke PATH. Untuk menjalankan aplikasi melalui web, siapkan Google Chrome. Dart SDK sudah tersedia bersama Flutter sehingga tidak perlu diinstal secara terpisah.

Periksa lingkungan pengembangan dengan:

```bash
flutter --version
flutter doctor
flutter devices
```

### 2. Clone the repository

```bash
git clone https://github.com/Agra-17/myportofolio_mobile.git
cd myportofolio_mobile
```

### 3. Install dependencies

```bash
flutter pub get
```

### 4. Run the application

```bash
flutter run -d chrome
```

### 5. Check code quality

```bash
flutter analyze
```

Target pemeriksaan adalah `No issues found!`. Perintah di atas merupakan langkah verifikasi, bukan pernyataan bahwa pemeriksaan terakhir sudah berhasil.

## Project Structure

```text
myportofolio_mobile/
├── lib/
│   ├── main.dart       # Entry point dan konfigurasi aplikasi
│   └── menu.dart       # Halaman utama, kartu identitas, dan kartu tombol
├── test/
│   └── widget_test.dart
├── pubspec.yaml       # Konfigurasi proyek dan dependencies
└── README.md          # Dokumentasi dan jawaban refleksi
```

### Tugas 7

#### 1. Apa yang dimaksud dengan widget tree dan bagaimana hubungan parent-child bekerja?

Widget tree adalah susunan widget dalam interface penggunga (UI) yang paling sering/umum diasosiasikan/digunakan dengan framework Flutter. Bentuknya menyerupai pohon karena suatu widget dapat memiliki widget lain di dalamnya. Hubungan parent-child terjadi ketika sebuah widget memuat widget lain di dalamnya. Widget yang membungkus disebut parent, sedangkan widget di dalamnya disebut child. Parent memberikan batasan ukuran kepada child, kemudian child menentukan ukurannya di dalam batasan tersebut. Pada contoh implementasi di code saya ada di implementasi Row (children : [InfoCard]), disini yang sebagai parent adalah Row dan Childnya adalah InfoCard.    


#### 2. Widget apa saja yang digunakan dan apa fungsinya?

Berikut widget yang digunakan secara langsung dalam kode aplikasi saya:

| Widget | Fungsi dalam aplikasi saya |
| --- | --- |
| `MyApp` | Membungkus konfigurasi utama aplikasi. |
| `MaterialApp` | Mengatur judul, tema, dan halaman awal aplikasi. |
| `MyHomePage` | Menyusun halaman utama portofolio. |
| `Scaffold` | Menyediakan kerangka halaman berupa `AppBar` dan `body`. |
| `AppBar` | Menampilkan bagian atas halaman dengan judul “MyPortfolio”. |
| `Text` | Menampilkan judul, identitas, pesan sambutan, nama menu, dan isi `SnackBar`. |
| `Padding` | Memberi jarak di sekitar widget. |
| `Column` | Menyusun widget dari atas ke bawah. |
| `Row` | Menyusun tiga kartu identitas secara mendatar. |
| `SizedBox` | Memberi jarak kosong antarelemen. |
| `Center` | Menempatkan child di tengah ruang yang tersedia. |
| `GridView.count` | Menyusun kartu menu dalam kisi tiga kolom. |
| `InfoCard` | Menampilkan satu informasi identitas, seperti NPM. |
| `Card` | Memberi tampilan kartu dan bayangan pada informasi identitas. |
| `Container` | Mengatur ukuran dan jarak di dalam kartu. |
| `ItemCard` | Menampilkan satu menu yang dapat diketuk. |
| `Material` | Memberi warna dan permukaan Material pada kartu menu. |
| `InkWell` | Mendeteksi ketukan dan memberikan efek sentuhan. |
| `Icon` | Menampilkan ikon pada kartu menu. |
| `SnackBar` | Menampilkan pesan sementara setelah menu diketuk. |  

#### 3. Apa fungsi MaterialApp dan mengapa umumnya digunakan sebagai root widget?

MaterialApp berfungsi sebagai pusat pengaturan konfigurasi utama aplikasi. Untuk Flow eksekusinya seperti ini runApp -> MyApp -> MaterialApp -> MyHomePage. MaterialApp seringkali diletakkan dii root karena bagian ini menyediakan pengaturan yang dipakai oleh banyak widget di bawahnya seperti tema, navigasi, dan halaman awal. Dengan begitu, pengaturan tema dan navigasi tidak perlu dibuat ulang pada setiap halaman.


#### 4. Apa perbedaan StatelessWidget dan StatefulWidget, serta kapan menggunakannya?

StatelessWidget adalah widget yang tidak menyimpan keadaan yang berubah di dalam dirinya sendiri. Widget ini hanya sekedar menerima data lalu menampilkannya. Sedangkan StatefulWidget adalah widget yang memiliki keadaan yang bisa berubah selama aplikasi digunakan. Widget ini ketika ada perubahan yang terjadi maka tampilannya bisa diperbaharui. Untuk lebih simplenya bisa menggunakan kata kunci state yang berarti nilai atau kondisi yang perlu diingat oleh suatu widget. Jadi Statelesswidget akan bagus ketika widget tersebut tidak perlu menyimpan data yang berubah di dalam dirinya sendiri. Disisi lain untuk StatefulWidget bagus digunakan ketika widget perlu menyimpan kondisi yang berubah selama digunakan. Perlu diingat juga StatelessWidget tetap bisa dibangun ulang ketika konfigurasi dari parent atau informasi lingkungan yang digunakannya berubah.  

#### 5. Apa itu BuildContext dan bagaimana penggunaannya dalam metode build?

BuildContext adalah objek yang mewakili posisi sebuah widget dalam widget tree. Sederhananya BuildContext ini digunakan untuk menunjukkan posisi sebuah widget di dalam sebuah widget tree. Dalam metode build urutan/alur penggunaannya adalah flutter memanggil build dan memberikan context milik widget tersebut (sebagai parameternya). Lalu build akan mengembalikan widget yang tampilannya mengikuti/memakai informasi yang telah diterapkan di fungsi tersebut. Maka dari itu penggunaan context di dalam build adalah sebagai acuan posisi saat widget membutuhkan informasi dari lingkungan di sekitarnya.


#### 6. Apa perbedaan hot reload, hot restart, dan full restart?

Hot reload memasukkan perubahan kode ke aplikasi yang sedang berjalan dan membangun ulang widget tree sambil mempertahankan state aplikasi. Fitur ini cocok untuk mencoba perubahan tampilan seperti teks, padding, dan warna.   

Hot restart memulai ulang aplikasi Flutter dengan kode terbaru dan menghapus state sebelumnya. Proses inisialisasi aplikasi dijalankan kembali. Hal ini biasanya digunakna ketika perubahan harus menjalankan ulang main() atau initState(), atau ketika perubahan struktur tipe tertentu yang tidak didukung hot reload.

Full restart dilakukan dengan menghentikan aplikasi lalu menjalankannya kembali. Proses ini diperlukan ketika terdapat perubahan kode native seperti Kotlin, Java, Swift, atau Objective-C, serta konfigurasi build tertentu.  

Untuk simplenya : hot reload : perbarui, hot restart : memulai ulang flutter, full restart : tutup dan jalankan kembali.


### AI Disclosure

Saya menggunkann AI/LLM dalam pembuatan tugas ini. Penggunaan AI ini yang saya terapkan antara lain : Pemahaman alur tugas secara mendalam, memahami maksud dari tugas yang masih belum terlalu jelas, pengaturan git/bentuk git commit disiplinnya bagaimana, dan melakukan fix bug yang terjadi ketika saya melakukan implementasi. Saya juga meminta AI saya untuk memastikan perubahan yang saya lakukan pada tugas ini apakah sudah sesuai dengan BRP yang diminta dan tugas yang diperintahkan (dengan tutorial menjadi batasan/pembanding buat implementasinya). Saya juga memanfaatkan platform lain selain AI untuk mengerjakan tugas ini, seperti panduan tutorial, dan dokumentasi untuk mencari atau memahami materinya secara mendalam. Penggunaan AI ini saya lebih fokuskan untuk membantu saya memahami basic flutter dan kegunaannya terutama dalam menganalisis pertanyaan refleksinya. Selebihnya saya memakai AI sebagai teman untuk saya berdiskusi ketika menemukan materi yang bingung dan ingin melakukan pemahaman secara mendalam mengenai tugas/materi tertentu.

AI assistance reference: [https://chatgpt.com/s/cx_6afb15ad765c8191bab2383b23b3d045] AI Tools : github copilot chat, codex chat, chatGPT  

### References

- Tutorial 08 : Basic Flutter (https://pbp.cs.ui.ac.id/en/tutorial/tutorial-8.html)
- Dokumentasi Flutter : (https://docs.flutter.dev/) dan (https://api.flutter.dev/)

### Progress Mingguan

Pada minggu ini, progres saya berfokus pada dasar flutter seperti penyesuaian halaman utama menjadi portofolio pribadi. Saya menampilkan nama, NPM, dan kelas PBP, lalu memberikan warna berbeda pada tombol Lihat Proyek, Tambah Proyek, dan Logout. Warna kartu yang saya terapkan sengaja mengikuti tone warna portofolio website saya. Setiap tombol menampilkan SnackBar sesuai nama tombol yang ditekan. Saya juga mempelajari hubungan widget dalam widget tree, penggunaan BuildContext, serta perbedaan hot reload dan hot restart.
