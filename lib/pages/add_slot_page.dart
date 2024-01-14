import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:grorange/widgets/page_app_bar.dart';
import 'package:grorange/controllers/slot_controller.dart';
import 'package:grorange/controllers/user_controller.dart';
import 'package:grorange/controllers/workspace_controller.dart';
import 'package:grorange/database/v2/dao/slot_dao.dart';
import 'package:grorange/models/Slot.dart';
import 'package:grorange/models/Workspace.dart';
import 'package:uuid/uuid.dart';

class AddSlotPage extends StatefulWidget {
  const AddSlotPage({super.key});

  @override
  State<AddSlotPage> createState() => _AddSlotPageState();
}

class _AddSlotPageState extends State<AddSlotPage> {
  final TextEditingController _slotNameController = TextEditingController();
  final WorkspaceController workspaceController = Get.find();
  final SlotController slotController = Get.find();
  final UserController userController = Get.find();

  late Workspace workspace;

  @override
  void initState() {
    super.initState();
    workspace = workspaceController.workspace;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PageAppBar(
        title: 'Add Slot',
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 32.0, right: 16, left: 16),
        child: Column(
          children: [
            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Slot name',
                style: TextStyle(fontWeight: FontWeight.w500),
              ),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: _slotNameController,
              autofocus: true,
              decoration: InputDecoration(
                hintText: 'Fridge',
                border: _buildOutlineInputBorder(),
                focusedBorder: _buildOutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 32),
            SizedBox(
              width: double.maxFinite,
              child: ElevatedButton(
                onPressed: () {
                  _save();
                  _slotNameController.text = '';
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

  OutlineInputBorder _buildOutlineInputBorder() {
    return OutlineInputBorder(
      borderSide: const BorderSide(width: 1, color: Colors.grey),
      borderRadius: BorderRadius.circular(10),
    );
  }

  void _save() async {
    var dao = SlotDAO();
    var uuid = const Uuid();

    final Slot newSlot = Slot(
      id: uuid.v1(),
      name: _slotNameController.text,
      user: userController.user,
      workspace: workspace,
      active: true,
      inserted_at: DateTime.now().toString(),
      updated_at: null,
    );

    await dao.save(newSlot);
    slotController.add(newSlot);
  }
}
