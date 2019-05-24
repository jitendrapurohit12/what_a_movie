import 'package:flutter/material.dart';

class DialogHelper{
  static void showErrorDialog(BuildContext context, String message) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Something went wrong!'),
            content: Text(message),
            actions: <Widget>[
              FlatButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text(
                    'OK',
                    style: TextStyle(color: Colors.black),
                  ))
            ],
          );
        });
  }
}