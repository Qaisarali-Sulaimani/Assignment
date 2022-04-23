import 'package:assignment/screens/homepage.dart';
import 'package:assignment/screens/login.dart';
import 'package:assignment/screens/splash_screen.dart';
import 'package:assignment/screens/splash_screen2.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: SplashScreen.id,
      routes: {
        LoginPage.id: (context) => const LoginPage(),
        SplashScreen.id: (context) => const SplashScreen(),
        Splash_Screen2.id: (context) => const Splash_Screen2(),
        HomePage.id: (context) => const HomePage(),
      },
    );
  }
}
