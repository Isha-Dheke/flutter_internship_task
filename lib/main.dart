import 'package:flutter/material.dart';
// import 'package:internflutter/screens/detail_screen.dart';
// import 'package:internflutter/screens/home_screen.dart';
// import 'package:internflutter/screens/search_screen.dart';
import 'package:internflutter/screens/splash_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Online Store',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: SplashScreen());
  }
}
