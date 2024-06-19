import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hydrobox/utils/color_asset.dart';

class MyTextField extends StatelessWidget {
  final String hintText;
  final IconData iconData;
  final TextEditingController controller;
  final bool obscureText;
  const MyTextField(
      {super.key,
      required this.hintText,
      required this.iconData,
      required this.controller,
      required this.obscureText});

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      obscureText: obscureText,
      style: GoogleFonts.urbanist(
          fontWeight: FontWeight.w900, color: ColorsAsset.dark, fontSize: 18),
      cursorColor: ColorsAsset.primary,
      decoration: InputDecoration(
          hintText: hintText,
          prefixIcon: Padding(
            padding: const EdgeInsets.only(left: 15, right: 10),
            child: Icon(iconData, size: 30, color: ColorsAsset.dark),
          ),
          hintStyle: GoogleFonts.urbanist(
            fontSize: 20,
            fontWeight: FontWeight.w900,
            color: ColorsAsset.darkGray,
          ),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5),
              borderSide: BorderSide(width: 4, color: ColorsAsset.darkGray)),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5),
              borderSide: BorderSide(width: 4, color: ColorsAsset.darkGray))),
    );
  }
}
