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
    super.active,
    super.insertDateTime,
    super.updateDateTime,
  );
}
