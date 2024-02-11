import 'dart:convert';

import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_core/amplify_core.dart';
import 'package:grorange/models/User.dart';

class UserService {
  static User fromJson(String json){
    return User.fromJson(jsonDecode(json));
  }

  static String toJson(User user){
    return jsonEncode(user);
  }

  Future<void> deleteUser() async {
    try{
      await Amplify.Auth.deleteUser();
      safePrint('Delete user succeeded');
    } on AuthException catch (e) {
      safePrint('Delete user failed with error: $e');
    }
  }
}