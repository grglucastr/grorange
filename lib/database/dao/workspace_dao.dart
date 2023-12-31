import 'package:flutter/cupertino.dart';
import 'package:grorange/database/app_database.dart';
import 'package:grorange/models/workspace.dart';
import 'package:sqflite/sqflite.dart';

class WorkspaceDAO {
  static const String tableName = 'workspaces';

  static const String _id = 'id';
  static const String _insertDateTime = 'insert_date_time';
  static const String _updateDateTime = 'update_date_time';
  static const String _active = 'active';

  static const String _name = 'name';
  static const String _userId = 'user_id';

  static const String createTable = 'CREATE TABLE $tableName('
      '$_id TEXT, '
      '$_name TEXT, '
      '$_userId TEXT, '
      '$_insertDateTime TEXT, '
      '$_updateDateTime TEXT, '
      '$_active INTEGER)';

  Future<int> save(Workspace workspace) async {
    final Database db = await getDatabase();
    return await db.insert(tableName, workspace.toMap());
  }

  Future<int> delete(Workspace workspace) async {
    final Database db = await getDatabase();
    workspace.active = false;
    workspace.updateDateTime = DateTime.now();
    return await db.update(
      tableName,
      workspace.toMap(),
      where: '$_id = ?',
      whereArgs: [workspace.id],
    );
  }

  Future<int> updateName(String workspaceID, String newName) async {
    final Database db = await getDatabase();
    final String updateDateTime = DateTime.now().toString();
    const String sql =
        'UPDATE $tableName SET $_name = ?, $_updateDateTime = ? WHERE $_id = ?';
    final int rowsUpdated =
        await db.rawUpdate(sql, [newName, updateDateTime, workspaceID]);
    if (rowsUpdated > 0) {
      debugPrint('Updated successfully');
    } else {
      debugPrint('Error while updating');
    }

    return rowsUpdated;
  }

  Future<List<Workspace>> findAllByUserId(String userId) async {
    final List<Workspace> workspaces = List.empty(growable: true);

    final Database db = await getDatabase();
    List<Map<String, dynamic>> rows = await db.query(
      tableName,
      where: '$_userId = ? AND $_active = 1',
      whereArgs: [userId],
    );

    for (Map<String, dynamic> row in rows) {
      workspaces.add(Workspace.fromMap(row));
    }
    return workspaces;
  }
}
