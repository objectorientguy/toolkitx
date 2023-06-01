import 'package:flutter/material.dart';
import 'package:toolkit/configs/app_theme.dart';
import 'package:toolkit/screens/profile/edit/edit_screen.dart';
import 'package:toolkit/utils/constants/string_constants.dart';
import 'package:toolkit/widgets/android_pop_up.dart';
import '../../../configs/app_dimensions.dart';
import '../../../configs/app_spacing.dart';
import '../../../utils/profile_util.dart';
import '../../onboarding/welcome_screen.dart';

class EditOptionsSection extends StatelessWidget {
  const EditOptionsSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
      GestureDetector(
        onTap: () {
          Navigator.pushNamed(context, EditScreen.routeName);
        },
        child: Column(children: [
          Image.asset('${ProfileUtil.iconPath}' 'pen.png',
              height: kProfileImageHeight, width: kProfileImageWidth),
          const SizedBox(height: xxTiniestSpacing),
          Text(StringConstants.kEditProfile,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.xxSmall)
        ]),
      ),
      Column(children: [
        Image.asset('${ProfileUtil.iconPath}' 'exchange.png',
            height: kProfileImageHeight, width: kProfileImageWidth),
        const SizedBox(height: xxTiniestSpacing),
        Text(StringConstants.kChangeClient,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.xxSmall)
      ]),
      GestureDetector(
          onTap: () {
            showDialog(
                context: context,
                builder: (context) {
                  return AndroidPopUp(
                      titleValue: StringConstants.kLogout,
                      contentValue: StringConstants.kLogoutDialogContent,
                      onPressed: () => Navigator.of(context)
                          .pushNamedAndRemoveUntil(WelcomeScreen.routeName,
                              (Route<dynamic> route) => false));
                });
          },
          child: Column(children: [
            Image.asset('${ProfileUtil.iconPath}' 'logout.png',
                height: kProfileImageHeight, width: kProfileImageWidth),
            const SizedBox(height: xxTiniestSpacing),
            Text(StringConstants.kLogout,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.xxSmall)
          ]))
    ]);
  }
}
