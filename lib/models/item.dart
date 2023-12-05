import 'package:grorange/models/base.dart';
import 'package:grorange/models/enums/item_consumption_level.dart';

class Item extends Base {
  final String name;
  final int quantity;
  final double usagePercentage;
  final ItemConsumptionLevel consumptionLevel;
  final String slotId;
  final String workspaceId;
  final String userId;

  Item(
      super.id,
      this.name,
      this.quantity,
      this.usagePercentage,
      this.consumptionLevel,
      this.slotId,
      this.workspaceId,
      this.userId,
      super.insertDateTime,
      super.updateDateTime);

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {};
    map['id'] = id;
    map['name'] = name;
    map['quantity'] = quantity;
    map['usage_percentage'] = usagePercentage;
    map['consumption_level'] = consumptionLevel.text;
    map['slot_id'] = slotId;
    map['workspace_id'] = workspaceId;
    map['user_id'] = userId;

    map['insert_date_time'] = insertDateTime.toString();
    map['update_date_time'] = updateDateTime.toString();
    map['active'] = active ? 1 : 0;
    return map;
  }

  static Item fromMap(Map<String, dynamic> map) {
    final Item item = Item(
        map['id'],
        map['name'],
        map['quantity'],
        map['usage_percentage'],
        _itemConsumptionLevelFromString(map['consumption_level']),
        map['slot_id'],
        map['workspace_id'],
        map['user_id'],
        DateTime.parse(map['insert_date_time']),
        map['update_date_time'] == 'null' ? null : DateTime.parse(map['update_date_time']));
    item.active = map['active'] == 1;
    return item;
  }

  @override
  String toString() {
    return 'Item{name: $name, quantity: $quantity, usagePercentage: $usagePercentage, consumptionLevel: $consumptionLevel, slotId: $slotId, workspaceId: $workspaceId, userId: $userId}';
  }

  static ItemConsumptionLevel _itemConsumptionLevelFromString(String str) {
    if (str == ItemConsumptionLevel.safe.text) {
      return ItemConsumptionLevel.safe;
    }

    if (str == ItemConsumptionLevel.moderate.text) {
      return ItemConsumptionLevel.moderate;
    }

    if (str == ItemConsumptionLevel.severe.text) {
      return ItemConsumptionLevel.severe;
    }

    return ItemConsumptionLevel.critical;
  }
}
