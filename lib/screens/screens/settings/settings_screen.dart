import 'package:flutter/material.dart';

class SettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
        backgroundColor: const Color.fromARGB(255, 243, 114, 63),
      ),
      body: Center(
        child: Text('This is the Settings screen'),
      ),
    );
  }
}
