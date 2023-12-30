import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:grorange/components/grid_button.dart';
import 'package:grorange/components/grid_empty.dart';
import 'package:grorange/components/grid_options.dart';
import 'package:grorange/components/page_app_bar_with_actions.dart';
import 'package:grorange/components/page_title.dart';
import 'package:grorange/controllers/app_bar_controller.dart';
import 'package:grorange/controllers/user_controller.dart';
import 'package:grorange/controllers/workspace_controller.dart';
import 'package:grorange/database/dao/workspace_dao.dart';
import 'package:grorange/models/workspace.dart';
import 'package:grorange/pages/add_workspace_page.dart';
import 'package:grorange/pages/slots_page.dart';

class WorkspacesPage extends StatefulWidget {
  const WorkspacesPage({super.key});

  @override
  State<WorkspacesPage> createState() => _WorkspacesPageState();
}

class _WorkspacesPageState extends State<WorkspacesPage> {
  final UserController userController = Get.find();
  final WorkspaceController workspaceController = Get.find();
  final AppBarController appBarController = Get.find();

  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();
    final WorkspaceDAO wkDAO = WorkspaceDAO();
    workspaceController.workspaces = await wkDAO
        .findAllByUserId(userController.user.id!);
    _setAppBar();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PageAppBarWithActions(actions: []),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _redirectAddWorkspace(),
        child: const Icon(Icons.add),
      ),
      body: Column(
        children: [
          const SizedBox(height: 40),
          const PageTitle(title: 'Workspaces'),
          const SizedBox(height: 60),
          GetBuilder<WorkspaceController>(
              builder: (_) => _renderGrid(_.workspaces)),
        ],
      ),
    );
  }

  Widget _renderGrid(List<Workspace> workspaces) {
    if (workspaces.isEmpty) {
      return const GridEmpty(text: 'No workspaces found...');
    }

    List<GridButton> buttons = List.empty(growable: true);
    for (var workspace in workspaces) {
      buttons.add(GridButton(
        text: workspace.name!,
        onTap: () {
          workspaceController.workspace = workspace;
          appBarController.titleText = workspace.name!;
          _redirectToSlots();
        },
      ));
    }

    return GridOptions(buttons: buttons);
  }

  Future<void> _redirectToSlots() {
    var page = MaterialPageRoute(builder: (ctx) => const SlotsPage());
    return Navigator.of(context).push(page).then((v) => _setAppBar());
  }

  Future<void> _redirectAddWorkspace() {
    var page = MaterialPageRoute(builder: (ctx) => const AddWorkspacePage());
    return Navigator.of(context).push(page).then((v) => _setAppBar());
  }

  void _setAppBar(){
    appBarController.titleText = "Welcome, ${userController.firstName}";
  }
}
