import 'dart:developer';

import 'package:hamonapp/DBHelper/DBModel/StudentTable.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';
import 'package:path/path.dart';

import 'DBModel/SubTable.dart';

class DBHelper {
  static Database? _db;

  DBHelper._() {}
  static Future<Database?> getInstance() async {
    String path = await getDatabasesPath();
    if (_db == null) {
      _db = await openDatabase(join(path, 'ClassRoom.db'),
          version: 1, onCreate: createTable);
    }
    return _db;
  }

  static void createTable(Database database, int version) async {
    await database.execute('''
           create table $stdListtdb (
             
             SId integer primary key autoincrement,
             ${StdListDBT.id} integer ,
             ${StdListDBT.name} varchar ,
             ${StdListDBT.email} varchar ,
             ${StdListDBT.age} varchar            
             )
        ''');
    await database.execute('''
           create table $subListtdb (
             
             SId integer primary key autoincrement,
             ${SubListDBT.id} integer ,
             ${SubListDBT.credits} varchar ,
             ${SubListDBT.name} varchar ,
             ${SubListDBT.teacher} varchar            
             )
        ''');
    //DisPositonListTable
  }
}
