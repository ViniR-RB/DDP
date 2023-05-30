// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class CardCategory extends StatelessWidget {
  final String title;
  final String subTitle;
  final IconData leading;
  void Function()? onTap;

  CardCategory(
      {super.key,
      required this.title,
      required this.subTitle,
      required this.leading,
      this.onTap});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Card(
          color: Colors.grey[400],
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(32))),
          child: ListTile(
            onTap: onTap,
            title: Text(
              title,
              style: const TextStyle(
                  fontSize: 24,
                  color: Colors.white,
                  fontWeight: FontWeight.bold),
            ),
            subtitle: Text(
              subTitle,
              style: TextStyle(
                  fontSize: 12,
                  color: Colors.indigo[600],
                  fontWeight: FontWeight.w400),
            ),
            leading: Icon(
              leading,
              color: Colors.white,
              size: 32,
            ),
            trailing: const Icon(Icons.arrow_forward_ios,
                color: Colors.white, size: 24),
          ),
        ),
      ),
    );
  }
}
