import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';

class PopUpMessage {
  flushbarmessage(
      BuildContext context, String message, String title) {
    return Flushbar(
      title: title,
      message: message,
      duration: const Duration(seconds: 3),
    )..show(context);
  }
}
