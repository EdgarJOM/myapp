import 'package:flutter/material.dart';
import '../models/car.dart';

class CarDetailScreen extends StatelessWidget {
  const CarDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final Car car = ModalRoute.of(context)!.settings.arguments as Car;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Detalles del Carro'),
        backgroundColor: Colors.blueAccent, // Color de fondo del AppBar
        elevation: 4, // Sombra suave
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView( // Hacemos la pantalla desplazable
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Placa
              Text(
                'Placa: ${car.plate}',
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold, // Negrita
                  color: Colors.blueAccent, // Color destacado para la placa
                ),
              ),
              const SizedBox(height: 8),
              
              // Conductor
              Text(
                'Conductor: ${car.driver}',
                style: const TextStyle(
                  fontSize: 20,
                  color: Colors.black87, // Color normal para el conductor
                ),
              ),
              const SizedBox(height: 16),
              
              // Imagen del carro
              ClipRRect(
                borderRadius: BorderRadius.circular(16), // Bordes redondeados para la imagen
                child: Image.network(
                  car.image,
                  height: 200,
                  width: double.infinity,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return const Center(
                      child: Text(
                        'Error al cargar la imagen',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 16, color: Colors.red),
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 16),
              
              // Detalles adicionales (si los tuvieses)
              // Aquí podrías agregar más información si es necesario
            ],
          ),
        ),
      ),
    );
  }
}
