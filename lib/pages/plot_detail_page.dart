import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hydrobox/services/ble_provider.dart';
import 'package:hydrobox/utils/color_asset.dart';
import 'package:provider/provider.dart';

class PlotDetailPage extends StatelessWidget {
  const PlotDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        foregroundColor: Colors.white,
        backgroundColor: ColorsAsset.primary,
        title: Text("Box 1",
            style: GoogleFonts.urbanist(
                fontWeight: FontWeight.w900, color: Colors.white)),
        actions: [
          IconButton(
              onPressed: () async {
                await context
                    .read<BLEProvider>()
                    .writeCharacteristic!
                    .write(utf8.encode("A-0"));
                await context.read<BLEProvider>().bluetoothDevice!.disconnect();
                Navigator.pop(context);
              },
              icon: const Icon(Icons.delete, size: 24))
        ],
      ),
      body: Column(
        children: [
          // top
          Image.asset("assets/top2.png"),

          const SizedBox(height: 10),

          StreamBuilder(
              stream: context
                  .read<BLEProvider>()
                  .notify1Characteristic!
                  .onValueReceived,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  var data1 = utf8.decode(snapshot.data!).split("/");
                  return StreamBuilder(
                      stream: context
                          .read<BLEProvider>()
                          .notify2Characteristic!
                          .onValueReceived,
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          var data2 = utf8.decode(snapshot.data!).split("/");
                          return StreamBuilder(
                              stream: context
                                  .read<BLEProvider>()
                                  .notify3Characteristic!
                                  .onValueReceived,
                              builder: (context, snapshot) {
                                if (snapshot.hasData) {
                                  var data3 =
                                      utf8.decode(snapshot.data!).split("/");
                                  return Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 15),
                                    child: Column(
                                      children: [
                                        // plot image + status
                                        Container(
                                          width: double.infinity,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(12),
                                              color: ColorsAsset.gray),
                                          child: Padding(
                                            padding: const EdgeInsets.all(12.0),
                                            child: Column(
                                              children: [
                                                // image
                                                Container(
                                                  width: double.infinity,
                                                  height: 175,
                                                  clipBehavior: Clip.hardEdge,
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              12)),
                                                  child: Image.asset(
                                                    "assets/butterhead_lettuce.jpg",
                                                    fit: BoxFit.cover,
                                                  ),
                                                ),

                                                const SizedBox(height: 5),

                                                const Divider(),

                                                const SizedBox(height: 5),

                                                // status
                                                IntrinsicHeight(
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceEvenly,
                                                    children: [
                                                      Image.asset(
                                                          "assets/hydrobox.png",
                                                          width: 95,
                                                          height: 81),
                                                      const VerticalDivider(),
                                                      Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          // on / off
                                                          Row(
                                                            children: [
                                                              Container(
                                                                width: 23,
                                                                height: 23,
                                                                decoration: BoxDecoration(
                                                                    borderRadius:
                                                                        BorderRadius
                                                                            .circular(
                                                                                2),
                                                                    color: const Color(
                                                                        0xff24b395)),
                                                              ),
                                                              const SizedBox(
                                                                  width: 5),
                                                              Text("Device On",
                                                                  style: GoogleFonts.urbanist(
                                                                      fontSize:
                                                                          20,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w900))
                                                            ],
                                                          ),

                                                          // mode
                                                          Text(
                                                              data3[0] == "M-0"
                                                                  ? "Seeding Mode"
                                                                  : "Growing Mode",
                                                              style: GoogleFonts.urbanist(
                                                                  fontSize: 16,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w900,
                                                                  color: ColorsAsset
                                                                      .darkGray,
                                                                  height: 0.8))
                                                        ],
                                                      )
                                                    ],
                                                  ),
                                                ),

                                                const SizedBox(height: 5),

                                                // selected plant
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.end,
                                                  children: [
                                                    Text("Plant Type: ",
                                                        style: GoogleFonts
                                                            .urbanist(
                                                                fontSize: 12,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w900,
                                                                color:
                                                                    ColorsAsset
                                                                        .dark)),
                                                    Text(data3[1],
                                                        style: GoogleFonts
                                                            .urbanist(
                                                                fontSize: 12,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w900,
                                                                color: ColorsAsset
                                                                    .primary))
                                                  ],
                                                )
                                              ],
                                            ),
                                          ),
                                        ),

                                        const SizedBox(height: 15),

                                        // plot stats
                                        Container(
                                          width: double.infinity,
                                          padding: const EdgeInsets.all(12),
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(12),
                                              color: ColorsAsset.gray),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceAround,
                                            children: [
                                              // icon button
                                              Column(
                                                children: [
                                                  // icon
                                                  GestureDetector(
                                                    onTap: () {
                                                      showModalBottomSheet(
                                                          backgroundColor:
                                                              Colors.white,
                                                          context: context,
                                                          builder:
                                                              (context) =>
                                                                  SizedBox(
                                                                    width: double
                                                                        .infinity,
                                                                    height: 370,
                                                                    child: StatefulBuilder(builder:
                                                                        (context,
                                                                            setState) {
                                                                      return StreamBuilder(
                                                                          stream: context
                                                                              .read<
                                                                                  BLEProvider>()
                                                                              .notify1Characteristic!
                                                                              .onValueReceived,
                                                                          builder:
                                                                              (context, snapshot) {
                                                                            if (snapshot.hasData) {
                                                                              var modalData1 = utf8.decode(snapshot.data!).split("/");
                                                                              return StreamBuilder(
                                                                                  stream: context.read<BLEProvider>().notify2Characteristic!.onValueReceived,
                                                                                  builder: (context, snapshot) {
                                                                                    if (snapshot.hasData) {
                                                                                      var modalData2 = utf8.decode(snapshot.data!).split("/");
                                                                                      return StreamBuilder(
                                                                                          stream: context.read<BLEProvider>().notify3Characteristic!.onValueReceived,
                                                                                          builder: (context, snapshot) {
                                                                                            if (snapshot.hasData) {
                                                                                              var modalData3 = utf8.decode(snapshot.data!).split("/");
                                                                                              return Column(
                                                                                                children: [
                                                                                                  const SizedBox(height: 15),
                                                                                                  // header
                                                                                                  Text("Stats", style: GoogleFonts.urbanist(fontSize: 36, fontWeight: FontWeight.w900, color: ColorsAsset.dark)),

                                                                                                  const SizedBox(height: 15),

                                                                                                  Row(
                                                                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                                                                    children: [
                                                                                                      Container(
                                                                                                        width: 51,
                                                                                                        height: 51,
                                                                                                        padding: const EdgeInsets.all(7),
                                                                                                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(7), color: ColorsAsset.primary),
                                                                                                        child: const Icon(Icons.device_thermostat, size: 30, color: Colors.white),
                                                                                                      ),
                                                                                                      const SizedBox(width: 10),
                                                                                                      SizedBox(
                                                                                                        width: 100,
                                                                                                        child: Column(
                                                                                                          crossAxisAlignment: CrossAxisAlignment.center,
                                                                                                          children: [
                                                                                                            // data
                                                                                                            Text("${modalData1[0].split(".")[0]}°C", style: GoogleFonts.urbanist(fontSize: 24, fontWeight: FontWeight.w900, color: ColorsAsset.dark, height: 0.9)),

                                                                                                            // text
                                                                                                            Text("Temperature", style: GoogleFonts.urbanist(fontSize: 16, fontWeight: FontWeight.w900, color: ColorsAsset.dark, height: 0.9))
                                                                                                          ],
                                                                                                        ),
                                                                                                      ),
                                                                                                      const SizedBox(width: 15),
                                                                                                      Container(
                                                                                                        width: 51,
                                                                                                        height: 51,
                                                                                                        padding: const EdgeInsets.all(7),
                                                                                                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(7), color: ColorsAsset.primary),
                                                                                                        child: SvgPicture.asset("assets/icons/humidity_indoor.svg", width: 30),
                                                                                                      ),
                                                                                                      const SizedBox(width: 10),
                                                                                                      SizedBox(
                                                                                                        width: 100,
                                                                                                        child: Column(
                                                                                                          crossAxisAlignment: CrossAxisAlignment.center,
                                                                                                          children: [
                                                                                                            // data
                                                                                                            Text("${modalData1[1].split(".")[0]}°C", style: GoogleFonts.urbanist(fontSize: 24, fontWeight: FontWeight.w900, color: ColorsAsset.dark, height: 0.9)),

                                                                                                            // text
                                                                                                            Text("Water Temp", style: GoogleFonts.urbanist(fontSize: 16, fontWeight: FontWeight.w900, color: ColorsAsset.dark, height: 0.9))
                                                                                                          ],
                                                                                                        ),
                                                                                                      )
                                                                                                    ],
                                                                                                  ),

                                                                                                  const SizedBox(height: 30),

                                                                                                  Row(
                                                                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                                                                    children: [
                                                                                                      Container(
                                                                                                        width: 51,
                                                                                                        height: 51,
                                                                                                        padding: const EdgeInsets.all(7),
                                                                                                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(7), color: ColorsAsset.primary),
                                                                                                        child: SvgPicture.asset("assets/icons/door_sensor_white.svg", width: 30),
                                                                                                      ),
                                                                                                      const SizedBox(width: 10),
                                                                                                      SizedBox(
                                                                                                        width: 100,
                                                                                                        child: Column(
                                                                                                          crossAxisAlignment: CrossAxisAlignment.center,
                                                                                                          children: [
                                                                                                            // data
                                                                                                            Text(modalData2[0], style: GoogleFonts.urbanist(fontSize: 24, fontWeight: FontWeight.w900, color: ColorsAsset.dark, height: 0.9)),

                                                                                                            // text
                                                                                                            Text("pH Value", style: GoogleFonts.urbanist(fontSize: 16, fontWeight: FontWeight.w900, color: ColorsAsset.dark, height: 0.9))
                                                                                                          ],
                                                                                                        ),
                                                                                                      ),
                                                                                                      const SizedBox(width: 15),
                                                                                                      Container(
                                                                                                        width: 51,
                                                                                                        height: 51,
                                                                                                        padding: const EdgeInsets.all(7),
                                                                                                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(7), color: ColorsAsset.primary),
                                                                                                        child: SvgPicture.asset("assets/icons/flash_on_white.svg", width: 30),
                                                                                                      ),
                                                                                                      const SizedBox(width: 10),
                                                                                                      SizedBox(
                                                                                                        width: 100,
                                                                                                        child: Column(
                                                                                                          crossAxisAlignment: CrossAxisAlignment.center,
                                                                                                          children: [
                                                                                                            // data
                                                                                                            Text(modalData2[1], style: GoogleFonts.urbanist(fontSize: 24, fontWeight: FontWeight.w900, color: ColorsAsset.dark, height: 0.9)),

                                                                                                            // text
                                                                                                            Text("Fertilizer", style: GoogleFonts.urbanist(fontSize: 16, fontWeight: FontWeight.w900, color: ColorsAsset.dark, height: 0.9))
                                                                                                          ],
                                                                                                        ),
                                                                                                      )
                                                                                                    ],
                                                                                                  ),

                                                                                                  const SizedBox(height: 30),

                                                                                                  Row(
                                                                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                                                                    children: [
                                                                                                      Container(
                                                                                                        width: 51,
                                                                                                        height: 51,
                                                                                                        padding: const EdgeInsets.all(7),
                                                                                                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(7), color: ColorsAsset.primary),
                                                                                                        child: SvgPicture.asset("assets/icons/rainy_light.svg", width: 30),
                                                                                                      ),
                                                                                                      const SizedBox(width: 10),
                                                                                                      SizedBox(
                                                                                                        width: 100,
                                                                                                        child: Column(
                                                                                                          crossAxisAlignment: CrossAxisAlignment.center,
                                                                                                          children: [
                                                                                                            // data
                                                                                                            Text(modalData1[2], style: GoogleFonts.urbanist(fontSize: 24, fontWeight: FontWeight.w900, color: ColorsAsset.dark, height: 0.9)),

                                                                                                            // text
                                                                                                            Text("Water Level", style: GoogleFonts.urbanist(fontSize: 16, fontWeight: FontWeight.w900, color: ColorsAsset.dark, height: 0.9))
                                                                                                          ],
                                                                                                        ),
                                                                                                      ),
                                                                                                      const SizedBox(width: 15),
                                                                                                      Container(
                                                                                                        width: 51,
                                                                                                        height: 51,
                                                                                                        padding: const EdgeInsets.all(7),
                                                                                                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(7), color: ColorsAsset.primary),
                                                                                                        child: SvgPicture.asset("assets/icons/model_training_white.svg", width: 30),
                                                                                                      ),
                                                                                                      const SizedBox(width: 10),
                                                                                                      SizedBox(
                                                                                                        width: 100,
                                                                                                        child: Column(
                                                                                                          crossAxisAlignment: CrossAxisAlignment.center,
                                                                                                          children: [
                                                                                                            // data
                                                                                                            Text(modalData3[0].split(" ")[0] == "M-0" ? "Seeding" : "Growing", style: GoogleFonts.urbanist(fontSize: 24, fontWeight: FontWeight.w900, color: ColorsAsset.dark, height: 0.9)),

                                                                                                            // text
                                                                                                            Text("Mode", style: GoogleFonts.urbanist(fontSize: 16, fontWeight: FontWeight.w900, color: ColorsAsset.dark, height: 0.9))
                                                                                                          ],
                                                                                                        ),
                                                                                                      )
                                                                                                    ],
                                                                                                  ),

                                                                                                  const SizedBox(height: 25),

                                                                                                  IntrinsicHeight(
                                                                                                    child: Row(
                                                                                                      mainAxisAlignment: MainAxisAlignment.center,
                                                                                                      children: [
                                                                                                        // toggle light
                                                                                                        GestureDetector(
                                                                                                          onTap: () async {
                                                                                                            await context.read<BLEProvider>().writeCharacteristic!.write(utf8.encode("L-1"));
                                                                                                          },
                                                                                                          child: Row(
                                                                                                            children: [
                                                                                                              SizedBox(
                                                                                                                width: 20,
                                                                                                                height: 20,
                                                                                                                child: SvgPicture.asset("assets/icons/light.svg", colorFilter: ColorFilter.mode(ColorsAsset.primary, BlendMode.srcIn)),
                                                                                                              ),
                                                                                                              const SizedBox(width: 5),
                                                                                                              Text(
                                                                                                                "Light",
                                                                                                                style: GoogleFonts.urbanist(fontSize: 18, fontWeight: FontWeight.w900, color: ColorsAsset.primary),
                                                                                                              )
                                                                                                            ],
                                                                                                          ),
                                                                                                        ),

                                                                                                        const SizedBox(width: 5),

                                                                                                        const VerticalDivider(),

                                                                                                        // toggle fertilizer
                                                                                                        GestureDetector(
                                                                                                          onTap: () async {
                                                                                                            await context.read<BLEProvider>().writeCharacteristic!.write(utf8.encode("F-1"));
                                                                                                          },
                                                                                                          child: Row(
                                                                                                            children: [
                                                                                                              SizedBox(
                                                                                                                  width: 20,
                                                                                                                  height: 20,
                                                                                                                  child: SvgPicture.asset(
                                                                                                                    "assets/icons/flash_on.svg",
                                                                                                                    colorFilter: ColorFilter.mode(ColorsAsset.primary, BlendMode.srcIn),
                                                                                                                  )),
                                                                                                              const SizedBox(width: 5),
                                                                                                              Text(
                                                                                                                "Fertilizer",
                                                                                                                style: GoogleFonts.urbanist(fontSize: 18, fontWeight: FontWeight.w900, color: ColorsAsset.primary),
                                                                                                              )
                                                                                                            ],
                                                                                                          ),
                                                                                                        ),

                                                                                                        const SizedBox(width: 5),

                                                                                                        const VerticalDivider(),

                                                                                                        // toggle pH
                                                                                                        GestureDetector(
                                                                                                          onTap: () async {
                                                                                                            await context.read<BLEProvider>().writeCharacteristic!.write(utf8.encode("P-1"));
                                                                                                          },
                                                                                                          child: Row(
                                                                                                            children: [
                                                                                                              SizedBox(width: 20, height: 20, child: SvgPicture.asset("assets/icons/door_sensor.svg", colorFilter: ColorFilter.mode(ColorsAsset.primary, BlendMode.srcIn))),
                                                                                                              const SizedBox(width: 5),
                                                                                                              Text(
                                                                                                                "toggle pH",
                                                                                                                style: GoogleFonts.urbanist(fontSize: 18, fontWeight: FontWeight.w900, color: ColorsAsset.primary),
                                                                                                              )
                                                                                                            ],
                                                                                                          ),
                                                                                                        ),
                                                                                                      ],
                                                                                                    ),
                                                                                                  )
                                                                                                ],
                                                                                              );
                                                                                            } else {
                                                                                              return Center(child: CircularProgressIndicator(color: ColorsAsset.primary));
                                                                                            }
                                                                                          });
                                                                                    } else {
                                                                                      return const Center(child: CircularProgressIndicator(color: Colors.white));
                                                                                    }
                                                                                  });
                                                                            } else {
                                                                              return const Center(child: CircularProgressIndicator(color: Colors.white));
                                                                            }
                                                                          });
                                                                    }),
                                                                  ));
                                                    },
                                                    child: Container(
                                                      width: 51,
                                                      height: 51,
                                                      padding:
                                                          const EdgeInsets.all(
                                                              7),
                                                      decoration: BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(7),
                                                          color: ColorsAsset
                                                              .primary),
                                                      child: SvgPicture.asset(
                                                        "assets/icons/instant_mix.svg",
                                                      ),
                                                    ),
                                                  ),

                                                  // text
                                                  Text("Stats",
                                                      style:
                                                          GoogleFonts.urbanist(
                                                              fontSize: 16,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w900,
                                                              color: ColorsAsset
                                                                  .dark))
                                                ],
                                              ),

                                              // temp
                                              Column(
                                                children: [
                                                  // temp icon
                                                  const SizedBox(
                                                    width: 51,
                                                    height: 51,
                                                    child: Icon(
                                                        Icons
                                                            .device_thermostat_outlined,
                                                        size: 36,
                                                        color: Colors.black),
                                                  ),

                                                  // temp text
                                                  Text("${data1[0]}°C",
                                                      style:
                                                          GoogleFonts.urbanist(
                                                              fontSize: 16,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w900,
                                                              color: ColorsAsset
                                                                  .dark))
                                                ],
                                              ),

                                              // pH Value
                                              Column(
                                                children: [
                                                  const SizedBox(height: 7),
                                                  // pH icon
                                                  SizedBox(
                                                      width: 36,
                                                      height: 36,
                                                      child: SvgPicture.asset(
                                                          "assets/icons/door_sensor.svg")),

                                                  const SizedBox(height: 8),

                                                  // pH text
                                                  Text(data2[0],
                                                      style:
                                                          GoogleFonts.urbanist(
                                                              fontSize: 16,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w900,
                                                              color: ColorsAsset
                                                                  .dark))
                                                ],
                                              ),

                                              // tds value
                                              Column(
                                                children: [
                                                  const SizedBox(height: 8),
                                                  // tds icon
                                                  SizedBox(
                                                    width: 36,
                                                    height: 36,
                                                    child: SvgPicture.asset(
                                                        "assets/icons/flash_on.svg"),
                                                  ),

                                                  const SizedBox(height: 7),

                                                  // temp text
                                                  Text("${data2[1]} ppm",
                                                      style:
                                                          GoogleFonts.urbanist(
                                                              fontSize: 16,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w900,
                                                              color: ColorsAsset
                                                                  .dark))
                                                ],
                                              )
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  );
                                } else {
                                  return Center(
                                      child: CircularProgressIndicator(
                                          color: ColorsAsset.primary));
                                }
                              });
                        } else {
                          return Center(
                              child: CircularProgressIndicator(
                                  color: ColorsAsset.primary));
                        }
                      });
                } else {
                  return Center(
                      child: CircularProgressIndicator(
                          color: ColorsAsset.primary));
                }
              })
        ],
      ),
    );
  }
}
