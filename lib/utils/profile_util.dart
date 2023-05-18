import 'package:toolkit/utils/constants/string_constants.dart';

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
          title: StringConstants.kChangeLanguage,
          image: "${iconPath}languages.png"),
      ProfileOptions(
          title: StringConstants.kChangeTimezone,
          image: "${iconPath}time_zone.png"),
      ProfileOptions(
          title: StringConstants.kChangeDateFormat,
          image: "${iconPath}calendar.png"),
      ProfileOptions(
          title: StringConstants.kToolKitEmail, image: "${iconPath}email.png"),
      ProfileOptions(
          title: StringConstants.kPrivacyPolicy,
          image: "${iconPath}compliant.png"),
      ProfileOptions(
          title: StringConstants.kMaturityModel, image: "${iconPath}shield.png")
    ];
  }
}
