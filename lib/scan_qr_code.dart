import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class ScanQrCode extends StatefulWidget {
  const ScanQrCode({super.key});

  @override
  State<ScanQrCode> createState() => _ScanQrCodeState();
}

class _ScanQrCodeState extends State<ScanQrCode> {
  String qrResult = "Scanned Data will appear here";
  String lastScanned = "";

  @override
  Widget build(BuildContext context) {
    double scanSize = MediaQuery.of(context).size.width * 0.75;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Scan QR Code"),
        backgroundColor: Colors.deepPurple,
      ),

      body: Column(
        children: [
          Expanded(
            flex: 3,
            child: Stack(
              children: [
                // 📷 QR SCANNER
                MobileScanner(
                  onDetect: (capture) {
                    final barcode = capture.barcodes.first;
                    final value = barcode.rawValue;

                    if (value == null || value.isEmpty) return;
                    if (value == lastScanned) return;

                    setState(() {
                      lastScanned = value;
                      qrResult = value;
                    });
                  },
                ),

                Center(
                  child: Container(
                    width: scanSize,
                    height: scanSize,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.deepPurple, width: 3),
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                ),
              ],
            ),
          ),

          Expanded(
            child: Center(
              child: Text(
                qrResult,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
