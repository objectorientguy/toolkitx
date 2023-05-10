import 'package:flutter/material.dart';
import 'package:toolkit/configs/app_theme.dart';
import 'package:toolkit/data/cache/cache_keys.dart';
import 'package:toolkit/screens/onboarding/login/emailAddress/login_email_screen.dart';
import 'package:toolkit/screens/onboarding/widgets/custom_card.dart';
import 'package:toolkit/widgets/primary_button.dart';
import '../../../configs/app_spacing.dart';
import '../../../data/cache/customer_cache.dart';
import '../../../data/enums/date_enum.dart';
import '../../../utils/constants/string_constants.dart';
import '../../../widgets/generic_app_bar.dart';

class SelectYourDateFormatScreen extends StatefulWidget {
  static const routeName = 'SelectYourDateFormatScreen';

  const SelectYourDateFormatScreen({Key? key}) : super(key: key);

  @override
  State<SelectYourDateFormatScreen> createState() =>
      _SelectYourDateFormatScreenState();
}

class _SelectYourDateFormatScreenState
    extends State<SelectYourDateFormatScreen> {
  CustomerCache cache = CustomerCache();
  String? dateFormatValues;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const CustomAppBar(),
        body: Padding(
            padding: const EdgeInsets.only(
                left: leftRightMargin,
                right: leftRightMargin,
                top: topBottomSpacing),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(StringConstants.kSelectDateFormat,
                  style: Theme.of(context).textTheme.largeTitle),
              const SizedBox(height: tinySpacing),
              CustomCard(
                elevation: 0,
                child: ListView.separated(
                  physics: const NeverScrollableScrollPhysics(),
                  padding: EdgeInsets.only(
                      bottom: MediaQuery.of(context).size.width * 0.03),
                  shrinkWrap: true,
                  itemCount: CustomDateFormat.values.length,
                  itemBuilder: (context, index) {
                    return SizedBox(
                        height: MediaQuery.of(context).size.width * 0.1,
                        child: RadioListTile(
                          activeColor: Colors.blue,
                          title: Text(CustomDateFormat.values
                              .elementAt(index)
                              .dateFormat),
                          controlAffinity: ListTileControlAffinity.trailing,
                          value: CustomDateFormat.values
                              .elementAt(index)
                              .dateFormat,
                          groupValue: dateFormatValues,
                          onChanged: (value) {
                            setState(() {
                              value = CustomDateFormat.values
                                  .elementAt(index)
                                  .dateFormat;
                              dateFormatValues = value;
                            });
                          },
                        ));
                  },
                  separatorBuilder: (context, index) {
                    return Divider(
                        thickness: kDividerThickness,
                        height: MediaQuery.of(context).size.width * 0.062);
                  },
                ),
              ),
              const SizedBox(height: mediumSpacing),
              PrimaryButton(
                  onPressed: () {
                    cache.setCustomerDateFormatString(
                        CacheKeys.dateFormatKey, dateFormatValues.toString());
                    Navigator.pushNamed(context, LoginEmailScreen.routeName);
                  },
                  textValue: StringConstants.kSave)
            ])));
  }
}
