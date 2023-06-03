import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:maps/app/core/models/contact.dart';

class DetailContactPage extends StatefulWidget {
  final dynamic args;
  const DetailContactPage({super.key, required this.args});

  @override
  State<DetailContactPage> createState() => _DetailContactPageState();
}

class _DetailContactPageState extends State<DetailContactPage> {
  late Contact data;
  @override
  void initState() {
    data = widget.args['contact'];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        actions: const [
          Icon(
            Icons.upload,
            color: Colors.cyan,
          ),
          Icon(
            Icons.settings,
            color: Colors.cyan,
          ),
        ],
        leading: IconButton(
            onPressed: () => Modular.to.pop(),
            icon: Icon(
              Icons.arrow_back,
              color: Colors.indigo[800],
            )),
        title: Text(data.name),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleAvatar(
                  radius: 64,
                  child: Text(data.name[0].toUpperCase(),
                      style: const TextStyle(fontSize: 32)),
                ),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                '${data.latitude}',
                style: const TextStyle(
                  fontSize: 24,
                  color: Colors.black,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                '${data.longitude}',
                style: const TextStyle(
                  fontSize: 24,
                  color: Colors.black,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
