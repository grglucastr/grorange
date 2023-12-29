import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:grorange/components/page_app_bar.dart';
import 'package:grorange/controllers/user_controller.dart';
import 'package:grorange/database/dao/workspace_dao.dart';
import 'package:grorange/models/workspace.dart';
import 'package:uuid/uuid.dart';

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
                  _save();
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

  void _save() async {
    var uuid = const Uuid();
    final UserController userController = Get.find();

    final Workspace workspace = Workspace(
      uuid.v4(),
      _workspaceNameController.text,
      DateTime.now(),
      null,
      userController.user.id,
    );

    var dao = WorkspaceDAO();
    await dao.save(workspace);
  }
}
