import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hydrobox/utils/color_asset.dart';

class MyPlot extends StatefulWidget {
  final String plantType;
  final String seedingMode;
  const MyPlot({super.key, required this.plantType, required this.seedingMode});

  @override
  State<MyPlot> createState() => _MyPlotState();
}

class _MyPlotState extends State<MyPlot> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
          color: ColorsAsset.gray, borderRadius: BorderRadius.circular(12)),
      child: Column(
        children: [
          // box number + plant type
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // box number
              Text("Box 1",
                  style: GoogleFonts.urbanist(
                      fontSize: 20,
                      fontWeight: FontWeight.w900,
                      color: ColorsAsset.dark)),

              // plant type
              Text(widget.plantType,
                  style: GoogleFonts.urbanist(
                      fontSize: 20,
                      fontWeight: FontWeight.w900,
                      color: ColorsAsset.dark))
            ],
          ),

          const SizedBox(height: 5),

          const Divider(),

          const SizedBox(height: 5),

          // quick information
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              // plot date
              SizedBox(
                width: 80,
                height: 110,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset("assets/icons/plot_date.png",
                        width: 80, color: ColorsAsset.primary),
                    SizedBox(
                      width: 80,
                      child: Text("45 Days",
                          textAlign: TextAlign.center,
                          style: GoogleFonts.urbanist(
                              fontSize: 20, fontWeight: FontWeight.w900)),
                    )
                  ],
                ),
              ),

              // plot mode
              SizedBox(
                width: 140,
                height: 110,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset("assets/icons/plot_mode.png",
                        width: 80, color: ColorsAsset.primary),
                    SizedBox(
                      width: 140,
                      child: Text(widget.seedingMode,
                          textAlign: TextAlign.center,
                          style: GoogleFonts.urbanist(
                              fontSize: 20, fontWeight: FontWeight.w900)),
                    )
                  ],
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
