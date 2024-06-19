import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hydrobox/services/ble_provider.dart';
import 'package:hydrobox/services/plant_provider.dart';
import 'package:hydrobox/utils/color_asset.dart';
import 'package:provider/provider.dart';

class ConnectPage extends StatefulWidget {
  final BluetoothDevice device;
  const ConnectPage({super.key, required this.device});

  @override
  State<ConnectPage> createState() => _ConnectPageState();
}

class _ConnectPageState extends State<ConnectPage> {
  final currentUser = FirebaseAuth.instance.currentUser;

  Map<String, dynamic> BleContainerBlueprint = {
    "write": null,
    "notify1": null,
    "notify2": null,
    "notify3": null
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        foregroundColor: Colors.white,
        backgroundColor: ColorsAsset.primary,
        title: Text("Device",
            style: GoogleFonts.urbanist(
              fontSize: 20,
              fontWeight: FontWeight.w900,
            )),
      ),
      body: Column(
        children: [
          // top
          Image.asset("assets/top2.png"),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Column(
              children: [
                const SizedBox(height: 20),
                // would you like to connect text
                Text(
                    "Would you like to connect HydroBox with your current account?",
                    style: GoogleFonts.urbanist(
                        fontSize: 19,
                        fontWeight: FontWeight.w900,
                        color: ColorsAsset.darkGray)),

                const SizedBox(height: 10),

                // connect graphic
                Container(
                  width: 324,
                  height: 194,
                  decoration: BoxDecoration(
                      color: ColorsAsset.gray,
                      borderRadius: BorderRadius.circular(12)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      // HydroBox graphic
                      SizedBox(
                        width: 120,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            // graphic
                            Image.asset("assets/hydrobox.png",
                                width: 115, height: 98),

                            // HydroBox
                            SizedBox(
                              width: 115,
                              height: 20,
                              child: Text("HydroBox",
                                  textAlign: TextAlign.center,
                                  style: GoogleFonts.urbanist(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w900)),
                            )
                          ],
                        ),
                      ),

                      Icon(Icons.link, size: 30, color: ColorsAsset.primary),

                      // account graphic
                      SizedBox(
                        width: 120,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            // graphic
                            const Icon(Icons.account_circle_outlined, size: 90),

                            const SizedBox(height: 10),

                            // username
                            SizedBox(
                              width: 115,
                              height: 20,
                              child: Text(currentUser!.email!.split("@")[0],
                                  textAlign: TextAlign.center,
                                  style: GoogleFonts.urbanist(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w900)),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),

                const SizedBox(height: 240),

                // connect button
                GestureDetector(
                  onTap: () async {
                    showDialog(
                        context: context,
                        builder: (context) => Center(
                            child: CircularProgressIndicator(
                                color: ColorsAsset.primary)));
                    try {
                      final HydroBox = widget.device;

                      await HydroBox.connect();

                      var services = await HydroBox.discoverServices();

                      for (var service in services) {
                        if (service.serviceUuid.toString().length > 4) {
                          var characteristics = service.characteristics;

                          for (var characteristic in characteristics) {
                            List<BluetoothDescriptor> unFormattedDescriptors =
                                characteristic.descriptors;

                            String? descriptor;

                            for (var d in unFormattedDescriptors) {
                              var descriptorText = await d.read();

                              descriptor = utf8.decode(descriptorText);
                            }

                            if (descriptor!.contains("Write")) {
                              BleContainerBlueprint["write"] = characteristic;
                            }
                            if (descriptor.contains("Notify1")) {
                              BleContainerBlueprint["notify1"] = characteristic;
                            }
                            if (descriptor.contains("Notify2")) {
                              BleContainerBlueprint["notify2"] = characteristic;
                            }
                            if (descriptor.contains("Notify3")) {
                              BleContainerBlueprint["notify3"] = characteristic;
                            }
                          }
                        }
                      }

                      // write characteristic
                      context.read<BLEProvider>().changeWriteCharacteristic(
                          BleContainerBlueprint["write"]);

                      // notify1 characteristic
                      context.read<BLEProvider>().changeNotify1Characteristic(
                          BleContainerBlueprint["notify1"]);

                      // notify2 characteristic
                      context.read<BLEProvider>().changeNotify2Characteristic(
                          BleContainerBlueprint["notify2"]);

                      // notify3 characteristic
                      context.read<BLEProvider>().changeNotify3Characteristic(
                          BleContainerBlueprint["notify3"]);

                      // bluetooth device
                      context.read<BLEProvider>().changeDevice(HydroBox);

                      await context
                          .read<BLEProvider>()
                          .writeCharacteristic!
                          .write(utf8.encode(
                              context.read<PlantProvider>().selectedPlant!));

                      Navigator.pop(context);
                      Navigator.pop(context);
                      Navigator.pop(context);
                      Navigator.pop(context);
                      Navigator.pop(context);
                    } catch (error) {
                      print(error);
                      await widget.device.disconnect();
                      showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                                title: Text("Error",
                                    style: GoogleFonts.urbanist(
                                        fontWeight: FontWeight.w900,
                                        color: ColorsAsset.red)),
                                content: Text("There's an error connecting...",
                                    style: GoogleFonts.urbanist(
                                        fontWeight: FontWeight.w900,
                                        color: ColorsAsset.dark)),
                                actions: [
                                  TextButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                        Navigator.pop(context);
                                      },
                                      child: Text("OK",
                                          style: GoogleFonts.urbanist(
                                              fontWeight: FontWeight.w900,
                                              color: ColorsAsset.primary)))
                                ],
                              ));
                    }
                  },
                  child: Container(
                    width: double.infinity,
                    height: 50,
                    decoration: BoxDecoration(
                        color: ColorsAsset.primary,
                        borderRadius: BorderRadius.circular(50)),
                    child: Center(
                      child: Text("Connect",
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
    );
  }
}
