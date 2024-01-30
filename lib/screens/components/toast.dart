import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ToastShow {
  final String msg;

  ToastShow({required this.msg});

  void showToast(BuildContext context) {
    print('Showing toast');
    Fluttertoast.showToast(
      msg: msg,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.black,
      textColor: Colors.white,
      fontSize: 16.0,
    );
  }
}
