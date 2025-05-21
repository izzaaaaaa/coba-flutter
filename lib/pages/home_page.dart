import 'package:flutter/material.dart';
// Import paket Flutter material design untuk membangun UI

import 'package:cobaflutter/pages/detail_page.dart';
// Import halaman DetailPage dari folder pages (path proyek kamu)

class HomePage extends StatelessWidget {
  // Membuat widget stateless bernama HomePage sebagai halaman utama

  const HomePage({super.key});
  // Konstruktor const dengan key opsional

  @override
  Widget build(BuildContext context) {
    // Method build untuk menggambar UI

    return Scaffold(
      // Scaffold memberikan struktur dasar halaman dengan appBar dan body

      appBar: AppBar(
        title: const Text("Home Page"),
        // Judul pada appBar

        actions: [
          IconButton(
            // Tombol icon di pojok kanan appBar

            onPressed: () => Navigator.pushNamed(context, '/setting'),
            // Ketika ditekan, navigasi ke route dengan nama '/setting'

            icon: const Icon(Icons.settings),
            // Ikon berupa ikon pengaturan (gear)
          ),
        ],
      ),

      body: Center(
        // Konten utama halaman ditempatkan di tengah layar

        child: Column(
          // Widget kolom untuk menampilkan beberapa widget secara vertikal

          children: [
            ElevatedButton(
              // Tombol yang menonjol dengan efek elevasi

              onPressed: () => Navigator.of(context).push(
                // Ketika ditekan, lakukan navigasi menggunakan MaterialPageRoute

                MaterialPageRoute(
                  builder: (context) => const DetailPage(id: 123),
                  // Membangun halaman DetailPage dengan parameter id = 123

                  settings: const RouteSettings(arguments: "buku"),
                  // Menyisipkan data tambahan (arguments) berupa string "buku"
                  // yang dapat diakses pada halaman DetailPage
                ),
              ),

              child: const Text("Detail"),
              // Teks pada tombol "Detail"
            ),

            const Text("Hom Page"),
            // Menampilkan teks "Hom Page" di bawah tombol

            ElevatedButton(
              onPressed: () => Navigator.pushNamed(context, "/album"),
              // Tombol navigasi ke route bernama '/album'

              child: const Text("Album"),
              // Teks tombol "Album"
            ),

            ElevatedButton(
              onPressed: () => Navigator.pushNamed(context, "/note"),
              // Tombol navigasi ke route bernama '/note'

              child: const Text("Note Page"),
              // Teks tombol "Note Page"
            ),
          ],
        ),
      ),
    );
  }
}
