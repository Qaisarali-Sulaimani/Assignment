import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:assignment/screens/login.dart';
import 'package:flutter/material.dart';
import '../constants.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);
  static String id = "SplashScreen";

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
      duration: 1500,
      splash: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const <Widget>[
          Icon(
            Icons.monetization_on_rounded,
            size: 50,
            color: Colors.white,
          ),
          SizedBox(
            width: 10,
          ),
          Text(
            "Admin Panel",
            style: TextStyle(
              fontSize: 35,
              color: Colors.white,
              fontStyle: FontStyle.italic,
            ),
          ),
        ],
      ),
      nextScreen: const LoginPage(),
      backgroundColor: kmycolor,
    );
  }
}
