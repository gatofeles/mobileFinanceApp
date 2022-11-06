import 'package:finance/blocs/model/Expense.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:async';
import 'package:flutter/widgets.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DataBaseProvider{
  Future<Database>? _client;
  
  void startDb() async {
  // Open the database and store the reference.
    _client = openDatabase(
    // Set the path to the database. Note: Using the `join` function from the
    // `path` package is best practice to ensure the path is correctly
    // constructed for each platform.
    join(await getDatabasesPath(), 'expenses.db'),
    // When the database is first created, create a table to store dogs.
    onCreate: (db, version) {
      // Run the CREATE TABLE statement on the database.
      return db.execute(
        'CREATE TABLE dogs(id INTEGER PRIMARY KEY, userId TEXT, title TEXT, cost TEXT, date TEXT)',
      );
    },
    // Set the version. This executes the onCreate function and provides a
    // path to perform database upgrades and downgrades.
    version: 1,  
    );
  }

   Future<void> createExpense(Expense expense) async {
    // Get a reference to the database.
    final db = await _client;

    // Insert the Dog into the correct table. You might also specify the
    // `conflictAlgorithm` to use in case the same dog is inserted twice.
    //
    // In this case, replace any previous data.
    await db!.insert(
      'expenses',
      expense.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

    Future<List<Expense>> expenses() async {
    // Get a reference to the database.
    final db = await _client;

    // Query the table for all The Dogs.
    final List<Map<String, dynamic>> maps = await db!.query('dogs');

    // Convert the List<Map<String, dynamic> into a List<Dog>.
    return List.generate(maps.length, (i) {
      return Expense(
        id: maps[i]['id'],
        userId: maps[i]['userId'],
        title: maps[i]['title'],
        cost: maps[i]['cost'],
        date: maps[i]['date']
      );
    });
  }

  Future<void> deleteExpense(int id) async {
    // Get a reference to the database.
    final db = await _client;

    // Remove the Dog from the database.
    await db!.delete(
      'expenses',
      // Use a `where` clause to delete a specific dog.
      where: 'id = ?',
      // Pass the Dog's id as a whereArg to prevent SQL injection.
      whereArgs: [id],
    );
  }


}