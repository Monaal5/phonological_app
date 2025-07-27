import 'package:flutter/material.dart';
import 'home_screen.dart';
import 'main_screen.dart';
import 'result_db.dart';


class TestResult  {
  final String testID;
  final String testTitle;
  final String date;
  final String time;
  final String score;

  TestResult({
    required this.testID,
    required this.testTitle,
    required this.date,
    required this.time,
    required this.score,
  });
}







class DashboardScreen extends StatefulWidget{
  DashboardScreen({super.key});
  @override
  DashboardScreenState createState() => DashboardScreenState();


}



class DashboardScreenState extends State<DashboardScreen> {
  final ResultDataBase rd = ResultDataBase();
  List<Map<dynamic, dynamic>> results = [];

  @override
  void initState() {
    super.initState();
    fetchResults();
  }


  Future<void> fetchResults() async {
    await rd.createDB();
    final res = await rd.getDB(); // Use your getResults() method
    setState(() {
      results = res;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF26C6DA),

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
        title: const Text('Previous Test Results'),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: ListView.builder(

        itemCount: results.length,
        itemBuilder: (context, index) {
          final result = results[index];


          return Column(
            children: [
              FeatureCard(
                icon: Icons.dashboard_outlined,
                color: Colors.blueGrey,
                title: (result['testTitle']),
                subtitle:
                'Test ID: ${result['testID']} • Date: ${result['date']} • Time: ${result['time']}. Score: ${result['score']}',
                // trailing: Text('Score: ${result.score}'),

              ),


            ],
          );
        },
      ),
    );
  }
}