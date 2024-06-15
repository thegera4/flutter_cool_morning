import 'package:flutter/material.dart';
import 'package:flutter_cool_morning/screens/pdf/pdf_screen.dart';
import 'package:flutter_cool_morning/utils/enums.dart';

class ChatWithAvatar extends StatelessWidget {
  const ChatWithAvatar({
    super.key,
    required this.avatarPosition,
    required this.image,
    required this.avatar,
    required this.catalog,
  });

  final AvatarPosition avatarPosition;
  final String image;
  final String avatar;
  final String catalog;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        if (avatarPosition == AvatarPosition.left)
        CircleAvatar(radius: 30.0, backgroundImage: AssetImage(avatar),),
        const SizedBox(width: 4.0),
        GestureDetector(
          onTap: () {
              Navigator.push(
                context,
                PageRouteBuilder(
                  pageBuilder: (context, animation, secondaryAnimation) => PDFScreen(catalog: catalog),
                  transitionsBuilder: (context, animation, secondaryAnimation, child) {
                    var begin = const Offset(1.0, 0.0);
                    var end = Offset.zero;
                    var curve = Curves.ease;
                    var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
                    return SlideTransition(
                      position: animation.drive(tween),
                      child: FadeTransition(
                        opacity: animation,
                        child: child,
                      ),
                    );
                  },
                ),
              );
              },
          child: Image(image: AssetImage(image), width: 280.0,),
        ),
        const SizedBox(width: 4.0),
        if (avatarPosition == AvatarPosition.right)
        CircleAvatar(radius: 30.0, backgroundImage: AssetImage(avatar),),
      ],
    );
  }
}