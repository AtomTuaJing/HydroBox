import 'package:flutter/material.dart';
import 'package:hydrobox/pages/sign_in_page.dart';
import 'package:hydrobox/pages/sign_up_page.dart';

class SignInOrSignUp extends StatefulWidget {
  const SignInOrSignUp({super.key});

  @override
  State<SignInOrSignUp> createState() => _SignInOrSignUpState();
}

class _SignInOrSignUpState extends State<SignInOrSignUp> {
  // initially sign in page
  bool isSignIn = true;

  void toggleSignIn() {
    setState(() {
      isSignIn = !isSignIn;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (isSignIn) {
      return SignInPage(toggleSignIn: toggleSignIn);
    } else {
      return SignUpPage(toggleSignIn: toggleSignIn);
    }
  }
}
