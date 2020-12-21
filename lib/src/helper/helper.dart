import 'package:flushbar/flushbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Helper {
  static bool haveEnoughPoints(BuildContext context, List objectPoints) {
    if (objectPoints == null ||
        objectPoints.isEmpty ||
        objectPoints.length <= 2) {
      showFlushbar(context, 'Please select some more points!');
      return false;
    }
    return true;
  }

  static void showFlushbar(BuildContext context, String message) {
    if (message == null) {
      return;
    }
    Flushbar(
      message: message,
      duration: Duration(seconds: 3),
    )..show(context);
  }

  static showAlertDialog(BuildContext context, String title, String message) {
    Widget okButton = FlatButton(
      child: Text("OK"),
      onPressed: () {
        Navigator.pop(context);
      },
    );

    AlertDialog alert = AlertDialog(
      title: Text(title ?? ''),
      content: Text(message ?? ''),
      actions: [
        okButton,
      ],
    );

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
