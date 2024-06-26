import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hydrobox/utils/color_asset.dart';

class MyPlant extends StatelessWidget {
  final String plantName;
  final String plantingTime;
  final String phValue;
  final String temp;
  final String imgPath;
  final bool addImg;
  final String addImgPath;
  const MyPlant(
      {super.key,
      required this.plantName,
      required this.plantingTime,
      required this.phValue,
      required this.temp,
      required this.imgPath,
      required this.addImg,
      required this.addImgPath});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 115,
      margin: const EdgeInsets.only(bottom: 15),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
          color: ColorsAsset.gray, borderRadius: BorderRadius.circular(12)),
      child: Row(
        children: [
          // plant image
          Container(
              clipBehavior: Clip.hardEdge,
              width: 77,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
              ),
              child: addImg
                  ? Image.network(addImgPath)
                  : Image.asset(
                      imgPath,
                      fit: BoxFit.cover,
                      alignment: imgPath == "assets/kale.jpg"
                          ? Alignment.topCenter
                          : Alignment.center,
                    )),

          const SizedBox(width: 10),

          const VerticalDivider(),

          const SizedBox(width: 10),

          // plant detail
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // plant name
              Text(plantName,
                  style: GoogleFonts.urbanist(
                      fontSize: 20,
                      fontWeight: FontWeight.w900,
                      color: ColorsAsset.dark,
                      height: 1.1)),

              // plant information
              Text("Planting Time : $plantingTime Days",
                  style: GoogleFonts.urbanist(
                      fontSize: 15,
                      fontWeight: FontWeight.w900,
                      color: ColorsAsset.darkGray,
                      height: 1.1)),
              Text("Temperature : $temp°C",
                  style: GoogleFonts.urbanist(
                      fontSize: 15,
                      fontWeight: FontWeight.w900,
                      color: ColorsAsset.darkGray,
                      height: 1.1)),
              Text("pH : $phValue",
                  style: GoogleFonts.urbanist(
                      fontSize: 15,
                      fontWeight: FontWeight.w900,
                      color: ColorsAsset.darkGray,
                      height: 1.1)),
            ],
          )
        ],
      ),
    );
  }
}
