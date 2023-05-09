import 'package:flutter/material.dart';
import 'package:toolkit/configs/app_theme.dart';
import 'package:toolkit/screens/onboarding/login/emailAddress/login_email_screen.dart';
import 'package:toolkit/widgets/primary_button.dart';
import '../../../configs/app_color.dart';
import '../../../configs/app_spacing.dart';
import '../../../utils/constants/string_constants.dart';

class SelectYourDateFormatScreen extends StatelessWidget {
  static const routeName = 'SelectYourDateFormatScreen';

  const SelectYourDateFormatScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(automaticallyImplyLeading: false),
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
              height: MediaQuery.of(context).size.width * 1.12,
              color: AppColor.white,
              child: ListView.separated(
                physics: const NeverScrollableScrollPhysics(),
                padding: EdgeInsets.zero,
                shrinkWrap: true,
                itemCount: 10,
                itemBuilder: (context, index) {
                  return SizedBox(
                    height: MediaQuery.of(context).size.width * 0.1,
                    child: Center(
                      child: RadioListTile(
                          title: const Text(""),
                          controlAffinity: ListTileControlAffinity.trailing,
                          value: null,
                          groupValue: "",
                          onChanged: (_) {}),
                    ),
                  );
                },
                separatorBuilder: (context, index) {
                  return Divider(
                    thickness: kDividerThickness,
                    height: MediaQuery.of(context).size.width * 0.062,
                  );
                },
              ),
            ),
            const SizedBox(height: mediumSpacing),
            PrimaryButton(
                onPressed: () {
                  Navigator.pushNamed(context, LoginEmailScreen.routeName);
                },
                textValue: StringConstants.kSave)
          ],
        ),
      ),
    );
  }
}
