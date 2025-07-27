import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class TestResult  {
  final String testID;
  final String testTitle;
  final String date;
  final String time;
  final String score;

  TestResult({
    required this.testID,
    required this.testTitle,
    required this.date,
    required this.time,
    required this.score,
  });
}

class ResultDataBase {
  Database? _database;

  // Create or open the database
  Future<void> createDB() async {
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'phonological_result.db');

    _database = await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
          await db.execute(
              'CREATE TABLE Test (testID INTEGER PRIMARY KEY, testTitle TEXT, date TEXT, time TEXT, score INTEGER)');
        });
  }

  // Insert data into the database
  Future<void> insertDB(String title, String date, String time, int score) async {
    if (_database == null) {
      throw Exception("Database not initialized. Call createDB() first.");
    }

    await _database!.transaction((txn) async {
      int id = await txn.rawInsert(
          'INSERT INTO Test(testTitle, date, time, score) VALUES(?, ?, ?, ?)',
          [title, date, time, score]);
      print('Inserted row ID: $id');
    });
  }

  Future<List<Map<dynamic,dynamic>>> getDB() async {

    List<Map> list = await _database!.rawQuery('SELECT * FROM Test');
    print(list);
    return list;
  }

  Future<void> closeDB() async {
    await _database!.close();
  }
}

