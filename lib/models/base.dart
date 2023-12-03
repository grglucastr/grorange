abstract class Base {
  String? id;
  bool active = true;
  DateTime insertDateTime;
  DateTime? updateDateTime;

  Base(this.id, this.insertDateTime, this.updateDateTime);

  @override
  String toString() {
    return 'Base{id: $id, active: $active, insertDateTime: $insertDateTime, updateDateTime: $updateDateTime}';
  }
}