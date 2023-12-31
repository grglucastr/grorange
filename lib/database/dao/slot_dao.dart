import 'package:flutter/material.dart';
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
    return await db.insert(tableName, slot.toMap());
  }

  Future<int> delete(Slot slot) async {
    final Database db = await getDatabase();
    slot.active = false;
    slot.updateDateTime = DateTime.now();
    return await db.update(tableName, slot.toMap(), where: '$_id = ?', whereArgs: [slot.id]);
  }

  Future<int> updateName(String slotID, String newName) async {
    final Database db = await getDatabase();
    final String updateDateTime = DateTime.now().toString();
    const String sql = 'UPDATE $tableName SET $_name = ?, $_updateDateTime = ? WHERE $_id = ?';
    final int rowsUpdated = await db.rawUpdate(sql, [newName, updateDateTime, slotID]);
    if(rowsUpdated > 0) {
      debugPrint('Updated successfully');
    }else{
      debugPrint('Error while updating');
    }
    return rowsUpdated;
  }

  Future<List<Slot>> findAll(String workspaceID) async {
    final Database db = await getDatabase();
    List<Map<String, dynamic>> rows = await db.query(
      tableName,
      where: '$_workspaceId=? AND $_active = 1',
      whereArgs: [workspaceID],
    );

    List<Slot> slots = List.empty(growable: true);
    for (Map<String, dynamic> row in rows) {
      slots.add(Slot.fromMap(row));
    }

    return slots;
  }
}
