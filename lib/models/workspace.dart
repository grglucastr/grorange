import 'package:grorange/models/base.dart';

class Workspace extends Base {
  final String name;
  final String userId;

  Workspace(
    super.id,
    this.name,
    super.insertDateTime,
    super.updateDateTime,
    this.userId,
    super.active,
  );
}
