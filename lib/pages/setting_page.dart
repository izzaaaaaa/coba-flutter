import 'package:flutter/material.dart';

class SettingPage extends StatelessWidget {
  const SettingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Setting Page")),
      body: Center(
        child: ElevatedButton(
          onPressed: () => Navigator.pushNamed(context, "/profile"),
          child: const Text("Profile"),
        ),
      ),
    );
  }
}