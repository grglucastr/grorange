import 'package:grorange/models/base.dart';

class User extends Base {
  final String name;

  User(
    super.id,
    this.name,
    super.insertDateTime,
    super.updateDateTime,
  );
}
