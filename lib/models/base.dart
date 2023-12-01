abstract class Base {
  final String id;
  final bool active;
  final DateTime insertDateTime;
  final DateTime updateDateTime;

  Base(this.id, this.active, this.insertDateTime, this.updateDateTime);
}