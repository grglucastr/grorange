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

  @override
  String toString() {
    return 'Item{name: $name, quantity: $quantity, usagePercentage: $usagePercentage, consumptionLevel: $consumptionLevel, slotId: $slotId, workspaceId: $workspaceId, userId: $userId}';
  }
}
