import 'package:flutter/material.dart';

import 'package:test_app/splash_screen.dart';



void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Future.delayed(Duration(seconds: 3)); // simulate loading delay

  runApp(const TalkingBearApp());
}

class TalkingBearApp extends StatelessWidget {
  const TalkingBearApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Talking Bear Phonological App',
      home:  SplashScreen(),
    );
  }
}

