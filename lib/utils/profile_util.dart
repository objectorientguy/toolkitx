import 'package:toolkit/utils/constants/string_constants.dart';

import '../data/models/profile/profile_options_model.dart';

abstract class ProfileUtil {
  static const String imageIconPath = 'assets/icons/';

  static List<ProfileOptions> profileOptionsList() {
    return [
      ProfileOptions(
          title: StringConstants.kChangePassword,
          image: "${imageIconPath}reset-password.png"),
      ProfileOptions(
          title: StringConstants.kChangeLanguage,
          image: "${imageIconPath}languages.png"),
      ProfileOptions(
          title: StringConstants.kChangeTimezone,
          image: "${imageIconPath}time_zone.png"),
      ProfileOptions(
          title: StringConstants.kChangeDateFormat,
          image: "${imageIconPath}calendar.png"),
      ProfileOptions(
          title: StringConstants.kToolKitEmail,
          image: "${imageIconPath}email.png"),
      ProfileOptions(
          title: StringConstants.kPrivacyPolicy,
          image: "${imageIconPath}compliant.png"),
      ProfileOptions(
          title: StringConstants.kMaturityModel,
          image: "${imageIconPath}shield.png")
    ];
  }
}
