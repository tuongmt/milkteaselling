import 'package:flutter/material.dart';

class Routes {
  static Future<dynamic> pushAndRemoveUntil(
      {required widget, required BuildContext context}) {
    return Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (ctx) => widget), (route) => false);
  }

  static Future<dynamic> push(
      {required widget, required BuildContext context}) {
    return Navigator.of(context)
        .push(MaterialPageRoute(builder: (ctx) => widget));
  }
}
