import 'package:flutter/material.dart';
import 'package:test_app/onboarding_screen.dart';
import 'package:test_app/phonological_test_buttons.dart';


void main() {
  runApp(const TalkingBearApp());
}

class TalkingBearApp extends StatelessWidget {
  const TalkingBearApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Talking Bear Phonological App',
      home: const OnboardingScreen(),
    );
  }
}

