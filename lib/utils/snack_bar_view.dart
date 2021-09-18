import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

void showSnackBar(String text) {
  Fluttertoast.showToast(
      msg: text,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.grey,
      textColor: Colors.black,
      fontSize: 16.0
  );
}