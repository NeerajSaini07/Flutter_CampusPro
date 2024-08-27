// ignore_for_file: depend_on_referenced_packages

import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import 'menu_model.dart';

class DatabaseManager {
  Database? _database;

  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    }
    _database = await initWinDB();
    return _database!;
  }

  Future<Database> initWinDB() async {
    final directory = await getApplicationDocumentsDirectory();
    final path = join(directory.path, 'database.db');

    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
       CREATE TABLE user_menu(
            mobileNo TEXT,
            userId TEXT,
            updatedDate TEXT,
            orgId TEXT,
            schoolId TEXT,
            userType TEXT,
            drawerData TEXT
          )
          ''');
  }

  Future<void> insertOrUpdateUserData(
      UserData userData, String usertype) async {
    print("here");
    final db = await database;

    // ******************   Check if the usertype already exists ****************
    List<Map<String, dynamic>> existingUser = await db.query(
      'user_menu',
      where: 'userType = ?',
      whereArgs: [usertype],
    );

    if (existingUser.isEmpty) {
      // ********************* If usertype does not exist, insert new data *************
      await db.insert(
        'user_menu',
        userData.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );

      print("menu insert successfully");
    } else {
      // ************************  If usertype exists, update the existing record ****************
      await db.update(
        'user_menu',
        userData.toMap(),
        where: 'userType = ?',
        whereArgs: [usertype],
        conflictAlgorithm: ConflictAlgorithm.replace,
      );

      print("menu updated successfully");
    }
  }

  Future<String?> getUpdatedDateByUserType(String usertype) async {
    final db = await database;
    List<Map<String, dynamic>> result = await db.query(
      'user_menu',
      columns: ['updatedDate'],
      where: 'userType = ?',
      whereArgs: [usertype],
    );

    if (result.isNotEmpty) {
      return result.first['updatedDate'] as String?;
    } else {
      return null; // or you could throw an exception or return a default value
    }
  }

  Future<List<Map<String, dynamic>>?> getmenudata(usertype) async {
    final db = await database;
    List<Map<String, dynamic>> result = await db.query(
      'user_menu',
      where: 'userType = ?',
      whereArgs: [usertype],
    );

    if (result.isNotEmpty) {
      return result;
    } else {
      return null; // or you could throw an exception or return a default value
    }
  }
}
