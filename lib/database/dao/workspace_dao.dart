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
    return db.insert(tableName, workspace.toMap());
  }

  Future<List<Workspace>> findAll() async {
    final List<Workspace> workspaces = List.empty(growable: true);

    final Database db = await getDatabase();
    final List<Map<String, dynamic>> rows = await db.query(tableName);

    for (var row in rows) {
      workspaces.add(Workspace.fromMap(row));
    }
    return workspaces;
  }
}
