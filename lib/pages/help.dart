import 'package:flutter/material.dart';

class Help extends StatelessWidget {
  const Help({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Bantuan")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Title
              const Text(
                "Panduan Penggunaan Aplikasi",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),

              // Section 1: Introduction
              const Text(
                "Selamat datang di aplikasi monitoring kambing! Aplikasi ini dirancang untuk mempermudah pengelolaan data kambing dan mitra. Berikut adalah panduan lengkap untuk memulai.",
                style: TextStyle(fontSize: 18),
              ),
              const SizedBox(height: 16),

              // Section 2: How to Add Mitra
              const Text(
                "1. Menambahkan Mitra",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              const Text(
                "Untuk menambahkan Mitra baru, pilih tombol '+' di halaman utama, kemudian isi informasi seperti nama mitra, desa, pengecek, dan pendamping. Setelah selesai, tekan tombol 'Simpan'.",
                style: TextStyle(fontSize: 18),
              ),
              const SizedBox(height: 16),

              // Section 3: How to Add Kambing
              const Text(
                "2. Menambahkan Kambing",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              const Text(
                "Setelah menambahkan Mitra, Anda dapat menambahkan kambing yang dimiliki oleh mitra tersebut. Pilih Mitra yang ingin dilihat, lalu tekan tombol '+' untuk menambahkan kambing baru. Isi data kambing seperti nomor kambing, kondisi, dan keterangan lainnya.",
                style: TextStyle(fontSize: 18),
              ),
              const SizedBox(height: 16),

              // Section 4: View Kambing Details
              const Text(
                "3. Melihat Detail Kambing",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              const Text(
                "Untuk melihat detail kambing, pilih kambing yang ingin dilihat dari daftar mitra, dan Anda akan melihat informasi lengkap tentang kambing tersebut, seperti kondisi kesehatan, umur kehamilan, serta foto kambing.",
                style: TextStyle(fontSize: 18),
              ),
              const SizedBox(height: 16),

              // Section 5: Troubleshooting
              const Text(
                "4. Pemecahan Masalah",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              const Text(
                "Jika Anda mengalami masalah teknis, seperti aplikasi tidak merespons atau data tidak tersimpan, coba untuk keluar dan masuk kembali ke aplikasi. Jika masalah tetap berlanjut, coba perbarui aplikasi atau hubungi tim dukungan.",
                style: TextStyle(fontSize: 18),
              ),
              const SizedBox(height: 16),

              // Section 6: Contact Support
              const Text(
                "5. Kontak Dukungan",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              const Text(
                "Untuk bantuan lebih lanjut, Anda bisa menghubungi tim dukungan kami melalui email: support@mitrakambing.com atau telepon di nomor 0800-123-456. Kami siap membantu Anda.",
                style: TextStyle(fontSize: 18),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
