import 'package:flutter/material.dart';

class PageAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;

  const PageAppBar({required this.title, super.key});

  @override
  Size get preferredSize {
    return const Size(double.maxFinite, 90);
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(title),
      backgroundColor: const Color.fromARGB(255, 255, 152, 0),
      foregroundColor: Colors.white,
    );
  }
}
