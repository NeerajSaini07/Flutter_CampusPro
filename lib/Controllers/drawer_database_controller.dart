import 'dart:convert';
import 'dart:developer';
import 'package:get/get.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class UserData {
  final String? mobileNo;
  final String? userId;
  final String? updatedDate;
  final String? orgId;
  final String? schoolId;
  final String? userType;
  final List drawerData;

  UserData(
      {this.mobileNo,
      this.userId,
      this.updatedDate,
      this.orgId,
      this.schoolId,
      this.userType,
      required this.drawerData});

  Map<String, dynamic> toMap() {
    return {
      'mobileNo': mobileNo,
      'userId': userId,
      'updatedDate': updatedDate,
      'orgId': orgId,
      'schoolId': schoolId,
      'userType': userType,
      'drawerData': jsonEncode(drawerData),
    };
  }

  factory UserData.fromMap(Map<String, dynamic> map) {
    return UserData(
      mobileNo: map['mobileNo'],
      userId: map['userId'],
      updatedDate: map['updatedDate'],
      orgId: map['orgId'],
      schoolId: map['schoolId'],
      userType: map['userType'],
      drawerData: List<dynamic>.from(jsonDecode(map['drawerData'])),
    );
  }
}

class DrawerDatabaseController extends GetxController {
  var drawerLists = <UserData>[].obs;
  late Database _database;

  @override
  void onInit() {
    super.onInit();
    _initDatabase();
  }

  Future<void> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'campuspro.db');
    _database = await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
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
      },
    );
    _loadUserDatas(); // Load existing user lists
  }

  Future<void> _loadUserDatas() async {
    var drawerListData = await _database.query('user_menu');
    drawerLists.value = drawerListData.isNotEmpty
        ? drawerListData.map((ul) => UserData.fromMap(ul)).toList()
        : [];
    // log(drawerLists.value.toString());
  }

  Future<void> addUserData(UserData drawerList) async {
    await _database.insert('user_menu', drawerList.toMap());
    _loadUserDatas();
  }

  Future<UserData?> getSpecificUserData(
      String orgId, String userType, String schoolId) async {
    final List<Map<String, dynamic>> result = await _database.query(
      'user_menu',
      where: 'orgId = ? AND userType = ? AND schoolId = ?',
      whereArgs: [orgId, userType, schoolId],
    );

    if (result.isNotEmpty) {
      return UserData.fromMap(result.first);
    } else {
      return null;
    }
  }

  Future<void> updateUserData(String orgId, String userType, String schoolId,
      String newUpdatedDate) async {
    await _database.update(
      'user_menu',
      {'updatedDate': newUpdatedDate},
      where: 'orgId = ? AND userType = ? AND schoolId = ?',
      whereArgs: [orgId, userType, schoolId],
    );
    _loadUserDatas();
  }
}
