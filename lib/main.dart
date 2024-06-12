import 'package:flutter/material.dart';
import 'package:flutter_cool_morning/screens/home/home_screen.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Cool Morning',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSwatch(
          primarySwatch: Colors.brown,
          accentColor: Colors.teal,
          backgroundColor: Colors.white,
        ),
        fontFamily: 'Roboto', //TODO: Add my font and use it here
        textTheme: const TextTheme(
          bodyLarge: TextStyle(fontSize: 18.0),
          bodyMedium: TextStyle(fontSize: 16.0),
          bodySmall: TextStyle(fontSize: 14.0),
          headlineLarge: TextStyle(fontSize: 48.0, fontWeight: FontWeight.bold),
          headlineMedium: TextStyle(fontSize: 36.0, fontWeight: FontWeight.bold),
          headlineSmall: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
        ),
        useMaterial3: true,
      ),
      home: const Home(),
    );
  }
}