import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hydrobox/components/my_plant.dart';
import 'package:hydrobox/components/my_textfield.dart';
import 'package:hydrobox/pages/plant_detail_page.dart';
import 'package:hydrobox/services/plant_provider.dart';
import 'package:hydrobox/utils/color_asset.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class ChoosePlantPage extends StatefulWidget {
  const ChoosePlantPage({super.key});

  @override
  State<ChoosePlantPage> createState() => _ChoosePlantPageState();
}

class _ChoosePlantPageState extends State<ChoosePlantPage> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    context.read<PlantProvider>().changeSelectedPlant("");
  }

  // controllers
  var profileController;
  var plantNameController = TextEditingController();
  var plantDescriptionController = TextEditingController();
  var seedingTimeController = TextEditingController();
  var plantingTimeController = TextEditingController();
  var pHValueController = TextEditingController();
  var tempController = TextEditingController();
  var tdsController = TextEditingController();

  var currentUser = FirebaseAuth.instance.currentUser;

  // custom icon state
  bool customIcon = false;
  bool customIcon2 = false;
  bool customIcon3 = false;

  final Map<String, Map<String, String>> plantDetails = {
    "Kale": {
      "description":
          "Kale is a hardy leafy green, rich in vitamins and minerals, known for its slightly bitter flavor and versatility in salads, smoothies, and cooking.",
      "pH": "5.5-6.5",
      "temp": "13 - 24°C",
      "growth": "50 - 70"
    },
    "Spinach": {
      "description":
          "Spinach is a nutrient-dense leafy green, prized for its tender leaves and mild flavor, ideal for salads, cooking, and smoothies.",
      "pH": "6.0-7.0",
      "temp": "16 - 22°C",
      "growth": "30 - 45"
    },
    "ButterHead": {
      "description":
          "Butterhead Lettuce is known for its soft, buttery leaves and mild flavor, perfect for salads and sandwiches.",
      "pH": "6.0-6.8",
      "temp": "15 - 20°C",
      "growth": "55 - 75"
    },
    "TokyoBekana": {
      "description":
          "Tokyo Bekana is a tender, mild Asian green, often used in salads and stir-fries, with a crisp texture similar to lettuce.",
      "pH": "6.0-7.0",
      "temp": "15 - 20°C",
      "growth": "30 - 40"
    },
    "GreenLettuce": {
      "description":
          "Green Lettuce is a broad category of leafy greens, prized for their crisp texture and mild flavor, perfect for salads and garnishes.",
      "pH": "6.0-7.0",
      "temp": "15 - 20°C",
      "growth": "45 - 55"
    },
    "IceBergLettuce": {
      "description":
          "Iceberg Lettuce is known for its crisp, crunchy texture and mild flavor, commonly used in salads and sandwiches.",
      "pH": "6.0-6.8",
      "temp": "15 - 18°C",
      "growth": "70 - 85"
    }
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        foregroundColor: Colors.white,
        backgroundColor: ColorsAsset.primary,
        title: Text("Choose Plant",
            style: GoogleFonts.urbanist(
              fontSize: 20,
              fontWeight: FontWeight.w900,
            )),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // top
            Image.asset("assets/top2.png"),

            // body
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // plants
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Text("Plants",
                      style: GoogleFonts.urbanist(
                          fontSize: 32,
                          fontWeight: FontWeight.w900,
                          color: ColorsAsset.primary)),
                ),

                // recommeded
                Theme(
                  data: ThemeData().copyWith(dividerColor: Colors.transparent),
                  child: ExpansionTile(
                    initiallyExpanded: true,
                    title: Text("Recommeded",
                        style: GoogleFonts.urbanist(
                            fontSize: 20,
                            fontWeight: FontWeight.w900,
                            color: ColorsAsset.dark)),
                    trailing: customIcon
                        ? Icon(Icons.arrow_drop_down,
                            size: 35, color: ColorsAsset.dark)
                        : Icon(Icons.arrow_left,
                            size: 35, color: ColorsAsset.dark),
                    onExpansionChanged: (bool value) {
                      setState(() {
                        customIcon = value;
                      });
                    },
                    children: [
                      Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          child: Column(
                            children: [
                              GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                PlantDetailPage(
                                                  addImg: false,
                                                  addImgPath: "",
                                                  imgPath: "assets/kale.jpg",
                                                  plantName: "Kale",
                                                  plantDescription:
                                                      plantDetails["Kale"]![
                                                          "description"]!,
                                                  plantingTime: plantDetails[
                                                      "Kale"]!["growth"]!,
                                                  phValue: plantDetails[
                                                      "Kale"]!["pH"]!,
                                                  temp: plantDetails["Kale"]![
                                                      "temp"]!,
                                                )));
                                  },
                                  child: const MyPlant(
                                    addImg: false,
                                    addImgPath: "",
                                    imgPath: "assets/kale.jpg",
                                    plantName: "Kale",
                                    plantingTime: "50",
                                    phValue: "5.5",
                                    temp: "13",
                                  )),
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => PlantDetailPage(
                                              addImg: false,
                                              addImgPath: "",
                                              plantName: "Spinach",
                                              plantDescription: plantDetails[
                                                  "Spinach"]!["description"]!,
                                              plantingTime: plantDetails[
                                                  "Spinach"]!["growth"]!,
                                              phValue: plantDetails["Spinach"]![
                                                  "pH"]!,
                                              temp: plantDetails["Spinach"]![
                                                  "temp"]!,
                                              imgPath: "assets/spinach.jpg")));
                                },
                                child: const MyPlant(
                                  addImg: false,
                                  addImgPath: "",
                                  imgPath: "assets/spinach.jpg",
                                  plantName: "Spinach",
                                  plantingTime: "30",
                                  phValue: "5.5",
                                  temp: "10",
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => PlantDetailPage(
                                              addImg: false,
                                              addImgPath: "",
                                              plantName: "Green Lettuce",
                                              plantDescription:
                                                  plantDetails["GreenLettuce"]![
                                                      "description"]!,
                                              plantingTime: plantDetails[
                                                  "GreenLettuce"]!["growth"]!,
                                              phValue: plantDetails[
                                                  "GreenLettuce"]!["pH"]!,
                                              temp: plantDetails[
                                                  "GreenLettuce"]!["temp"]!,
                                              imgPath:
                                                  "assets/green_lettuce.jpg")));
                                },
                                child: const MyPlant(
                                  addImg: false,
                                  addImgPath: "",
                                  imgPath: "assets/green_lettuce.jpg",
                                  plantName: "Green Lettuce",
                                  plantingTime: "45",
                                  phValue: "6.0",
                                  temp: "15",
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => PlantDetailPage(
                                              addImg: false,
                                              addImgPath: "",
                                              plantName: "Iceberg Lettuce",
                                              plantDescription: plantDetails[
                                                      "IceBergLettuce"]![
                                                  "description"]!,
                                              plantingTime: plantDetails[
                                                  "IceBergLettuce"]!["growth"]!,
                                              phValue: plantDetails[
                                                  "IceBergLettuce"]!["pH"]!,
                                              temp: plantDetails[
                                                  "IceBergLettuce"]!["temp"]!,
                                              imgPath:
                                                  "assets/iceberg_lettuce.jpg")));
                                },
                                child: const MyPlant(
                                  addImg: false,
                                  addImgPath: "",
                                  imgPath: "assets/iceberg_lettuce.jpg",
                                  plantName: "Iceberg Lettuce",
                                  plantingTime: "70",
                                  phValue: "6.0",
                                  temp: "15",
                                ),
                              ),
                            ],
                          ))
                    ],
                  ),
                ),

                // hydroponic basic
                Theme(
                  data: ThemeData().copyWith(dividerColor: Colors.transparent),
                  child: ExpansionTile(
                    title: Text("Hydroponic Basic",
                        style: GoogleFonts.urbanist(
                            fontSize: 20,
                            fontWeight: FontWeight.w900,
                            color: ColorsAsset.dark)),
                    trailing: customIcon2
                        ? Icon(Icons.arrow_drop_down,
                            size: 35, color: ColorsAsset.dark)
                        : Icon(Icons.arrow_left,
                            size: 35, color: ColorsAsset.dark),
                    onExpansionChanged: (bool value) {
                      setState(() {
                        customIcon2 = value;
                      });
                    },
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        child: Column(
                          children: [
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => PlantDetailPage(
                                            addImg: false,
                                            addImgPath: "",
                                            plantName: "Butterhead Lettuce",
                                            plantDescription: plantDetails[
                                                "ButterHead"]!["description"]!,
                                            plantingTime: plantDetails[
                                                "ButterHead"]!["growth"]!,
                                            phValue: plantDetails[
                                                "ButterHead"]!["pH"]!,
                                            temp: plantDetails["ButterHead"]![
                                                "temp"]!,
                                            imgPath:
                                                "assets/butterhead_lettuce.jpg")));
                              },
                              child: const MyPlant(
                                addImg: false,
                                addImgPath: "",
                                imgPath: "assets/butterhead_lettuce.jpg",
                                plantName: "Butterhead Lettu..",
                                plantingTime: "55",
                                phValue: "6.0",
                                temp: "15",
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => PlantDetailPage(
                                            addImg: false,
                                            addImgPath: "",
                                            plantName: "Tokyo Bekana",
                                            plantDescription: plantDetails[
                                                "TokyoBekana"]!["description"]!,
                                            plantingTime: plantDetails[
                                                "TokyoBekana"]!["growth"]!,
                                            phValue: plantDetails[
                                                "TokyoBekana"]!["pH"]!,
                                            temp: plantDetails["TokyoBekana"]![
                                                "temp"]!,
                                            imgPath:
                                                "assets/tokyo_bekana.jpg")));
                              },
                              child: const MyPlant(
                                addImg: false,
                                addImgPath: "",
                                imgPath: "assets/tokyo_bekana.jpg",
                                plantName: "Tokyo Bekana",
                                plantingTime: "30",
                                phValue: "6.0",
                                temp: "15",
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => PlantDetailPage(
                                            addImg: false,
                                            addImgPath: "",
                                            plantName: "Green Lettuce",
                                            plantDescription:
                                                plantDetails["GreenLettuce"]![
                                                    "description"]!,
                                            plantingTime: plantDetails[
                                                "GreenLettuce"]!["growth"]!,
                                            phValue: plantDetails[
                                                "GreenLettuce"]!["pH"]!,
                                            temp: plantDetails["GreenLettuce"]![
                                                "temp"]!,
                                            imgPath:
                                                "assets/green_lettuce.jpg")));
                              },
                              child: const MyPlant(
                                addImg: false,
                                addImgPath: "",
                                imgPath: "assets/green_lettuce.jpg",
                                plantName: "Green Lettuce",
                                plantingTime: "45",
                                phValue: "6.0",
                                temp: "15",
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => PlantDetailPage(
                                            addImg: false,
                                            addImgPath: "",
                                            plantName: "Iceberg Lettuce",
                                            plantDescription:
                                                plantDetails["IceBergLettuce"]![
                                                    "description"]!,
                                            plantingTime: plantDetails[
                                                "IceBergLettuce"]!["growth"]!,
                                            phValue: plantDetails[
                                                "IceBergLettuce"]!["pH"]!,
                                            temp: plantDetails[
                                                "IceBergLettuce"]!["temp"]!,
                                            imgPath:
                                                "assets/iceberg_lettuce.jpg")));
                              },
                              child: const MyPlant(
                                addImg: false,
                                addImgPath: "",
                                imgPath: "assets/iceberg_lettuce.jpg",
                                plantName: "Iceberg Lettuce",
                                plantingTime: "70",
                                phValue: "6.0",
                                temp: "15",
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),

                // your plants
                Theme(
                  data: ThemeData().copyWith(dividerColor: Colors.transparent),
                  child: ExpansionTile(
                    title: Text("Your Plants",
                        style: GoogleFonts.urbanist(
                            fontSize: 20,
                            fontWeight: FontWeight.w900,
                            color: ColorsAsset.dark)),
                    trailing: customIcon3
                        ? Icon(Icons.arrow_drop_down,
                            size: 35, color: ColorsAsset.dark)
                        : Icon(Icons.arrow_left,
                            size: 35, color: ColorsAsset.dark),
                    onExpansionChanged: (bool value) {
                      setState(() {
                        customIcon3 = value;
                      });
                    },
                    children: [
                      Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          child: Expanded(
                            child: Column(
                              children: [
                                StreamBuilder(
                                    stream: FirebaseFirestore.instance
                                        .collection("Users")
                                        .doc(currentUser!.email)
                                        .collection("myPlants")
                                        .snapshots(),
                                    builder: (context, snapshot) {
                                      if (snapshot.hasData) {
                                        return ListView.builder(
                                          shrinkWrap: true,
                                          itemCount:
                                              snapshot.data!.docs.length + 1,
                                          itemBuilder: (context, index) {
                                            var plant;
                                            if (index !=
                                                snapshot.data!.docs.length) {
                                              plant =
                                                  snapshot.data!.docs[index];
                                            }
                                            return index !=
                                                    snapshot.data!.docs.length
                                                ? GestureDetector(
                                                    onTap: () {
                                                      Navigator.push(
                                                          context,
                                                          MaterialPageRoute(
                                                              builder: (context) =>
                                                                  PlantDetailPage(
                                                                    firebaseImgPath:
                                                                        plant[
                                                                            "profileName"],
                                                                    deletePage:
                                                                        true,
                                                                    addImg:
                                                                        true,
                                                                    addImgPath:
                                                                        plant[
                                                                            "plantProfile"],
                                                                    imgPath: "",
                                                                    plantName:
                                                                        plant[
                                                                            "plantName"],
                                                                    plantDescription:
                                                                        plant[
                                                                            "plantDescription"],
                                                                    plantingTime:
                                                                        plant[
                                                                            "plantingTime"],
                                                                    phValue:
                                                                        plant[
                                                                            "pH"],
                                                                    temp: plant[
                                                                        "temp"],
                                                                  )));
                                                    },
                                                    child: MyPlant(
                                                      addImg: true,
                                                      addImgPath:
                                                          plant["plantProfile"],
                                                      imgPath: "",
                                                      plantName:
                                                          plant["plantName"],
                                                      plantingTime:
                                                          plant["plantingTime"],
                                                      phValue: plant["pH"],
                                                      temp: plant["temp"],
                                                    ))
                                                : GestureDetector(
                                                    onTap: () async {
                                                      showDialog(
                                                        context: context,
                                                        builder: (context) =>
                                                            AlertDialog(
                                                          title: Text(
                                                              "Add Plant",
                                                              style: GoogleFonts.urbanist(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w900,
                                                                  color:
                                                                      ColorsAsset
                                                                          .dark)),
                                                          content: StatefulBuilder(
                                                              builder: (context,
                                                                  setState) {
                                                            return SingleChildScrollView(
                                                              child: Column(
                                                                children: [
                                                                  // profile selector
                                                                  GestureDetector(
                                                                    onTap:
                                                                        () async {
                                                                      final returnedImage =
                                                                          await ImagePicker()
                                                                              .pickImage(source: ImageSource.gallery);

                                                                      if (returnedImage ==
                                                                          null) {
                                                                        return;
                                                                      }

                                                                      setState(
                                                                          () {
                                                                        profileController =
                                                                            File(returnedImage.path);
                                                                      });
                                                                    },
                                                                    child:
                                                                        Container(
                                                                      width:
                                                                          100,
                                                                      height:
                                                                          100,
                                                                      padding: const EdgeInsets
                                                                          .all(
                                                                          15),
                                                                      decoration: BoxDecoration(
                                                                          shape: BoxShape
                                                                              .circle,
                                                                          color:
                                                                              Colors.grey[300]),
                                                                      child: profileController !=
                                                                              null
                                                                          ? Image.file(
                                                                              profileController!)
                                                                          : const Icon(
                                                                              Icons.image_search_rounded,
                                                                              size: 20),
                                                                    ),
                                                                  ),

                                                                  const SizedBox(
                                                                      height:
                                                                          10),

                                                                  // name text field
                                                                  MyTextField(
                                                                      hintText:
                                                                          "Plant Name",
                                                                      iconData:
                                                                          Icons
                                                                              .data_object,
                                                                      controller:
                                                                          plantNameController,
                                                                      obscureText:
                                                                          false),

                                                                  const SizedBox(
                                                                      height:
                                                                          10),

                                                                  // description text field
                                                                  MyTextField(
                                                                      hintText:
                                                                          "Plant Description",
                                                                      iconData:
                                                                          Icons
                                                                              .description,
                                                                      controller:
                                                                          plantDescriptionController,
                                                                      obscureText:
                                                                          false),

                                                                  const SizedBox(
                                                                      height:
                                                                          10),

                                                                  // seeding time
                                                                  MyTextField(
                                                                      hintText:
                                                                          "Seeding Time",
                                                                      iconData:
                                                                          Icons
                                                                              .timelapse_outlined,
                                                                      controller:
                                                                          seedingTimeController,
                                                                      obscureText:
                                                                          false),

                                                                  const SizedBox(
                                                                      height:
                                                                          10),

                                                                  // planting time
                                                                  MyTextField(
                                                                      hintText:
                                                                          "Planting Time",
                                                                      iconData:
                                                                          Icons
                                                                              .timelapse_outlined,
                                                                      controller:
                                                                          plantingTimeController,
                                                                      obscureText:
                                                                          false),

                                                                  const SizedBox(
                                                                      height:
                                                                          10),

                                                                  // ph
                                                                  MyTextField(
                                                                      hintText:
                                                                          "pH Value",
                                                                      iconData:
                                                                          Icons
                                                                              .gas_meter_outlined,
                                                                      controller:
                                                                          pHValueController,
                                                                      obscureText:
                                                                          false),

                                                                  const SizedBox(
                                                                      height:
                                                                          10),

                                                                  // temp
                                                                  MyTextField(
                                                                      hintText:
                                                                          "Temp Value",
                                                                      iconData:
                                                                          Icons
                                                                              .device_thermostat_outlined,
                                                                      controller:
                                                                          tempController,
                                                                      obscureText:
                                                                          false),

                                                                  const SizedBox(
                                                                      height:
                                                                          10),

                                                                  // tds
                                                                  MyTextField(
                                                                      hintText:
                                                                          "Tds Value",
                                                                      iconData:
                                                                          Icons
                                                                              .electric_meter_outlined,
                                                                      controller:
                                                                          tdsController,
                                                                      obscureText:
                                                                          false),
                                                                ],
                                                              ),
                                                            );
                                                          }),
                                                          actions: [
                                                            TextButton(
                                                                onPressed: () {
                                                                  setState(() {
                                                                    profileController ==
                                                                        null;
                                                                  });
                                                                  plantNameController
                                                                      .clear();
                                                                  plantDescriptionController
                                                                      .clear();
                                                                  seedingTimeController
                                                                      .clear();
                                                                  plantingTimeController
                                                                      .clear();
                                                                  pHValueController
                                                                      .clear();
                                                                  tempController
                                                                      .clear();
                                                                  tdsController
                                                                      .clear();
                                                                  Navigator.pop(
                                                                      context);
                                                                },
                                                                child: Text(
                                                                    "Cancel",
                                                                    style: GoogleFonts.urbanist(
                                                                        fontWeight:
                                                                            FontWeight
                                                                                .w900,
                                                                        color: ColorsAsset
                                                                            .red))),
                                                            TextButton(
                                                                onPressed:
                                                                    () async {
                                                                  showDialog(
                                                                      context:
                                                                          context,
                                                                      builder: (context) =>
                                                                          Center(
                                                                              child: CircularProgressIndicator(color: ColorsAsset.primary)));
                                                                  if (plantNameController.text.isNotEmpty &&
                                                                      seedingTimeController
                                                                          .text
                                                                          .isNotEmpty &&
                                                                      plantingTimeController
                                                                          .text
                                                                          .isNotEmpty &&
                                                                      pHValueController
                                                                          .text
                                                                          .isNotEmpty &&
                                                                      tempController
                                                                          .text
                                                                          .isNotEmpty &&
                                                                      tdsController
                                                                          .text
                                                                          .isNotEmpty) {
                                                                    String
                                                                        fileName =
                                                                        DateTime.now()
                                                                            .microsecondsSinceEpoch
                                                                            .toString();

                                                                    Reference
                                                                        referenceRoot =
                                                                        FirebaseStorage
                                                                            .instance
                                                                            .ref();
                                                                    Reference
                                                                        referenceDireImages =
                                                                        referenceRoot
                                                                            .child("plants");

                                                                    Reference
                                                                        referenceImageToUpload =
                                                                        referenceDireImages
                                                                            .child(fileName);

                                                                    await referenceImageToUpload
                                                                        .putFile(
                                                                            File(profileController!.path));

                                                                    var imageUrl =
                                                                        await referenceImageToUpload
                                                                            .getDownloadURL();

                                                                    try {
                                                                      await FirebaseFirestore
                                                                          .instance
                                                                          .collection(
                                                                              "Users")
                                                                          .doc(currentUser!
                                                                              .email)
                                                                          .collection(
                                                                              "myPlants")
                                                                          .doc(plantNameController
                                                                              .text)
                                                                          .set({
                                                                        "profileName":
                                                                            fileName,
                                                                        "plantProfile":
                                                                            imageUrl,
                                                                        "plantName":
                                                                            plantNameController.text,
                                                                        "plantDescription":
                                                                            plantNameController.text,
                                                                        "seedingTime":
                                                                            seedingTimeController.text,
                                                                        "plantingTime":
                                                                            plantingTimeController.text,
                                                                        "pH": pHValueController
                                                                            .text,
                                                                        "temp":
                                                                            tempController.text,
                                                                        "tds": tdsController
                                                                            .text
                                                                      });
                                                                      setState(
                                                                          () {
                                                                        profileController =
                                                                            null;
                                                                      });
                                                                      plantNameController
                                                                          .clear();
                                                                      plantDescriptionController
                                                                          .clear();
                                                                      seedingTimeController
                                                                          .clear();
                                                                      plantingTimeController
                                                                          .clear();
                                                                      pHValueController
                                                                          .clear();
                                                                      tempController
                                                                          .clear();
                                                                      tdsController
                                                                          .clear();
                                                                      Navigator.pop(
                                                                          context);
                                                                      Navigator.pop(
                                                                          context);
                                                                    } catch (error) {
                                                                      Navigator.pop(
                                                                          context);
                                                                      showDialog(
                                                                          context:
                                                                              context,
                                                                          builder: (context) =>
                                                                              AlertDialog(
                                                                                title: Text("Error", style: GoogleFonts.urbanist(fontWeight: FontWeight.w900, color: ColorsAsset.red)),
                                                                                content: Text(error.toString(), style: GoogleFonts.urbanist(fontWeight: FontWeight.w900, color: ColorsAsset.red)),
                                                                                actions: [
                                                                                  TextButton(
                                                                                    onPressed: () {
                                                                                      Navigator.pop(context);
                                                                                    },
                                                                                    child: Text("OK", style: GoogleFonts.urbanist(fontWeight: FontWeight.w900, color: ColorsAsset.primary)),
                                                                                  )
                                                                                ],
                                                                              ));
                                                                    }
                                                                  } else {
                                                                    Navigator.pop(
                                                                        context);
                                                                    showDialog(
                                                                        context:
                                                                            context,
                                                                        builder: (context) =>
                                                                            AlertDialog(
                                                                              title: Text("Error", style: GoogleFonts.urbanist(fontWeight: FontWeight.w900, color: ColorsAsset.red)),
                                                                              content: Text("Please fill all the textfields", style: GoogleFonts.urbanist(fontWeight: FontWeight.w900, color: ColorsAsset.dark)),
                                                                              actions: [
                                                                                TextButton(
                                                                                    onPressed: () {
                                                                                      Navigator.pop(context);
                                                                                      Navigator.pop(context);
                                                                                    },
                                                                                    child: Text("OK", style: GoogleFonts.urbanist(fontWeight: FontWeight.w900, color: ColorsAsset.primary)))
                                                                              ],
                                                                            ));
                                                                  }
                                                                },
                                                                child: Text(
                                                                    "OK",
                                                                    style: GoogleFonts.urbanist(
                                                                        fontWeight:
                                                                            FontWeight
                                                                                .w900,
                                                                        color: ColorsAsset
                                                                            .primary)))
                                                          ],
                                                        ),
                                                      );
                                                    },
                                                    child: Padding(
                                                      padding: const EdgeInsets
                                                          .symmetric(
                                                          horizontal: 15,
                                                          vertical: 10),
                                                      child: Container(
                                                        width: double.infinity,
                                                        height: 45,
                                                        decoration: BoxDecoration(
                                                            color: ColorsAsset
                                                                .primary,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        50)),
                                                        child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          children: [
                                                            const Icon(
                                                                Icons.add,
                                                                size: 26,
                                                                color: Colors
                                                                    .white),
                                                            const SizedBox(
                                                                width: 5),
                                                            Text("Add Plant",
                                                                style: GoogleFonts.urbanist(
                                                                    fontSize:
                                                                        24,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w900,
                                                                    color: Colors
                                                                        .white)),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  );
                                          },
                                        );
                                      } else if (snapshot.hasError) {
                                        return Text("Error fetching data...",
                                            style: GoogleFonts.urbanist(
                                                fontSize: 36,
                                                fontWeight: FontWeight.w900,
                                                color: ColorsAsset.dark));
                                      } else {
                                        return Center(
                                            child: CircularProgressIndicator(
                                                color: ColorsAsset.primary));
                                      }
                                    }),
                              ],
                            ),
                          ))
                    ],
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
