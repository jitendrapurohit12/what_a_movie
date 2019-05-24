import 'package:flutter/material.dart';
import 'package:what_a_movie/constants/constants.dart';
import 'package:what_a_movie/helper/db_helper/db_calls.dart';
import 'package:what_a_movie/helper/method_helper.dart';
import 'package:what_a_movie/helper/ui_helper.dart';
import 'package:what_a_movie/navigation/navigation.dart';
import 'package:what_a_movie/shared_preferences/set_preferences.dart';

import 'generic_dialogs.dart';

class SwitchUserDialog extends StatefulWidget {
  @override
  _SwitchUserDialogState createState() => _SwitchUserDialogState();
}

class _SwitchUserDialogState extends State<SwitchUserDialog> {

  TextEditingController _controller;

  @override
  void initState() {
    super.initState();

    _controller = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
      child: Container(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text(
              'Switch User',
              style: TextStyle(color: Colors.teal, fontSize: 20.0),
            ),
            SizedBox(height: 16.0),
            Text(
              'Please enter username. Don\'t worry we will save this usename for future switches.',
              style: TextStyle(fontWeight: FontWeight.w500),
            ),
            SizedBox(height: 16.0),
            UIHelper.getTextField(
                context, Labels.USERNAME, _controller, null, 20),
            SizedBox(height: 36.0),
            Row(
              children: <Widget>[
                Expanded(child: RaisedButton(onPressed: () => switchUser(),color: Colors.blueAccent, child: Text('Switch', style: TextStyle(color: Colors.white)))),
                SizedBox(width: 16),
                Expanded(child: RaisedButton(onPressed: () => Navigator.pop(context),color: Colors.red ,child: Text('Cancel',style: TextStyle(color: Colors.white),),)),
              ],
            )
          ],
        ),
      ),
    );
  }

  switchUser() {
    GenericDialogs.progressDialog(context);
    DBCalls.signIn(_controller.text.trim()).then((user) {
      if (user != null) {
        SetPreferences.setUserName(user.username);
        SetPreferences.setUserId(user.id);
        SetPreferences.setUserLoggedIn(true);
        SetPreferences.setUsername2(user.username);
        Navigator.pop(context);
        Navigation.homeAndClearBackStack(context);
      }else{
        Navigator.pop(context);
        GenericDialogs.errorDialog(context, 'No user found with this username!');
      }
    }).catchError((error) async {
      Navigator.pop(context);
      GenericDialogs.errorDialog(context, error.toString());
    });
  }
}
