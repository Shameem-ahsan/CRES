import 'package:flutter/material.dart';

class Alert {
  static void showSimpleAlert(BuildContext context, {String title, String message, String buttonTitle, VoidCallback onPressed}) {
    showDialog(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext context) {
          return new AlertDialog(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10.0))),
            title: Text(title),
            content:  Text(message),
            actions: <Widget>[
              new TextButton(
                child:  Text(buttonTitle),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        });
  }
}