import 'package:sqflite/sqflite.dart';

Future<void> onDbUpgrade(Database db, int oldVersion, int newVersion) async {
  if (oldVersion < 3) {
    await db.execute('''
       CREATE TABLE dashboard_menu(
            mobileNo TEXT,
            userId TEXT,
            updatedDate TEXT,
            orgId TEXT,
            schoolId TEXT,
            userType TEXT,
            dashboardmenu TEXT
          )
          ''');
  }
}
