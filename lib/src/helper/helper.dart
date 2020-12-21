import 'package:flushbar/flushbar.dart';
import 'package:flutter/cupertino.dart';

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
}
