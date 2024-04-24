import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:palash_ecom/web_page_flutter.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: AnimatedSplashScreen(

        splash: Image.asset('assets/logo.png'), // Replace with your splash image
        splashIconSize: double.infinity,
        nextScreen: WebPageFlutter(),
        splashTransition: SplashTransition.scaleTransition,

        duration: 500, // Adjust the duration as needed (milliseconds)
      ),
    );
  }
}