// sql lite database for storing numbers
import 'dart:ffi';

import 'package:sqflite/sqflite.dart';
import 'dart:async';

class numDb {
  /**
   * run_no | date | num1 | num2 | num3 | num4 | num5 | num6 | bonus|
   * ---------------------------------------------------------------
   * 1     | 2021 | 1    | 2    | 3    | 4    | 5    | 6    | 7    |
   */

  // db file name
  static final String dbName = 'num.db';
  // table name
  static final String tableName = 'num';


  // create table sql
  String createTableSql = '''
    CREATE TABLE $tableName (
      'id' INTEGER PRIMARY KEY AUTOINCREMENT,
      'run_no' INTEGER,
      'date' TEXT,
      'n1' INTEGER,
      'n2' INTEGER,
      'n3' INTEGER,
      'n4' INTEGER,
      'n5' INTEGER,
      'n6' INTEGER,
      'nb' INTEGER
    )
  ''';

  // DB 생성.
  Future<Database> _openDb() async {
    final dbPath = await getDatabasesPath();
    final path = '$dbPath/$dbName';

    final db = await openDatabase(
      path,
      version: 1,
      onConfigure: (Database db) => {},
      onCreate: (Database db, int version) async {
        await db.execute(createTableSql);
      },
      onUpgrade: (Database db, int oldVersion, int newVersion) async {},
    );

    return db;
  }

  // 태이블 생성.
  Future<void> createTable() async {
    final db = await _openDb();
    try {
      await db.execute(createTableSql);
      print('create table success');
    } catch (e) {
      print('create table error: $e');
    }
    return;
  }
  
  // check duplicate by date, run_no
  Future<bool> checkDuplicate(String run_no, String date) async {
    final db = await _openDb();
    // check if table exists and date, run_no exists
    var sql = 'SELECT * FROM $tableName WHERE run_no = $run_no AND date = "$date"';
    var result = await db.rawQuery(sql);
    if (result.length > 0) {
      return true;
    }
    return false;
  }

  // 데이터 추가.
  Future<void> insertData(Map<String, dynamic> data) async {
    final db = await _openDb();
    var sql_str = 'INSERT INTO $tableName (';
    var sql_val = 'VALUES (';
    data.forEach((key, value) {
      sql_str += '$key, ';
      sql_val += '$value, ';
    });
    sql_str = sql_str.substring(0, sql_str.length - 2) + ')';
    sql_val = sql_val.substring(0, sql_val.length - 2) + ')';
    await db.execute(sql_str + sql_val);
    print('insert result');
    return;
  }

  // 데이터 변경.
  Future<void> updateData(Map<String, dynamic> data) async {
    final db = await _openDb();
    var sql_str = 'UPDATE $tableName SET ';
    data.forEach((key, value) {
      sql_str += '$key = $value, ';
    });
    sql_str = sql_str.substring(0, sql_str.length - 2);

    await db.execute(sql_str);
    print('update result');
    return ;
  }

  // 데이터 삭제.
  Future<void> deleteData(int run_no) async {
    final db = await _openDb();
    await db.delete(tableName, where: 'run_no = ?', whereArgs: [run_no]);
  }

  // 사용자 쿼리문으로 데이터 조회.
  Future<List<Map<String, dynamic>>> selectData(String query) async {
    final db = await _openDb();
    return await db.rawQuery(query);
  }
}

