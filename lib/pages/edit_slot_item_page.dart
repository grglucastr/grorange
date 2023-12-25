import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:grorange/components/dialog_delete_confirm.dart';
import 'package:grorange/components/page_app_bar_with_actions.dart';
import 'package:grorange/controllers/item_controller.dart';
import 'package:grorange/controllers/slot_controller.dart';
import 'package:grorange/database/dao/item_dao.dart';
import 'package:grorange/models/enums/item_consumption_level.dart';
import 'package:grorange/models/item.dart';
import 'package:grorange/models/slot.dart';

class EditSlotItemPage extends StatefulWidget {
  const EditSlotItemPage({super.key});

  @override
  State<EditSlotItemPage> createState() => _EditSlotItemPageState();
}

class _EditSlotItemPageState extends State<EditSlotItemPage> {
  final TextEditingController _itemNameController = TextEditingController();
  final TextEditingController _quantityController = TextEditingController();
  final SlotController slotController = Get.find();
  final ItemController itemController = Get.find();
  double consumption = .5;

  @override
  void initState() {
    super.initState();
    _itemNameController.text = itemController.item.name;
    _quantityController.text = itemController.item.quantity.toString();
    consumption = itemController.item.usagePercentage;
  }

  @override
  Widget build(BuildContext context) {
    var dao = ItemDAO();

    return Scaffold(
      appBar: PageAppBarWithActions(
        actions: [
          IconButton(
            onPressed: () async {
              bool? proceedDelete = await _showDeleteItemDialog();
              if(proceedDelete!){
                final int deleted = await dao.delete(itemController.item.id!);
                if(deleted == 1){
                  if(context.mounted){
                    itemController.item = null;
                    Navigator.pop(context);
                  }
                }
              }
            },
            icon: const Icon(Icons.delete),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
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
    final Slot slot = slotController.slot;
    final Item item = itemController.item;

    final Item itemToUpdate = Item(
      item.id,
      _itemNameController.text,
      int.parse(_quantityController.text),
      consumption,
      _getLevel(consumption),
      slot.id!,
      slot.workspaceId,
      item.userId,
      slot.insertDateTime,
      DateTime.now(),
    );

    var dao = ItemDAO();
    await dao.update(itemToUpdate);
  }

  ItemConsumptionLevel _getLevel(double consumption) {
    if (consumption >= .7) {
      return ItemConsumptionLevel.safe;
    }

    if (consumption >= .4) {
      return ItemConsumptionLevel.moderate;
    }

    if (consumption >= .39) {
      return ItemConsumptionLevel.severe;
    }

    return ItemConsumptionLevel.critical;
  }

  Future<bool?> _showDeleteItemDialog() {
    final ItemController itemController = Get.find();
    return showDialog<bool>(
      context: context,
      builder: (context) {
        return DialogDeleteConfirm(
          onConfirm: () {
            Navigator.pop(context, true);
          },
          title: 'Delete Item',
          description: 'Are you sure you want to remove this item ${itemController.item.name} from this slot?',
        );
      },
    );
  }
}
