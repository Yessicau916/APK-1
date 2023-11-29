
import 'package:consumir_api_2/appTheme/appTheme.dart';
import 'package:consumir_api_2/login.dart';
import 'package:flutter/material.dart';
// import 'package:formulario/login.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      
      debugShowCheckedModeBanner: false,
      title: 'Login App',
      theme: AppBarTheme1.theme1,
      home: const Login(),
      
    );
  }
}
