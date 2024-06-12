import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_cool_morning/screens/contact/contact_screen.dart';
import 'package:flutter_cool_morning/screens/home/widgets/home_content.dart';
import 'package:flutter_cool_morning/utils/constants.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent_bottom_nav_bar_v2.dart';
import '../catalogs/catalogs_screen.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  @override
  void initState() {
    super.initState();
    // Hide the system bars
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
  }

  @override
  Widget build(BuildContext context) {

    return PersistentTabView(
      tabs: [
        PersistentTabConfig(
          screen: const HomeContent(),
          item: ItemConfig(
            icon: const Icon(Icons.home),
            inactiveIcon: const Icon(Icons.home_outlined),
            title: kHome,
            inactiveForegroundColor: Colors.brown,
            activeColorSecondary: Colors.white,
            activeForegroundColor: Colors.teal,
          ),
        ),
        PersistentTabConfig(
          screen: const CatalogsScreen(),
          item: ItemConfig(
            icon: const Icon(Icons.info),
            inactiveIcon: const Icon(Icons.info_outlined),
            title: kCatalogs,
            inactiveForegroundColor: Colors.brown,
            activeColorSecondary: Colors.white,
            activeForegroundColor: Colors.teal,
          ),
        ),
        PersistentTabConfig(
          screen: const ContactScreen(),
          item: ItemConfig(
            icon: const Icon(Icons.contact_mail),
            inactiveIcon: const Icon(Icons.contact_mail_outlined),
            title: kContact,
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