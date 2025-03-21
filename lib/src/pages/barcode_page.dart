import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:temp_noti/src/widgets/scanner/scanner_error.dart';
import 'package:temp_noti/src/widgets/scanner/scanner_label.dart';
import 'package:temp_noti/src/widgets/scanner/scanner_overlay.dart';

class BarcodePage extends StatefulWidget {
  const BarcodePage({super.key});

  @override
  State<BarcodePage> createState() => _BarcodePageState();
}

class _BarcodePageState extends State<BarcodePage> {
  final MobileScannerController barcodeController = MobileScannerController(formats: [BarcodeFormat.qrCode]);

  @override
  void dispose() {
    super.dispose();
    barcodeController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    void onBarcodeScanned(BarcodeCapture barcode) {
      barcodeController.dispose();
      List<Barcode> qr = barcode.barcodes;
      Navigator.pop<String?>(context, qr.first.displayValue);
    }

    final scanwindow = Rect.fromCenter(
      center: MediaQuery.sizeOf(context).center(Offset.zero),
      width: 200,
      height: 200,
    );
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Center(
            child: MobileScanner(
              fit: BoxFit.cover,
              controller: barcodeController,
              scanWindow: scanwindow,
              errorBuilder: (context, error, child) => ScannerErrorWidget(error: error),
              onDetect: onBarcodeScanned,
              overlayBuilder: (context, constraints) => Padding(
                padding: const EdgeInsets.all(16),
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: ScannedBarcodeLabel(barcodes: barcodeController.barcodes),
                ),
              ),
            ),
          ),
          ValueListenableBuilder(
            valueListenable: barcodeController,
            builder: (context, value, child) {
              if (!value.isInitialized || !value.isRunning || value.error != null) const SizedBox();
              return CustomPaint(painter: ScannerOverlay(scanWindow: scanwindow));
            },
          ),
          Container(
            padding: const EdgeInsets.all(15.0),
            alignment: Alignment.topLeft,
            child: SafeArea(
              child: TextButton.icon(
                icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white, size: 30),
                onPressed: () => Navigator.pop<String>(context, null),
                label: const Text("BACK", style: TextStyle(color: Colors.white, fontSize: 20)),
                style: TextButton.styleFrom(padding: const EdgeInsets.all(5)),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
