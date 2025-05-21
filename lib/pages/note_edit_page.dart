import 'package:flutter/material.dart';
// Import library Flutter untuk membuat UI

import 'package:cobaflutter/pages/note_page.dart';
// Import halaman note_page.dart, kemungkinan berisi model Note

import 'package:supabase_flutter/supabase_flutter.dart';
// Import library Supabase Flutter untuk komunikasi dengan backend Supabase


class NoteEditPage extends StatefulWidget {
  // Widget Stateful untuk halaman tambah/edit catatan

  const NoteEditPage({super.key});
  // Konstruktor const dengan key opsional

  @override
  State<NoteEditPage> createState() => _NoteEditPageState();
  // Membuat state yang terkait dengan widget ini
}


class _NoteEditPageState extends State<NoteEditPage> {
  // State dari NoteEditPage yang berisi logika dan UI dinamis

  Note? note;
  // Variabel yang menampung objek Note, bisa null (artinya buat baru)

  bool initialized = false;
  // Flag untuk memastikan data note sudah di-load dan di-set ke form

  final _formKey = GlobalKey<FormState>();
  // Key unik untuk mengontrol validasi form

  String title = '';
  String description = '';
  // Variabel untuk menyimpan input user di form judul dan deskripsi


  Future save() async {
    // Fungsi async untuk menyimpan data catatan ke Supabase

    if (_formKey.currentState!.validate()) {
      // Cek validasi form (judul tidak kosong)

      final supabase = Supabase.instance.client;
      // Mendapatkan instance client Supabase

      String message = 'Berhasil menyimpan catatan';
      // Pesan default ketika insert catatan berhasil

      if (note != null) {
        // Jika note tidak null berarti update catatan lama

        await supabase
            .from('notes')
            .update({'title': title, 'description': description})
            .eq('id', note?.id ?? '');
        // Update data di tabel 'notes' berdasarkan id catatan

        message = 'Berhasil mengubah catatan';
        // Ubah pesan jika update berhasil
      } else {
        // Jika note null berarti buat catatan baru (insert)

        await supabase.from('notes').insert({
          'title': title,
          'description': description,
        });
      }

      if (!mounted) return;
      // Cek apakah widget masih ada di widget tree (untuk mencegah error)

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(message)));
      // Tampilkan pesan snack bar sebagai notifikasi

      Navigator.pop<String>(context, 'OK');
      // Kembali ke halaman sebelumnya, dengan mengirim nilai 'OK'
    }
  }


  Future delete() async {
    // Fungsi async untuk menghapus catatan

    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Konfirmasi'),
          content: const Text('Apakah Anda yakin ingin menghapus catatan ini?'),
          // Dialog konfirmasi hapus catatan

          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context, false),
              child: const Text('Batal'),
              // Tombol batal, mengembalikan nilai false
            ),
            TextButton(
              onPressed: () => Navigator.pop(context, true),
              child: const Text('Hapus'),
              // Tombol hapus, mengembalikan nilai true
            ),
          ],
        );
      },
    );

    if (confirmed == true) {
      // Jika user konfirmasi hapus

      final supabase = Supabase.instance.client;
      await supabase.from('notes').delete().eq('id', note?.id ?? '');
      // Hapus catatan berdasarkan id di tabel 'notes'

      if (!mounted) return;
      // Cek widget masih ada

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('berhasil menghapus catatan')));
      // Tampilkan notifikasi berhasil hapus

      Navigator.pop<String>(context, 'OK');
      // Kembali ke halaman sebelumnya
    }
  }


  @override
  Widget build(BuildContext context) {
    // Method build untuk menggambar UI

    note = ModalRoute.of(context)!.settings.arguments as Note?;
    // Ambil argumen dari route, yang berisi objek Note (bisa null)

    if (note != null && !initialized) {
      // Jika note ada dan belum di-inisialisasi

      setState(() {
        title = note?.title ?? '';
        description = note?.description ?? '';
        // Set nilai awal form dari data note yang diterima
      });

      initialized = true;
      // Tandai sudah di-inisialisasi agar tidak terus-set state berulang
    }


    return Scaffold(
      // Struktur halaman dengan appBar dan body

      appBar: AppBar(
        title: Text("${(note != null) ? 'Edit' : 'Buat'} Catatan"),
        // Judul appBar berubah sesuai mode edit atau buat baru

        actions:
            (note != null)
                ? [
                    IconButton(icon: const Icon(Icons.delete), onPressed: delete),
                    // Jika edit, tampilkan tombol hapus di appBar
                  ]
                : [],
      ),

      body: Form(
        key: _formKey,
        // Widget Form untuk validasi dan pengelolaan form

        child: Column(
          children: [
            TextFormField(
              decoration: const InputDecoration(labelText: 'Judul'),
              // Input field untuk judul catatan

              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Judul tidak boleh kosong';
                  // Validasi: judul harus diisi
                }
                return null;
              },

              initialValue: title,
              // Set nilai awal dari variabel title

              onChanged: (value) {
                setState(() {
                  title = value;
                  // Simpan nilai input ke variabel title saat diubah user
                });
              },
            ),

            TextFormField(
              decoration: const InputDecoration(labelText: 'Deskripsi'),
              // Input field untuk deskripsi catatan

              initialValue: description,
              // Set nilai awal dari variabel description

              onChanged: (value) {
                setState(() {
                  description = value;
                  // Simpan nilai input ke variabel description saat diubah user
                });
              },
            ),

            ElevatedButton(onPressed: save, child: const Text('Simpan')),
            // Tombol simpan yang memicu fungsi save()
          ],
        ),
      ),
    );
  }
}
