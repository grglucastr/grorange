import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:grorange/models/User.dart';
import 'package:grorange/models/Workspace.dart';

class WorkspaceDAO {
  Future<void> save(Workspace workspace) async {
    try {
      await Amplify.DataStore.save(workspace);
    } on DataStoreException catch (e) {
      safePrint('Something went wrong saving workspace: ${e.message}');
    }
  }

  Future<List<Workspace>?> findAll(User user) async {
    try {
      return await Amplify.DataStore.query(
        Workspace.classType,
        where: Workspace.USER.eq(user.id)
      );
    } on DataStoreException catch (e) {
      safePrint('Something went wrong querying workspaces: ${e.message}');
    }
    return null;
  }


}
