import 'package:flutter/material.dart';
import 'package:grorange/components/grid_button.dart';
import 'package:grorange/components/grid_options.dart';
import 'package:grorange/components/page_app_bar.dart';
import 'package:grorange/components/page_title.dart';
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
    // TODO: Load info from database
    List<Widget> buttons = List.empty(growable: true);
    buttons.add(GridButton(
      text: 'Home',
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => const SlotsPage(),
          ),
        );
      },
    ));

    return Scaffold(
        appBar: const PageAppBar(
          title: 'Welcome, George!',
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => const AddWorkspacePage(),
            ));
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
            GridOptions(buttons: buttons),
          ],
        ));
  }
}
