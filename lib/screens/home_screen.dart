import 'package:flutter/material.dart';
import '../services/auth_service.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Inicio'),
        backgroundColor: Colors.blueAccent, // Color personalizado para el AppBar
        elevation: 4, // Añadir sombra al AppBar
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () async {
              await AuthService.logout();
              Navigator.pushReplacementNamed(context, '/');
            },
          ),
        ],
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0), // Añadir padding para un buen espaciado
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Imagen de bienvenida (puedes agregar una imagen si la tienes)
              const CircleAvatar(
                radius: 50,
                backgroundColor: Colors.blueAccent,
                child: Icon(
                  Icons.home,
                  size: 50,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 24), // Espacio después de la imagen de bienvenida

              // Título de bienvenida
              Text(
                'Bienvenido a la App',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.blueAccent, // Título en color de la app
                ),
              ),
              const SizedBox(height: 40), // Espacio entre el título y los botones

              // Botones estilizados
              ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/qr_scanner');
                },
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 32),
                  backgroundColor: Colors.blueAccent, // Usando backgroundColor en lugar de primary
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12), // Bordes redondeados
                  ),
                  elevation: 5, // Sombra para darle un efecto de profundidad
                ),
                child: const Text(
                  'Escanear',
                  style: TextStyle(fontSize: 18),
                ),
              ),
              const SizedBox(height: 16), // Espacio entre botones

              ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/car_list');
                },
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 32),
                  backgroundColor: Colors.blueAccent, // Usando backgroundColor en lugar de primary
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12), // Bordes redondeados
                  ),
                  elevation: 5, // Sombra para darle un efecto de profundidad
                ),
                child: const Text(
                  'Ver mis Carros',
                  style: TextStyle(fontSize: 18),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
