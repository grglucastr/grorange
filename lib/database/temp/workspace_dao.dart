import 'package:amplify_core/amplify_core.dart';
import 'package:grorange/models/ModelProvider.dart';

Future<void> saveWorkspace() async {
  final newWorkspace = Workspace(name: 'Using GraphQL for the first time');

  try{
    await Amplify.DataStore.save(newWorkspace);
  }on DataStoreException catch (e) {
    safePrint('Something went wrong saving the model: ${e.message}');
  }
}

Future<void> queryWorkspaces() async {
  try{
    final workspaces = await Amplify.DataStore.query(Workspace.classType);
    safePrint('workspaces: $workspaces');
  }on DataStoreException catch(e) {
    safePrint('Something went wrong querying posts: ${e.message}');
  }
}