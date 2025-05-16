import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;

  const CustomButton({super.key, required this.text, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        // Aquí puedes definir el color del fondo directamente
        backgroundColor: Colors.blueAccent,  // Color de fondo
        foregroundColor: Colors.white,        // Color del texto
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30), // Bordes redondeados
        ),
        elevation: 5, // Sombra para darle un efecto de profundidad
      ),
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 18, // Tamaño de texto
          fontWeight: FontWeight.bold, // Negrita
        ),
      ),
    );
  }
}
