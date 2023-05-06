import 'package:flutter/material.dart';
import 'package:toolkit/configs/app_spacing.dart';
import 'package:toolkit/configs/app_theme.dart';
import 'package:toolkit/screens/onboarding/selectYourTimeZone/select_your_time_zone_screen.dart';
import 'package:toolkit/screens/onboarding/widgets/circle_avatar_widget.dart';
import 'package:toolkit/utils/constants/string_constants.dart';
import '../../configs/app_color.dart';
import '../../widgets/primary_button.dart';

class OnBoardingScreen extends StatelessWidget {
  static const routeName = 'onBoardingScreen';

  const OnBoardingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.only(
            left: leftRightMargin,
            right: leftRightMargin,
            top: MediaQuery.of(context).size.width * 0.2),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircleAvatarWidget(
                backgroundImage: const AssetImage("assets/images/person.webp"),
                radius: MediaQuery.of(context).size.width * 0.15),
            const SizedBox(height: largeSpacing),
            Text(StringConstants.kWelcomeToToolkitX,
                style: Theme.of(context)
                    .textTheme
                    .xlarge
                    .copyWith(color: AppColor.mediumBlack)),
            const SizedBox(height: mediumSpacing),
            Text(StringConstants.kAppIntroductionNoSpacing,
                style: Theme.of(context).textTheme.mediumTitle,
                textAlign: TextAlign.center),
            const SizedBox(height: extraLargeSpacing),
            PrimaryButton(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const SelectYourTimeZoneScreen()));
                },
                style: buttonStyle,
                child: const Text(StringConstants.kStartNow))
          ],
        ),
      ),
    );
  }
}
