import 'package:flutter/material.dart';
// Mengimpor paket Flutter untuk membangun UI aplikasi

import 'package:cobaflutter/pages/album_page.dart';
import 'package:cobaflutter/pages/home_page.dart';
import 'package:cobaflutter/pages/note_edit_page.dart';
import 'package:cobaflutter/pages/note_page.dart';
import 'package:cobaflutter/pages/profile_page.dart';
import 'package:cobaflutter/pages/setting_page.dart';
// Mengimpor semua halaman yang digunakan dalam aplikasi dari direktori 'pages'

import 'package:supabase_flutter/supabase_flutter.dart';
// Mengimpor pustaka Supabase khusus Flutter untuk integrasi backend

const String supabaseKey = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9...';
// Kunci anon Supabase untuk autentikasi ke project Supabase kamu
// (sebaiknya disimpan di tempat aman, misalnya .env file untuk proyek nyata)

Future<void> main() async {
  // Fungsi utama sebagai titik awal aplikasi

  await Supabase.initialize(
    url: 'https://bbbxqhkngzcpmyxhbcxh.supabase.co',
    // URL project Supabase kamu

    anonKey: supabaseKey,
    // Kunci anon yang dipakai untuk mengakses Supabase (public)
  );

  runApp(const MainApp());
  // Menjalankan aplikasi Flutter dengan widget utama MainApp
}

class MainApp extends StatelessWidget {
  // Widget utama dari aplikasi (stateless)

  const MainApp({super.key});
  // Konstruktor const

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // Membungkus aplikasi dalam MaterialApp — root widget untuk aplikasi Flutter Material Design

      initialRoute: '/',
      // Menentukan rute awal saat aplikasi dijalankan

      routes: {
        // Mendefinisikan peta rute: nama rute dan widget yang akan dibuka

        '/': (context) => const HomePage(),
        // Rute utama menampilkan HomePage

        '/setting': (context) => const SettingPage(),
        // Rute ke halaman pengaturan

        '/profile': (context) => const ProfilePage(),
        // Rute ke halaman profil

        '/album': (context) => const AlbumPage(),
        // Rute ke halaman album (misalnya API JSONPlaceholder)

        '/note': (context) => const NotePage(),
        // Rute ke halaman daftar catatan

        '/note/edit': (context) => const NoteEditPage(),
        // Rute ke halaman untuk membuat/mengedit catatan
      },

      // home: Scaffold(body: Center(child: Text("halo"))),
      // Ini contoh alternatif jika tidak menggunakan routing (dikomentari)
    );
  }
}
