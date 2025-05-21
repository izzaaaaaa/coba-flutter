import 'package:flutter/material.dart';
// Mengimpor paket Flutter untuk membangun UI

class SettingPage extends StatelessWidget {
  // Mendefinisikan widget stateless bernama SettingPage
  // Widget ini tidak memiliki state yang berubah

  const SettingPage({super.key});
  // Konstruktor const dengan parameter key opsional

  @override
  Widget build(BuildContext context) {
    // Method build untuk membangun tampilan widget ini

    return Scaffold(
      // Scaffold menyediakan kerangka dasar aplikasi dengan AppBar dan body

      appBar: AppBar(title: const Text("Setting Page")),
      // Membuat AppBar dengan judul "Setting Page"

      body: Center(
        // Widget Center untuk menempatkan child di tengah layar

        child: ElevatedButton(
          // Tombol elevated (berbayang) sebagai child Center

          onPressed: () => Navigator.pushNamed(context, "/profile"),
          // Fungsi yang dijalankan saat tombol ditekan
          // Menavigasi ke route dengan nama "/profile"

          child: const Text("Profile"),
          // Teks yang ditampilkan pada tombol
        ),
      ),
    );
  }
}
