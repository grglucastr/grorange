import 'package:flutter/material.dart';
import 'package:grorange/components/grid_button.dart';
import 'package:grorange/components/grid_empty.dart';
import 'package:grorange/components/grid_options.dart';
import 'package:grorange/components/loading.dart';
import 'package:grorange/components/page_app_bar.dart';
import 'package:grorange/components/page_title.dart';
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
  @override
  Widget build(BuildContext context) {
    var dao = WorkspaceDAO();
    return Scaffold(
        appBar: const PageAppBar(
          title: 'Welcome, George!',
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.of(context)
                .push(MaterialPageRoute(
                  builder: (context) => const AddWorkspacePage(),
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
            const PageTitle(title: 'Workspaces'),
            const SizedBox(
              height: 60,
            ),
            FutureBuilder<List<Workspace>>(
                future: Future.delayed(const Duration(seconds: 1))
                    .then((value) => dao.findAll()),
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
        text: workspace.name,
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => const SlotsPage(),
            ),
          );
        },
      ));
    }
    return GridOptions(buttons: buttons);
  }
}
