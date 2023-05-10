import 'package:flutter/material.dart';
import 'package:toolkit/configs/app_spacing.dart';
import 'package:toolkit/configs/app_theme.dart';
import 'package:toolkit/screens/onboarding/widgets/circle_avatar.dart';
import 'package:toolkit/utils/constants/string_constants.dart';
import '../../configs/app_color.dart';
import '../../widgets/primary_button.dart';
import 'selectYourLanguage/select_your_language_screen.dart';

class WelcomeScreen extends StatelessWidget {
  static const routeName = 'WelcomeScreen';

  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(),
      body: Padding(
        padding: EdgeInsets.only(
            left: leftRightMargin,
            right: leftRightMargin,
            top: MediaQuery.of(context).size.width * 0.25),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircleAvatarWidget(
                backgroundImage:
                    const AssetImage("assets/images/man_avatar.png"),
                radius: MediaQuery.of(context).size.width * 0.15),
            const SizedBox(height: largeSpacing),
            Text(StringConstants.kWelcomeToToolkitX,
                style: Theme.of(context)
                    .textTheme
                    .xxLarge
                    .copyWith(color: AppColor.mediumBlack)),
            const SizedBox(height: tinySpacing),
            Text(StringConstants.kAppIntroductionNoSpacing,
                style: Theme.of(context)
                    .textTheme
                    .largeTitle
                    .copyWith(fontWeight: FontWeight.normal),
                textAlign: TextAlign.center),
            const SizedBox(height: extraLargeSpacing),
            PrimaryButton(
              onPressed: () {
                Navigator.pushNamed(
                    context, SelectYourLanguageScreen.routeName);
              },
              textValue: StringConstants.kStartNow,
            )
          ],
        ),
      ),
    );
  }
}
