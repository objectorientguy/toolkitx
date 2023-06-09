import 'package:flutter/material.dart';
import 'package:toolkit/configs/app_dimensions.dart';
import 'package:toolkit/configs/app_theme.dart';
import 'package:toolkit/screens/onboarding/login/password/password_screen.dart';
import 'package:toolkit/screens/onboarding/widgets/custom_card.dart';
import 'package:toolkit/screens/onboarding/widgets/circle_avatar.dart';
import 'package:toolkit/widgets/primary_button.dart';
import '../../../../configs/app_spacing.dart';
import '../../../../utils/constants/string_constants.dart';
import '../../widgets/onboarding_app_bar.dart';
import '../../widgets/text_field.dart';

class LoginEmailScreen extends StatelessWidget {
  static const routeName = 'LoginEmailScreen';

  const LoginEmailScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const OnBoardingAppBar(),
      body: Padding(
        padding: const EdgeInsets.only(
            left: leftRightMargin,
            right: leftRightMargin,
            top: topBottomSpacing,
            bottom: topBottomSpacing),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Material(
              elevation: kCardRadius,
              borderRadius: BorderRadius.all(
                  Radius.circular(MediaQuery.of(context).size.width * 0.3)),
              child: CircleAvatarWidget(
                  child: Icon(Icons.message,
                      size: MediaQuery.of(context).size.width * 0.1)),
            ),
            const SizedBox(height: largeSpacing),
            SizedBox(
              height: MediaQuery.of(context).size.width * 0.48,
              width: double.infinity,
              child: CustomCard(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(kCardRadius),
                ),
                child: Padding(
                  padding:
                      EdgeInsets.all(MediaQuery.of(context).size.width * 0.042),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(StringConstants.kEmailAddress,
                          style: Theme.of(context).textTheme.largeTitle),
                      const SizedBox(height: tinySpacing),
                      const TextFieldWidget(
                          textInputType: TextInputType.emailAddress,
                          maxLines: 1),
                      const SizedBox(height: mediumSpacing),
                      PrimaryButton(
                        onPressed: () {
                          Navigator.pushNamed(
                              context, PasswordScreen.routeName);
                        },
                        textValue: StringConstants.kNext,
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
