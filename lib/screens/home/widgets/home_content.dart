import 'package:flutter/material.dart';
import 'package:flutter_cool_morning/utils/constants.dart';

class HomeContent extends StatelessWidget {
  const HomeContent({super.key});

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    final isTablet = deviceSize.width > 600;
    final isSmallPhone = deviceSize.height <= 736 ? true : false;

    return Column(
      children: <Widget>[
        SizedBox(
          height: isTablet ? deviceSize.height * 0.85 :
          isSmallPhone ? deviceSize.height * 0.7 : deviceSize.height * 0.80,
          width: double.infinity,
          child: const Image(
            image: AssetImage(kHomeImage),
            fit: BoxFit.cover,
          ),
        ),
        SizedBox(
          height: 110.0,
          width: deviceSize.width,
          child: Center(
            child: Text(
              kHomeText,
              style: Theme.of(context).textTheme.bodyLarge,
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ],
    );
  }
}