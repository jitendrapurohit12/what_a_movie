import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:what_a_movie/dialogs/generic_dialogs.dart';
import 'package:what_a_movie/helper/db_helper/db_calls.dart';
import 'package:what_a_movie/model/user.dart';
import 'package:what_a_movie/navigation/navigation.dart';
import 'package:what_a_movie/shared_preferences/get_preferences.dart';
import 'package:what_a_movie/shared_preferences/set_preferences.dart';

class MethodHelper {
  static Future<bool> isInternetAvailable(BuildContext context) async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.wifi)
      return true;
    else {
      GenericDialogs.errorDialog(
          context, 'Please check your internet connection and try again.');
      return false;
    }
  }

  static Future<bool> isUserValid(BuildContext context) async {
    String username = await GetPreferences.getUsername();
    User user = await DBCalls.signIn(username);
    if (user == null) {
      GenericDialogs.invalidUserDialog(context);
    }
    return user != null;
  }

  static logout(BuildContext context) {
    SetPreferences.clear();
    Navigation.signInAndClearBackStack(context);
  }
}
