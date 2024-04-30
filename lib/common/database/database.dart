export 'database_impl.dart';
export 'database_io.dart' if (dart.library.js_interop) 'database_web.dart';
import '../utils/logger.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

// import '../../src/customer/db/customer_db.dart';
// import '../../src/schedule/db/schedule_db.dart';

const String dbName = 'hive_app.db';
String dbPath = '';

dbPathConfig() async {
  final location = await getDatabasesPath();
  // Create the path where the database file will be stored
  dbPath = join(location, dbName);
  osstpLoggerNoStack.d('dbPath: $dbPath');

  await createTables();
}

createTables() async {
  final db = await openDatabase(dbPath, version: 1, onCreate: (db, version) async {
    // await db.execute('''
    //     CREATE TABLE IF NOT EXISTS $boss_schedule
    //     (id INTEGER PRIMARY KEY AUTOINCREMENT,
    //     title TEXT,
    //     description TEXT,
    //     start_date_time TEXT,
    //     start_weekday INTEGER,
    //     end_date_time TEXT,
    //     end_weekday INTEGER,
    //     is_plan INTEGER)
    //     ''');
    //
    // await db.execute('''
    //     CREATE TABLE IF NOT EXISTS $boss_customer
    //     (id INTEGER PRIMARY KEY AUTOINCREMENT,
    //     name TEXT,
    //     company TEXT,
    //     industry TEXT,
    //     level TEXT,
    //     description TEXT,
    //     phone TEXT,
    //     email TEXT,
    //     source TEXT,
    //     last_contact_date TEXT,
    //     last_contact_weekday TEXT,
    //     next_contact_date TEXT,
    //     next_contact_weekday TEXT)
    //     ''');
  });
  db.close();
}

Future<Database> openDB({String? path}) async {
  path ??= dbPath;
  final db = await openDatabase(path);

  return db;
}
