import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class AppWidget extends StatelessWidget {
  const AppWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'My Smart App',
      theme: ThemeData(
        useMaterial3: true,
        appBarTheme: const AppBarTheme(
          actionsIconTheme: IconThemeData(),
            backgroundColor: Colors.blueAccent,
            elevation: 1,
            titleTextStyle: TextStyle(
                color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),
            centerTitle: true),
        // Defina o tema personalizado para o TextField
        inputDecorationTheme: const InputDecorationTheme(
          border: OutlineInputBorder(),

          // Define o estilo do rótulo (label) do TextField
          labelStyle: TextStyle(
            color: Colors.blue,
          ),
          // Define o estilo do texto do TextField
          hintStyle: TextStyle(
            color: Colors.grey,
          ),
          // Define a cor da borda do TextField

          // Define a cor do foco da borda do TextField
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.blue,
              width: 2.0,
            ),
          ),
        ),
      ),
      routeInformationParser: Modular.routeInformationParser,
      routerDelegate: Modular.routerDelegate,
    ); //added by extension
  }
}
