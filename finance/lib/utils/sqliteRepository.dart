import 'package:finance/blocs/model/Expense.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:async';
import 'package:flutter/widgets.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DataBaseProvider {
  static final DataBaseProvider instance = DataBaseProvider._init();
  static Database? _database;
  DataBaseProvider._init();

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDB('expenses.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    final id = 'INTEGER PRIMARY KEY AUTOINCREMENT';
    final userId = 'TEXT NOT NULL';
    final title = 'TEXT NOT NULL';
    final cost = 'TEXT NOT NULL';
    final date = 'TEXT NOT NULL';

    await db.execute('''
CREATE TABLE $expenses ( 
  ${ExpenseFields.id} $id, 
  ${ExpenseFields.userId} $userId,
  ${ExpenseFields.title} $title,
  ${ExpenseFields.cost} $cost,
  ${ExpenseFields.date} $date
  )
''');
  }

  Future<void> createExpense(Expense expense) async {
    // Get a reference to the database.
    final db = await instance.database;

    var result = await db.insert(
      'expenses',
      expense.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );

    expense.copy(id: result);
  }

  Future<List<Expense>> getExpenses(String userId) async {
    // Get a reference to the database.
    final db = await instance.database;

    // tableNotes,
    //   columns: NoteFields.values,
    //   where: '${NoteFields.id} = ?',
    //   whereArgs: [id],

    final List<Map<String, dynamic>> maps =
        await db.query('expenses', where: '${ExpenseFields.userId} = ?', whereArgs: [userId]);

    // Convert the List<Map<String, dynamic> into a List<Dog>.
    return List.generate(maps.length, (i) {
      return Expense(
          id: maps[i]['_id'],
          userId: maps[i]['userId'],
          title: maps[i]['title'],
          cost: maps[i]['cost'],
          date: maps[i]['date']);
    });
  }

  Future<void> deleteExpense(int id) async {
    // Get a reference to the database.
    final db = await instance.database;

    // Remove the Dog from the database.
    await db.delete(
      'expenses',
      // Use a `where` clause to delete a specific dog.
      where: '_id = ?',
      // Pass the Dog's id as a whereArg to prevent SQL injection.
      whereArgs: [id],
    );
  }

    Future close() async {
    final db = await instance.database;

    db.close();
  }
}
