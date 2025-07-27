
import 'package:flutter/material.dart';
import 'main_screen.dart';
import 'test_page.dart';
class BearHomePage extends StatefulWidget {
  const BearHomePage({super.key});

  @override
  State<BearHomePage> createState() => _BearHomePageState();
}

class _BearHomePageState extends State<BearHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.orange[50],
      appBar: AppBar(
        leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (context) => const MainScreen(),
                ),
              );}
        ),
        title: const Text(' Phonological Assessment'),
        backgroundColor: Colors.deepOrangeAccent,
        foregroundColor: Colors.white,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            const Text(
              'Choose a Phonological Test',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.deepOrange,
              ),
            ),
            const SizedBox(height: 30),
            Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: 20,
                mainAxisSpacing: 20,
                children: [
                  _testCard(context, 'Rhyming', Icons.music_note, Colors.red, () {
                    Navigator.push(context, MaterialPageRoute(
                      builder: (context) => const TestPage(title : 'Rhyming'),
                    ));
                  }),
                  _testCard(context, 'Syllables', Icons.audiotrack, Colors.blue, () {
                    Navigator.push(context, MaterialPageRoute(
                      builder: (context) => const TestPage(title : 'Syllables'),
                    ));
                  }),
                  _testCard(context, 'Segmenting', Icons.scatter_plot, Colors.green, () {
                    Navigator.push(context, MaterialPageRoute(
                      builder: (context) => const TestPage(title: 'Segmenting'),
                    ));
                  }),
                  _testCard(context, 'Blending', Icons.merge, Colors.purple, () {
                    Navigator.push(context, MaterialPageRoute(
                      builder: (context) => const TestPage(title: 'Blending'),
                    ));
                  }),
                  _testCard(context, 'InitialSound', Icons.text_fields, Colors.orange, () {
                    Navigator.push(context, MaterialPageRoute(
                      builder: (context) => const TestPage(title: 'InitialSound'),
                    ));
                  }),
                  _testCard(context, 'FinalSound', Icons.text_fields, Colors.teal, () {
                    Navigator.push(context, MaterialPageRoute(
                      builder: (context) => const TestPage(title: 'FinalSound'),
                    ));
                  }),
                  _testCard(context, 'MiddleSound', Icons.text_fields, Colors.indigo, () {
                    Navigator.push(context, MaterialPageRoute(
                      builder: (context) => const TestPage(title: 'MiddleSound'),
                    ));
                  }),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _testCard(BuildContext context, String title, IconData icon, Color color, VoidCallback onTap) {
    return Card(
      elevation: 8,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(15),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [color.withOpacity(0.8), color],
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 50, color: Colors.white),
              const SizedBox(height: 10),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}