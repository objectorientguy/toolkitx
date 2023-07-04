import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:toolkit/configs/app_theme.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:toolkit/utils/constants/string_constants.dart';
import 'package:toolkit/utils/database_utils.dart';

import '../configs/app_spacing.dart';
import '../data/models/profile/profile_options_model.dart';
import '../widgets/text_button.dart';

abstract class ProfileUtil {
  static const String iconPath = 'assets/icons/';
  static const String imagePath = 'assets/images/';
  static late PackageInfo packageInfo;

  static List<ProfileOptions> profileOptionsList() {
    return [
      ProfileOptions(
          title: StringConstants.kChangePassword,
          image: "${iconPath}reset-password.png"),
      ProfileOptions(
          title: DatabaseUtil.getText('LanguageTanslate'),
          image: "${iconPath}languages.png"),
      ProfileOptions(
          title: DatabaseUtil.getText('changetimezone'),
          image: "${iconPath}time_zone.png"),
      ProfileOptions(
          title: DatabaseUtil.getText('changedateformat'),
          image: "${iconPath}calendar.png"),
      ProfileOptions(
          title: DatabaseUtil.getText('MailUs'), image: "${iconPath}email.png"),
      ProfileOptions(
          title: DatabaseUtil.getText('PrivacyPolicies'),
          image: "${iconPath}compliant.png"),
      ProfileOptions(
          title: DatabaseUtil.getText('MaturityModel'),
          image: "${iconPath}shield.png")
    ];
  }

  static Future<bool> showExitPopup(map1, map2, context) async {
    if (!mapEquals(map1, map2)) {
      return await showDialog(
            //show confirm dialogue
            //the return value will be from "Yes" or "No" options
            context: context,
            builder: (context) => AlertDialog(
              content: Text(
                StringConstants.kDiscardChanges,
                style: Theme.of(context).textTheme.medium,
              ),
              buttonPadding: const EdgeInsets.all(xxTiniestSpacing),
              contentPadding: const EdgeInsets.fromLTRB(
                  xxTinySpacing, xxTinySpacing, xxTinySpacing, 0),
              actionsPadding: const EdgeInsets.only(top: xxTinierSpacing),
              actionsAlignment: MainAxisAlignment.start,
              actions: [
                CustomTextButton(
                  onPressed: () => Navigator.of(context).pop(true),
                  textValue: 'Yes',
                ),
                CustomTextButton(
                  onPressed: () => Navigator.of(context).pop(false),
                  textValue: 'No',
                ),
              ],
            ),
          ) ??
          false;
    } else {
      Navigator.pop(context);
    }
    return false;
  }
}
