import 'dart:async';

import 'package:mpesa_ledger_flutter/utils/constants/database_constants.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseProvider {
  Database _database;

  Future<Database> get database async {
    if (_database != null) {
      print("DATABASE EXISTS");
      return _database;
    }
    _database = await initializedDatabase();
    return _database;
  }

  Future<String> databasePath() async {
    var databasesPath = await getDatabasesPath();
    return join(databasesPath, databaseName);
  }

  Future<Database> initializedDatabase() async {
    print("INITIALIZING DATABASE 1");
    String path = await databasePath();
    Database database = await openDatabase(
      path,
      version: 1,
      onCreate: (Database db, int version) async {
        print("CREATING DATABASE 2");
        // When creating the db, create the table
        for (var i = 0; i < schema.length; i++) {
          await db.execute(schema[i]);
        }
        print("DATABASE CREATED 3");
      },
    );
    print("DATABASE CREATED 4");
    return database;
  }

  void closeDatabase() async {
    if (_database != null) {
      _database.close();
    }
    _database = null;
  }

  void deleteDatabaseMeth() async {
    String path = await databasePath();
    deleteDatabase(path);
    _database = null;
    print("DATABASE DELETED");
  }

  void select() async{
    var db = await database;
    print(_database);
    var j = await db.query("categories");
    print(j);
  }
}
