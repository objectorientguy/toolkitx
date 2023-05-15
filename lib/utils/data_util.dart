import 'package:flutter/material.dart';
import 'package:toolkit/utils/constants/string_constants.dart';

import '../screens/profile/profile_options_class.dart';

abstract class DataUtil {
  static List<ProfileCardOption> profileCardOptionsList() {
    return [
      ProfileCardOption(
          title: StringConstants.kEditProfile, iconData: Icons.edit),
      ProfileCardOption(
          title: StringConstants.kChangeClient, iconData: Icons.edit),
      ProfileCardOption(
          title: StringConstants.kLogout, iconData: Icons.logout_outlined),
    ];
  }

  static List<ProfileOptions> profileOptionsList() {
    const String imagePath = 'assets/icons/';
    return [
      ProfileOptions(
          title: StringConstants.kChangePassword,
          assetImage: const AssetImage("${imagePath}reset-password.png")),
      ProfileOptions(
          title: StringConstants.kChangeLanguage,
          assetImage: const AssetImage("${imagePath}languages.png")),
      ProfileOptions(
          title: StringConstants.kChangeTimezone,
          assetImage: const AssetImage("")),
      ProfileOptions(
          title: StringConstants.kChangeDateFormat,
          assetImage: const AssetImage("")),
      ProfileOptions(
          title: StringConstants.kToolKitEmail,
          assetImage: const AssetImage("${imagePath}email.png")),
      ProfileOptions(
          title: StringConstants.kPrivacyPolicy,
          assetImage: const AssetImage("")),
      ProfileOptions(
          title: StringConstants.kMaturityModel,
          assetImage: const AssetImage("")),
    ];
  }
}
