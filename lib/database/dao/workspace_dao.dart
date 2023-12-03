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

    Map<String, dynamic> map = {};
    map[_name] = workspace.name;
    map[_userId] = workspace.userId;

    map[_id] = workspace.id;
    map[_insertDateTime] = workspace.insertDateTime.toString();
    map[_updateDateTime] = workspace.updateDateTime.toString();
    map[_active] = workspace.active ? 1 : 0;

    return db.insert(tableName, map);
  }

  Future<List<Workspace>> findAll() async {
    final List<Workspace> workspaces = List.empty(growable: true);

    final Database db = await getDatabase();
    final List<Map<String, dynamic>> rows = await db.query(tableName);

    for (Map<String, dynamic> row in rows) {
      Workspace wk = Workspace(
        row[_id],
        row[_name],
        DateTime.parse(row[_insertDateTime]),
        row[_updateDateTime] == 'null' ? null : DateTime.parse(row[_updateDateTime]),
        row[_userId],
      );

      wk.active = row[_active] == 1;

      workspaces.add(wk);
    }

    return workspaces;
  }
}
