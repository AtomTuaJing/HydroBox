import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hydrobox/components/my_plot.dart';
import 'package:hydrobox/pages/choose_plant_page.dart';
import 'package:hydrobox/pages/plot_detail_page.dart';
import 'package:hydrobox/services/ble_provider.dart';
import 'package:hydrobox/utils/color_asset.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  final bool connectionState;
  const HomePage({super.key, required this.connectionState});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (context.watch<BLEProvider>().notify1Characteristic != null) {
      context.read<BLEProvider>().notify1Characteristic!.setNotifyValue(true);
    }
    if (context.watch<BLEProvider>().notify2Characteristic != null) {
      context.read<BLEProvider>().notify2Characteristic!.setNotifyValue(true);
    }
    if (context.watch<BLEProvider>().notify3Characteristic != null) {
      context.read<BLEProvider>().notify3Characteristic!.setNotifyValue(true);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorsAsset.primary,
        centerTitle: true,
        title: Text("Home",
            style: GoogleFonts.urbanist(
                fontSize: 20,
                fontWeight: FontWeight.w900,
                color: Colors.white)),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // top
          Image.asset("assets/top2.png"),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // your plots
                Text("Your Plots",
                    style: GoogleFonts.urbanist(
                        fontSize: 32,
                        fontWeight: FontWeight.w900,
                        color: ColorsAsset.primary)),

                const SizedBox(height: 10),

                widget.connectionState
                    ? // plot lists
                    SizedBox(
                        height: 450,
                        child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: 1 + 1,
                          itemBuilder: (context, index) {
                            return (index != 1)
                                ? GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  PlotDetailPage()));
                                    },
                                    child: StreamBuilder(
                                        stream: context
                                            .read<BLEProvider>()
                                            .notify3Characteristic!
                                            .onValueReceived,
                                        builder: (context, snapshot) {
                                          if (snapshot.hasData) {
                                            var data =
                                                utf8.decode(snapshot.data!);
                                            var splitedData = data.split("/");
                                            return MyPlot(
                                              seedingMode:
                                                  splitedData[0] == "M-0"
                                                      ? "Seeding Mode"
                                                      : "Growing Mode",
                                              plantType: splitedData[1],
                                            );
                                          } else {
                                            return Center(
                                                child:
                                                    CircularProgressIndicator(
                                                        color: ColorsAsset
                                                            .primary));
                                          }
                                        }))
                                : GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  const ChoosePlantPage()));
                                    },
                                    child: Container(
                                      width: double.infinity,
                                      height: 45,
                                      decoration: BoxDecoration(
                                          color: ColorsAsset.primary,
                                          borderRadius:
                                              BorderRadius.circular(50)),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          const Icon(Icons.add,
                                              size: 26, color: Colors.white),
                                          const SizedBox(width: 5),
                                          Text("Add",
                                              style: GoogleFonts.urbanist(
                                                  fontSize: 24,
                                                  fontWeight: FontWeight.w900,
                                                  color: Colors.white)),
                                        ],
                                      ),
                                    ),
                                  );
                          },
                        ),
                      )
                    : Column(
                        children: [
                          // no device logo
                          Image.asset("assets/no_device_yet.png",
                              width: 200, height: 229),

                          const SizedBox(height: 5),

                          // no device yet
                          Text("No Device Yet...",
                              style: GoogleFonts.urbanist(
                                  fontSize: 24,
                                  fontWeight: FontWeight.w900,
                                  color: ColorsAsset.darkGray)),

                          const SizedBox(height: 30),

                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const ChoosePlantPage()));
                            },
                            child: Container(
                              width: double.infinity,
                              height: 45,
                              decoration: BoxDecoration(
                                  color: ColorsAsset.primary,
                                  borderRadius: BorderRadius.circular(50)),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Icon(Icons.add,
                                      size: 26, color: Colors.white),
                                  const SizedBox(width: 5),
                                  Text("Add",
                                      style: GoogleFonts.urbanist(
                                          fontSize: 24,
                                          fontWeight: FontWeight.w900,
                                          color: Colors.white)),
                                ],
                              ),
                            ),
                          )
                        ],
                      )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
