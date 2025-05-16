import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String labelText;
  final bool isPassword;

  const CustomTextField({
    super.key,
    required this.controller,
    required this.labelText,
    this.isPassword = false,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: isPassword,
      decoration: InputDecoration(
        labelText: labelText,
        labelStyle: TextStyle(
          color: Colors.blueAccent, // Estilo del texto de la etiqueta
          fontWeight: FontWeight.bold,
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.blueAccent, // Color del borde
            width: 2.0,
          ),
          borderRadius: BorderRadius.circular(12), // Bordes redondeados
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.blueAccent, // Color del borde al estar enfocado
            width: 2.5,
          ),
          borderRadius: BorderRadius.circular(12), // Bordes redondeados
        ),
        hintStyle: TextStyle(color: Colors.black38), // Estilo del texto en hint
      ),
      validator: (value) => value!.isEmpty ? "Ingrese $labelText" : null,
    );
  }
}
