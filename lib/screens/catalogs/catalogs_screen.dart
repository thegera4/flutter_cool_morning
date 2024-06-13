import 'package:flutter/material.dart';

import '../../utils/constants.dart';

class CatalogsScreen extends StatelessWidget {
  const CatalogsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
        children: <Widget>[
          // The BoxDecoration is used here only for styling purposes
          Opacity(
            opacity: 0.2,
            child: Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(kCatalogsBackgroundImg), // replace with your image
                  fit: BoxFit.cover,
                ),
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

