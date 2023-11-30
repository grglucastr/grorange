import 'package:flutter/material.dart';
import 'package:grorange/pages/home_page.dart';

void main() {
  runApp(const Grorange());
}

class Grorange extends StatelessWidget {
  const Grorange({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(useMaterial3: true),
      home: const Home(),
    );
  }
}
