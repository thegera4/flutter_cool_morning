import 'package:flutter/material.dart';
import 'package:flutter_cool_morning/screens/contact/widgets/social_contact.dart';
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
                    padding: EdgeInsets.symmetric(vertical: kSizeBoxSpacing),
                    child: Image(
                      image: AssetImage(kTopBarLogo),
                      width: kTopBarLogoWidth,
                    ),
                  ),
                  Text(
                    kTopBarTextContact,
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  const SizedBox(height: kSpacingContact),
                  Expanded(
                      child: ListView(
                        children: const <Widget>[
                          SocialContact(
                            image: kWebImage,
                            url: kWebUrl,
                          ),
                          SizedBox(height: kSpacingContact),
                          SocialContact(
                            image: kWhatsappImage,
                            url: kWhatsappUrl,
                          ),
                          SizedBox(height: kSpacingContact),
                          SocialContact(
                            image: kFacebookImage,
                            url: kFacebookUrl,
                          ),
                          SizedBox(height: kSpacingContact),
                          SocialContact(
                            image: kInstagramImage,
                            url: kInstagramUrl,
                          ),
                          SizedBox(height: kSpacingContact),
                          SocialContact(
                            image: kEmailImage,
                            url: kEmailUrl,
                          ),
                        ],
                      )
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}