import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'SigninSignup/signup.dart';
import 'study.dart';  // Import StudyPage

class InitScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    _checkAuthenticationStatus(context);
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: CircularProgressIndicator(), // Display a loading indicator
      ),
    );
  }

  void _checkAuthenticationStatus(BuildContext context) async {
    final User? user = FirebaseAuth.instance.currentUser;
    await Future.delayed(Duration(seconds: 1)); // Simulate a delay for splash screen
    if (user != null) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => StudyPage()),
      );
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => SignUpPage()),
      );
    }
  }
}
