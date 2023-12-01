import 'package:flutter/material.dart';
import 'package:grorange/components/page_app_bar.dart';
import 'package:grorange/models/item.dart';
import 'package:grorange/models/enums/item_consumption_level.dart';
import 'package:grorange/pages/add_slot_item_page.dart';

class SlotItemsPage extends StatefulWidget {
  const SlotItemsPage({super.key});

  @override
  State<SlotItemsPage> createState() => _SlotItemsPageState();
}

class _SlotItemsPageState extends State<SlotItemsPage> {
  final TextEditingController _searchItemsController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    List<Item> items = _getItems();

    List<Item> filteredItems = List.empty(growable: true);
    filteredItems.addAll(items);

    return Scaffold(
      appBar: const PageAppBar(
        title: 'Fridge',
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => const AddSlotItemPage(),
            ),
          );
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
                  //TODO: finish this filtering
                  if (newValue.isEmpty) {
                    filteredItems.addAll(items);
                  }
                  _searchItemsController.text = newValue;
                  setState(() {
                    filteredItems.clear();
                    filteredItems.addAll(items
                        .where((el) => el.name
                            .toLowerCase()
                            .contains(newValue.toLowerCase()))
                        .toList());
                  });
                },
                decoration: InputDecoration(
                  hintText: 'Search items...',
                  border: _buildOutlineInputBorder(),
                  focusedBorder: _buildOutlineInputBorder(),
                ),
              ),
            ),
            Expanded(
              child: ListView.separated(
                separatorBuilder: (context, index) => const Divider(),
                itemCount: filteredItems.length,
                itemBuilder: (context, index) {
                  Item current = filteredItems[index];
                  return ListTile(
                    title: Text(current.name),
                    subtitle: Text(current.consumptionLevel.text),
                  );
                },
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

  List<Item> _getItems() {
    List<Item> items = List.empty(growable: true);
    items.add(Item(null, 'Yogurt', 2, 0.83, ItemConsumptionLevel.safe, "", "",
        "", DateTime.now(), null));
    items.add(Item(null, 'Cheese', 2, 0.4, ItemConsumptionLevel.moderate, "",
        "", "", DateTime.now(), null));
    items.add(Item(null, 'Broccoli', 2, 0.1, ItemConsumptionLevel.critical, "",
        "", "", DateTime.now(), null));

    return items;
  }
}
