import 'package:flutter/material.dart';

class GridEmpty extends StatelessWidget {
  final String text;

  const GridEmpty({this.text = 'Nothing found...', super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          const Icon(
            Icons.warning,
            size: 56,
            color: Colors.black45,
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            text,
            style: const TextStyle(
              fontSize: 24,
              color: Colors.black45,
            ),
          ),
        ],
      ),
    );
  }
}
