import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:grorange/services/item_service.dart';
import 'package:grorange/widgets/dialog_delete_confirm.dart';
import 'package:grorange/widgets/page_app_bar_with_actions.dart';
import 'package:grorange/controllers/item_controller.dart';
import 'package:grorange/controllers/slot_controller.dart';
import 'package:grorange/database/v2/dao/item_dao.dart';
import 'package:grorange/models/enums/item_consumption_level.dart';
import 'package:grorange/models/Item.dart';

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
  double? consumption = .5;

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
              if (proceedDelete!) {
                final Item item = itemController.item;
                await dao.delete(item);
                if (context.mounted) {
                  final Map<String, dynamic> feedback = {
                    'action': 'delete',
                    'successfully': true,
                    'item_name': item.name,
                  };
                  itemController.remove(item);
                  Navigator.pop(context, feedback);
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
                  value: consumption ?? 0,
                  onChanged: (newVal) {
                    setState(() {
                      consumption = newVal;
                    });
                  }),
              Text(ItemConsumptionLevel.getLevelFromPercentage(consumption ?? 0)
                  .text),
              const SizedBox(height: 50),
              SizedBox(
                width: double.maxFinite,
                child: ElevatedButton(
                  onPressed: () {
                    _save();
                    _itemNameController.text = '';
                    _quantityController.text = '';
                    Navigator.pop(
                        context, {'action': 'update', 'successfully': true});
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
    final Item item = itemController.item;

    final Item itemToUpdate = Item(
      id: item.id,
      name: _itemNameController.text,
      quantity: int.parse(_quantityController.text),
      usagePercentage: consumption,
      consumptionLevel: ItemService.getLevelFromPercentage(consumption ?? 0),
      active: true,
      inserted_at: item.inserted_at,
      updated_at: DateTime.now().toString(),
      user: item.user,
      slot: item.slot
    );

    var dao = ItemDAO();
    await dao.update(itemToUpdate);
    itemController.updateItem(itemToUpdate);
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
          description:
              'Are you sure you want to remove this item ${itemController.item.name} from this slot?',
        );
      },
    );
  }
}
