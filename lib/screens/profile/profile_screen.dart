import 'package:flutter/material.dart';
import 'package:toolkit/configs/app_spacing.dart';
import 'package:toolkit/screens/onboarding/widgets/onboarding_app_bar.dart';
import 'profile_card_options_body.dart';
import 'profile_options_body.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const OnBoardingAppBar(),
        body: Padding(
            padding: const EdgeInsets.only(
                left: leftRightMargin,
                right: leftRightMargin,
                top: topBottomSpacing),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: const [
                  ProfileCardOptionsBody(),
                  SizedBox(height: tinySpacing),
                  ProfileOptionsBody()
                ])));
  }
}
