import 'package:flutter/material.dart';
import 'package:test_app/dashboard_screen.dart';
import 'package:test_app/phonological_test_buttons.dart';
import 'package:test_app/settings_screen.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("PhonoPlay",style:TextStyle(fontSize: 24,
          fontWeight: FontWeight.bold,
          color: Colors.white, ),),
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      extendBodyBehindAppBar: true,
      drawer: Drawer(
        elevation: 0,
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Colors.blue[400]!,
                Colors.blue[900]!,
              ],
            ),
          ),
          child: Column(
            children: <Widget>[
              DrawerHeader(
                decoration: const BoxDecoration(
                  color: Colors.transparent,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      'PhonoPlay\nv2.0 Pro',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 8),
                    Expanded(
                      child: Text(
                        'Professional phonological assessment and speech therapy application designed for healthcare professionals, educators, and speech-language pathologists.',
                        style: TextStyle(
                          color: Colors.white70,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0),
                child: Text(
                  'Quick Access',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              ListTile(
                leading: const Icon(Icons.info_outline, color: Colors.white),
                title: const Text('About PhonoPlay', style: TextStyle(color: Colors.white)),
                subtitle: const Text('Learn more about our mission', style: TextStyle(color: Colors.white70)),
                onTap: () {
                  // TODO: Navigate to About PhonoPlay
                },
              ),
              ListTile(
                leading: const Icon(Icons.help_outline, color: Colors.white),
                title: const Text('Help & Support', style: TextStyle(color: Colors.white)),
                subtitle: const Text('24/7 assistance available', style: TextStyle(color: Colors.white70)),
                onTap: () {
                  // TODO: Navigate to Help & Support
                },
              ),
              ListTile(
                leading: const Icon(Icons.phone, color: Colors.white),
                title: const Text('Contact Us', style: TextStyle(color: Colors.white)),
                subtitle: const Text('Get in touch with our team', style: TextStyle(color: Colors.white70)),
                onTap: () {
                  // TODO: Navigate to Contact Us
                },
              ),
              const Spacer(),
              const Padding(
                padding: EdgeInsets.all(16.0),
                child: Text(
                  '© 2025 PhonoPlay Technologies\nEmpowering speech therapy worldwide',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white54,
                    fontSize: 12,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color.fromARGB(255, 49, 127, 191), Colors.lightBlueAccent],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: ListView(
          padding: EdgeInsets.only(
            top: AppBar().preferredSize.height + MediaQuery.of(context).padding.top + 20,
          ),
          children: <Widget>[
            Center(
              child: Image.asset(
                'assets/image-removebg-preview.png',
                height: 150,
                width: 150,
              ),
            ),
            Center(
              child: Container(
                margin: const EdgeInsets.symmetric(vertical: 20),
                width: 180,
                height: 180,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white.withOpacity(0.2),
                  border: Border.all(color: Colors.white.withOpacity(0.5), width: 2),
                ),
                child: const Icon(
                  Icons.science_outlined,
                  size: 80,
                  color: Colors.white,
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
              child: Column(
                children: [
                  Text(
                    "AI-Powered Analysis",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    "Advanced speech pattern recognition",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white70,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  _StatCard(label: "Accuracy", value: "98%"),
                  _StatCard(label: "Analysis", value: "2.5s"),
                  _StatCard(label: "Available", value: "24/7"),
                ],
              ),
            ),
            _FeatureCard(
              icon: Icons.science_outlined,
              color: Colors.redAccent,
              title: "Phonological Test",
              subtitle: "Start comprehensive assessment",
              onTap:(){ Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=>BearHomePage()));},

            ),
            _FeatureCard(
              icon: Icons.dashboard_outlined,
              color: Colors.teal,
              title: "Dashboard",
              subtitle: "View progress & analytics",
                onTap:(){ Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=>DashboardScreen()));}
            ),
            _FeatureCard(
              icon: Icons.settings_outlined,
              color: Colors.blueGrey,
              title: "Settings",
              subtitle: "Customize your experience",
                onTap:(){ Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=>SettingsScreen()));}
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Why Choose PhonoPlay?",
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    "•   Real-time speech analysis\n•   Personalized therapy plans\n•   Progress tracking & reports\n•   Professional-grade accuracy",
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white70,
                    ),
                  ),
                ],
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
              child: Card(
                elevation: 4,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
                child: ListTile(
                  leading: Icon(Icons.assignment),
                  title: Text("Phonological Test"),
                  subtitle: Text("Start comprehensive assessment"),
                  trailing: Icon(Icons.arrow_forward_ios),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _StatCard extends StatelessWidget {
  final String label;
  final String value;

  const _StatCard({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.3),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          Text(value, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white)),
          const SizedBox(height: 5),
          Text(label, style: const TextStyle(fontSize: 15, color: Colors.white70)),
        ],
      ),
    );
  }
}

class _FeatureCard extends StatelessWidget {
  final IconData icon;
  final Color color;
  final String title;
  final String subtitle;
  final VoidCallback? onTap;

  const _FeatureCard({
    required this.icon,
    required this.color,
    required this.title,
    required this.subtitle,
    this.onTap,

  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: ListTile(
            onTap: onTap,
            leading: Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: color.withOpacity(0.2),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(icon, color: color, size: 30),
            ),
            title: Text(title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            subtitle: Text(subtitle, style: const TextStyle(fontSize: 14)),
            trailing: const Icon(Icons.arrow_forward),
          ),
        ),
      ),
    );
  }
}
