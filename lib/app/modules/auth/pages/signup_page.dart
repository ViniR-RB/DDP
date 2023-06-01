import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:maps/app/modules/auth/auth_controller.dart';

import '../../../core/components/custom_input.dart';
import '../../../core/components/custom_password.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _controller = Modular.get<AuthController>();
  final TextEditingController _nameController = TextEditingController();

  final TextEditingController _emailController = TextEditingController();

  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('SignUp'),
      ),
      body: LayoutBuilder(
        builder: (p0, size) {
          return SizedBox(
            width: size.maxWidth,
            height: size.maxHeight,
            child: SingleChildScrollView(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    CustomInput(
                      labelText: 'Email',
                      controller: _emailController,
                      keyboardType: TextInputType.emailAddress,
                      prefixIcon: const Icon(Icons.email),
                    ),
                    CustomInput(
                      labelText: 'Nome',
                      controller: _nameController,
                      keyboardType: TextInputType.name,
                      prefixIcon: const Icon(Icons.people),
                    ),
                    CustomInputPassword(
                      labelText: 'Password',
                      controller: _passwordController,
                      keyboardType: TextInputType.emailAddress,
                      prefixIcon: const Icon(Icons.password),
                    ),
                    TextButton(
                      child: const Text('Voltar para o Login?'),
                      onPressed: () => Modular.to.navigate('/login'),
                    ),
                    ElevatedButton(
                      onPressed: () async {
                        await _controller.signUp(
                            _nameController.text,
                            _emailController.text,
                            _passwordController.text,
                            context);
                      },
                      child: const Text('SignUp'),
                    ),
                  ]),
            ),
          );
        },
      ),
    );
  }
}
