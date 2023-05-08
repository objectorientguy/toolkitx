import 'package:flutter/material.dart';
import 'package:toolkit/configs/app_theme.dart';
import 'package:toolkit/screens/onboarding/login/emailAddress/login_email_screen.dart';
import 'package:toolkit/widgets/primary_button.dart';
import '../../../configs/app_color.dart';
import '../../../configs/app_spacing.dart';
import '../../../data/enums/date_enum.dart';
import '../../../utils/constants/string_constants.dart';

class SelectYourDateFormatScreen extends StatelessWidget {
  const SelectYourDateFormatScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
      ),
      body: Padding(
        padding: const EdgeInsets.only(
            left: leftRightMargin,
            right: leftRightMargin,
            top: topBottomSpacing),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(StringConstants.kSelectDateFormat,
                style: Theme.of(context).textTheme.largeTitle),
            const SizedBox(height: tinySpacing),
            Container(
              color: AppColor.white,
              child: ListView.separated(
                padding: EdgeInsets.zero,
                shrinkWrap: true,
                itemCount: dateFormatMap.length,
                itemBuilder: (context, index) {
                  return RadioListTile(
                      title: Text(
                          dateFormatMap.values.elementAt(index).toString()),
                      controlAffinity: ListTileControlAffinity.trailing,
                      value: null,
                      groupValue: "",
                      onChanged: (_) {});
                },
                separatorBuilder: (context, index) {
                  return const Divider(thickness: kDividerThickness);
                },
              ),
            ),
            const SizedBox(height: tinySpacing),
            PrimaryButton(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const LoginEmailScreen()));
                },
                textValue: StringConstants.kSave)
          ],
        ),
      ),
    );
  }
}
