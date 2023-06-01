import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/configs/app_spacing.dart';
import 'package:toolkit/screens/onboarding/widgets/custom_card.dart';
import 'package:toolkit/utils/constants/string_constants.dart';

import '../../../blocs/dateFormat/date_format_bloc.dart';
import '../../../blocs/dateFormat/date_format_events.dart';
import '../../../configs/app_dimensions.dart';
import '../../../data/enums/date_enum.dart';
import '../selectDateFormat/select_date_format_screen.dart';
import '../../../widgets/generic_app_bar.dart';

class SelectTimeZoneScreen extends StatelessWidget {
  static const routeName = 'SelectTimeZoneScreen';

  const SelectTimeZoneScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const GenericAppBar(title: StringConstants.kSelectTimeZone),
        body: Padding(
            padding: const EdgeInsets.only(
                left: leftRightMargin,
                right: leftRightMargin,
                top: topBottomPadding),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
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
                                  context.read<DateFormatBloc>().add(
                                      SetDateFormat(
                                          saveDateFormatValue: CustomDateFormat
                                              .values
                                              .elementAt(0)
                                              .value,
                                          saveDateFormatString: CustomDateFormat
                                              .values
                                              .elementAt(0)
                                              .dateFormat));
                                  Navigator.pushNamed(context,
                                      SelectDateFormatScreen.routeName);
                                },
                                leading:
                                    const Icon(Icons.public, size: kIconSize),
                                title: const Padding(
                                  padding:
                                      EdgeInsets.only(bottom: xxTiniestSpacing),
                                  child: Text(StringConstants.kTimeZone),
                                ),
                                subtitle:
                                    const Text(StringConstants.kTimeLocation)));
                      },
                      separatorBuilder: (BuildContext context, int index) {
                        return const SizedBox(height: xxTinySpacing);
                      }))
            ])));
  }
}
