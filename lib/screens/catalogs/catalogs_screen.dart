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
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 16.0),
                    child: Image(
                        image: AssetImage(kTopBarLogo),
                        width: 150.0,
                    ),
                  ),
                  Text(
                    kTopBarTextCatalogs,
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  const SizedBox(height: 16.0),
                  Expanded(
                      child: ListView(
                        children: const <Widget>[
                          ChatWithAvatar(
                            avatarPosition: AvatarPosition.right,
                            image: kDesayunosImg,
                            avatar: kAvatarDesayunos,
                            catalog: kDesayunosPath,
                          ),
                          SizedBox(height: 16.0),
                          ChatWithAvatar(
                            avatarPosition: AvatarPosition.left,
                            image: kCenasImg,
                            avatar: kAvatarCenas,
                            catalog: kCenasPath,
                          ),
                          SizedBox(height: 16.0),
                          ChatWithAvatar(
                            avatarPosition: AvatarPosition.right,
                            image: kLucesImg,
                            avatar: kAvatarLuces,
                            catalog: kLucesPath,
                          ),
                          SizedBox(height: 16.0),
                          ChatWithAvatar(
                            avatarPosition: AvatarPosition.left,
                            image: kEspecialImg,
                            avatar: kAvatarEspecial,
                            catalog: kDesayunosPath,
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