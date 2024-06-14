import 'package:flutter/material.dart';
import '../../utils/constants.dart';

class ContactScreen extends StatelessWidget {
  const ContactScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
          decoration: const BoxDecoration( // This is used for styling
            image: DecorationImage(
              image: AssetImage(kContactBackgroundImg),
              fit: BoxFit.cover,
            ),
          ),
        ),
        SafeArea(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 16.0),
                    child: Image(
                      image: AssetImage(kTopBarLogo),
                      width: 200.0,
                    ),
                  ),
                  Text(
                    kTopBarTextContact,
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  // Add more widgets to the column as needed
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}