import 'package:flutter/material.dart';

abstract class CustomSnackBar {
  static showSnackBar(BuildContext context, content) async {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(content),
    ));
  }
}
