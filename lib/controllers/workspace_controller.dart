import 'package:get/get.dart';
import 'package:grorange/models/workspace.dart';

class WorkspaceController extends GetxController {

  Workspace? _workspace;

  Workspace get workspace => _workspace!;

  set workspace(Workspace value) {
    _workspace = value;
    update();
  }
}