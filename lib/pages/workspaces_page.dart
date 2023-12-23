import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:grorange/components/grid_button.dart';
import 'package:grorange/components/grid_empty.dart';
import 'package:grorange/components/grid_options.dart';
import 'package:grorange/components/loading.dart';
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
  WorkspaceController workspaceController = Get.find();
  AppBarController appBarController = Get.find();
  UserController userController = Get.find();

  @override
  Widget build(BuildContext context) {
    var dao = WorkspaceDAO();

    _setAppBarTitle();

    return Scaffold(
        appBar: PageAppBarWithActions(actions: []),
        floatingActionButton: FloatingActionButton(
          onPressed: () => _redirectAddWorkspace(context),
          child: const Icon(Icons.add),
        ),
        body: Column(
          children: [
            const SizedBox(
              height: 40,
            ),
            const PageTitle(title: 'Workspaces'),
            const SizedBox(
              height: 60,
            ),
            FutureBuilder<List<Workspace>>(
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
                }),
          ],
        ));
  }

  void _setAppBarTitle() {
    if (userController.firstName.isEmpty) {
      Future.delayed(const Duration(milliseconds: 1500)).then((value) {
        appBarController.title.value = "Welcome, ${userController.firstName}";
      });
    } else {
      appBarController.title.value = "Welcome, ${userController.firstName}";
    }
  }
  
  

  Future<Null> _redirectAddWorkspace(BuildContext context) {
    return Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => const AddWorkspacePage(),
    )).then((value) {
        appBarController.title.value = "Welcome, ${userController.firstName}";
        setState(() {});
    });
  }

  Widget _handleFutureBuilderDone(
      BuildContext context, AsyncSnapshot<List<Workspace>> snapshot) {
    if (snapshot.hasData) {
      List<Workspace> workspaces = snapshot.data!;
      return workspaces.isNotEmpty
          ? _fillGrid(workspaces)
          : const GridEmpty(text: 'No workspaces found...');
    }
    return const Center(
      child: Text('Still loading...'),
    );
  }

  Widget _fillGrid(List<Workspace> workspaces) {
    List<GridButton> buttons = List.empty(growable: true);

    for (var workspace in workspaces) {
      buttons.add(GridButton(
        text: workspace.name!,
        onTap: () {
          workspaceController.workspace = workspace;
          appBarController.title.value = workspace.name!;
          _redirectToSlots();
        },
      ));
    }
    return GridOptions(buttons: buttons);
  }

  Future<void> _redirectToSlots() {
    return Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => const SlotsPage()),
    ).then((value) {
        appBarController.title.value = "Welcome, ${userController.firstName}";
        setState(() {});
    });
  }
}
