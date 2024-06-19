import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hydrobox/utils/color_asset.dart';

class MyButton extends StatelessWidget {
  final text;
  const MyButton({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 55,
      decoration: BoxDecoration(
          color: ColorsAsset.primary, borderRadius: BorderRadius.circular(50)),
      child: Center(
        child: Text(text,
            style: GoogleFonts.urbanist(
                fontSize: 24,
                fontWeight: FontWeight.w900,
                color: Colors.white)),
      ),
    );
  }
}
