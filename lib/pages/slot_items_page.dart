import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:grorange/services/item_service.dart';
import 'package:grorange/widgets/dialog_delete_confirm.dart';
import 'package:grorange/widgets/dialog_edit_names.dart';
import 'package:grorange/widgets/grid_empty.dart';
import 'package:grorange/widgets/page_app_bar_with_actions.dart';
import 'package:grorange/controllers/app_bar_controller.dart';
import 'package:grorange/controllers/item_controller.dart';
import 'package:grorange/controllers/slot_controller.dart';
import 'package:grorange/controllers/workspace_controller.dart';
import 'package:grorange/database/v2/dao/item_dao.dart';
import 'package:grorange/database/v2/dao/slot_dao.dart';
import 'package:grorange/models/Item.dart';
import 'package:grorange/models/Slot.dart';
import 'package:grorange/pages/add_slot_item_page.dart';
import 'package:grorange/pages/edit_slot_item_page.dart';

class SlotItemsPage extends StatefulWidget {
  const SlotItemsPage({super.key});

  @override
  State<SlotItemsPage> createState() => _SlotItemsPageState();
}

class _SlotItemsPageState extends State<SlotItemsPage> {
  final SlotController slotController = Get.find();
  final WorkspaceController workspaceController = Get.find();
  final ItemController itemController = Get.find();
  final AppBarController appBarController = Get.find();

  Timer? _debounce;

  var dao = ItemDAO();
  var slotDAO = SlotDAO();

  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();
    if (itemController.items.isEmpty) {
      itemController.items = await dao.findAll(slotController.slot) ?? [];
    }
    itemController.filteredItems = itemController.items;
  }

  @override
  void dispose() {
    super.dispose();
    _debounce?.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PageAppBarWithActions(
        actions: [
          IconButton(
            onPressed: () => _showEditDialog(),
            icon: const Icon(Icons.edit),
          ),
          IconButton(
            onPressed: () => _showDeleteDialog(),
            icon: const Icon(Icons.delete),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context)
              .push(MaterialPageRoute(
                builder: (context) =>
                    AddSlotItemPage(slot: slotController.slot),
              ))
              .then((value) => setState(() {}));
        },
        child: const Icon(Icons.add),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 20, left: 10, right: 10),
        child: Column(
          children: [
            const Align(
              alignment: Alignment.center,
              child: Text('Items',
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 32,
                  )),
            ),
            Padding(
              padding: const EdgeInsets.only(
                top: 25,
                bottom: 25,
              ),
              child: TextField(
                onChanged: (newValue) {
                  _onSearchChanged(newValue);
                },
                decoration: InputDecoration(
                  hintText: 'Search items...',
                  border: _buildOutlineInputBorder(),
                  focusedBorder: _buildOutlineInputBorder(),
                ),
              ),
            ),
            GetBuilder<ItemController>(
              builder: (_) {
                return Visibility(
                  visible: _.filteredItems.isNotEmpty,
                  child: Expanded(
                    child: _buildListView(_.filteredItems),
                  ),
                );
              },
            ),
            GetBuilder<ItemController>(
              builder: (_) {
                return Visibility(
                  visible: _.filteredItems.isEmpty,
                  child: const GridEmpty(),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  ListView _buildListView(List<Item> filteredItems) {
    return ListView.separated(
      separatorBuilder: (context, index) => const Divider(),
      itemCount: filteredItems.length,
      itemBuilder: (context, index) {
        Item current = filteredItems[index];
        return _renderDismissibleItem(current);
      },
    );
  }

  Dismissible _renderDismissibleItem(Item item) {
    itemController.item = item;

    return Dismissible(
      key: UniqueKey(),
      confirmDismiss: _handleItemRemovalConfirmation,
      onDismissed: (direction) {
        dao.delete(item);
        itemController.remove(item);
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('${item.name} removed')));
      },
      background: Container(
        color: Colors.red,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _removeText(), //left
              _removeText(), //right
            ],
          ),
        ),
      ),
      child: _renderListTile(item),
    );
  }

  Future<bool?> _handleItemRemovalConfirmation(
      DismissDirection dismissDirection) async {
    switch (dismissDirection) {
      case DismissDirection.endToStart:
      case DismissDirection.startToEnd:
        return await _showDeleteItemDialog();
      case DismissDirection.vertical:
      case DismissDirection.horizontal:
      case DismissDirection.up:
      case DismissDirection.down:
      case DismissDirection.none:
        return false;
    }
  }

  ListTile _renderListTile(Item item) {
    return ListTile(
      title: Text(item.name),
      subtitle: Text(ItemService.itemConsumptionLevelString(item.consumptionLevel)),
      onTap: () {
        appBarController.titleText = 'Edit ${item.name}';
        itemController.item = item;
        var page =
            MaterialPageRoute(builder: (context) => const EditSlotItemPage());

        Navigator.push(context, page).then((value) {
          appBarController.titleText = slotController.slot.name!;
          _handleFeedbackFromEditPage(value);
        });
      },
    );
  }

  void _handleFeedbackFromEditPage(value) {
    if (value != null) {
      final Map<String, dynamic> feedback = value;
      if (feedback['action'] == 'update' && feedback['successfully']) {
        _showUpdatedSnackbar();
      }
      if (feedback['action'] == 'delete' && feedback['successfully']) {
        _showDeleteSnackbar(feedback['item_name']);
      }
    }
  }

  void _showUpdatedSnackbar() {
    final String item = itemController.item.name;
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text('$item updated')));
  }

  void _showDeleteSnackbar(String itemName) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text('$itemName removed')));
  }

  OutlineInputBorder _buildOutlineInputBorder() {
    return OutlineInputBorder(
      borderSide: const BorderSide(width: 1, color: Colors.grey),
      borderRadius: BorderRadius.circular(10),
    );
  }

  Text _removeText() {
    return const Text(
      'Remove',
      style: TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  void _showDeleteDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return DialogDeleteConfirm(
          title: 'Delete Slot',
          description:
              'Delete slot: ${slotController.slot.name}\n\nWARNING:\nAll items related to this slot will be lost. Are you sure you want to proceed?',
          onConfirm: () => _confirmDelete(context),
        );
      },
    );
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

  void _showEditDialog() {
    final TextEditingController titleController = TextEditingController();
    titleController.text = slotController.slot.name!;

    showDialog(
      context: context,
      builder: (context) {
        return DialogEditNames(
          title: 'New slot name',
          controller: titleController,
          onConfirm: () {
            final Slot newSlot = _prepareSlotToUpdate(titleController.text);
            slotDAO.update(newSlot).then((_) {
              slotController.slot = newSlot;
              appBarController.titleText = titleController.text;
              Navigator.pop(context);
            });
          },
        );
      },
    );
  }

  void _onSearchChanged(String query) {
    if (_debounce?.isActive ?? false) _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () {
      if (query.isEmpty) {
        itemController.filteredItems = itemController.items;
        return;
      }
      itemController.filteredItems = itemController.items
          .where((it) => it.name.toLowerCase().contains(query.toLowerCase()))
          .toList(growable: true);
    });
  }

  void _confirmDelete(BuildContext context) {
    final String slotName = slotController.slot.name!;
    slotDAO.delete(slotController.slot);
    slotController.delete(slotController.slot);

    appBarController.titleText = workspaceController.workspace.name!;

    Navigator.pop(context); // dismiss dialog

    final Map<String, dynamic> feedback = {
      'action': 'delete',
      'successfully': true,
      'slot_name': slotName,
    };
    Navigator.pop(context, feedback); // return to previous page
  }

  Slot _prepareSlotToUpdate(String newSlotName) {
    final Slot old = slotController.slot;
    return Slot(
      name: newSlotName,
      updated_at: DateTime.now().toString(),
      inserted_at: old.inserted_at,
      active: old.active,
      id: old.id,
      user: old.user,
      workspace: old.workspace,
      items: old.items,
    );
  }
}
