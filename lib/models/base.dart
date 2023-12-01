abstract class Base {
  final String? id;
  final bool active = true;
  final DateTime insertDateTime;
  final DateTime? updateDateTime;

  Base(this.id, this.insertDateTime, this.updateDateTime);
}