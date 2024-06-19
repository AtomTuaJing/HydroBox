import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hydrobox/pages/choose_connection_page.dart';
import 'package:hydrobox/services/plant_provider.dart';
import 'package:hydrobox/utils/color_asset.dart';
import 'package:provider/provider.dart';

class PlantDetailPage extends StatelessWidget {
  final String plantName;
  final String plantDescription;
  final String plantingTime;
  final String phValue;
  final String temp;
  final String imgPath;
  final bool addImg;
  final String addImgPath;
  final bool deletePage;
  final String firebaseImgPath;
  const PlantDetailPage(
      {super.key,
      required this.plantName,
      required this.plantDescription,
      required this.plantingTime,
      required this.phValue,
      required this.temp,
      required this.imgPath,
      required this.addImg,
      required this.addImgPath,
      this.firebaseImgPath = "",
      this.deletePage = false});

  @override
  Widget build(BuildContext context) {
    var currentUser = FirebaseAuth.instance.currentUser;

    return Container(
      decoration: BoxDecoration(
          image: addImg
              ? DecorationImage(
                  alignment: Alignment.topCenter,
                  image: NetworkImage(addImgPath),
                  fit: BoxFit.contain)
              : DecorationImage(
                  alignment: Alignment.topCenter,
                  image: AssetImage(imgPath),
                  fit: BoxFit.contain)),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          centerTitle: true,
          foregroundColor: Colors.white,
          backgroundColor: Colors.transparent,
          title: Text("Choose Plant",
              style: GoogleFonts.urbanist(
                fontSize: 20,
                fontWeight: FontWeight.w900,
              )),
          actions: [
            deletePage
                ? IconButton(
                    onPressed: () async {
                      showDialog(
                          context: context,
                          builder: (context) => Center(
                              child: CircularProgressIndicator(
                                  color: ColorsAsset.primary)));
                      await FirebaseStorage.instance
                          .ref()
                          .child("plants/$firebaseImgPath")
                          .delete();
                      await FirebaseFirestore.instance
                          .collection("Users")
                          .doc(currentUser!.email)
                          .collection("myPlants")
                          .doc(plantName)
                          .delete();
                      Navigator.pop(context);
                      Navigator.pop(context);
                    },
                    icon: const Icon(Icons.delete_outline,
                        size: 30, color: Colors.white))
                : IconButton(onPressed: () {}, icon: const Icon(null))
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 124),
              // plant details
              Stack(
                children: [
                  // top
                  Image.asset("assets/top3.png"),

                  // detail
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 15, right: 15, top: 60),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // plant name
                        Text(plantName,
                            style: GoogleFonts.urbanist(
                                fontSize: 32,
                                fontWeight: FontWeight.w900,
                                color: ColorsAsset.dark)),

                        const SizedBox(height: 15),

                        // plant description
                        Text("Plant Description",
                            style: GoogleFonts.urbanist(
                                fontSize: 20,
                                fontWeight: FontWeight.w900,
                                color: ColorsAsset.dark)),

                        const SizedBox(height: 10),

                        Text(plantDescription,
                            style: GoogleFonts.urbanist(
                                fontSize: 16,
                                fontWeight: FontWeight.w900,
                                color: ColorsAsset.darkGray,
                                height: 1.8)),

                        const SizedBox(height: 20),

                        // growing requirements
                        Text("Growing Requirements",
                            style: GoogleFonts.urbanist(
                                fontSize: 20,
                                fontWeight: FontWeight.w900,
                                color: ColorsAsset.dark)),

                        const SizedBox(height: 10),

                        Text(
                            "Growth Duration : $plantingTime Days \nTemperature : $temp°C \npH Value : $phValue",
                            style: GoogleFonts.urbanist(
                                fontSize: 16,
                                fontWeight: FontWeight.w900,
                                color: ColorsAsset.darkGray,
                                height: 1.8)),

                        const SizedBox(height: 20),

                        // select
                        GestureDetector(
                          onTap: () {
                            addImg
                                ? context
                                    .read<PlantProvider>()
                                    .changeSelectedPlant("C-1")
                                : context
                                    .read<PlantProvider>()
                                    .changeSelectedPlant(plantName);
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const ChooseConnectionPage()));
                          },
                          child: Container(
                            width: double.infinity,
                            height: 45,
                            decoration: BoxDecoration(
                                color: ColorsAsset.primary,
                                borderRadius: BorderRadius.circular(50)),
                            child: Center(
                              child: Text("Select",
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
              )
            ],
          ),
        ),
      ),
    );
  }
}
