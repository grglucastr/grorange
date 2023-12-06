import 'package:grorange/database/app_database.dart';
import 'package:grorange/models/slot.dart';
import 'package:sqflite/sqflite.dart';

class SlotDAO {

  static const String _id = 'id';
  static const String _name = 'name';
  static const String _userId = 'user_id';
  static const String _workspaceId = 'workspace_id';
  static const String _insertDateTime = 'insert_date_time';
  static const String _updateDateTime = 'update_date_time';
  static const String _active = 'active';

  static const String tableName = 'slots';

  static const String createTable = 'CREATE TABLE $tableName ('
      '$_id TEXT, '
      '$_name TEXT, '
      '$_userId TEXT, '
      '$_workspaceId TEXT, '
      '$_insertDateTime TEXT, '
      '$_updateDateTime TEXT, '
      '$_active INTEGER)';


  Future<int> save(Slot slot) async {
    final Database db = await getDatabase();
    return db.insert(tableName, slot.toMap());
  }

  Future<int> delete(String slotID) async {
    final Database db = await getDatabase();
    return await db.delete(tableName, where: '$_id=?', whereArgs: [slotID]);
  }

  Future<List<Slot>> findAll() async {
    final Database db = await getDatabase();
    List<Map<String, dynamic>> rows = await db.query(tableName);

    List<Slot> slots = List.empty(growable: true);
    for(Map<String, dynamic> row in rows){
      slots.add(Slot.fromMap(row));
    }

    return slots;
  }



}