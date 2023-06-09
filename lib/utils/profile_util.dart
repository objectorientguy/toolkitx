import 'package:toolkit/utils/constants/string_constants.dart';
import 'package:toolkit/utils/database_utils.dart';

import '../data/models/profile/profile_options_model.dart';

abstract class ProfileUtil {
  static const String iconPath = 'assets/icons/';
  static const String imagePath = 'assets/images/';

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
}
