import 'package:flutter/material.dart';
import 'package:cobaflutter/pages/note_page.dart';
import 'package:supabase_flutter/supabase_flutter.dart';



class NoteEditPage extends StatefulWidget {
  const NoteEditPage({super.key});

  @override
  State<NoteEditPage> createState() => _NoteEditPageState();
}

  class _NoteEditPageState extends State<NoteEditPage> {
  Note? note;
  bool initialized = false;

  final _formKey = GlobalKey<FormState>();
  String title = '';
  String description = '';

  Future save() async {
    if (_formKey.currentState!.validate()) {
      final supabase = Supabase.instance.client;
      String message = 'Berhasil menyimpan catatan';

      // Jika note tidak null, maka kita update
      if (note != null) {
        await supabase
            .from('notes')
            .update({'title': title, 'description': description})
            .eq('id', note?.id ?? '');
        message = 'Berhasil mengubah catatan';
      } else {
        // Jika note null, maka kita insert
        await supabase.from('notes').insert({
          'title': title,
          'description': description,
        });
      }

      if (!mounted) return;
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(message)));
      Navigator.pop<String>(context, 'OK');
    }
  }

  Future delete() async {
    // tampilkan dialog konfirmasi sebelum menghapus
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Konfirmasi'),
          content: const Text('Apakah Anda yakin ingin menghapus catatan ini?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context, false),
              child: const Text('Batal'),
            ),
            TextButton(
              onPressed: () => Navigator.pop(context, true),
              child: const Text('Hapus'),
            ),
          ],
        );
      },
    );

    if (confirmed == true) {
      final supabase = Supabase.instance.client;
      await supabase.from('notes').delete().eq('id', note?.id ?? '');
       if (!mounted) return;
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('berhasil menghapus catatan')));

      Navigator.pop<String>(context, 'OK');
    }
  }

  @override
  Widget build(BuildContext context) {
    note = ModalRoute.of(context)!.settings.arguments as Note?;
    if (note != null && !initialized) {
      setState(() {
        title = note?.title ?? '';
        description = note?.description ?? '';
      });
      initialized = true;
    }

    return Scaffold(
      appBar: AppBar(
        title: Text("${(note != null) ? 'Edit' : 'Buat'} Catatan"),
        actions:
            (note != null)
                ? [
                  IconButton(icon: const Icon(Icons.delete), onPressed: delete),
                ]
                : [],
      ),
      body: Form(
        key: _formKey,
        child: Column(
          children: [
            TextFormField(
              decoration: const InputDecoration(labelText: 'Judul'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Judul tidak boleh kosong';
                }
                return null;
              },
              initialValue: title,
              onChanged: (value) {
                setState(() {
                  title = value;
                });
              },
            ),
            TextFormField(
              decoration: const InputDecoration(labelText: 'Deskripsi'),
              initialValue: description,
              onChanged: (value) {
                setState(() {
                  description = value;
                });
              },
            ),
            ElevatedButton(onPressed: save, child: const Text('Simpan')),
          ],
        ),
      ),
    );
  }
}