import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hydrobox/components/my_button.dart';
import 'package:hydrobox/components/my_textfield.dart';
import 'package:hydrobox/utils/color_asset.dart';

class SignUpPage extends StatefulWidget {
  final Function()? toggleSignIn;
  const SignUpPage({super.key, required this.toggleSignIn});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  // controllers
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  // sign in method
  void signUp() async {
    // show loading circle
    showDialog(
        context: context,
        builder: (context) => Center(
            child: CircularProgressIndicator(color: ColorsAsset.primary)));

    // try sign in
    try {
      if (emailController.text != "" &&
          passwordController.text != "" &&
          confirmPasswordController.text != "") {
        if (passwordController.text == confirmPasswordController.text) {
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
              email: emailController.text, password: passwordController.text);
          if (mounted) Navigator.pop(context);
        } else {
          if (mounted) Navigator.pop(context);
          showErrorMessage("Your passwords are not matching..");
        }
      }
    } on FirebaseException catch (e) {
      if (mounted) Navigator.pop(context);
      showErrorMessage(e.code);
    }
  }

  // show message
  void showErrorMessage(String message) {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              backgroundColor: Colors.white,
              title: Text("Error",
                  style: GoogleFonts.urbanist(
                    fontWeight: FontWeight.w900,
                  )),
              content: Text(message,
                  style: GoogleFonts.urbanist(
                    fontWeight: FontWeight.w900,
                  )),
              actions: [
                TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text("OK",
                        style: GoogleFonts.urbanist(
                            fontWeight: FontWeight.w900,
                            color: ColorsAsset.primary)))
              ],
            ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // top
              Image.asset("assets/top2.png", width: double.infinity),

              // body
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // sign up
                    Text("Sign Up",
                        style: GoogleFonts.urbanist(
                            fontSize: 40,
                            fontWeight: FontWeight.w900,
                            color: ColorsAsset.primary)),

                    const SizedBox(height: 20),

                    // email textfield
                    MyTextField(
                      hintText: "Email",
                      iconData: Icons.account_circle_outlined,
                      controller: emailController,
                      obscureText: false,
                    ),

                    const SizedBox(height: 10),

                    // password textfield
                    MyTextField(
                      hintText: "Password",
                      iconData: Icons.account_circle_outlined,
                      controller: passwordController,
                      obscureText: true,
                    ),

                    const SizedBox(height: 10),

                    // confirm password textfield
                    MyTextField(
                      hintText: "Confirm Password",
                      iconData: Icons.lock_outline,
                      controller: confirmPasswordController,
                      obscureText: true,
                    ),

                    const SizedBox(height: 25),

                    // sign up button
                    GestureDetector(
                        onTap: signUp, child: const MyButton(text: "Sign Up")),

                    const SizedBox(height: 60),

                    // Already have an account? Sign In
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Already have an account?",
                            style: GoogleFonts.urbanist(
                                fontSize: 16,
                                fontWeight: FontWeight.w900,
                                color: ColorsAsset.dark)),
                        const SizedBox(width: 5),
                        GestureDetector(
                          onTap: widget.toggleSignIn,
                          child: Text("Sign In",
                              style: GoogleFonts.urbanist(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w900,
                                  color: ColorsAsset.primary)),
                        )
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
