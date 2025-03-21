import 'package:flutter/material.dart';
import 'package:app2023/screen/user_settings_screen.dart'; // Importando a tela de configurações

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Perfil do Viajante',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.cyan),
      ),
      home: UserSettingsScreen(),  // Aponta para a tela de configurações
    );
  }
}
