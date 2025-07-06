import 'package:flutter/material.dart';
import 'package:flutter_cool_morning/utils/enums.dart';
import 'package:url_launcher/url_launcher.dart';
//import 'package:flutter_cool_morning/screens/pdf/pdf_screen.dart';

class ChatWithAvatar extends StatelessWidget {
  const ChatWithAvatar({
    super.key,
    required this.avatarPosition,
    required this.image,
    required this.avatar,
    required this.url,
  });

  final AvatarPosition avatarPosition;
  final String image;
  final String avatar;
  final String url;

  Future<void> _launchURL(String url) async {
    if (!await launchUrl(Uri.parse(url))) {
      throw 'Could not launch $url';
    }
  }

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
          onTap: () => _launchURL(url),
          child: Image(image: AssetImage(image), width: 240.0,),
        ),
        const SizedBox(width: 4.0),
        if (avatarPosition == AvatarPosition.right)
        CircleAvatar(radius: 30.0, backgroundImage: AssetImage(avatar),),
      ],
    );
  }
}

//Code to open the pdf file, on widget tap, with the package flutter_pdfview
/*Navigator.push(
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
              );*/