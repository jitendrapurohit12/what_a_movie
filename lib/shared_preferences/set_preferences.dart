import 'package:shared_preferences/shared_preferences.dart';
import 'package:what_a_movie/constants/constants.dart';

class SetPreferences {
  static void setUserLoggedIn(bool loginStatus) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool(SharedPrefConstants.IS_USER_LOGGED_IN, loginStatus);
  }

  static void setUserName(String username) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(SharedPrefConstants.USERNAME, username);
  }

  static void setUserId(int id) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setInt(SharedPrefConstants.USER_ID, id);
  }

  static void setUsername1(String username) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(SharedPrefConstants.USERNAME1, username);
  }

  static void setUsername2(String username) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(SharedPrefConstants.USERNAME2, username);
  }

  static void clear() async{
    final prefs = await SharedPreferences.getInstance();
    prefs.clear();
  }
}
