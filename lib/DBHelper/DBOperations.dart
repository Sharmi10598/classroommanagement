import 'dart:developer';

import 'package:hamonapp/DBHelper/DBModel/StudentTable.dart';
import 'package:hamonapp/DBHelper/DBModel/SubTable.dart';
import 'package:hamonapp/Models/SubModels.dart';
import 'package:sqflite/sqlite_api.dart';

import '../Models/StudentsModel.dart';

class DBOperation {
  static Future insertStudent(
      Database db, List<GetStudentListModel> values) async {
    var data = values.map((e) => e.toMap()).toList();
    var batch = db.batch();
    data.forEach((es) async {
      batch.insert(stdListtdb, es);
    });
    await batch.commit();
    List<Map<String, Object?>> result = await db.rawQuery('''
    select * from $stdListtdb
     ''');
    log("stdListtdb result:: ${result.length}");
  }

  static Future<List<Map<String, Object?>>> getStudent(Database db) async {
    final List<Map<String, Object?>> result = await db.rawQuery('''
SELECT * from $stdListtdb
''');
    return result;
  }

  static Future<List<Map<String, Object?>>> getStudentId(
      Database db, int id) async {
    final List<Map<String, Object?>> result = await db.rawQuery('''
SELECT * from $stdListtdb where Id=$id
''');
    return result;
  }

  static Future insertsubject(Database db, List<GetSubListModel> values) async {
    var data = values.map((e) => e.toMap()).toList();
    var batch = db.batch();
    data.forEach((es) async {
      batch.insert(subListtdb, es);
    });
    await batch.commit();
    List<Map<String, Object?>> result = await db.rawQuery('''
    select * from $subListtdb
     ''');
    log("stdListtdb result:: ${result.length}");
  }

  static Future<List<Map<String, Object?>>> getSubject(Database db) async {
    final List<Map<String, Object?>> result = await db.rawQuery('''
SELECT * from $subListtdb
''');
    return result;
  }

  static Future<List<Map<String, Object?>>> getSubjectid(
      Database db, int id) async {
    final List<Map<String, Object?>> result = await db.rawQuery('''
SELECT * from $subListtdb where Id=$id
''');
    return result;
  }

  static Future<void> truncateStd(Database db) async {
    await db.rawQuery('delete from $stdListtdb');
  }

  static Future<void> truncateSub(Database db) async {
    await db.rawQuery('delete from $subListtdb');
  }
}
