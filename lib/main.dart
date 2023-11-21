import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:meraki/auth_screen.dart';
import 'package:meraki/first_screen.dart';
import 'package:provider/provider.dart';
import 'package:meraki/user_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  SharedPreferences prefs = await SharedPreferences.getInstance();
  bool isLoggedIn = prefs.getBool('isLoggedIn') ?? false;

  runApp(
    ChangeNotifierProvider(
      create: (context) => UserProvider(),
      child: MaterialApp(
        title: 'Meraki',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.black),
          useMaterial3: true,
        ),
        home: MyAppRoot(isLoggedIn: isLoggedIn),
        debugShowCheckedModeBanner: false,
      ),
    ),
  );
}

class MyAppRoot extends StatefulWidget {
  final bool isLoggedIn;

  const MyAppRoot({Key? key, required this.isLoggedIn}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _MyAppRootState createState() => _MyAppRootState();
}

class _MyAppRootState extends State<MyAppRoot> {
  @override
  void initState() {
    super.initState();

    // Delay the navigation to AuthScreen after 4 seconds
    Future.delayed(const Duration(seconds: 4), () {
      if (mounted) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) =>
                widget.isLoggedIn ? const FirstScreen() : const AuthScreen(),
          ),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    // Initial screen is GoalScreen for the first 4 seconds
    return const FirstScreen();
  }
}
