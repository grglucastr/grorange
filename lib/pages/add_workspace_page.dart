import 'package:flutter/material.dart';
import 'package:grorange/components/page_app_bar.dart';

class AddWorkspacePage extends StatefulWidget {
  const AddWorkspacePage({super.key});

  @override
  State<AddWorkspacePage> createState() => _AddWorkspacePageState();
}

class _AddWorkspacePageState extends State<AddWorkspacePage> {
  final TextEditingController _workspaceNameController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PageAppBar(
        title: 'Add Workspace',
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 32.0, right: 16, left: 16),
        child: Column(
          children: [
            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Workspace name',
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: _workspaceNameController,
              autofocus: true,
              decoration: InputDecoration(
                hintText: 'Home',
                focusedBorder: buildOutlineInputBorder(),
                border: buildOutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 32),
            SizedBox(
              width: double.maxFinite,
              child: ElevatedButton(
                onPressed: () {
                  debugPrint(
                      'Workspace name: ${_workspaceNameController.text}');
                  _workspaceNameController.text = '';
                  Navigator.pop(context);
                },
                child: const Text('Save'),
              ),
            )
          ],
        ),
      ),
    );
  }

  OutlineInputBorder buildOutlineInputBorder() {
    return OutlineInputBorder(
      borderSide: const BorderSide(width: 1, color: Colors.grey),
      borderRadius: BorderRadius.circular(10),
    );
  }
}
