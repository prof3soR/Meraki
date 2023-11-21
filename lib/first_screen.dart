import 'package:flutter/material.dart';

class FirstScreen extends StatefulWidget {
  const FirstScreen({Key? key}) : super(key: key);

  @override
  _FirstScreenState createState() => _FirstScreenState();
}

class _FirstScreenState extends State<FirstScreen> {
  String greeting() {
    var hour = DateTime.now().hour;
    if (hour < 12) {
      return 'Good Morning!';
    } else if (hour < 17) {
      return 'Good Afternoon!';
    } else {
      return 'Good Evening!';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Color.fromRGBO(0, 0, 0, 1), // Use rgba(0, 0, 0, 1) for black
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "WELCOME to Meraki",
              style: TextStyle(
                fontSize: 30,
                color: Colors.white, // Set text color to white
                fontFamily: 'Quicksand', // Use Quicksand font
                fontWeight: FontWeight.normal, // Use regular font weight
                decoration: TextDecoration.none,
              ),
            ),
            ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image.asset(
                'assets/logo.png',
                height: 300,
                width: 500,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              greeting(),
              style: const TextStyle(
                fontSize: 30,
                color: Colors.white, // Set text color to white
                fontFamily: 'Quicksand', // Use Quicksand font
                fontWeight: FontWeight.bold,
                decoration: TextDecoration.none,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
