import 'package:flutter/material.dart';
import 'package:flutter_cool_morning/screens/catalogs/widgets/chat_with_avatar.dart';
import '../../utils/constants.dart';
import '../../utils/enums.dart';

class CatalogsScreen extends StatelessWidget {
  const CatalogsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
        children: <Widget>[
          Opacity(
            opacity: kCatalogsBackgroundOpacity,
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
                    kTopBarTextCatalogs,
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  const SizedBox(height: kSizeBoxSpacing),
                  Expanded(
                      child: ListView(
                        children: const <Widget>[
                          ChatWithAvatar(
                            avatarPosition: AvatarPosition.right,
                            image: kDesayunosImg,
                            avatar: kAvatarDesayunos,
                            url: kDesayunosUrl,
                          ),
                          SizedBox(height: kSizeBoxSpacing),
                          ChatWithAvatar(
                            avatarPosition: AvatarPosition.left,
                            image: kCenasImg,
                            avatar: kAvatarCenas,
                            url: kCenasUrl,
                          ),
                          SizedBox(height: kSizeBoxSpacing),
                          ChatWithAvatar(
                            avatarPosition: AvatarPosition.right,
                            image: kLucesImg,
                            avatar: kAvatarLuces,
                            url: kLucesUrl,
                          ),
                          SizedBox(height: kSizeBoxSpacing),
                          ChatWithAvatar(
                            avatarPosition: AvatarPosition.left,
                            image: kEspecialImg,
                            avatar: kAvatarEspecial,
                            url: kEspecialUrl,
                          ),
                        ],
                      )
                  ),
                ],
              ),
            ),
          ),
        ],
    );
  }
}