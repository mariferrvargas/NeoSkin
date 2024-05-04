import 'package:flutter/material.dart';
import 'package:my_app_23abril/gradient_color.dart';

// EJEMPLO
//void main() {
//  runApp(const MaterialApp( // googlear MaterialApp Flutter para conocer los recursos que se tienen
//    home: Scaffold( // home es la base
//      body: Center(child: Text('hola')), // body es la estructura básica
//    ),
//  ));
//}

void main() {
  runApp(
    const MaterialApp(
      home: Scaffold(
        body: GradientContainer(), // Se llama a la función GradientContainer
      ),
    ),
  );
}
