import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hydrobox/pages/connect_page.dart';
import 'package:hydrobox/utils/color_asset.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class ScanQrCodePage extends StatefulWidget {
  const ScanQrCodePage({super.key});

  @override
  State<ScanQrCodePage> createState() => _ScanQrCodePageState();
}

class _ScanQrCodePageState extends State<ScanQrCodePage> {
  @override
  void dispose() {
    super.dispose();
    controller!.dispose();
  }

  // setup qr code
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  Barcode? result;
  QRViewController? controller;
  bool scanState = false;

  // scan qr code method
  void onQRViewCreated(QRViewController controller) {
    this.controller = controller;
    controller.scannedDataStream.listen((scanData) async {
      if (scanData.code!.contains("HydroBox")) {
        showDialog(
            context: context,
            builder: (context) => Center(
                child: CircularProgressIndicator(color: ColorsAsset.primary)));
        controller.pauseCamera();
        FlutterBluePlus.startScan();
        FlutterBluePlus.onScanResults.listen((devices) {
          if (devices.isNotEmpty) {
            ScanResult device = devices.last;
            if (device.advertisementData.advName.contains("HydroBox")) {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ConnectPage(
                            device: device.device,
                          )));
            }
          }
        });
      } else if (!scanData.code!.contains("HydroBox")) {
        controller.pauseCamera;
        showDialog(
            context: context,
            builder: (context) => AlertDialog(
                  title: Text("Error",
                      style: GoogleFonts.urbanist(
                          fontWeight: FontWeight.w900, color: ColorsAsset.red)),
                  content: Text("That's not HydroBox QR Code...",
                      style: GoogleFonts.urbanist(
                          fontWeight: FontWeight.w900,
                          color: ColorsAsset.dark)),
                  actions: [
                    TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text("OK",
                            style: GoogleFonts.urbanist(
                                fontWeight: FontWeight.w900,
                                color: ColorsAsset.primary)))
                  ],
                ));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        foregroundColor: Colors.white,
        backgroundColor: ColorsAsset.primary,
        title: Text("QR Code",
            style: GoogleFonts.urbanist(
                fontSize: 20, fontWeight: FontWeight.w900)),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // top
            Image.asset("assets/top4.png"),

            const SizedBox(height: 20),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Column(
                children: [
                  // scan instructions
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(15),
                    decoration: BoxDecoration(
                        color: ColorsAsset.gray,
                        borderRadius: BorderRadius.circular(12)),
                    child: Column(
                      children: [
                        // Scan QR Code
                        Text("Scan QR Code",
                            style: GoogleFonts.urbanist(
                                fontSize: 20,
                                fontWeight: FontWeight.w900,
                                color: ColorsAsset.dark)),

                        // instructions
                        Text(
                            "Scan QR Code on HydroBox’s \nScreen to connect to the HydroBox.",
                            textAlign: TextAlign.center,
                            style: GoogleFonts.urbanist(
                                fontSize: 16,
                                fontWeight: FontWeight.w900,
                                color: ColorsAsset.darkGray))
                      ],
                    ),
                  ),

                  const SizedBox(height: 10),

                  // scan camera
                  scanState == false
                      ? Container(
                          width: double.infinity,
                          height: 450,
                          decoration: BoxDecoration(
                              color: ColorsAsset.gray,
                              borderRadius: BorderRadius.circular(12)),
                          child: Expanded(
                            child: QRView(
                              key: qrKey,
                              onQRViewCreated: onQRViewCreated,
                            ),
                          ),
                        )
                      : Container(
                          width: double.infinity,
                          height: 450,
                          decoration: BoxDecoration(
                              color: ColorsAsset.darkGray,
                              borderRadius: BorderRadius.circular(12)),
                        ),

                  const SizedBox(height: 10),

                  // scan button

                  scanState == false
                      ? GestureDetector(
                          onTap: () {
                            controller!.pauseCamera();
                            setState(() {
                              scanState = true;
                            });
                          },
                          child: Container(
                            width: double.infinity,
                            height: 50,
                            decoration: BoxDecoration(
                                color: ColorsAsset.red,
                                borderRadius: BorderRadius.circular(50)),
                            child: Center(
                              child: Text("Stop Scan",
                                  style: GoogleFonts.urbanist(
                                      fontSize: 24,
                                      fontWeight: FontWeight.w900,
                                      color: Colors.white)),
                            ),
                          ),
                        )
                      : GestureDetector(
                          onTap: () {
                            setState(() {
                              scanState = false;
                            });
                            controller!.resumeCamera();
                          },
                          child: Container(
                            width: double.infinity,
                            height: 50,
                            decoration: BoxDecoration(
                                color: ColorsAsset.primary,
                                borderRadius: BorderRadius.circular(50)),
                            child: Center(
                              child: Text("Scan",
                                  style: GoogleFonts.urbanist(
                                      fontSize: 24,
                                      fontWeight: FontWeight.w900,
                                      color: Colors.white)),
                            ),
                          ),
                        )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
