import 'package:grorange/database/app_database.dart';
import 'package:grorange/models/enums/item_consumption_level.dart';
import 'package:grorange/models/item.dart';
import 'package:sqflite/sqflite.dart';

class ItemDAO {
  static const String _id = 'id';
  static const String _name = 'name';
  static const String _quantity = 'quantity';
  static const String _usagePercentage = 'usage_percentage';
  static const String _consumptionLevel = 'consumption_level';
  static const String _slotId = 'slot_id';
  static const String _workspaceId = 'workspace_id';
  static const String _userId = 'user_id';
  static const String _insertDateTime = 'insert_date_time';
  static const String _updateDateTime = 'update_date_time';
  static const String _active = 'active';

  static const String _tableName = 'items';

  static const String createTable = 'CREATE TABLE $_tableName ('
      '$_id TEXT,'
      '$_name TEXT, '
      '$_quantity INTEGER, '
      '$_usagePercentage REAL, '
      '$_consumptionLevel TEXT, '
      '$_slotId TEXT, '
      '$_workspaceId TEXT, '
      '$_userId TEXT, '
      '$_insertDateTime TEXT, '
      '$_updateDateTime TEXT,'
      '$_active INTEGER)';

  Future<int> save(Item item) async {
    final Database db = await getDatabase();

    Map<String, dynamic> itemMap = {};
    itemMap[_id] = item.id;
    itemMap[_name] = item.name;
    itemMap[_quantity] = item.quantity;
    itemMap[_usagePercentage] = item.usagePercentage;
    itemMap[_consumptionLevel] = item.consumptionLevel.text;
    itemMap[_workspaceId] = item.workspaceId;
    itemMap[_userId] = item.userId;
    itemMap[_slotId] = item.slotId;
    itemMap[_insertDateTime] = item.insertDateTime.toString();
    itemMap[_updateDateTime] = item.updateDateTime.toString();
    itemMap[_active] = item.active ? 1 : 0;

    return db.insert(_tableName, itemMap);
  }

  Future<List<Item>> findAll() async {
    final Database db = await getDatabase();
    final List<Map<String, dynamic>> result = await db.query(_tableName);
    final List<Item> items = [];

    for (Map<String, dynamic> row in result) {
      final item = Item(
        row[_id],
        row[_name],
        row[_quantity],
        row[_usagePercentage],
        _itemConsumptionLevelFromString(row[_consumptionLevel]),
        row[_slotId],
        row[_workspaceId],
        row[_userId],
        DateTime.parse(row[_insertDateTime]),
        row[_updateDateTime] == 'null' ? null : row[_updateDateTime],
      );

      item.active = row[_active] == 1;
      items.add(item);
    }
    return items;
  }

  ItemConsumptionLevel _itemConsumptionLevelFromString(String str) {
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
