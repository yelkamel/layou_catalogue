import 'package:flutter/material.dart';
import 'package:flushbar/flushbar.dart';

class Info {
  static void showInfoFlushBar(BuildContext context, String msg) {
    Flushbar(
      title: "Attention 😡",
      message: msg,
    )..show(context);
  }
}
