import 'package:flutter/material.dart';
import 'dart:async';
import 'onboarding_screen.dart'; // Import your onboarding screen file
// Import the Lottie package if you haven't already
// import 'package:lottie/lottie.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 5), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => OnboardingScreen()), // Navigate to OnboardingScreen
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF5ac0e5), // Use the color from the first image
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Replace with your logo image
            Image.asset(
                'assets/image-removebg-preview.png'), // Replace with your logo image path
            // Gap between logo and animation
            // Placeholder for Lottie Animation (Pencil and Eraser)

          ],
        ),
      ),
    );
  }
}