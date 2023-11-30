import 'package:flutter/material.dart';
import 'package:grorange/components/grid_options.dart';
import 'package:grorange/components/page_app_bar.dart';
import 'package:grorange/components/page_title.dart';
import 'package:grorange/components/grid_button.dart';
import 'package:grorange/pages/add_slot_page.dart';
import 'package:grorange/pages/slot_items_page.dart';

class SlotsPage extends StatefulWidget {
  const SlotsPage({super.key});

  @override
  State<SlotsPage> createState() => _SlotsPageState();
}

class _SlotsPageState extends State<SlotsPage> {
  @override
  Widget build(BuildContext context) {
    // TODO: Load info from database
    List<Widget> buttons = List.empty(growable: true);
    buttons.add(
      GridButton(
        text: 'Fridge',
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => const SlotItemsPage()),
          );
        },
      ),
    );

    return Scaffold(
      appBar: const PageAppBar(title: 'Home'),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => const AddSlotPage(),
          ));
        },
        child: const Icon(Icons.add),
      ),
      body: Column(
        children: [
          const SizedBox(
            height: 40,
          ),
          const PageTitle(title: 'Slots'),
          const SizedBox(
            height: 60,
          ),
          GridOptions(buttons: buttons),
        ],
      ),
    );
  }
}
