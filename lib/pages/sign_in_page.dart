import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hydrobox/components/my_button.dart';
import 'package:hydrobox/components/my_textfield.dart';
import 'package:hydrobox/utils/color_asset.dart';

class SignInPage extends StatefulWidget {
  final Function()? toggleSignIn;
  const SignInPage({super.key, required this.toggleSignIn});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  // controllers
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  // sign in method
  void signIn() async {
    // show loading circle
    showDialog(
        context: context,
        builder: (context) => Center(
            child: CircularProgressIndicator(color: ColorsAsset.primary)));

    // try sign in
    try {
      if (emailController.text != "" && passwordController.text != "") {
        await FirebaseAuth.instance.signInWithEmailAndPassword(
            email: emailController.text, password: passwordController.text);
        if (mounted) Navigator.pop(context);
      }
    } on FirebaseException catch (e) {
      Navigator.pop(context);
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
              Image.asset("assets/top.png"),

              // body
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // sign in
                    Text("Sign In",
                        style: GoogleFonts.urbanist(
                            fontSize: 40,
                            fontWeight: FontWeight.w900,
                            color: ColorsAsset.primary)),

                    const SizedBox(height: 40),

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
                      iconData: Icons.lock_outline,
                      controller: passwordController,
                      obscureText: true,
                    ),

                    const SizedBox(height: 25),

                    // sign in button
                    GestureDetector(
                        onTap: signIn, child: const MyButton(text: "Sign In")),

                    const SizedBox(height: 120),

                    // Don't have an account? Create One
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Dont't have an account?",
                            style: GoogleFonts.urbanist(
                                fontSize: 16,
                                fontWeight: FontWeight.w900,
                                color: ColorsAsset.dark)),
                        const SizedBox(width: 5),
                        GestureDetector(
                          onTap: widget.toggleSignIn,
                          child: Text("Create One",
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
