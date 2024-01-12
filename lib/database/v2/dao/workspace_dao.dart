import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:grorange/models/User.dart';
import 'package:grorange/models/Workspace.dart';

class WorkspaceDAO {
  Future<void> save(Workspace workspace) async {
    try {
      await Amplify.DataStore.save(workspace);
    } on DataStoreException catch (e) {
      safePrint('Something went wrong saving the model: ${e.message}');
    }
  }

  Future<List<Workspace>?> findAll(User user) async {
    try {
      return await Amplify.DataStore.query(
        Workspace.classType,
        where: User.ID.eq(user),
      );
    } on DataStoreException catch (e) {
      safePrint('Something went wrong querying posts: ${e.message}');
    }
    return null;
  }


}
