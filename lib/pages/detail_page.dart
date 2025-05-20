import 'package:flutter/material.dart';

class DetailPage extends StatelessWidget {
  final int id;

  const DetailPage({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    final argId = ModalRoute.of(context)!.settings.arguments as String;

    return Scaffold(
      appBar: AppBar(title: Text("Detail id: $id")),
      body: Center(child: Text("Detail Page: $argId")),
    );
  }
}