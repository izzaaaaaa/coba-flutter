import 'package:flutter/material.dart';
import 'package:cobaflutter/pages/album_page.dart';
import 'package:cobaflutter/pages/home_page.dart';
import 'package:cobaflutter/pages/note_edit_page.dart';
import 'package:cobaflutter/pages/note_page.dart';
import 'package:cobaflutter/pages/profile_page.dart';
import 'package:cobaflutter/pages/setting_page.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

const String supabaseKey =
    'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImJiYnhxaGtuZ3pjcG15eGhiY3hoIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NDUzMjc2NDksImV4cCI6MjA2MDkwMzY0OX0.lcPscwFjXEb8oU6O15jT-TwBlwtIJyVfsbrlGh5F-lU';

Future<void> main() async {
  await Supabase.initialize(
    url: 'https://bbbxqhkngzcpmyxhbcxh.supabase.co',
    anonKey: supabaseKey,
  );

  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      routes: {
        '/': (context) => const HomePage(),
        '/setting': (context) => const SettingPage(),
        '/profile': (context) => const ProfilePage(),
        '/album': (context) => const AlbumPage(),
        '/note': (context) => const NotePage(),
        '/note/edit': (context) => const NoteEditPage(),
      },
      // home: Scaffold(body: Center(child: Text("halo"))),
    );
  }
}