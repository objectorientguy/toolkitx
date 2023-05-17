import 'package:toolkit/utils/constants/string_constants.dart';

import '../data/models/profile/profile_options_model.dart';

abstract class ProfileUtil {
  static List<ProfileOptions> profileOptionsList() {
    const String imagePath = 'assets/icons/';
    return [
      ProfileOptions(
          title: StringConstants.kChangePassword,
          image: "${imagePath}reset-password.png"),
      ProfileOptions(
          title: StringConstants.kChangeLanguage,
          image: "${imagePath}languages.png"),
      ProfileOptions(
          title: StringConstants.kChangeTimezone,
          image: "${imagePath}time_zone.png"),
      ProfileOptions(
          title: StringConstants.kChangeDateFormat,
          image: "${imagePath}calendar.png"),
      ProfileOptions(
          title: StringConstants.kToolKitEmail, image: "${imagePath}email.png"),
      ProfileOptions(
          title: StringConstants.kPrivacyPolicy,
          image: "${imagePath}compliant.png"),
      ProfileOptions(
          title: StringConstants.kMaturityModel,
          image: "${imagePath}shield.png")
    ];
  }
}
