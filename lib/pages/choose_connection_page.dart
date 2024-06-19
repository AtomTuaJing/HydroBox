import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hydrobox/pages/bluetooth_scanning_page.dart';
import 'package:hydrobox/pages/scan_qr_code_page.dart';
import 'package:hydrobox/utils/color_asset.dart';

class ChooseConnectionPage extends StatelessWidget {
  const ChooseConnectionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        foregroundColor: Colors.white,
        backgroundColor: ColorsAsset.primary,
        title: Text("Device",
            style: GoogleFonts.urbanist(
                fontSize: 20, fontWeight: FontWeight.w900)),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // top
          Image.asset("assets/top2.png"),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // connect via
                SizedBox(
                  width: double.infinity,
                  child: Text("Connect Via",
                      style: GoogleFonts.urbanist(
                          fontSize: 32,
                          fontWeight: FontWeight.w900,
                          color: ColorsAsset.primary)),
                ),

                const SizedBox(height: 25),

                // bluetooth button
                GestureDetector(
                  onTap: () {
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                const BluetoothScanningPage()));
                  },
                  child: Container(
                    width: 266,
                    height: 226,
                    decoration: BoxDecoration(
                        color: ColorsAsset.primary,
                        borderRadius: BorderRadius.circular(12)),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // icon
                        const Icon(Icons.bluetooth,
                            size: 100, color: Colors.white),

                        // bluetooth
                        Text("Bluetooth",
                            style: GoogleFonts.urbanist(
                                fontSize: 24,
                                fontWeight: FontWeight.w900,
                                color: Colors.white))
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 25),

                // qr code button
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const ScanQrCodePage()));
                  },
                  child: Container(
                    width: 266,
                    height: 226,
                    decoration: BoxDecoration(
                        color: ColorsAsset.primary,
                        borderRadius: BorderRadius.circular(12)),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // icon
                        const Icon(Icons.qr_code_2,
                            size: 100, color: Colors.white),

                        // bluetooth
                        Text("QR Code",
                            style: GoogleFonts.urbanist(
                                fontSize: 24,
                                fontWeight: FontWeight.w900,
                                color: Colors.white))
                      ],
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
