import 'dart:convert';
// Import library untuk mengubah data JSON ke objek Dart dan sebaliknya.

import 'package:flutter/material.dart';
// Import library Flutter untuk membuat UI material design.

import 'package:http/http.dart' as http;
// Import package http untuk melakukan request HTTP, diberi alias 'http'.

// Fungsi untuk mengambil data album dari API secara async
Future<Album> fetchAlbum() async {
  final response = await http.get(
    Uri.parse('https://jsonplaceholder.typicode.com/albums/1'),
  );
  // Melakukan request GET ke URL API dan menunggu responsenya

  if (response.statusCode == 200) {
    // Jika status response 200 (OK),
    // parsing response body yang berupa JSON menjadi objek Album
    return Album.fromJson(jsonDecode(response.body) as Map<String, dynamic>);
  } else {
    // Jika status bukan 200, lempar exception error
    throw Exception('Failed to load album');
  }
}

class Album {
  final int userId; // ID user yang memiliki album
  final int id; // ID album
  final String title; // Judul album

  const Album({required this.userId, required this.id, required this.title});
  // Konstruktor untuk membuat objek Album dengan field yang wajib diisi

  // Factory constructor untuk membuat objek Album dari Map JSON
  factory Album.fromJson(Map<String, dynamic> json) {
    return switch (json) {
      {'userId': int userId, 'id': int id, 'title': String title} => Album(
          userId: userId,
          id: id,
          title: title,
        ),
      _ => throw const FormatException('Failed to load album.'),
      // Jika format json tidak sesuai, lempar error format exception
    };
  }
}

class AlbumPage extends StatefulWidget {
  const AlbumPage({super.key});
  // Widget stateful yang menampilkan halaman album

  @override
  State<AlbumPage> createState() => _AlbumPageState();
  // Membuat state untuk widget AlbumPage
}

class _AlbumPageState extends State<AlbumPage> {
  late Future<Album> futureAlbum;
  // Variabel yang menyimpan future album yang akan di-fetch

  @override
  void initState() {
    super.initState();
    futureAlbum = fetchAlbum();
    // Saat widget dibuat, langsung panggil fetchAlbum untuk mulai ambil data
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Album Page")),
      // Membuat app bar dengan judul

      body: Center(
        child: FutureBuilder<Album>(
          future: futureAlbum,
          // Widget yang membangun UI berdasarkan state Future futureAlbum

          builder: (context, snapshot) {
            if (snapshot.hasData) {
              // Jika data sudah tersedia, tampilkan judul album
              return Text(snapshot.data!.title);
            } else if (snapshot.hasError) {
              // Jika terjadi error saat fetching data, tampilkan pesan error
              return Text('${snapshot.error}');
            }

            // Jika data belum siap, tampilkan loading spinner
            return const CircularProgressIndicator();
          },
        ),
      ),
    );
  }
}
