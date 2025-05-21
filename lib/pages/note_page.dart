import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';


Future fetchNote() async {
  final supabase = Supabase.instance.client;

  final data = await supabase.from('notes').select();
  return data;
}

class Note {
  final String id;
  final String title;
  final String? description;

  const Note({
    required this.id,
    required this.title,
    required this.description,
  });

  factory Note.fromJson(Map<String, dynamic> json) {
    return switch (json) {
      {
        'id': String id,
        'title': String title,
        'description': String? description,
      } =>
        Note(id: id, title: title, description: description),
      _ => throw const FormatException('Failed to load album.'),
    };
  }
}

class NotePage extends StatefulWidget {
  const NotePage({super.key});

  @override
  State<NotePage> createState() => _NotePageState();
}

class _NotePageState extends State<NotePage> {
  late Future futureNote;

  @override
  void initState() {
    super.initState();
    futureNote = fetchNote();
  }

  Future<void> _editNotePage(BuildContext context, Object? arguments) async {
    final result = await Navigator.pushNamed(
      context,
      '/note/edit',
      arguments: arguments,
    );

    if (result == 'OK') {
      setState(() {
        futureNote = fetchNote();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Note Page")),
      body: Center(
        child: FutureBuilder(
          future: futureNote,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              // return Text(snapshot.data.toString());
              return ListView.builder(
                itemCount: snapshot.data.length,
                itemBuilder: (context, index) {
                  final note = Note.fromJson(snapshot.data[index]);
                  return ListTile(
                    title: Text(note.title),
                    subtitle: Text(note.description ?? ''),
                    onTap: () {
                      _editNotePage(context, note);
                    },
                  );
                },
              );
            } else if (snapshot.hasError) {
              return Text('${snapshot.error}');
            }

            // By default, show a loading spinner.
            return const CircularProgressIndicator();
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _editNotePage(context, null);
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}