import 'package:flutter/material.dart';
// Import Flutter UI framework

import 'package:supabase_flutter/supabase_flutter.dart';
// Import Supabase Flutter untuk koneksi backend Supabase


Future fetchNote() async {
  // Fungsi async untuk mengambil data catatan dari Supabase

  final supabase = Supabase.instance.client;
  // Dapatkan instance client Supabase

  final data = await supabase.from('notes').select();
  // Query data dari tabel 'notes'

  return data;
  // Kembalikan data hasil query
}


class Note {
  // Model class untuk objek Note

  final String id;
  final String title;
  final String? description;
  // Properti id, title wajib, description opsional (nullable)

  const Note({
    required this.id,
    required this.title,
    required this.description,
  });
  // Konstruktor dengan parameter wajib dan opsional

  factory Note.fromJson(Map<String, dynamic> json) {
    // Factory constructor untuk mengonversi dari JSON ke objek Note

    return switch (json) {
      {
        'id': String id,
        'title': String title,
        'description': String? description,
      } =>
        Note(id: id, title: title, description: description),
      _ => throw const FormatException('Failed to load album.'),
    };
    // Memastikan JSON memiliki key dan tipe data yang sesuai
  }
}


class NotePage extends StatefulWidget {
  // StatefulWidget untuk halaman daftar catatan

  const NotePage({super.key});

  @override
  State<NotePage> createState() => _NotePageState();
  // Membuat state untuk halaman ini
}


class _NotePageState extends State<NotePage> {
  late Future futureNote;
  // Future yang akan menampung data hasil fetch catatan (asinkron)

  @override
  void initState() {
    super.initState();
    futureNote = fetchNote();
    // Saat widget diinisialisasi, langsung fetch data catatan
  }

  Future<void> _editNotePage(BuildContext context, Object? arguments) async {
    // Fungsi async untuk navigasi ke halaman edit catatan
    // menerima arguments untuk dikirim ke halaman edit

    final result = await Navigator.pushNamed(
      context,
      '/note/edit',
      arguments: arguments,
    );
    // Panggil halaman edit dengan route name '/note/edit' dan passing arguments

    if (result == 'OK') {
      // Jika halaman edit mengembalikan 'OK' (berarti ada perubahan)

      setState(() {
        futureNote = fetchNote();
        // Refresh data catatan dengan fetch ulang
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // Method build untuk membangun UI halaman

    return Scaffold(
      appBar: AppBar(title: const Text("Note Page")),
      // AppBar dengan judul "Note Page"

      body: Center(
        child: FutureBuilder(
          future: futureNote,
          // Menunggu futureNote selesai (data dari Supabase)

          builder: (context, snapshot) {
            if (snapshot.hasData) {
              // Jika data sudah tersedia

              // return Text(snapshot.data.toString()); // (Opsional debug)

              return ListView.builder(
                itemCount: snapshot.data.length,
                // Jumlah item sesuai data catatan yang di-fetch

                itemBuilder: (context, index) {
                  final note = Note.fromJson(snapshot.data[index]);
                  // Konversi setiap data JSON ke objek Note

                  return ListTile(
                    title: Text(note.title),
                    subtitle: Text(note.description ?? ''),
                    // Tampilkan judul dan deskripsi catatan

                    onTap: () {
                      _editNotePage(context, note);
                      // Saat diklik, navigasi ke halaman edit dengan note sebagai argumen
                    },
                  );
                },
              );
            } else if (snapshot.hasError) {
              // Jika ada error saat fetch data

              return Text('${snapshot.error}');
              // Tampilkan pesan error
            }

            // Jika data belum tersedia, tampilkan loading spinner
            return const CircularProgressIndicator();
          },
        ),
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _editNotePage(context, null);
          // Jika tombol tambah ditekan, buka halaman edit untuk buat catatan baru
        },
        child: const Icon(Icons.add),
        // Ikon tambah (+)
      ),
    );
  }
}
