import 'package:flutter/material.dart';
import '../../utils/constants.dart';

class CatalogsScreen extends StatelessWidget {
  const CatalogsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
        children: <Widget>[
          Opacity(
            opacity: 0.2,
            child: Container(
              decoration: const BoxDecoration( // This is used for styling
                image: DecorationImage(
                  image: AssetImage(kCatalogsBackgroundImg),
                  fit: BoxFit.cover,
                ),
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
                      kTopBarTextCatalogs,
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