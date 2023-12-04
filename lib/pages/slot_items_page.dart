import 'package:flutter/material.dart';
import 'package:grorange/components/grid_empty.dart';
import 'package:grorange/components/page_app_bar.dart';
import 'package:grorange/database/dao/item_dao.dart';
import 'package:grorange/models/item.dart';
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
    var dao = ItemDAO();

    return Scaffold(
      appBar: const PageAppBar(
        title: 'Fridge',
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context)
              .push(MaterialPageRoute(
                builder: (context) => const AddSlotItemPage(),
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
                future: dao.findAll(),
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
        return ListTile(
          title: Text(current.name),
          subtitle: Text(current.consumptionLevel.text),
        );
      },
    );
  }

  OutlineInputBorder _buildOutlineInputBorder() {
    return OutlineInputBorder(
      borderSide: const BorderSide(width: 1, color: Colors.grey),
      borderRadius: BorderRadius.circular(10),
    );
  }
}
