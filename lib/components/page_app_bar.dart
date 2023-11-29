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
      backgroundColor: Colors.blue,
      foregroundColor: Colors.white,
    );
  }
}
