import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:grorange/components/page_app_bar.dart';
import 'package:grorange/controllers/item_controller.dart';
import 'package:grorange/controllers/user_controller.dart';
import 'package:grorange/database/dao/item_dao.dart';
import 'package:grorange/models/enums/item_consumption_level.dart';
import 'package:grorange/models/item.dart';
import 'package:grorange/models/slot.dart';
import 'package:uuid/uuid.dart';

class AddSlotItemPage extends StatefulWidget {
  final Slot slot;

  const AddSlotItemPage({
    required this.slot,
    super.key,
  });

  @override
  State<AddSlotItemPage> createState() => _AddSlotItemPageState();
}

class _AddSlotItemPageState extends State<AddSlotItemPage> {
  final TextEditingController _itemNameController = TextEditingController();
  final TextEditingController _quantityController = TextEditingController();
  final ItemController itemController = Get.find();

  double consumption = .5;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PageAppBar(
        title: 'Add Item',
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              const Padding(
                padding: EdgeInsets.only(left: 5.0, bottom: 10),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Item name',
                    style: TextStyle(fontWeight: FontWeight.w500),
                  ),
                ),
              ),
              TextField(
                controller: _itemNameController,
                textInputAction: TextInputAction.next,
                decoration: InputDecoration(
                    hintText: 'Milk',
                    border: _buildOutlineInputBorder(),
                    focusedBorder: _buildOutlineInputBorder()),
              ),
              const SizedBox(height: 20),
              const Padding(
                padding: EdgeInsets.only(left: 5.0, bottom: 10),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Quantity',
                    style: TextStyle(fontWeight: FontWeight.w500),
                  ),
                ),
              ),
              TextField(
                controller: _quantityController,
                decoration: InputDecoration(
                    hintText: '0',
                    border: _buildOutlineInputBorder(),
                    focusedBorder: _buildOutlineInputBorder()),
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 20),
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Overall percentage consumption',
                  style: TextStyle(fontWeight: FontWeight.w500),
                ),
              ),
              Slider(
                  value: consumption,
                  onChanged: (newVal) {
                    setState(() {
                      consumption = newVal;
                    });
                  }),
              Text(ItemConsumptionLevel.getLevelFromPercentage(consumption).text),
              const SizedBox(height: 50),
              SizedBox(
                width: double.maxFinite,
                child: ElevatedButton(
                  onPressed: () {
                    _save();
                    _itemNameController.text = '';
                    _quantityController.text = '';
                    Navigator.pop(context);
                  },
                  child: const Text('Save'),
                ),
              )
            ],
          ),
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
    var uuid = const Uuid();
    final UserController userController = Get.find();

    final Item item = Item(
      uuid.v4(),
      _itemNameController.text,
      int.parse(_quantityController.text),
      consumption,
      ItemConsumptionLevel.getLevelFromPercentage(consumption),
      widget.slot.id!,
      widget.slot.workspaceId,
      userController.user.id!,
      DateTime.now(),
      null,
    );

    var dao = ItemDAO();
    await dao.save(item);

    final List<Item> items = itemController.items;
    items.add(item);

    itemController.items = items;
  }
}
