import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:maps/app/core/components/custom_password.dart';

import '../../../core/components/custom_button.dart';
import '../../../core/components/custom_input.dart';
import '../auth_controller.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _controller = Modular.get<AuthController>();

  final TextEditingController _emailController = TextEditingController();

  final TextEditingController _passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: LayoutBuilder(
        builder: (p0, size) {
          return SizedBox(
            width: size.maxWidth,
            height: size.maxHeight,
            child: Center(
              child: SingleChildScrollView(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      CustomInput(
                        labelText: 'Email',
                        controller: _emailController,
                        keyboardType: TextInputType.emailAddress,
                        prefixIcon: const Icon(Icons.email),
                      ),
                      CustomInputPassword(
                        labelText: 'Password',
                        controller: _passwordController,
                        keyboardType: TextInputType.visiblePassword,
                        prefixIcon: const Icon(Icons.password),
                      ),
                      TextButton(
                        child: const Text('Não possui uma conta?'),
                        onPressed: () => Modular.to.pushNamed('/signup'),
                      ),
                      CustomButton(
                        onPressed: () async {
                          await _controller.logIn(_emailController.text,
                              _passwordController.text, context);
                        },
                        label: 'Log-In',
                      ),
                    ]),
              ),
            ),
          );
        },
      ),
    );
  }
}
