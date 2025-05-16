import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/car.dart';

class ApiService {
  final String baseUrl = 'https://67f7d1812466325443eadd17.mockapi.io/carros';

  Future<List<Car>> getCars() async {
    try {
      final response = await http.get(Uri.parse(baseUrl));
      if (response.statusCode == 200) {
        List data = json.decode(response.body);
        return data.map((e) => Car.fromJson(e)).toList();
      } else {
        throw Exception('Error al obtener carros: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error al conectar con el servidor: $e');
    }
  }

  Future<Car> getCarByQR(String qrCode) async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/$qrCode'));
      if (response.statusCode == 200) {
        return Car.fromJson(json.decode(response.body));
      } else {
        throw Exception('Carro no encontrado: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error al conectar con el servidor: $e');
    }
  }
}