import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hydrobox/utils/color_asset.dart';

class AccountPage extends StatelessWidget {
  AccountPage({super.key});

  final currentUser = FirebaseAuth.instance.currentUser;

  void signOut() async {
    await FirebaseAuth.instance.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: ColorsAsset.primary,
        title: Text("Account",
            style: GoogleFonts.urbanist(
                fontSize: 20,
                fontWeight: FontWeight.w900,
                color: Colors.white)),
      ),
      body: Column(
        children: [
          // top + hello user
          Stack(
            children: [
              // top image
              Image.asset("assets/top.png", width: 360, height: 205),

              // hello user
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 30),
                child: Row(
                  children: [
                    // user profile
                    Image.asset(
                      "assets/user.png",
                      width: 85,
                    ),

                    const SizedBox(width: 15),

                    // hello user
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Hello,",
                            style: GoogleFonts.urbanist(
                                fontSize: 20,
                                fontWeight: FontWeight.w900,
                                color: Colors.white,
                                height: 1)),
                        Text(currentUser!.email!.split("@")[0],
                            style: GoogleFonts.urbanist(
                                fontSize: 24,
                                fontWeight: FontWeight.w900,
                                color: Colors.white,
                                height: 1)),
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),

          const SizedBox(height: 25),

          // interacting button
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Column(
              children: [
                // edit profile button
                SizedBox(
                  width: double.infinity,
                  child: Row(
                    children: [
                      // edit icon
                      Icon(Icons.border_color_outlined,
                          size: 30, color: ColorsAsset.dark),

                      const SizedBox(width: 5),

                      // Edit Profile
                      Text("Edit Profile",
                          style: GoogleFonts.urbanist(
                              fontSize: 24,
                              fontWeight: FontWeight.w900,
                              color: ColorsAsset.dark))
                    ],
                  ),
                ),

                const SizedBox(height: 15),

                const Divider(thickness: 2),

                const SizedBox(height: 15),

                // sign out button
                GestureDetector(
                  onTap: signOut,
                  child: SizedBox(
                    width: double.infinity,
                    child: Row(
                      children: [
                        // edit icon
                        Icon(Icons.logout, size: 30, color: ColorsAsset.red),

                        const SizedBox(width: 5),

                        // Edit Profile
                        Text("Sign Out",
                            style: GoogleFonts.urbanist(
                                fontSize: 24,
                                fontWeight: FontWeight.w900,
                                color: ColorsAsset.red))
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
