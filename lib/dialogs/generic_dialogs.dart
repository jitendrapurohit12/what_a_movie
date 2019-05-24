import 'package:flutter/material.dart';
import 'package:what_a_movie/helper/method_helper.dart';
import 'package:what_a_movie/listener/bool_listener.dart';

class GenericDialogs {
  static void createNewUserDialog(
      BuildContext context, String content, BoolListener listener) {
    AlertDialog dialog = AlertDialog(
      title: Text('Error'),
      content: Text(content),
      actions: <Widget>[
        FlatButton(onPressed: () => listener.result(true), child: Text('Sure')),
        FlatButton(
          onPressed: () => listener.result(false),
          child: Text('No'),
        )
      ],
    );

    showDialog(context: context, builder: (context) => dialog);
  }

  static void errorDialog(BuildContext context, String content) {
    AlertDialog dialog = AlertDialog(
      title: Text('Error'),
      content: Text(content),
      actions: <Widget>[
        FlatButton(
          onPressed: () => Navigator.pop(context),
          child: Text('Okay'),
        )
      ],
    );

    showDialog(context: context, builder: (context) => dialog);
  }

  static invalidUserDialog(BuildContext context){
    AlertDialog dialog = AlertDialog(
      title: Text('Error'),
      content: Text('You have been deleted by the ADMIN.'),
      actions: <Widget>[
        FlatButton(
          onPressed: () {
            Navigator.pop(context);
            MethodHelper.logout(context);
          },
          child: Text('Okay'),
        )
      ],
    );

    showDialog(context: context, builder: (context) => dialog, barrierDismissible: false);
  }

  static logoutDialog(BuildContext context){
    AlertDialog dialog = AlertDialog(
      title: Text('Confirmation'),
      content: Text('Do you really want to Logout?'),
      actions: <Widget>[
        FlatButton(
          onPressed: () {
            Navigator.pop(context);
            MethodHelper.logout(context);
          },
          child: Text('Logout'),
        ),
        FlatButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text('Cancel'),
        )
      ],
    );

    showDialog(context: context, builder: (context) => dialog, barrierDismissible: false);
  }

  static void progressDialog(BuildContext context,
      {String message = 'Please Wait...'}) {
    Dialog dialog = Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
      child: Container(
          padding: EdgeInsets.fromLTRB(16, 36, 16, 36),
          child: Row(
            children: <Widget>[
              SizedBox(width: 24.0),
              CircularProgressIndicator(),
              SizedBox(width: 32.0),
              Text(
                message,
                style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w400),
              )
            ],
          )),
    );

    showDialog(context: context, builder: (context) => dialog);
  }
}
