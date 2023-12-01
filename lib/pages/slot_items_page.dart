import 'package:flutter/material.dart';
import 'package:grorange/components/page_app_bar.dart';
import 'package:grorange/models/SlotItem.dart';
import 'package:grorange/models/item_consumption_level.dart';
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
    List<SlotItem> items = List.empty(growable: true);
    items.add(SlotItem('Yogurt', ItemConsumptionLevel.safe));
    items.add(SlotItem('Cheese', ItemConsumptionLevel.moderate));
    items.add(SlotItem('Broccoli', ItemConsumptionLevel.critical));

    List<SlotItem> filteredItems = List.empty(growable: true);
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
                onChanged: (newValue){
                  //TODO: finish this filtering
                  if(newValue.isEmpty){
                    filteredItems.addAll(items);
                  }
                  _searchItemsController.text = newValue;
                  setState(() {
                    filteredItems.clear();
                    filteredItems.addAll(items
                        .where((el) => el.name.toLowerCase()
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
                  SlotItem current = filteredItems[index];
                  return ListTile(
                    title: Text(current.name),
                    subtitle: Text(current.level.text),
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
}
