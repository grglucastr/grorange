import 'dart:convert';

import 'package:grorange/models/User.dart';

class UserService {
  static User fromJson(String json){
    return User.fromJson(jsonDecode(json));
  }

  static String toJson(User user){
    return jsonEncode(user);
  }
}