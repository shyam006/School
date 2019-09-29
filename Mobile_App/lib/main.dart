import 'package:flutter/material.dart';
import 'Components/SplashScreen.dart';
import 'Components/LoginScreen.dart';
import 'Components/HomeScreen.dart';
import 'Components/OtpScreen.dart';

main() {
  runApp(MaterialApp(
    title: 'Named Routes Demo',
    initialRoute: '/',
     routes: {
      '/': (context) => SplashScreen(),
      '/Login' : (context) => LoginScreen(),
      '/Home': (_) => HomeScreen(),
      '/Otp' : (_)=> OtpScreen(),
    },
  ));
}
