import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:maps/app/modules/auth/auth_controller.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  final _controller = Modular.get<AuthController>();
  @override
  void initState() {
    _controller.checkeToken();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
          child: Text(
        'Hello Maps',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 32),
      )),
    );
  }
}
