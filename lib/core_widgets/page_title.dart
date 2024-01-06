import 'package:flutter/material.dart';

class PageTitle extends StatelessWidget {

  final String title;

  const PageTitle({ required this.title, super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.maxFinite,
      child: Text(
        title,
        style: const TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: 32,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }
}
