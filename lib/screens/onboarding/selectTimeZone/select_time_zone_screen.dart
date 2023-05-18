import 'package:flutter/material.dart';
import 'package:toolkit/configs/app_spacing.dart';
import 'package:toolkit/configs/app_theme.dart';
import 'package:toolkit/screens/onboarding/widgets/custom_card.dart';
import 'package:toolkit/utils/constants/string_constants.dart';

import '../../../configs/app_dimensions.dart';
import '../selectDateFormat/select_date_format_screen.dart';
import '../../../widgets/generic_app_bar.dart';

class SelectTimeZoneScreen extends StatelessWidget {
  static const routeName = 'SelectTimeZoneScreen';

  const SelectTimeZoneScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const GenericAppBar(),
        body: Padding(
            padding: const EdgeInsets.only(
                left: leftRightMargin,
                right: leftRightMargin,
                top: topBottomSpacing),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(StringConstants.kSelectTimeZone,
                  style: Theme.of(context).textTheme.medium),
              const SizedBox(height: tinySpacing),
              Expanded(
                  child: ListView.separated(
                      padding: EdgeInsets.zero,
                      physics: const BouncingScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: 15,
                      itemBuilder: (context, index) {
                        return CustomCard(
                            shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.circular(kCardRadius)),
                            child: ListTile(
                                onTap: () {
                                  Navigator.pushNamed(context,
                                      SelectDateFormatScreen.routeName);
                                },
                                leading:
                                    const Icon(Icons.public, size: kIconSize),
                                title: const Padding(
                                  padding:
                                      EdgeInsets.only(bottom: tiniestSpacing),
                                  child: Text(StringConstants.kTime),
                                ),
                                subtitle:
                                    const Text(StringConstants.kTimeLocation)));
                      },
                      separatorBuilder: (BuildContext context, int index) {
                        return const SizedBox(height: tinySpacing);
                      }))
            ])));
  }
}
