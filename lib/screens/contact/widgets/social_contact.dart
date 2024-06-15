import 'package:flutter/material.dart';
import 'package:flutter_cool_morning/utils/constants.dart';
import 'package:url_launcher/url_launcher.dart';

class SocialContact extends StatelessWidget {
  const SocialContact({super.key, required this.image, required this.url});

  final String image;
  final String url;

  Future<void> _launchURL(String url) async {
    if (!await launchUrl(Uri.parse(url))) {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _launchURL(url),
      child: Center(
        child: Image(image: AssetImage(image), width: kSocialContactWidth,),
      ),
    );
  }
}
