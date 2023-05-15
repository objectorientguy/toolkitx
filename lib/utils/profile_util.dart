import 'package:flutter/material.dart';
import 'package:toolkit/utils/constants/string_constants.dart';

import '../configs/app_dimensions.dart';
import '../screens/profile/widgets/options_class.dart';

abstract class ProfileUtil {
  static List<EditOptions> editOptionsList() {
    String imagePath = 'assets/icons/';
    return [
      EditOptions(
          title: StringConstants.kEditProfile,
          image: Image.asset("${imagePath}pen.png",
              height: kProfileImageHeight, width: kProfileImageWidth)),
      EditOptions(
          title: StringConstants.kChangeClient,
          image: Image.asset("${imagePath}exchange.png",
              height: kProfileImageHeight, width: kProfileImageWidth)),
      EditOptions(
          title: StringConstants.kLogout,
          image: Image.asset("${imagePath}logout.png",
              height: kProfileImageHeight, width: kProfileImageWidth)),
    ];
  }

  static List<ProfileOptions> profileOptionsList() {
    const String imagePath = 'assets/icons/';
    return [
      ProfileOptions(
          title: StringConstants.kChangePassword,
          image: Image.asset("${imagePath}reset-password.png",
              height: kProfileImageHeight, width: kProfileImageWidth)),
      ProfileOptions(
          title: StringConstants.kChangeLanguage,
          image: Image.asset("${imagePath}languages.png",
              height: kProfileImageHeight, width: kProfileImageWidth)),
      ProfileOptions(
          title: StringConstants.kChangeTimezone,
          image: Image.asset("${imagePath}time_zone.png",
              height: kProfileImageHeight, width: kProfileImageWidth)),
      ProfileOptions(
          title: StringConstants.kChangeDateFormat,
          image: Image.asset("${imagePath}calendar.png",
              height: kProfileImageHeight, width: kProfileImageWidth)),
      ProfileOptions(
          title: StringConstants.kToolKitEmail,
          image: Image.asset("${imagePath}email.png",
              height: kProfileImageHeight, width: kProfileImageWidth)),
      ProfileOptions(
          title: StringConstants.kPrivacyPolicy,
          image: Image.asset("${imagePath}compliant.png",
              height: kProfileImageHeight, width: kProfileImageWidth)),
      ProfileOptions(
          title: StringConstants.kMaturityModel,
          image: Image.asset("${imagePath}shield.png",
              height: kProfileImageHeight, width: kProfileImageWidth)),
    ];
  }
}
