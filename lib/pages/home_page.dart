import 'package:flutter/material.dart';
import 'package:cobaflutter/pages/detail_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home Page"),
        actions: [
          IconButton(
            onPressed: () => Navigator.pushNamed(context, '/setting'),
            icon: const Icon(Icons.settings),
          ),
        ],
      ),
      body: Center(
        child: Column(
          children: [
            ElevatedButton(
              onPressed:
                  () => Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const DetailPage(id: 123),
                      settings: const RouteSettings(arguments: "buku"),
                    ),
                  ),
              child: const Text("Detail"),
            ),
            const Text("Hom Page"),
            ElevatedButton(
              onPressed: () => Navigator.pushNamed(context, "/album"),
              child: const Text("Album"),
            ),
            ElevatedButton(
              onPressed: () => Navigator.pushNamed(context, "/note"),
              child: const Text("Note Page"),
            ),
          ],
        ),
      ),
    );
  }
}