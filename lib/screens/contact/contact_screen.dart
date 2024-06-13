import 'package:flutter/material.dart';

import '../../utils/constants.dart';

class ContactScreen extends StatelessWidget {
  const ContactScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        // The BoxDecoration is used here only for styling purposes
        Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage(kContactBackgroundImg), // replace with your image
              fit: BoxFit.cover,
            ),
          ),
        ),
        // Here's your column of content
        const Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('Hello, World!',),
            // Add more widgets to the column as needed
          ],
        ),
      ],
    );
  }
}
