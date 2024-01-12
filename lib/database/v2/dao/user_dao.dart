import 'package:amplify_core/amplify_core.dart';
import 'package:grorange/models/User.dart';

class UserDAO {
  
  Future<void> save(User user) async {
    try{
      await Amplify.DataStore.save(user);
    }on DataStoreException catch (e) {
      safePrint('Something went wrong saving the model: ${e.message}');
    }
  }
  
  Future<User?> getById(String userId) async {
    try{

      final List<User> users = await Amplify.DataStore
          .query(User.classType, where: User.ID.eq(userId));

      return users.isEmpty ? null : users[0];

    }on DataStoreException catch(e){
      safePrint('Something went wrong while querying the user data. ${e.message}');
    }

    return null;
  }
  
  
}