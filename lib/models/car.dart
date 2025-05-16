class Car {
  final String id;
  final String plate;
  final String driver;
  final String image;

  Car({
    required this.id,
    required this.plate,
    required this.driver,
    required this.image,
  });

  factory Car.fromJson(Map<String, dynamic> json) {
    return Car(
      id: json['id'],
      plate: json['placa'],
      driver: json['conductor'],
      image: json['imagen'],
    );
  }
}