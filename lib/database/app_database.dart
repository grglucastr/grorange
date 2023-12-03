import 'package:grorange/database/dao/item_dao.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

Future<Database> getDatabase() async {
  final String path = join(await getDatabasesPath(), 'grorange.db');
  return openDatabase(
    path,
    onCreate: (db, version) {
      db.execute(ItemDAO.createTable);
    },
    version: 1,
  );
}
