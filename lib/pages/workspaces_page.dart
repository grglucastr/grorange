import 'package:flutter/material.dart';

class WorkspacesPage extends StatelessWidget {
  const WorkspacesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Welcome, user!'),
      ),
      body: Column(
        children: [
          Text('Workspaces', style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 32,
          ),)
        ],
      ),
    );
  }
}
