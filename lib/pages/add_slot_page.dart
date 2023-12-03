import 'package:flutter/material.dart';
import 'package:grorange/components/page_app_bar.dart';
import 'package:grorange/database/dao/slot_dao.dart';
import 'package:grorange/models/slot.dart';
import 'package:uuid/uuid.dart';

class AddSlotPage extends StatefulWidget {
  const AddSlotPage({super.key});

  @override
  State<AddSlotPage> createState() => _AddSlotPageState();
}

class _AddSlotPageState extends State<AddSlotPage> {
  final TextEditingController _slotNameController = TextEditingController();

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

    final Slot slot = Slot(
      uuid.v4(),
      _slotNameController.text,
      uuid.v4(),
      uuid.v4(),
      DateTime.now(),
      null,
    );

    await dao.save(slot);
  }
}
