import 'package:grorange/models/base.dart';

class Workspace extends Base {
  String? name;
  String? userId;

  Workspace(
    super.id,
    this.name,
    super.insertDateTime,
    super.updateDateTime,
    this.userId,
  );

  Workspace.fromMap(Map<String, dynamic> map)
      : super.fromStrings(
            map['id'], map['insert_date_time'], map['update_date_time']) {
    name = map['name'];
    userId = map['user_id'];
    super.active = map['active'] == 1;
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {};
    map["name"] = name;
    map["user_id"] = userId;

    map["id"] = id;
    map["insert_date_time"] = insertDateTime.toString();
    map["update_date_time"] = updateDateTime.toString();
    map["active"] = active ? 1 : 0;
    return map;
  }

  @override
  String toString() {
    return 'Workspace{id: $id, name: $name, active: $active, insertDateTime: $insertDateTime, updateDateTime: $updateDateTime, userId: $userId}';
  }
}
