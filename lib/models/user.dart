import 'dart:convert';

import 'package:grorange/models/base.dart';

class User extends Base {
  final String name;

  User(
    super.id,
    this.name,
    super.insertDateTime,
    super.updateDateTime,
  );

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'insert_date_time': insertDateTime,
      'update_date_time': updateDateTime,
      'active': active
    };
  }

  static User fromMap(Map<String, dynamic> map) {
    final User user = User(
      map['id'],
      map['name'],
      map['insert_date_time'],
      map['update_date_time'],
    );
    user.active = map['active'];
    return user;
  }

  String toJson() => jsonEncode(toMap());

  static User fromJson(String json){
    Map<String, dynamic> jsonMap = jsonDecode(json);
    return fromMap(jsonMap);
  }
}
