import 'package:grorange/database/app_database.dart';
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
    return db.insert(_tableName, item.toMap());
  }

  Future<List<Item>> findAll(String slotID) async {
    final Database db = await getDatabase();
    final List<Map<String, dynamic>> result = await db.query(
      _tableName,
      where: '$_slotId=?',
      whereArgs: [slotID],
    );

    final List<Item> items = [];

    for (Map<String, dynamic> row in result) {
      items.add(Item.fromMap(row));
    }
    return items;
  }

  Future<int> delete(String itemID) async {
    final Database db = await getDatabase();
    return db.delete(_tableName, where: 'id=?', whereArgs: [itemID]);
  }
}
