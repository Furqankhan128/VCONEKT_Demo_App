
import 'package:shared_preferences/shared_preferences.dart';

import 'global_variables.dart';

const String _loggedIn = "loggedIn";
const String _userId = "userId";
const String _email = "email";
const String _password = "password";

class UserSession {
  static bool isLoggedIn = false;
  static SharedPreferences? _sharedPreferences;
  static String userId = "";  static String email = "";  static String password = "";
  static String accessToken = "";

  static Future<void> create(userId) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setBool(_loggedIn, true);
    sharedPreferences.setString(_userId, userId);
    UserSession.isLoggedIn = true;
    UserSession.userId = userId;
  }

  static Future<bool> exist() async {
    _sharedPreferences ??= await SharedPreferences.getInstance();
    isLoggedIn = _sharedPreferences?.getBool(_loggedIn)??false;
    userId = _sharedPreferences?.getString(_userId)??"";
    return isLoggedIn;
  }

  static Future<List<String>> getCredentials() async {
    _sharedPreferences ??= await SharedPreferences.getInstance();
    email = _sharedPreferences?.getString(_email)??"";
    password = _sharedPreferences?.getString(_password)??"";
    return [email,password];
  }

  static Future<void> saveCredentials(email, password) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString(_email, email);
    sharedPreferences.setString(_password, password);
    UserSession.email = email;
    UserSession.password = password;
  }

  static Future<void> logout() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.remove(_loggedIn);
    UserSession.isLoggedIn = false;
    sharedPreferences.remove(_userId);
    UserSession.userId = "";
    gFirebaseAuth.signOut();
  }
}
