import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:whatsapp_unilink/whatsapp_unilink.dart';

class CoachScreen extends StatelessWidget {
  const CoachScreen({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      backgroundColor: Colors.black,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Image
            Image.asset(
              'assets/coach_dp.png', // Replace with the actual path to your image asset
              width: 300, // Adjust the width as needed
              height: 150, // Adjust the height as needed
            ),
            const SizedBox(height: 20),

            // Three Icons and Labels
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                CoachItem(
                  icon: Icons.text_format,
                  label: 'Text Coach',
                  onTap: () {
                    _launchWhatsApp(context);
                  },
                ),
                CoachItem(
                  icon: Icons.call,
                  label: 'Call Coach',
                  onTap: () {
                    // Add functionality for calling the coach
                  },
                ),
                CoachItem(
                  icon: Icons.schedule,
                  label: 'Coach Schedule',
                  onTap: () {
                    // Add functionality for displaying the coach's schedule
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _launchWhatsApp(BuildContext context) async {
    final link = WhatsAppUnilink(
      phoneNumber: '+919963885413', // Replace with the actual phone number
      text: "Hello, I need coaching.",
    );

    try {
      await launch('$link');
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Unable to open WhatsApp"),
          duration: Duration(seconds: 2),
        ),
      );
    }
  }
}

class CoachItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback? onTap;

  const CoachItem({
    Key? key,
    required this.icon,
    required this.label,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Icon(
            icon,
            color: Colors.white,
            size: 40,
          ),
          const SizedBox(height: 10),
          Text(
            label,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }
}
