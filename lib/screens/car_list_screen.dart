import 'package:flutter/material.dart';
import '../services/api_service.dart';
import '../models/car.dart';

class CarListScreen extends StatefulWidget {
  const CarListScreen({super.key});

  @override
  State<CarListScreen> createState() => _CarListScreenState();
}

class _CarListScreenState extends State<CarListScreen> {
  late Future<List<Car>> _carsFuture;

  @override
  void initState() {
    super.initState();
    _carsFuture = ApiService().getCars();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mis Carros'),
        backgroundColor: Colors.blueAccent, // Color personalizado del AppBar
        elevation: 4, // Añadimos una pequeña sombra al AppBar
      ),
      body: FutureBuilder<List<Car>>(
        future: _carsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No hay carros disponibles'));
          }

          final cars = snapshot.data!;
          return ListView.builder(
            itemCount: cars.length,
            itemBuilder: (context, index) {
              final car = cars[index];
              return Card(
                margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16), // Bordes redondeados
                ),
                elevation: 5, // Sombra suave para las tarjetas
                child: ListTile(
                  contentPadding: const EdgeInsets.all(16), // Añadir relleno interno
                  leading: ClipRRect(
                    borderRadius: BorderRadius.circular(12), // Bordes redondeados para la imagen
                    child: SizedBox(
                      width: 50,
                      height: 50,
                      child: car.image.isNotEmpty
                          ? Image.network(
                              car.image,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) {
                                return const Icon(
                                  Icons.directions_car,
                                  size: 30,
                                  color: Colors.grey,
                                );
                              },
                            )
                          : const Icon(
                              Icons.directions_car,
                              size: 30,
                              color: Colors.grey,
                            ),
                    ),
                  ),
                  title: Text(
                    'Placa: ${car.plate}',
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  subtitle: Text(
                    'Conductor: ${car.driver}',
                    style: const TextStyle(fontSize: 16, color: Colors.black54),
                  ),
                  trailing: IconButton(
                    icon: const Icon(Icons.arrow_forward_ios),
                    onPressed: () {
                      // Aquí puedes añadir la navegación a la pantalla de detalle
                      Navigator.pushNamed(
                        context,
                        '/carDetail',
                        arguments: car,
                      );
                    },
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
