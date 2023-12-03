import 'package:grorange/models/base.dart';

class Slot extends Base {
  final String name;
  final String userId;
  final String workspaceId;

  Slot(
    super.id,
    this.name,
    this.userId,
    this.workspaceId,
    super.insertDateTime,
    super.updateDateTime,
  );

  Map<String, dynamic> toMap() {
    return {
      'id': super.id,
      'name': name,
      'user_id': userId,
      'workspace_id': workspaceId,
      'insert_date_time': super.insertDateTime.toString(),
      'update_date_time': super.updateDateTime.toString(),
      'active': super.active ? 1 : 0,
    };
  }

  static Slot fromMap(Map<String, dynamic> map) {
    Slot slot = Slot(
      map['id'],
      map['name'],
      map['user_id'],
      map['workspace_id'],
      DateTime.parse(map['insert_date_time']),
      map['update_date_time'] == 'null'
          ? null
          : DateTime.parse(map['update_date_time']),
    );

    slot.active = map['active'] == 1;
    return slot;
  }

  @override
  String toString() {
    return 'Slot{id: $id, active: $active, name: $name, userId: $userId, workspaceId: $workspaceId, insertDateTime: $insertDateTime, updateDateTime: $updateDateTime}';
  }
}
