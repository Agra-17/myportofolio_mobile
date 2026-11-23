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
│   ├── screens/
│   │   ├── menu.dart          # Halaman utama, kartu identitas, dan model menu
│   │   └── project_form.dart  # Form proyek sesuai Tutorial 09
│   └── widgets/
│       ├── left_drawer.dart   # Navigasi drawer
│       └── project_card.dart  # Kartu tombol
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


### Tugas 8

#### 1. Jelaskan perbedaan antara Navigator.push(), Navigator.pushReplacement(), dan Navigator.pop(). Metode apa yang digunakan untuk membuka formulir dari kartu aksi? Jelaskan juga bagaimana opsi Home di drawer membawa pengguna kembali ke halaman utama.  
Untuk ini kita bisa ibaratkan sebagai tumpukan biasa. Untuk Navigator.push() ini berfungsi untuk menambahkan kartu baru di atas home. Untuk Navigator.pushReplacement() ini berfungsi untuk mengganti kartu paling atas, contoh pada implementasi saat pengguna memilih home dari drawer di halaman form aplikasi akan mengganti halaman aktif dengan halaman home. Untuk Navigator.pop() ini berguna untuk  mengambil kartu yang paling atas, contoh implementasi nya saat dialog ringkasan terbuka, urutannya Home → Form → Dialog. Menekan OK menutup dialog, sehingga form terlihat lagi.  
Kartu aksi memakai Navigator.push()Saat kartu Tambah Pengalaman ditekan, Navigator.push() membuka ExperienceFormPage di atas halaman Home. Urutannya menjadi Home → Form. Karena Home masih ada di bawah, tombol Back menutup form dan menampilkan Home sebelumnya.sedangkan opsi Home di drawer memakai Navigator.pushReplacement(). Saat opsi Home di drawer dipilih dari halaman form, Navigator.pushReplacement() mengganti halaman form yang sedang aktif dengan MyHomePage. Jadi, pengguna langsung melihat halaman utama dan form yang tadi aktif dikeluarkan dari riwayat navigasi.  

#### 2. Bagaimana susunan Scaffold, AppBar, dan Drawer membantu menjaga struktur halaman tetap konsisten? Berikan satu contoh penggunaan warna tema portofolio di lebih dari satu halaman.  
Mudahnya Scaffold seperti kerangka halaman. AppBar menempati bagian atas untuk memberi tahu pengguna halaman apa yang sedang dibuka. Drawer menyediakan menu samping. Di dalam kerangka yang sama, Home punya isi berupa kartu, sedangkan Tambah Pengalaman punya isi berupa form. Pada implementasi saya halaman Home dan Tambah Pengalaman sama-sama menggunakan Scaffold sebagai kerangka halaman. AppBar menampilkan judul supaya pengguna tahu halaman yang sedang dibuka. Kedua halaman juga memakai widget LeftDrawer yang sama, sehingga pilihan navigasi seperti Home dan Tambah Pengalaman tersedia di keduanya.  

Untuk contoh penggunaan tema ada pada warna latar AppBar. Baik Home maupun Tambah Pengalaman mengambil warna dari Theme.of(context).colorScheme.primary. Karena keduanya memakai warna utama dari tema aplikasi, jika warna utama tema diubah, kedua AppBar akan ikut menyesuaikan.  

#### 3. Mengapa tata letak tersebut dipilih untuk formulir? Jelaskan peran widget pengatur jarak dan widget penggulir ketika ruang layar terbatas.  
Waktu membuat form Tambah Pengalaman, saya mengikuti enam kolom yang sudah ada di website portofolio saya. Saya memakai Column supaya pengguna bisa mengisi form secara berurutan, mulai dari Nama Experience sampai Tanggal Selesai. Saya juga memakai Padding agar kolom punya jarak satu sama lain dan isi form tidak terlalu mepet ke tepi layar.

Setelah kolom URL gambar dan kedua tanggal ditambahkan, isi form jadi lebih panjang. Karena itu, saya memakai SingleChildScrollView agar seluruh form bisa digulir. Contohnya, saat pengguna mengetik deskripsi dan keyboard muncul, ia masih bisa menggulir ke bawah untuk memilih tanggal atau menekan tombol Simpan.  

#### 4. Apa peran GlobalKey<FormState>, validator, dan validate() saat tombol Simpan ditekan? Berikan satu contoh nilai yang ditolak oleh validasi dan jelaskan mengapa memilih jenis input atau papan ketik saja belum cukup.  
GlobalKey adalah tanda pengenal unik yang bisa digunakan untuk mengakses widget dan state-nya. Di aplikasi saya, _formKey bertipe GlobalKey<FormState> dan dipasang pada form Tambah Pengalaman. Saat tombol Simpan ditekan, saya mengakses FormState lewat _formKey.currentState lalu memanggil validate(). Fungsi ini menjalankan validator pada setiap kolom yang punya aturan validasi. Jika suatu validator mengembalikan pesan kesalahan, pesan itu muncul pada kolom terkait. Dialog ringkasan baru tampil setelah semua kolom lolos pemeriksaan.

Contohnya, kolom URL Gambar Experience boleh dikosongkan. Kalau pengguna memasukkan gambar.jpg, validator menolaknya karena isian tersebut belum memiliki http:// atau https:// dan nama host. TextInputType.url memudahkan pengguna mengetik URL dengan menyesuaikan keyboard. Karena pengguna masih bisa mengetik atau menempelkan teks seperti gambar.jpg, saya tetap memeriksa formatnya lewat validator.

### AI Disclosure

Saya memakai LLM/AI dalam mengerjakan tugas ini. Penggunaan AI saya diantara lain untuk : Penentuan alur pengerjaan tugas, memahami maksud dari tugas secara mendalam, membuat pengaturan untuk git disiplin, dan membantu untuk fixing bug yang terjadi ketika melakukan implementasi. Saya juga meminta AI saya untuk memastikan apakah perubahan atau pengerjaan yang saya lakukan di tugas ini sudah sesuai dengan perintah tugas atau belum (acuannya adalah BRP yang telah ditetapkan dan juga tutorial sebagai contoh tempaltena). Saya juga memanfaatkan platform lain selain AI untuk mengerjakan tugas ini, seperti ppt, tutorial, dan dokumentasi untuk pencarian mendalam terkait syntaxnya. Penggunaan AI ini saya lebih fokuskan untuk membantu saya memahami basic dari tugasnya dan kegunaan dari tools yang tersedia. Selebihnya saya menggunakan AI untuk teman diskusi saya untuk memperdalam materi yang saya masih membingungkan dan ingin melakukan pemahaman yang mendalam (terutama ketika melakukan implementasi yang masih salah). 


AI assistance reference: [https://chatgpt.com/s/cx_6b03e2cf16248191915c94de11037e6f] AI Tools : github copilot chat, codex chat, chatGPT  

### References

- Tutorial 09 : Basic Flutter (https://pbp.cs.ui.ac.id/en/tutorial/tutorial-9.html)
- Dokumentasi Flutter : (https://docs.flutter.dev/) dan (https://api.flutter.dev/)

### Progress Mingguan

Pada minggu ini, progres saya berfokus pada dasar flutter seperti penyesuaian halaman utama menjadi portofolio pribadi. Saya menampilkan nama, NPM, dan kelas PBP, lalu memberikan warna berbeda pada tombol Lihat Proyek, Tambah Proyek, dan Logout. Warna kartu yang saya terapkan sengaja mengikuti tone warna portofolio website saya. Setiap tombol menampilkan SnackBar sesuai nama tombol yang ditekan. Saya juga mempelajari hubungan widget dalam widget tree, penggunaan BuildContext, serta perbedaan hot reload dan hot restart. (Minggu pertama Flutter)

Pada minggu ini, progres saya berfokus pada pembuatan model baru yaitu experience (fokus pada pembuatan form dan penampilan ringkasan setelah mengisi formnya). Saya menambahkan fitur Tambah Pengalaman ke aplikasi flutter portofolio saya. Form bisa dibuka dari kartu di Home dan dari drawer. Saya menyesuaikan enam kolomnya dengan form di website portofolio saya, termasuk dropdown kategori, URL gambar, serta pemilih tanggal mulai dan selesai. Saya juga menambahkan validasi untuk isian wajib, URL, dan urutan tanggal. Setelah semua isian valid, tombol Simpan menampilkan ringkasannya dalam dialog. (Minggu kedua flutter)
