// sql lite database for storing numbers
import 'package:sqflite/sqflite.dart';
import 'dart:async';

class numDb {
  /**
   * index | date | num1 | num2 | num3 | num4 | num5 | num6 | bonus|
   * ---------------------------------------------------------------
   * 1     | 2021 | 1    | 2    | 3    | 4    | 5    | 6    | 7    |
   */

  // db file name
  static final String dbName = 'num.db';
  // table name
  static final String tableName = 'num';

  // column names
  static final col_name = {
    'index': 'index',
    'date': 'date',
    'num1': 'num1',
    'num2': 'num2',
    'num3': 'num3',
    'num4': 'num4',
    'num5': 'num5',
    'num6': 'num6',
    'bonus': 'bonus',
  };
  
  // column types
  static final col_type = {
    'index': 'INTEGER PRIMARY KEY AUTOINCREMENT',
    'date': 'TEXT',
    'num1': 'INTEGER',
    'num2': 'INTEGER',
    'num3': 'INTEGER',
    'num4': 'INTEGER',
    'num5': 'INTEGER',
    'num6': 'INTEGER',
    'bonus': 'INTEGER',
  };

  // create table sql
  static final String createTableSql = '''
    CREATE TABLE $tableName (
      ${col_name['index']} ${col_type['index']},
      ${col_name['date']} ${col_type['date']},
      ${col_name['num1']} ${col_type['num1']},
      ${col_name['num2']} ${col_type['num2']},
      ${col_name['num3']} ${col_type['num3']},
      ${col_name['num4']} ${col_type['num4']},
      ${col_name['num5']} ${col_type['num5']},
      ${col_name['num6']} ${col_type['num6']},
      ${col_name['bonus']} ${col_type['bonus']}
    )
  ''';

  // DB 생성.
  Future<Database> _openDb() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, dbName);

    final db = await openDatabase(
      path,
      version: 1,
      onConfigure: (Database db) => {},
      onCreate: (Database db, int version) async {
        await db.execute(createTableSql);
      },
      onUpgrade: (Database db, int oldVersion, int newVersion) async {},
    );
  }

  // 태이블 생성.
  Future<void> createTable() async {
    final db = await _openDb();
    await db.execute(createTableSql);
  }

  // 데이터 추가.
  Future<void> insertData(Map<String, dynamic> data) async {
    final db = await _openDb();
    await db.insert(tableName, data);
  }

  // 데이터 변경.
  Future<void> updateData(Map<String, dynamic> data) async {
    final db = await _openDb();
    await db.update(tableName, data);
  }

  // 데이터 삭제.
  Future<void> deleteData(int index) async {
    final db = await _openDb();
    await db.delete(tableName, where: '${col_name['index']} = ?', whereArgs: [index]);
  }

  // 사용자 쿼리문으로 데이터 조회.
  Future<List<Map<String, dynamic>>> selectData(String query) async {
    final db = await _openDb();
    return await db.rawQuery(query);
  }
}

