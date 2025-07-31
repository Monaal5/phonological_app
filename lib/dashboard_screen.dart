import 'package:flutter/material.dart';
import 'dart:ui';
import 'dart:math' as math;
import 'home_screen.dart';
import 'main_screen.dart';
import 'result_db.dart';

class TestResult {
  final String testID;
  final String testTitle;
  final String date;
  final String time;
  final String score;
  final String correctAnswers;
  final String wrongAnswers;

  TestResult({
    required this.testID,
    required this.testTitle,
    required this.date,
    required this.time,
    required this.score,
    required this.correctAnswers,
    required this.wrongAnswers,
  });
}

class DashboardScreen extends StatefulWidget {
  DashboardScreen({super.key});
  @override
  DashboardScreenState createState() => DashboardScreenState();
}

class PieChartPainter extends CustomPainter {
  final double correctPercentage;
  final double wrongPercentage;

  PieChartPainter({
    required this.correctPercentage,
    required this.wrongPercentage,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = math.min(size.width, size.height) / 2 - 10;

    // Correct answers (green)
    final correctPaint = Paint()
      ..color = Colors.green
      ..style = PaintingStyle.fill;

    // Wrong answers (red)
    final wrongPaint = Paint()
      ..color = Colors.red
      ..style = PaintingStyle.fill;

    // Border paint
    final borderPaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;

    // Calculate angles
    final correctAngle = correctPercentage * 2 * math.pi;
    final wrongAngle = wrongPercentage * 2 * math.pi;

    // Draw correct slice
    if (correctPercentage > 0) {
      canvas.drawArc(
        Rect.fromCircle(center: center, radius: radius),
        -math.pi / 2,
        correctAngle,
        true,
        correctPaint,
      );
    }

    // Draw wrong slice
    if (wrongPercentage > 0) {
      canvas.drawArc(
        Rect.fromCircle(center: center, radius: radius),
        -math.pi / 2 + correctAngle,
        wrongAngle,
        true,
        wrongPaint,
      );
    }

    // Draw border
    canvas.drawCircle(center, radius, borderPaint);

    // Draw center circle for donut effect
    final centerPaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;

    canvas.drawCircle(center, radius * 0.4, centerPaint);
    canvas.drawCircle(center, radius * 0.4, borderPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
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
    final res = await rd.getDB();
    setState(() {
      results = res;
    });
  }

  void _showDetailedResult(Map<dynamic, dynamic> result) {
    print('Showing detailed result for: ${result['testTitle']}'); // Debug print
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return AlertDialog(
          contentPadding: EdgeInsets.zero,
          backgroundColor: Colors.transparent,
          content: Container(
            width: MediaQuery.of(context).size.width * 0.9,
            constraints: BoxConstraints(
              maxHeight: MediaQuery.of(context).size.height * 0.85,
            ),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.3),
                  blurRadius: 20,
                  offset: Offset(0, 10),
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Header with close button
                Container(
                  padding: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Color(0xFF26C6DA), Color(0xFF00ACC1)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                    ),
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.analytics, color: Colors.white, size: 28),
                      SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          'Test Results',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          print('Close button tapped'); // Debug print
                          Navigator.of(context).pop();
                        },
                        child: Container(
                          padding: EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Icon(
                            Icons.close,
                            color: Colors.white,
                            size: 20,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                // Content
                Flexible(
                  child: SingleChildScrollView(
                    padding: EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Test Title
                        _buildDetailRow(
                          'Test Title',
                          result['testTitle']?.toString() ?? 'N/A',
                          Icons.quiz,
                          Color(0xFF26C6DA),
                        ),
                        SizedBox(height: 15),

                        // Test ID
                        _buildDetailRow(
                          'Test ID',
                          result['testID']?.toString() ?? 'N/A',
                          Icons.tag,
                          Colors.orange,
                        ),
                        SizedBox(height: 15),

                        // Date & Time
                        Row(
                          children: [
                            Expanded(
                              child: _buildDetailRow(
                                'Date',
                                result['date']?.toString() ?? 'N/A',
                                Icons.calendar_today,
                                Colors.green,
                              ),
                            ),
                            SizedBox(width: 10),
                            Expanded(
                              child: _buildDetailRow(
                                'Time',
                                result['time']?.toString() ?? 'N/A',
                                Icons.access_time,
                                Colors.purple,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 20),

                        // Score Display
                        _buildScoreCard(result['score']?.toString() ?? '0'),
                        SizedBox(height: 20),

                        // Answers breakdown
                        Row(
                          children: [
                            Expanded(
                              child: _buildAnswerCard(
                                'Correct',
                                result['correctAnswers']?.toString() ?? '0',
                                Colors.green,
                                Icons.check_circle,
                              ),
                            ),
                            SizedBox(width: 10),
                            Expanded(
                              child: _buildAnswerCard(
                                'Wrong',
                                result['wrongAnswers']?.toString() ?? '0',
                                Colors.red,
                                Icons.cancel,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 15),

                        // Total Questions
                        _buildAnswerCard(
                          'Total Questions',
                          _getTotalQuestions(result).toString(),
                          Colors.blue,
                          Icons.quiz_outlined,
                        ),
                        SizedBox(height: 20),

                        // Pie Chart Section
                        Container(
                          width: double.infinity,
                          padding: EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: Colors.grey[50],
                            borderRadius: BorderRadius.circular(15),
                            border: Border.all(color: Colors.grey[300]!),
                          ),
                          child: Column(
                            children: [
                              Text(
                                'Performance Overview',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black87,
                                ),
                              ),
                              SizedBox(height: 20),
                              Container(
                                height: 200,
                                child: _buildPieChart(result),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildDetailRow(String label, String value, IconData icon, Color color) {
    return Container(
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, color: Colors.white, size: 16),
          ),
          SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey[600],
                  fontWeight: FontWeight.w500,
                ),
              ),
              Text(
                value,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildScoreCard(String score) {
    double scoreValue = double.tryParse(score) ?? 0.0;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: scoreValue >= 70
              ? [Colors.green[400]!, Colors.green[600]!]
              : scoreValue >= 50
              ? [Colors.orange[400]!, Colors.orange[600]!]
              : [Colors.red[400]!, Colors.red[600]!],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 8,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          Icon(Icons.star, color: Colors.white, size: 35),
          SizedBox(height: 10),
          Text(
            'Final Score',
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
          Text(
            '${scoreValue.toStringAsFixed(0)}%',
            style: TextStyle(
              color: Colors.white,
              fontSize: 32,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 5),
          Text(
            _getScoreText(scoreValue),
            style: TextStyle(
              color: Colors.white,
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPieChart(Map<dynamic, dynamic> result) {
    int correct = int.tryParse(result['correctAnswers']?.toString() ?? '0') ?? 0;
    int wrong = int.tryParse(result['wrongAnswers']?.toString() ?? '0') ?? 0;
    int total = correct + wrong;

    if (total == 0) {
      return Center(
        child: Text(
          'No data available',
          style: TextStyle(
            fontSize: 16,
            color: Colors.grey[600],
          ),
        ),
      );
    }

    double correctPercentage = correct / total;
    double wrongPercentage = wrong / total;

    return Row(
      children: [
        // Pie Chart
        Expanded(
          flex: 2,
          child: Container(
            height: 150,
            child: CustomPaint(
              painter: PieChartPainter(
                correctPercentage: correctPercentage,
                wrongPercentage: wrongPercentage,
              ),
              child: Container(),
            ),
          ),
        ),
        SizedBox(width: 20),
        // Legend
        Expanded(
          flex: 1,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildLegendItem(
                'Correct',
                correct.toString(),
                Colors.green,
                '${(correctPercentage * 100).toStringAsFixed(1)}%',
              ),
              SizedBox(height: 15),
              _buildLegendItem(
                'Wrong',
                wrong.toString(),
                Colors.red,
                '${(wrongPercentage * 100).toStringAsFixed(1)}%',
              ),
              SizedBox(height: 15),
              _buildLegendItem(
                'Total',
                total.toString(),
                Colors.grey[600]!,
                '100%',
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildLegendItem(String label, String count, Color color, String percentage) {
    return Row(
      children: [
        Container(
          width: 12,
          height: 12,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
          ),
        ),
        SizedBox(width: 8),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: Colors.black87,
                ),
              ),
              Text(
                '$count ($percentage)',
                style: TextStyle(
                  fontSize: 11,
                  color: Colors.grey[600],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildAnswerCard(String label, String count, Color color, IconData icon) {
    return Container(
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Icon(icon, color: Colors.white, size: 20),
          ),
          SizedBox(height: 8),
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              color: Colors.grey[600],
              fontWeight: FontWeight.w500,
            ),
          ),
          Text(
            count,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
        ],
      ),
    );
  }

  String _getScoreText(double score) {
    if (score >= 90) return 'Excellent!';
    if (score >= 80) return 'Very Good!';
    if (score >= 70) return 'Good!';
    if (score >= 60) return 'Fair';
    if (score >= 50) return 'Needs Improvement';
    return 'Keep Practicing!';
  }

  int _getTotalQuestions(Map<dynamic, dynamic> result) {
    int correct = int.tryParse(result['correctAnswers']?.toString() ?? '0') ?? 0;
    int wrong = int.tryParse(result['wrongAnswers']?.toString() ?? '0') ?? 0;
    return correct + wrong;
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
            );
          },
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
              GestureDetector(
                onTap: () => _showDetailedResult(result),
                child: FeatureCard(
                  icon: Icons.dashboard_outlined,
                  color: Colors.blueGrey,
                  title: (result['testTitle']),
                  subtitle:
                  'Test ID: ${result['testID']} • Date: ${result['date']} • Time: ${result['time']}. Score: ${result['score']}',
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}




