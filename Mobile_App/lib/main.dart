import 'package:flutter/material.dart';
import 'Components/SplashScreen.dart';
import 'Components/LoginScreen.dart';
import 'Components/HomeScreen.dart';

main() {
  runApp(MaterialApp(
    title: 'Named Routes Demo',
    initialRoute: '/',
     routes: {
      '/': (context) => SplashScreen(),
      '/Login' : (context) => LoginScreen(),
      '/Home': (_) => HomeScreen(),
    },
  ));
}
