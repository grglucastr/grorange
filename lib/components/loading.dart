import 'package:flutter/material.dart';

class Loading extends StatelessWidget {
  const Loading({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: const [
          CircularProgressIndicator(),
          SizedBox(height: 30),
          Text('Loading...'),
        ],
      ),
    );
  }
}
