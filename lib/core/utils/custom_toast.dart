import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class CustomToast {
  static showSimpleToast(
      {required String msg, Color? color, Color? textColor}) {
    Fluttertoast.showToast(
      msg: msg,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: color ?? Colors.green,
      textColor: textColor ?? Colors.white,
      fontSize: 16.0,
    );
  }
}
