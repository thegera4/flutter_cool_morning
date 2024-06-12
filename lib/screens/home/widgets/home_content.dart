import 'package:flutter/material.dart';
import 'package:flutter_cool_morning/utils/constants.dart';

class HomeContent extends StatelessWidget {
  const HomeContent({super.key});

  @override
  Widget build(BuildContext context) {

    final deviceSize = MediaQuery.of(context).size;
    final isTablet = deviceSize.width > 600;

    return Column(
      children: <Widget>[
        Expanded(
          flex: isTablet ? 8 : 4,
          child: const SizedBox(
              width: double.infinity,
              child: Image(
                  image: AssetImage(kHomeImage),
                  fit: BoxFit.cover
              )
          ),
        ),
        const Expanded(
          flex: 1,
          child: Center(child: Text(kHomeText,),),
        ),
      ],
    );
  }
}