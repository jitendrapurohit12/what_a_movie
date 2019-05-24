import 'package:flutter/material.dart';

class UIHelper {
  static Widget circularProgress() {
    return CircularProgressIndicator(
      backgroundColor: Colors.black,
      strokeWidth: 2.0,
    );
  }

  static Widget logInButton(Widget child, Color background) {
    return Container(
        width: 250.0,
        height: 50.0,
        alignment: FractionalOffset.center,
        decoration: BoxDecoration(
          color: background,
          borderRadius: BorderRadius.all(const Radius.circular(25.0)),
        ),
        child: child);
  }

  static Widget buttonText(String text, Color textColor) {
    return Text(
      text,
      style: new TextStyle(
        color: textColor,
        fontSize: 20.0,
        fontWeight: FontWeight.w300,
        letterSpacing: 0.3,
      ),
    );
  }

  static getTextField(
      BuildContext context,
      String label,
      TextEditingController controller,
      TextInputType inputType,
      int maxLength) {
    return TextField(
      autofocus: false,
      maxLength: maxLength,
      controller: controller,
      keyboardType: inputType,
      decoration: InputDecoration(
          labelText: label,
          contentPadding: EdgeInsets.fromLTRB(30.0, 15.0, 30.0, 15.0),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(8.0))),
    );
  }

  static Widget columnWithIconAndText(IconData icon, String text, Color color) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Icon(icon, color: color),
          SizedBox(
            height: 4.0,
          ),
          Text(
            text,
            style: TextStyle(color: color),
          )
        ],
      ),
    );
  }

  static getImageErrorUI() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Icon(
            Icons.error_outline,
            size: 36,
          ),
          SizedBox(height: 16.0),
          Text(
            'OOPS!',
            style: TextStyle(fontWeight: FontWeight.w500, letterSpacing: 2),
          )
        ],
      ),
    );
  }

  static richText(String grayText, String blackText) {
    return RichText(
        text: TextSpan(children: [
      TextSpan(
          text: '$grayText : ',
          style: TextStyle(
              color: Colors.grey, fontWeight: FontWeight.w500, fontSize: 16.0)),
      TextSpan(
          text: '$blackText',
          style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 16.0,
              color: Colors.black87))
    ]));
  }

  static getMovieDescriptionColumn(String type, String content) {
    return content != null
        ? Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              richText(type, content),
              SizedBox(height: 4.0),
            ],
          )
        : Container();
  }
}
