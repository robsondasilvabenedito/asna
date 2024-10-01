import 'package:asna/app/common/database/sql_utils.dart';
import 'package:sqflite_sqlcipher/sqflite.dart';

import 'package:path/path.dart' as p;

class SqlConnection {
  static Database? _db;

  static Future<Database?> get() async {
    if (_db != null) return _db;

    String path = p.join(await getDatabasesPath(), "fl_notes.db");

    _db = await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        // foreign key
        await db.execute("PRAGMA foreign_keys = ON");

        // tables
        await db.execute(SqlUtils.sqlScripts.definitionNote);
        await db.execute(SqlUtils.sqlScripts.definitionTag);
        await db.execute(SqlUtils.sqlScripts.definitionNoteTag);
      },
    );

    return _db;
  }
}
