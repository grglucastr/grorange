abstract class Base {
  String? id;
  bool active = true;
  DateTime insertDateTime;
  DateTime? updateDateTime;

  Base(this.id, this.insertDateTime, this.updateDateTime);
}