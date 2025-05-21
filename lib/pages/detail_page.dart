import 'package:flutter/material.dart';
// Import library Flutter untuk membuat UI menggunakan material design

class DetailPage extends StatelessWidget {
  // Widget stateless yang menampilkan halaman detail berdasarkan id

  final int id;
  // Properti final yang menyimpan nilai id yang diterima dari konstruktor

  const DetailPage({super.key, required this.id});
  // Konstruktor dengan named parameter 'id' yang wajib diisi saat membuat widget ini.
  // Juga menerima key opsional yang diteruskan ke superclass.

  @override
  Widget build(BuildContext context) {
    // Fungsi build yang mengembalikan widget UI

    final argId = ModalRoute.of(context)!.settings.arguments as String;
    // Mengambil argumen yang dikirim melalui Navigator route arguments dari context,
    // lalu casting-nya menjadi String.
    // Catatan: ini akan error jika arguments null atau bukan String.

    return Scaffold(
      appBar: AppBar(title: Text("Detail id: $id")),
      // Membuat app bar dengan judul yang memuat nilai id dari properti kelas

      body: Center(child: Text("Detail Page: $argId")),
      // Bagian utama body berupa teks yang menampilkan argumen yang diambil dari route arguments,
      // ditempatkan di tengah layar dengan widget Center.
    );
  }
}
