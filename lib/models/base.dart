abstract class Base {
  String? id;
  bool active = true;
  DateTime? insertDateTime;
  DateTime? updateDateTime;

  Base(this.id, this.insertDateTime, this.updateDateTime);

  // Dart named constructors
  Base.fromStrings(String this.id, String insertDateTime, String updateDateTime){
    this.insertDateTime = DateTime.parse(insertDateTime);
    this.updateDateTime = null;

    if(updateDateTime != 'null'){
      this.updateDateTime = DateTime.parse(updateDateTime);
    }
  }

  @override
  String toString() {
    return 'Base{id: $id, active: $active, insertDateTime: $insertDateTime, updateDateTime: $updateDateTime}';
  }
}