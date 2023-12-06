import 'package:flutter/material.dart';
import 'package:grorange/components/grid_button.dart';
import 'package:grorange/components/grid_empty.dart';
import 'package:grorange/components/grid_options.dart';
import 'package:grorange/components/loading.dart';
import 'package:grorange/components/page_app_bar_with_actions.dart';
import 'package:grorange/components/page_title.dart';
import 'package:grorange/database/dao/slot_dao.dart';
import 'package:grorange/database/dao/workspace_dao.dart';
import 'package:grorange/models/slot.dart';
import 'package:grorange/models/workspace.dart';
import 'package:grorange/pages/add_slot_page.dart';
import 'package:grorange/pages/slot_items_page.dart';

class SlotsPage extends StatefulWidget {
  final Workspace workspace;

  const SlotsPage({required this.workspace, super.key});

  @override
  State<SlotsPage> createState() => _SlotsPageState();
}

class _SlotsPageState extends State<SlotsPage> {
  var workspaceDAO = WorkspaceDAO();

  @override
  Widget build(BuildContext context) {
    var dao = SlotDAO();
    return Scaffold(
      appBar: PageAppBarWithActions(title: widget.workspace.name!, actions: [
        IconButton(
          onPressed: () {
            workspaceDAO.delete(widget.workspace.id!);
            Navigator.pop(context);
          },
          icon: const Icon(Icons.delete),
        )
      ]),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context)
              .push(MaterialPageRoute(
                builder: (context) => const AddSlotPage(),
              ))
              .then((value) => setState(() {}));
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
          FutureBuilder<List<Slot>>(
            future: dao.findAll(),
            builder: (context, snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.none:
                  break;
                case ConnectionState.waiting:
                  return const Loading();
                case ConnectionState.active:
                  break;
                case ConnectionState.done:
                  return _handleFutureBuilderDone(context, snapshot);
              }
              return const Text('data error');
            },
          ),
        ],
      ),
    );
  }

  Widget _handleFutureBuilderDone(
      BuildContext context, AsyncSnapshot<List<Slot>> snapshot) {
    if (snapshot.hasData) {
      List<Slot> slots = snapshot.data!;
      return slots.isNotEmpty
          ? _fillGrid(slots)
          : const GridEmpty(text: 'No slots found...');
    }
    return const Center(
      child: Text('Still loading...'),
    );
  }

  Widget _fillGrid(List<Slot> slots) {
    List<GridButton> buttons = List.empty(growable: true);

    for (var slot in slots) {
      buttons.add(GridButton(
        text: slot.name,
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => const SlotItemsPage(),
            ),
          );
        },
      ));
    }
    return GridOptions(buttons: buttons);
  }
}
