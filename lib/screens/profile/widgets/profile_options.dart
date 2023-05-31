import 'package:flutter/material.dart';
import 'package:toolkit/configs/app_theme.dart';
import 'package:toolkit/screens/profile/change_time_zone_screen.dart';
import 'package:toolkit/utils/constants/string_constants.dart';
import '../../../blocs/dateFormat/date_format_bloc.dart';
import '../../../blocs/dateFormat/date_format_events.dart';
import '../../../configs/app_color.dart';
import '../../../configs/app_dimensions.dart';
import '../../../configs/app_spacing.dart';
import '../../../data/enums/date_enum.dart';
import '../../../utils/profile_util.dart';
import '../../onboarding/selectDateFormat/select_date_format_screen.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'package:url_launcher/url_launcher.dart';

import '../changePassword/select_change_password_screen.dart';
import '../change_language_screen.dart';

class ProfileOptions extends StatelessWidget {
  final String dateTimeValue;

  const ProfileOptions({Key? key, required this.dateTimeValue})
      : super(key: key);

  void profileOptionsSwitchCase(context, index) async {
    switch (index) {
      case 0:
        Navigator.pushNamed(context, SelectChangePasswordTypeScreen.routeName);
        break;
      case 1:
        Navigator.pushNamed(context, ChangeLanguageScreen.routeName);
        break;
      case 2:
        Navigator.pushNamed(context, ChangeTimeZoneScreen.routeName);
        break;
      case 3:
        context.read<DateFormatBloc>().add(
              SetDateFormat(
                  saveDateFormatValue: dateTimeValue,
                  saveDateFormatString: CustomDateFormat.values
                      .elementAt(CustomDateFormat.values.indexWhere(
                          (element) => element.value == dateTimeValue))
                      .dateFormat,
                  isFromProfile: true),
            );
        Navigator.pushNamed(context, SelectDateFormatScreen.routeName);
        break;
      case 4:
        await launchUrl(Uri.parse("mailto:${StringConstants.kToolkitXEmail}"));
        break;
      case 5:
        launchUrlString(StringConstants.kPrivacyPolicyUrl,
            mode: LaunchMode.inAppWebView);
        break;
      case 6:
        launchUrlString(StringConstants.kMaturityModelUrl,
            mode: LaunchMode.inAppWebView);
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(children: [
              const SizedBox(height: tiniestSpacing),
              ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  padding: EdgeInsets.zero,
                  shrinkWrap: true,
                  itemCount: ProfileUtil.profileOptionsList().length,
                  itemBuilder: (context, index) {
                    return ListTile(
                        contentPadding: EdgeInsets.zero,
                        horizontalTitleGap: 0.0,
                        leading: Image.asset(
                            ProfileUtil.profileOptionsList()
                                .elementAt(index)
                                .image,
                            height: kProfileImageHeight,
                            width: kProfileImageWidth),
                        title: Text(
                            ProfileUtil.profileOptionsList()
                                .elementAt(index)
                                .title,
                            style: Theme.of(context).textTheme.xSmall),
                        onTap: () async {
                          profileOptionsSwitchCase(context, index);
                        });
                  }),
              const SizedBox(height: largeSpacing),
              Center(
                  child: Text("App version 1.0.9",
                      style: Theme.of(context)
                          .textTheme
                          .xSmall
                          .copyWith(color: AppColor.grey)))
            ])));
  }
}
