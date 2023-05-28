import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:maps/app/app_widget.dart';

import 'app/app_module.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  return runApp(ModularApp(module: AppModule(), child: const AppWidget()));
}
