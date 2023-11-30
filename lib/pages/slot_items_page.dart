import 'package:flutter/material.dart';
import 'package:grorange/components/page_app_bar.dart';
import 'package:grorange/models/SlotItem.dart';

class SlotItemsPage extends StatefulWidget {
  const SlotItemsPage({super.key});

  @override
  State<SlotItemsPage> createState() => _SlotItemsPageState();
}

class _SlotItemsPageState extends State<SlotItemsPage> {
  @override
  Widget build(BuildContext context) {
    List<SlotItem> items = List.empty(growable: true);
    items.add(SlotItem('Yogurt', 'Safe'));
    items.add(SlotItem('Cheese', 'Moderate'));
    items.add(SlotItem('Broccoli', 'Critical'));

    return Scaffold(
      appBar: const PageAppBar(
        title: 'Fridge',
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){},
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
                itemCount: items.length,
                itemBuilder: (context, index) {
                  SlotItem current = items[index];
                  return ListTile(
                    title: Text(current.name),
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
