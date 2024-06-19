import 'dart:io';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hydrobox/pages/connect_page.dart';
import 'package:hydrobox/utils/color_asset.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';

class BluetoothScanningPage extends StatefulWidget {
  const BluetoothScanningPage({super.key});

  @override
  State<BluetoothScanningPage> createState() => _BluetoothScanningPageState();
}

class _BluetoothScanningPageState extends State<BluetoothScanningPage> {
  @override
  void initState() {
    super.initState();
    if (Platform.isAndroid) {
      FlutterBluePlus.turnOn();
    }
    FlutterBluePlus.adapterState.listen((BluetoothAdapterState state) {
      if (state == BluetoothAdapterState.on) {
        FlutterBluePlus.startScan();
        FlutterBluePlus.onScanResults.listen((devices) {
          if (devices.isNotEmpty) {
            ScanResult device = devices.last;
            if (device.advertisementData.advName.contains("HydroBox")) {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          ConnectPage(device: device.device)));
            }
          }
        });
      } else {
        showDialog(
            context: context,
            builder: (context) => AlertDialog(
                  title: Text("Error",
                      style: GoogleFonts.urbanist(
                          fontWeight: FontWeight.w900, color: ColorsAsset.red)),
                  content: Text("Please Enable Bluetooth",
                      style: GoogleFonts.urbanist(
                          fontWeight: FontWeight.w900,
                          color: ColorsAsset.dark)),
                  actions: [
                    TextButton(
                        onPressed: () {
                          if (mounted) Navigator.pop(context);
                          if (mounted) Navigator.pop(context);
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
        title: Text("Bluetooth",
            style: GoogleFonts.urbanist(
              fontSize: 20,
              fontWeight: FontWeight.w900,
            )),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // top
          Image.asset("assets/top2.png"),

          const SizedBox(height: 15),

          // scanning image
          Image.asset("assets/scanning.png", width: 250),

          const SizedBox(height: 15),

          // Scanning for Device...
          Text("Scanning for Device...",
              style: GoogleFonts.urbanist(
                  fontSize: 24,
                  fontWeight: FontWeight.w900,
                  color: ColorsAsset.primary))
        ],
      ),
    );
  }
}
