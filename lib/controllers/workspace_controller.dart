import 'package:get/get.dart';
import 'package:grorange/models/Workspace.dart';

class WorkspaceController extends GetxController {

  Workspace? _workspace;
  List<Workspace> _workspaces = List.empty(growable: true);

  Workspace get workspace => _workspace!;

  List<Workspace> get workspaces => _workspaces;

  set workspace(Workspace value) {
    _workspace = value;
    update();
  }

  set workspaces(List<Workspace> value) {
    _workspaces = value;
    update();
  }

  void add(Workspace workspace){
    final List<Workspace> wks = workspaces;
    wks.add(workspace);
    workspaces = wks;
  }

  void delete(Workspace workspace){
    final List<Workspace> lst = workspaces.where((wk) => wk.id != workspace.id)
        .toList(growable: true);
    workspaces = lst;
  }
}