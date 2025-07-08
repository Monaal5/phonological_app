import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import 'main_screen.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final controller = PageController();
  bool isLastPage = false;

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.only(bottom: 80),
        child: PageView(
          controller: controller,
          onPageChanged: (index) {
            setState(() => isLastPage = index == 2);
          },
          children: [
            buildPage(
              color:  Colors.yellow.shade100,
              lottie: "assets/Animation - 1751536761107.json",
              title: "Welcome to PhonoPlay",
              subtitle: "Where sounds come to life and learning feels like play!",
            ),
            buildPage(
              color: Colors.yellow.shade100,
              lottie: "assets/Animation - 1751539841858.json",
              title: "Let’s Talk, Play & Learn",
              subtitle:
              "Join our friendly bear to explore sounds, words, and fun games",
            ),
            buildPage(
              color: Colors.yellow.shade100,
              lottie: "assets/Animation - 1751539934814.json",
              title: "Smart Score: Track, Learn, Win",
              subtitle:
              "Every sound you master earns points—watch your smart score grow as you play and learn!",
            ),
          ],
        ),
      ),
      bottomSheet: isLastPage
          ? TextButton(
        style: TextButton.styleFrom(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.zero),
          foregroundColor: Colors.white,
          backgroundColor: Colors.teal.shade700,
          minimumSize: const Size.fromHeight(80),
        ),
        onPressed: () {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (context) => const MainScreen(),
            ),
          );
        },
        child: const Text(
          "Get Started",
          style: TextStyle(fontSize: 24),
        ),
      )
          : Container(
        padding: const EdgeInsets.symmetric(horizontal: 9),
        height: 80,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TextButton(
              onPressed: () => controller.jumpToPage(2),
              child: const Text("Skip"
              , style: TextStyle(fontSize: 20),),
            ),
            SmoothPageIndicator(
              controller: controller,
              count: 3,
              effect: WormEffect(
                spacing: 16,
                dotColor: Colors.black26,
                activeDotColor: Colors.teal.shade700,
              ),
            ),
            TextButton(
              onPressed: () => controller.nextPage(
                duration: const Duration(milliseconds: 500),
                curve: Curves.easeInOut,
              ),
              child: const Text("Next",
                style: TextStyle(fontSize: 20),),
            ),
          ],
        ),
      ),
    );
  }
}

Widget buildPage({
  required Color color,
  required String lottie,
  required String title,
  required String subtitle,
}) =>
    Container(
      color: color,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Lottie.asset(
            lottie,
            fit: BoxFit.cover,
            width: double.infinity,
          ),
          const SizedBox(height: 64),
          Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Color(0xffff6f92),
              fontSize: 32,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 24),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32),
            child: Text(
              subtitle,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Colors.black,
                fontSize: 18,
                  fontWeight: FontWeight.bold
              ),
            ),
          ),
        ],
      ),
    );
