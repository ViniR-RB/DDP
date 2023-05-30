// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class CardContact extends StatelessWidget {
  final String title;
  void Function()? onTap;

  CardContact({super.key, required this.title, this.onTap});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Card(
          shadowColor: const Color.fromRGBO(0, 0, 0, 0),
          surfaceTintColor: const Color.fromRGBO(0, 0, 0, 0),
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(32))),
          child: ListTile(
            onTap: onTap,
            title: Text(
              title,
              style: const TextStyle(
                  fontSize: 14,
                  color: Colors.black,
                  fontWeight: FontWeight.w500),
            ),
            leading: CircleAvatar(
              radius: 18,
              backgroundColor: Colors.green,
              child: Text('A'.toUpperCase(),
                  style: const TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                      fontWeight: FontWeight.w500)),
            ),
          ),
        ),
      ),
    );
  }
}
