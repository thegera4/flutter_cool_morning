import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent_bottom_nav_bar_v2.dart';

void main() {
  runApp(const MyApp());
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
      home: const MyHomePage(title: 'Cool Morning'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  Widget build(BuildContext context) {

    return PersistentTabView(
      tabs: [
        PersistentTabConfig(
          screen: const Text("Your First Screen"),
          item: ItemConfig(
            icon: const Icon(Icons.home),
            title: "Home",
            inactiveForegroundColor: Colors.brown,
            activeColorSecondary: Colors.white,
            activeForegroundColor: Colors.teal,
          ),
        ),
        PersistentTabConfig(
          screen: const Text("Your Second Screen"),
          item: ItemConfig(
            icon: const Icon(Icons.message),
            title: "Messages",
            inactiveForegroundColor: Colors.brown,
            activeColorSecondary: Colors.white,
            activeForegroundColor: Colors.teal,
          ),
        ),
        PersistentTabConfig(
          screen: const Text("Your Third Screen"),
          item: ItemConfig(
            icon: const Icon(Icons.settings),
            title: "Settings",
            inactiveForegroundColor: Colors.brown,
            activeColorSecondary: Colors.white,
            activeForegroundColor: Colors.teal,
          ),
        ),
      ],
      navBarBuilder: (navBarConfig) => Style2BottomNavBar(
        navBarConfig: navBarConfig,
      ),
    );
  }
}

