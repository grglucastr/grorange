import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:grorange/controllers/app_bar_controller.dart';
import 'package:grorange/controllers/user_controller.dart';
import 'package:grorange/controllers/workspace_controller.dart';
import 'package:grorange/core_widgets/grid_button.dart';
import 'package:grorange/core_widgets/loading.dart';
import 'package:grorange/core_widgets/page_title.dart';
import 'package:grorange/database/v2/dao/workspace_dao.dart';
import 'package:grorange/models/Workspace.dart';
import 'package:grorange/pages/add_workspace_page.dart';
import 'package:grorange/pages/slots_page.dart';
import 'package:grorange/widgets/grid_empty.dart';
import 'package:grorange/widgets/grid_options.dart';
import 'package:grorange/widgets/page_app_bar_with_actions.dart';

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
    _loadWorkspaces();
    _setAppBar();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PageAppBarWithActions(actions: const []),
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

    if(workspaceController.loadingWorkspaces){
      return const Loading();
    }

    if (workspaces.isEmpty) {
      return const GridEmpty(text: 'No workspaces found...');
    }

    List<GridButton> buttons = List.empty(growable: true);
    for (var workspace in workspaces) {
      buttons.add(GridButton(
        text: workspace.name,
        onTap: () {
          workspaceController.workspace = workspace;
          appBarController.titleText = workspace.name;
          _redirectToSlots();
        },
      ));
    }
    return GridOptions(buttons: buttons);
  }

  Future<void> _redirectToSlots() {
    var page = MaterialPageRoute(builder: (ctx) => const SlotsPage());
    return Navigator.of(context).push(page).then((v){
      _setAppBar();
      _showSnackBarFeedback(v);
      _loadWorkspaces();
    });
  }

  void _showSnackBarFeedback(v) {
    if(v != null){
      final Map<String, dynamic> feedback = v;
      if(feedback['action'] == 'delete'){
        final String wkName = feedback['workspace_name'];
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('Workspace $wkName deleted')));
      }
    }
  }

  Future<void> _redirectAddWorkspace() {
    var page = MaterialPageRoute(builder: (ctx) => const AddWorkspacePage());
    return Navigator.of(context).push(page).then((v) => _setAppBar());
  }

  void _setAppBar(){
    appBarController.titleText = "Welcome, ${userController.firstName}";
  }

  void _loadWorkspaces() {
    workspaceController.workspaces = [];
    workspaceController.loadingWorkspaces = true;
    Future<void>.delayed(const Duration(milliseconds: 200), () async {
      final WorkspaceDAO wkDAO = WorkspaceDAO();
      List<Workspace>? lst = await wkDAO.findAll(userController.user);
      workspaceController.workspaces = lst ?? [];
      workspaceController.loadingWorkspaces = false;
    });
  }
}
