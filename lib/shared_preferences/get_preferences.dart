import 'package:shared_preferences/shared_preferences.dart';
import 'package:what_a_movie/constants/constants.dart';

class GetPreferences{
  static Future<bool> getUserLoggedIn() async{
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(SharedPrefConstants.IS_USER_LOGGED_IN);
  }

  static Future<String> getUsername() async{
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(SharedPrefConstants.USERNAME);
  }

  static Future<String> getUsername1() async{
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(SharedPrefConstants.USERNAME1);
  }

  static Future<String> getUsername2() async{
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(SharedPrefConstants.USERNAME2);
  }

  static Future<int> getUserId() async{
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt(SharedPrefConstants.USER_ID);
  }
}