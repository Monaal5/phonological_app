import 'package:flutter/material.dart';

import 'main_screen.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
          title: Text('Dashboard'),
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        extendBodyBehindAppBar: true,
        body: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Colors.blue[400]!,
                Colors.blue[900]!,
              ],
            ),
          ),
          child: ListView(
              padding: EdgeInsets.only(top: AppBar().preferredSize.height + MediaQuery.of(context).padding.top + 20, left: 16, right: 16),
              children: [
                Text(
                  'Dashboard',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  'Your practice overview',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white70,
                  ),
                ),
                SizedBox(height: 24),
                GridView.count(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  crossAxisCount: 2,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                  children: [
                    // Placeholder Statistics Cards
                    Card(
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Icon(Icons.people, color: Colors.blue),
                                Text(
                                  '+12%',
                                  style: TextStyle(color: Colors.green),
                                ),
                              ],
                            ),
                            SizedBox(height: 8),
                            Column(
                              children: [
                                Icon(Icons.people),
                                SizedBox(height: 8),
                                Text('24'),
                                Text('Active Patients'),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    Card(
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Icon(Icons.trending_up, color: Colors.green),
                                Text(
                                  '+5%',
                                  style: TextStyle(color: Colors.green),
                                ),
                              ],
                            ),
                            SizedBox(height: 8),
                            Column(
                              children: [
                                Icon(Icons.trending_up),
                                SizedBox(height: 8),
                                Text('94%'),
                                Text('Success Rate'),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    Card(
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Icon(Icons.calendar_today, color: Colors.orange),
                                Text('+3', style: TextStyle(color: Colors.green)),
                              ],
                            ),
                            SizedBox(height: 8),
                            Column(
                              children: [
                                Icon(Icons.calendar_today),
                                SizedBox(height: 8),
                                Text('18'),
                                Text('This Week'),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    Card(
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Icon(Icons.check_circle, color: Colors.red),
                                Text('+28', style: TextStyle(color: Colors.green)),
                              ],
                            ),
                            SizedBox(height: 8),
                            Column(
                              children: [
                                Icon(Icons.check_circle),
                                SizedBox(height: 8),
                                Text('156'),
                                Text('Completed'),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 24),
                // Placeholder Weekly Performance Chart
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Weekly Performance',
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                            TextButton(
                              onPressed: () {},
                              child: Text('View Details'),
                            ),
                          ],
                        ),
                        Container(
                          height: 150,
                          color: Colors.grey[300], // Placeholder for the chart
                          child: Center(child: Text('Chart Placeholder')),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 24),
                // Recent Activity Section
                Text(
                  'Recent Activity',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Recent Activity',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    TextButton(
                      onPressed: () {},
                      child: Text('View All'),
                    ),
                  ],
                ),
                Card(
                  child: Column(
                    children: [
                      // Placeholder List Items
                      ListTile(
                        leading: Icon(Icons.circle, color: Colors.green),
                        title: Text('Phonological Assessment Completed'),
                        subtitle: Text('Patient: Sarah M.'),
                        trailing: Text('2 hours ago'),
                      ),
                      Divider(),
                      ListTile(
                        leading: Icon(Icons.circle, color: Colors.blue),
                        title: Text('New Patient Registration'),
                        subtitle: Text('Patient: Michael R.'),
                        trailing: Text('4 hours ago'),
                      ),
                      Divider(),
                      ListTile(
                        leading: Icon(Icons.circle, color: Colors.orange),
                        title: Text('Progress Report Generated'),
                        subtitle: Text('Patient: Emma L.'),
                        trailing: Text('6 hours ago'),
                      ),
                      Divider(),
                      ListTile(
                        leading: Icon(Icons.circle, color: Colors.red),
                        title: Text('Therapy Session Scheduled'),
                        subtitle: Text('Patient: David K.'),
                        trailing: Text('1 day ago'),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 24),
                // Quick Actions Section
                Text(
                  'Quick Actions',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 16),
                GridView.count(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  crossAxisCount: 2,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                  children: [
                    // Placeholder Quick Action Buttons
                    ElevatedButton(
                      onPressed: () {},
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.psychology_outlined),
                          Text('New Assessment'),
                          Text('Start evaluation'),
                        ],
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {},
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.calendar_today),
                          Text('Schedule Session'),
                          Text('Book appointment'),
                        ],
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {},
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.insert_chart_outlined),
                          Text('Generate Report'),
                          Text('Create summary'),
                        ],
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {},
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.people_alt_outlined),
                          Text('Patient Records'),
                          Text('View history'),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 24), // Add some spacing at the bottom

              ] ),
        ));


  }
}