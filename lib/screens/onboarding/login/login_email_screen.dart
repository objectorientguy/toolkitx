import 'package:flutter/material.dart';
import 'package:toolkit/configs/app_theme.dart';
import 'package:toolkit/screens/onboarding/widgets/card_widget.dart';
import 'package:toolkit/screens/onboarding/widgets/circle_avatar_widget.dart';
import 'package:toolkit/screens/onboarding/login/email_text_field_widget.dart';
import '../../../configs/app_color.dart';
import '../../../configs/app_spacing.dart';
import '../../../utils/constants/string_constants.dart';
import 'email_button.dart';

class LoginEmailScreen extends StatelessWidget {
  const LoginEmailScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(automaticallyImplyLeading: false),
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
              elevation: kEmailCardElevation,
              borderRadius: BorderRadius.all(
                  Radius.circular(MediaQuery.of(context).size.width * 0.3)),
              child: CircleAvatarWidget(
                  radius: MediaQuery.of(context).size.width * 0.15,
                  backgroundColor: AppColor.blueGrey),
            ),
            const SizedBox(height: largeSpacing),
            SizedBox(
              height: MediaQuery.of(context).size.width * 0.44,
              width: double.infinity,
              child: CardWidget(
                  margin: EdgeInsets.zero,
                  elevation: kCardElevation,
                  shadowColor: AppColor.blueGrey,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(tiniestSpacing),
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(
                        MediaQuery.of(context).size.width * 0.042),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(StringConstants.kEmailAddress,
                            style: Theme.of(context).textTheme.largeTitle),
                        const SizedBox(height: tinySpacing),
                        const EmailTextFieldWidget(
                            textInputType: TextInputType.emailAddress,
                            maxLines: 1),
                        const SizedBox(height: mediumSpacing),
                        EmailButton(
                            onPressed: () {},
                            style: buttonStyle,
                            child: const Text(StringConstants.kNext))
                      ],
                    ),
                  )),
            )
          ],
        ),
      ),
    );
  }
}
