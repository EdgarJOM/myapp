import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import '../services/api_service.dart';

class QRScannerScreen extends StatefulWidget {
  const QRScannerScreen({super.key});

  @override
  State<QRScannerScreen> createState() => _QRScannerScreenState();
}

class _QRScannerScreenState extends State<QRScannerScreen> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  QRViewController? controller;

  void _onQRViewCreated(QRViewController controller) {
    this.controller = controller;
    controller.scannedDataStream.listen((scanData) async {
      controller.pauseCamera(); // Pausar la cámara al escanear un código
      try {
        final car = await ApiService().getCarByQR(scanData.code!);
        if (!mounted) return;

        // Mostrar el diálogo
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            titlePadding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
            title: Text(
              '¿Desea tomar el Carro ${car.plate}?',
              style: const TextStyle(fontSize: 16),
            ),
            actionsPadding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            actions: [
              // Botón 'No'
              TextButton(
                style: TextButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  minimumSize: const Size(60, 36),
                ),
                onPressed: () {
                  Navigator.pop(context);
                  controller.resumeCamera(); // Reanudar cámara
                },
                child: const Text('No', style: TextStyle(fontSize: 14)),
              ),
              // Botón 'Sí'
              TextButton(
                style: TextButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  minimumSize: const Size(60, 36),
                ),
                onPressed: () {
                  Navigator.pop(context);
                  Navigator.pushNamed(
                    context,
                    '/car_detail',
                    arguments: car,
                  );
                },
                child: const Text('Sí', style: TextStyle(fontSize: 14)),
              ),
            ],
          ),
        );
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: $e')),
        );
        controller.resumeCamera(); // Reanudar cámara en caso de error
      }
    });
  }

  @override
  void dispose() {
    controller?.dispose(); // Liberar recursos del controlador
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Escanear QR'),
        backgroundColor: Colors.blueAccent, // Color personalizado para el AppBar
        elevation: 0, // Sin sombra
      ),
      body: Stack(
        children: [
          QRView(
            key: qrKey,
            onQRViewCreated: _onQRViewCreated,
            overlay: QrScannerOverlayShape(
              borderColor: Colors.blueAccent, // Color del borde del escáner
              borderRadius: 10,
              borderLength: 30,
              borderWidth: 8,
              cutOutSize: MediaQuery.of(context).size.width * 0.8, // Tamaño de la zona de escaneo
            ),
          ),
          Positioned(
            top: 50,
            left: 0,
            right: 0,
            child: Center(
              child: Text(
                'Apunte al código QR',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  shadows: [
                    Shadow(offset: Offset(0, 2), blurRadius: 6, color: Colors.black.withOpacity(0.6)),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
