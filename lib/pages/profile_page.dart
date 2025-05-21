import 'package:flutter/material.dart';
// Import package Flutter untuk UI

class ProfilePage extends StatelessWidget {
  // Membuat widget stateless bernama ProfilePage
  // Stateless berarti widget ini tidak memiliki state yang berubah

  const ProfilePage({super.key});
  // Konstruktor const dengan parameter key opsional untuk widget ini

  @override
  Widget build(BuildContext context) {
    // Method build yang wajib ada pada widget Flutter
    // Membangun tampilan UI saat widget ini dipanggil

    return Scaffold(
      // Scaffold menyediakan struktur layout dasar seperti AppBar dan body

      appBar: AppBar(title: const Text("Profile Page")),
      // Membuat AppBar dengan judul "Profile Page"

      body: const Center(child: Text("Profile Page")),
      // Body berisi widget Center yang menempatkan teks "Profile Page" di tengah layar
    );
  }
}
