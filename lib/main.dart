import 'package:flutter/material.dart';
import 'package:flutter_cool_morning/screens/home/home_screen.dart';
import 'package:flutter_cool_morning/utils/constants.dart';
import 'package:flutter/services.dart';

void main() {
  // Set preferred orientations to portrait only
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]).then((_) {
    runApp(const MyApp());
  });
}

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
        fontFamily: kGotham,
        textTheme: const TextTheme(
          bodyLarge: TextStyle(
              fontSize: 24.0,
              fontWeight: FontWeight.bold,
              color: Colors.brown
          ),
          bodyMedium: TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
              color: Colors.brown
          ),
          bodySmall: TextStyle(
              fontSize: 14.0,
              fontWeight: FontWeight.bold,
              color: Colors.brown
          ),
        ),
        useMaterial3: true,
      ),
      home: const Home(),
    );
  }
}