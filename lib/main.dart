import 'package:flutter/material.dart';

import 'homepage.dart';

void main() {
  runApp(const PotatoDiseaseApp());
}

class PotatoDiseaseApp extends StatelessWidget {
  const PotatoDiseaseApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,

      title: 'Potato Disease Detection',

      theme: ThemeData(
        primarySwatch: Colors.green,
      ),

      home: const HomePage(),
    );
  }
}