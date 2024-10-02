import 'package:expencetracker/model/my_transaction.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
 

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  static Database? _database;

  factory DatabaseHelper() {
    return _instance;
  }

  DatabaseHelper._internal();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB();
    return _database!;
  }

  Future<Database> _initDB() async {
    String path = join(await getDatabasesPath(), 'transactions.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: _createDB,
    );
  }

  Future<void> _createDB(Database db, int version) async {
    await db.execute(''' 
      CREATE TABLE transactions(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        amount REAL,
        category TEXT,
        type TEXT,
        date TEXT
      )
    ''');
  }

  Future<void> insertTransaction(MyTransaction transaction) async {
    final db = await database;
    print(transaction.toMap().values);
    await db.insert(
      'transactions',
      transaction.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<MyTransaction>> getTransactions() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('transactions');
print(maps.length);
    return List.generate(maps.length, (i) {
      return MyTransaction(
        id: maps[i]['id'] as int?, 
        amount: maps[i]['amount'] as double,
        category: maps[i]['category'] as String,
        type: maps[i]['type'] as String,
        date: DateTime.parse(maps[i]['date'] as String), // Convert string back to DateTime
      );
    });
  }

  Future<void> deleteTransaction(String category) async {
  final db = await database;
  await db.delete(
    'transactions',
    where: 'category = ?',
    whereArgs: [category],
  );
}
}
