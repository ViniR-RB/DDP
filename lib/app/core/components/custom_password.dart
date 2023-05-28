// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class CustomInputPassword extends StatefulWidget {
  final TextEditingController controller;
  final TextInputType keyboardType;
  final String labelText;
  Widget? prefixIcon;
  bool obscureText = true;
  CustomInputPassword({
    Key? key,
    required this.controller,
    required this.keyboardType,
    required this.labelText,
    this.prefixIcon,
  }) : super(key: key);

  @override
  State<CustomInputPassword> createState() => _CustomInputPasswordState();
}

class _CustomInputPasswordState extends State<CustomInputPassword> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
        controller: widget.controller,
        keyboardType: widget.keyboardType,
        decoration: InputDecoration(
            labelText: widget.labelText,
            suffixIcon: IconButton(
                onPressed: () {
                  setState(() {
                    widget.obscureText = !widget.obscureText;
                  });
                },
                icon: widget.obscureText == true
                    ? const Icon(Icons.remove_red_eye)
                    : const Icon(Icons.remove_red_eye_outlined)),
            prefixIcon: widget.prefixIcon),
        obscureText: widget.obscureText,
      ),
    );
  }
}
