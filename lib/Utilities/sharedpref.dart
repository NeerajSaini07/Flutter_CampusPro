import 'package:shared_preferences/shared_preferences.dart';

class Sharedprefdata {
  static const loginKey = "isLogin";
  static const uid = "uid";
  static const token = "token";
  static const mobile = "mobileNumber";
  static const password = "password";
  static const userTypeIndex = "UserTypeIndex";
  static const fcmToken = "fcmToken";
  static const baseUrl = "baseUrl";

  // **************************** boolean value stored in prefrence************************

  static setbooleandata(String key, bool value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool(key, value);
  }

// **************************** boolean value get from prefrence************************
  Future getbooleandata(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(key);
  }

  //  ******************************* Stroing data String data in to sharedprefrence **************************************8
  static storeStringData(String key, String value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(key, value);
  }

  static Future getStrigData(key) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(key);
  }

  static storeIntegerData(String key, int value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt(key, value);
  }

  static Future getIntegerData(String key) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getInt(key);
  }
}
