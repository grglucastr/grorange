import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:grorange/components/dialog_delete_confirm.dart';
import 'package:grorange/components/page_app_bar_with_actions.dart';
import 'package:grorange/components/page_title.dart';
import 'package:grorange/controllers/app_bar_controller.dart';
import 'package:grorange/controllers/item_controller.dart';
import 'package:grorange/controllers/slot_controller.dart';
import 'package:grorange/controllers/user_controller.dart';
import 'package:grorange/controllers/workspace_controller.dart';
import 'package:grorange/database/dao/slot_dao.dart';
import 'package:grorange/database/dao/workspace_dao.dart';
import 'package:grorange/pages/home_page.dart';

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
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PageAppBarWithActions(
        actions: [
          IconButton(
            onPressed: () => {},
            icon: const Icon(Icons.edit),
          ),
          IconButton(
            onPressed: () => _showDeleteDialog(),
            icon: const Icon(Icons.delete),
          ),
        ]
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.add),
      ),
      body: const Column(
        children: [
          SizedBox(height: 40),
          PageTitle(title: 'Slots'),
          SizedBox(height: 60),
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

  void _performDelete() async {
    await workspaceDAO.delete(workspaceController.workspace.id!);
    if(context.mounted) {
      appBarController.titleText = "Welcome, ${userController.firstName}";
      var page = MaterialPageRoute(builder: (ctx) => const Home());
      Navigator.pushAndRemoveUntil(context, page, (route) => false);
    }
  }
}
