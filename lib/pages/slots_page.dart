import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:grorange/controllers/app_bar_controller.dart';
import 'package:grorange/controllers/item_controller.dart';
import 'package:grorange/controllers/slot_controller.dart';
import 'package:grorange/controllers/user_controller.dart';
import 'package:grorange/controllers/workspace_controller.dart';
import 'package:grorange/core_widgets/grid_button.dart';
import 'package:grorange/core_widgets/page_title.dart';
import 'package:grorange/database/v2/dao/slot_dao.dart';
import 'package:grorange/database/v2/dao/workspace_dao.dart';
import 'package:grorange/models/Workspace.dart';
import 'package:grorange/models/Slot.dart';
import 'package:grorange/pages/add_slot_page.dart';
import 'package:grorange/pages/slot_items_page.dart';
import 'package:grorange/widgets/dialog_delete_confirm.dart';
import 'package:grorange/widgets/dialog_edit_names.dart';
import 'package:grorange/widgets/grid_empty.dart';
import 'package:grorange/widgets/grid_options.dart';
import 'package:grorange/widgets/page_app_bar_with_actions.dart';

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
    await _loadSlots();
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
        text: slot.name,
        onTap: () => _handleSlotSelect(slot),
      ));
    }

    return GridOptions(buttons: buttons);
  }

  void _handleSlotSelect(Slot slot) {
    itemController.clear();
    slotController.slot = slot;
    appBarController.titleText = slot.name!;

    var page = MaterialPageRoute(builder: (ctx) => const SlotItemsPage());
    Navigator.of(context).push(page).then((value) {
      appBarController.titleText = workspaceController.workspace.name;
      _loadSlots();
      _handleSnackBarFeedback(value);
    });
  }

  void _handleSnackBarFeedback(value) {
    if (value != null) {
      final Map<String, dynamic> feedback = value;
      if (feedback['action'] == 'delete') {
        final String slotName = feedback['slot_name'];
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Slot $slotName was deleted')));
      }
    }
  }

  void _performDelete() async {
    final String workspaceName = workspaceController.workspace.name;
    await workspaceDAO.delete(workspaceController.workspace);
    workspaceController.delete(workspaceController.workspace);
    if (context.mounted) {
      appBarController.titleText = "Welcome, ${userController.firstName}";

      final Map<String, dynamic> feedback = {
        'action': 'delete',
        'successfully': true,
        'workspace_name': workspaceName,
      };

      Navigator.pop(context); //dismiss dialog
      Navigator.pop(context, feedback); // return to workspaces page
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
          onConfirm: () => _confirmUpdate(titleController, context),
        );
      },
    );
  }

  void _confirmUpdate(
      TextEditingController titleController, BuildContext context) {

    final Workspace newWk = _prepareWorkspaceUpdate(titleController.text);
    workspaceDAO.update(newWk).then((_) {
      workspaceController.workspace = newWk;
      appBarController.titleText = titleController.text;
      Navigator.pop(context);
    });
  }

  Future<void> _loadSlots() async {
    slotController.slots = [];
    final List<Slot>? slots = await dao.findAll(workspaceController.workspace);
    slotController.slots = slots ?? [];
  }

  void _redirectToAddSlotsPage() {
    var page = MaterialPageRoute(builder: (ctx) => const AddSlotPage());
    Navigator.of(context).push(page);
  }

  Workspace _prepareWorkspaceUpdate(String newTitle){
    final Workspace old = workspaceController.workspace;
    final Workspace newWk = Workspace(
      name: newTitle,
      updated_at: DateTime.now().toString(),
      inserted_at: old.inserted_at,
      active: old.active,
      slots: old.slots,
      id: old.id,
      user: old.user,
    );

    return newWk;
  }
}
