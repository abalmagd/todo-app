import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';

class SqfliteHelper {
  static late Database _database;

  static Future dbInit() async {
    _database = await openDatabase(
      'todo.db',
      version: 1,
      onCreate: (Database db, int version) async {
        await db.execute('CREATE TABLE Todo ('
            'Id INTEGER PRIMARY KEY, '
            'Title TEXT, '
            'Priority INTEGER, '
            'Date TEXT, '
            'Type TEXT'
            ')');
        debugPrint('Todo Database Created');
      },
      onOpen: (db) async {
        _database = db;
        debugPrint('Todo Database Opened');
        debugPrint(db.toString());
      },
    );
  }

  static Future<List> dbGetType({required String type}) async =>
      await _database.rawQuery('SELECT * FROM Todo WHERE Type == ?', [type]);

  static Future<void> dbInsert({
    required String title,
    required int priority,
    required String type,
  }) async {
    DateTime now = DateTime.now();
    String currentDate = '${now.day}-${now.month}-${now.year}';
    _database.transaction((txn) async {
      await txn.rawInsert(
          'INSERT INTO Todo('
          'Title, '
          'Priority, '
          'Date, '
          'Type) '
          'VALUES(?, ?, ?, ?)',
          [title, priority, currentDate, type]);
    });
  }

  static Future<int> dbUpdate(String type, int id) async => await _database
      .rawUpdate('UPDATE Todo SET Type = ? WHERE Id = ?', [type, id]);

  static Future<int> dbDelete(int id) async =>
      await _database.rawDelete('DELETE FROM Todo WHERE Id = ?', [id]);

  static Future<int> dbClear() async =>
      await _database.rawDelete('DELETE * FROM Todo');

  static void dbClose() {
    debugPrint('Todo Database closed');
    _database.close();
  }
}
