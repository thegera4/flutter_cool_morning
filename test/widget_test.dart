import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:flutter_cool_morning/main.dart';
import 'package:flutter_cool_morning/screens/contact/contact_screen.dart';
import 'package:flutter_cool_morning/screens/contact/widgets/social_contact.dart';
import 'package:flutter_cool_morning/utils/constants.dart';

void main() {
  testWidgets('App navigates to ContactScreen with all 6 links in order', (
    WidgetTester tester,
  ) async {
    tester.view.physicalSize = const Size(412, 915);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(() {
      tester.view.resetPhysicalSize();
      tester.view.resetDevicePixelRatio();
    });

    await tester.pumpWidget(const MyApp());
    await tester.pumpAndSettle();

    final context = tester.element(find.byType(MyApp));
    await tester.runAsync(() async {
      for (final asset in const [
        kHomeImage,
        kContactBackgroundImg,
        kTopBarLogo,
        kWebImage,
        kCenasWebImage,
        kWhatsappImage,
        kFacebookImage,
        kInstagramImage,
        kEmailImage,
      ]) {
        await precacheImage(AssetImage(asset), context);
      }
    });
    await tester.pumpAndSettle();

    expect(find.text(kHomeText), findsOneWidget);
    expect(find.byIcon(Icons.contact_mail_outlined), findsOneWidget);

    await tester.tap(find.byIcon(Icons.contact_mail_outlined));
    await tester.pumpAndSettle();

    expect(find.byType(ContactScreen), findsOneWidget);
    expect(find.text(kContact), findsOneWidget);
    expect(find.text(kTopBarTextContact), findsOneWidget);

    final expectedLinks = <(String, String)>[
      (kWebImage, kWebUrl),
      (kCenasWebImage, kCenasWebUrl),
      (kWhatsappImage, kWhatsappUrl),
      (kFacebookImage, kFacebookUrl),
      (kInstagramImage, kInstagramUrl),
      (kEmailImage, kEmailUrl),
    ];

    final actualLinks = tester
        .widgetList<SocialContact>(find.byType(SocialContact))
        .map((widget) => (widget.image, widget.url))
        .toList();

    expect(actualLinks, equals(expectedLinks));
  });
}
