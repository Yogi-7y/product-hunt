import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../resources/colors.dart';

enum MessageType {
  info,
  error,
}

abstract class ShowMessage {
  static void showSnacBar(BuildContext context, String message,
      [MessageType messageType = MessageType.info]) {
    final backgroundColor =
        messageType == MessageType.info ? kMattBlackColor : kRedColor;

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: const TextStyle(
            fontSize: 16.0,
            color: kWhiteColor,
            fontWeight: FontWeight.w500,
          ),
        ),
        backgroundColor: backgroundColor,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }
}
