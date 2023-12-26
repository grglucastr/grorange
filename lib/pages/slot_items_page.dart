import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:grorange/components/dialog_delete_confirm.dart';
import 'package:grorange/components/dialog_edit_names.dart';
import 'package:grorange/components/grid_empty.dart';
import 'package:grorange/components/page_app_bar_with_actions.dart';
import 'package:grorange/controllers/app_bar_controller.dart';
import 'package:grorange/controllers/item_controller.dart';
import 'package:grorange/controllers/slot_controller.dart';
import 'package:grorange/controllers/workspace_controller.dart';
import 'package:grorange/database/dao/item_dao.dart';
import 'package:grorange/database/dao/slot_dao.dart';
import 'package:grorange/models/item.dart';
import 'package:grorange/models/slot.dart';
import 'package:grorange/pages/add_slot_item_page.dart';
import 'package:grorange/pages/edit_slot_item_page.dart';
import 'package:grorange/pages/slots_page.dart';

class SlotItemsPage extends StatefulWidget {
  const SlotItemsPage({super.key});

  @override
  State<SlotItemsPage> createState() => _SlotItemsPageState();
}

class _SlotItemsPageState extends State<SlotItemsPage> {
  final TextEditingController _searchItemsController = TextEditingController();
  final SlotController slotController = Get.find();
  final WorkspaceController workspaceController = Get.find();
  final ItemController itemController = Get.find();
  final AppBarController appBarController = Get.find();

  var dao = ItemDAO();
  var slotDAO = SlotDAO();

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
                controller: _searchItemsController,
                onChanged: (newValue) {},
                decoration: InputDecoration(
                  hintText: 'Search items...',
                  border: _buildOutlineInputBorder(),
                  focusedBorder: _buildOutlineInputBorder(),
                ),
              ),
            ),
            Expanded(
              child: FutureBuilder<List<Item>>(
                future: dao.findAll(slotController.slot.id!),
                builder: (context, snapshot) {
                  if (snapshot.hasData && snapshot.data!.isNotEmpty) {
                    final List<Item> content = snapshot.data!;
                    return _buildListView(content);
                  }
                  return const GridEmpty();
                },
              ),
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
      onDismissed: (direction){
        dao.delete(item.id!);
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('${item.name} removed')));
        setState(() { });
      },
      background: Container(
        color: Colors.red,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _removeText(),
              _removeText(),
            ],
          ),
        ),
      ),
      child: _renderListTile(item),
    );
  }

  Future<bool?> _handleItemRemovalConfirmation(DismissDirection dismissDirection) async {
      switch(dismissDirection){
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
      subtitle: Text(item.consumptionLevel.text),
      onTap: (){
        appBarController.title.value = 'Edit ${item.name}';
        itemController.item = item;

        Navigator
            .push(context, MaterialPageRoute(builder: (context) => const EditSlotItemPage()))
            .then((value){
              appBarController.title.value = slotController.slot.name!;
              setState(() {});
            });
      },
    );
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
          onConfirm: () {
            slotDAO.delete(slotController.slot.id!);

            // TODO: fix this
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                  builder: (context) => const SlotsPage(),
                ),
                (route) => true);
          },
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
          description: 'Are you sure you want to remove this item ${itemController.item.name} from this slot?',
        );
      },
    );
  }

  void _showEditDialog() {
    final TextEditingController titleController = TextEditingController();

    debugPrint('value in controller: ${slotController.slot.toString()}');
    titleController.text = slotController.slot.name!;

    showDialog(
      context: context,
      builder: (context) {
        return DialogEditNames(
          title: 'New workspace name',
          controller: titleController,
          onConfirm: () {
            slotDAO
                .updateName(
                slotController.slot.id!, titleController.text)
                .then((value) {
              if (value == 1) {
                Slot slot = slotController.slot;
                slot.name = titleController.text;
                slotController.slot = slot;
                appBarController.title.value = titleController.text;
              }
              Navigator.pop(context);
            });
          },
        );
      },
    );
  }
  
}
