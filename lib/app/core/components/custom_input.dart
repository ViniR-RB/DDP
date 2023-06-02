// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class CustomInput extends StatelessWidget {
  final TextEditingController controller;
  final TextInputType keyboardType;
  final String labelText;
  Widget? prefixIcon;
  void Function(String)? onChanged;

  CustomInput({
    Key? key,
    required this.controller,
    required this.keyboardType,
    required this.labelText,
    this.prefixIcon,
    this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
        controller: controller,
        keyboardType: keyboardType,
        onChanged: onChanged,
        decoration:
            InputDecoration(labelText: labelText, prefixIcon: prefixIcon),
      ),
    );
  }
}
