import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:grorange/components/dialog_delete_confirm.dart';
import 'package:grorange/components/dialog_edit_names.dart';
import 'package:grorange/components/grid_button.dart';
import 'package:grorange/components/grid_empty.dart';
import 'package:grorange/components/grid_options.dart';
import 'package:grorange/components/loading.dart';
import 'package:grorange/components/page_app_bar_with_actions.dart';
import 'package:grorange/components/page_title.dart';
import 'package:grorange/controllers/app_bar_controller.dart';
import 'package:grorange/controllers/item_controller.dart';
import 'package:grorange/controllers/slot_controller.dart';
import 'package:grorange/controllers/workspace_controller.dart';
import 'package:grorange/database/dao/slot_dao.dart';
import 'package:grorange/database/dao/workspace_dao.dart';
import 'package:grorange/models/slot.dart';
import 'package:grorange/models/workspace.dart';
import 'package:grorange/pages/slot_items_page.dart';
import 'package:grorange/pages/workspaces_page.dart';

import 'add_slot_page.dart';

class SlotsPage extends StatefulWidget {
  const SlotsPage({super.key});

  @override
  State<SlotsPage> createState() => _SlotsPageState();
}

class _SlotsPageState extends State<SlotsPage> {
  var workspaceDAO = WorkspaceDAO();
  final WorkspaceController workspaceController = Get.find();
  final SlotController slotController = Get.find();
  final AppBarController appBarController = Get.find();
  final ItemController itemController = Get.find();

  @override
  Widget build(BuildContext context) {
    var dao = SlotDAO();
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
                    AddSlotPage(workspace: workspaceController.workspace),
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
            future: dao.findAll(workspaceController.workspace.id!),
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
        text: slot.name!,
        onTap: () {
          itemController.clear();
          slotController.slot = slot;
          appBarController.title.value = slot.name!;
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => const SlotItemsPage(),
            ),
          ).then((value) {
            appBarController.title.value = workspaceController.workspace.name!;
            setState(() {});
          });
        },
      ));
    }
    return GridOptions(buttons: buttons);
  }

  void _showDeleteDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return DialogDeleteConfirm(
          title: 'Delete Workspace',
          description:
              'Delete workspace: ${workspaceController.workspace.name}\n\nWARNING:\nAll slots and items related this workspace will be lost. Are you sure you want to proceed?',
          onConfirm: () {
            workspaceDAO.delete(workspaceController.workspace.id!);
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => const WorkspacesPage()),
              (route) => true,
            );
          },
        );
      },
    );
  }

  void _showEditDialog() {
    final TextEditingController titleController = TextEditingController();
    titleController.text = workspaceController.workspace.name!;

    showDialog(
      context: context,
      builder: (context) {
        return DialogEditNames(
          title: 'New workspace name',
          controller: titleController,
          onConfirm: () {
            workspaceDAO
                .updateName(
                    workspaceController.workspace.id!, titleController.text)
                .then((value) {
              if (value == 1) {
                Workspace wk = workspaceController.workspace;
                wk.name = titleController.text;
                workspaceController.workspace = wk;
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
