import 'package:flutter/material.dart';

class GradientContainer extends StatelessWidget{ // En una función, siempre se debe poner la clase y luego el tipo de objeto
  
  const GradientContainer({super.key});
  
  @override
  Widget build(context) {
    return Container( // Return es lo que la función regresa
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.black, Colors.white],
            ),
          ),
        );
  }
}