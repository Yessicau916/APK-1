// ignore: depend_on_referenced_packages
import 'package:flutter/material.dart';
class AppBarTheme1 {
  static final theme1 = ThemeData.dark().copyWith(
        appBarTheme: const AppBarTheme(
          color:  Color.fromRGBO(100, 0, 0, 0.392),
          elevation: 10,
          foregroundColor: Color.fromARGB(255, 0, 0, 0),
          titleTextStyle: TextStyle(fontSize: 30),  
        ),
        textTheme: const TextTheme(bodyMedium:TextStyle(
          color: Color.fromARGB(255, 100, 0, 0)),
        ),
        

      );

  static final theme2 = ThemeData.light().copyWith(
        appBarTheme: const AppBarTheme(
          color:  Color.fromARGB(255, 100, 0, 0),
          elevation: 10,
          foregroundColor: Color.fromARGB(255, 255, 255, 255),
          titleTextStyle: TextStyle(fontSize: 30)
        ),
        textTheme: const TextTheme(bodyMedium:TextStyle(
          color: Color.fromARGB(255, 100, 0, 0))
        ),

      );
      
  
}