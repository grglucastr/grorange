import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:grorange/components/dialog_delete_confirm.dart';
import 'package:grorange/components/dialog_edit_names.dart';
import 'package:grorange/components/grid_button.dart';
import 'package:grorange/components/grid_empty.dart';
import 'package:grorange/components/grid_options.dart';
import 'package:grorange/components/page_app_bar_with_actions.dart';
import 'package:grorange/components/page_title.dart';
import 'package:grorange/controllers/app_bar_controller.dart';
import 'package:grorange/controllers/item_controller.dart';
import 'package:grorange/controllers/slot_controller.dart';
import 'package:grorange/controllers/user_controller.dart';
import 'package:grorange/controllers/workspace_controller.dart';
import 'package:grorange/database/dao/slot_dao.dart';
import 'package:grorange/database/dao/workspace_dao.dart';
import 'package:grorange/models/slot.dart';
import 'package:grorange/models/workspace.dart';
import 'package:grorange/pages/add_slot_page.dart';
import 'package:grorange/pages/home_page.dart';
import 'package:grorange/pages/slot_items_page.dart';

class SlotsPage extends StatefulWidget {
  const SlotsPage({super.key});

  @override
  State<SlotsPage> createState() => _SlotsPageState();
}

class _SlotsPageState extends State<SlotsPage> {
  final SlotDAO dao = SlotDAO();
  final WorkspaceDAO workspaceDAO = WorkspaceDAO();
  final WorkspaceController workspaceController = Get.find();
  final SlotController slotController = Get.find();
  final AppBarController appBarController = Get.find();
  final ItemController itemController = Get.find();
  final UserController userController = Get.find();

  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();
    slotController.slots = await dao.findAll(workspaceController.workspace.id!);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PageAppBarWithActions(actions: [
        IconButton(
          onPressed: () => _showEditDialog(),
          icon: const Icon(Icons.edit),
        ),
        IconButton(
          onPressed: () => _showDeleteDialog(),
          icon: const Icon(Icons.delete),
        ),
      ]),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _redirectToAddSlotsPage(),
        child: const Icon(Icons.add),
      ),
      body: Column(
        children: [
          const SizedBox(height: 40),
          const PageTitle(title: 'Slots'),
          const SizedBox(height: 60),
          GetBuilder<SlotController>(builder: (_) => _renderGrid(_.slots)),
        ],
      ),
    );
  }

  void _showDeleteDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return DialogDeleteConfirm(
          title: 'Delete Workspace',
          description:
              'Delete workspace: ${workspaceController.workspace.name}\n\nWARNING:\nAll slots and items related this workspace will be lost. Are you sure you want to proceed?',
          onConfirm: () => _performDelete(),
        );
      },
    );
  }

  Widget _renderGrid(List<Slot> slots) {
    if (slots.isEmpty) {
      return const GridEmpty(text: 'No slots found...');
    }

    final List<GridButton> buttons = List.empty(growable: true);
    for (var slot in slots) {
      buttons.add(GridButton(
        text: slot.name!,
        onTap: () {
          itemController.clear();
          slotController.slot = slot;
          appBarController.titleText = slot.name!;
          var page = MaterialPageRoute(builder: (ctx) => const SlotItemsPage());
          Navigator.of(context).push(page).then((value) {
            appBarController.titleText = workspaceController.workspace.name!;
          });
        },
      ));
    }

    return GridOptions(buttons: buttons);
  }

  void _performDelete() async {
    await workspaceDAO.delete(workspaceController.workspace);
    if (context.mounted) {
      appBarController.titleText = "Welcome, ${userController.firstName}";
      var page = MaterialPageRoute(builder: (ctx) => const Home());
      Navigator.pushAndRemoveUntil(context, page, (route) => false);
    }
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
                appBarController.titleText = titleController.text;
              }
              Navigator.pop(context);
            });
          },
        );
      },
    );
  }

  void _redirectToAddSlotsPage() {
    var page = MaterialPageRoute(builder: (ctx) => const AddSlotPage());
    Navigator.of(context).push(page);
  }
}
