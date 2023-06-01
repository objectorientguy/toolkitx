import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/blocs/dateFormat/date_format_bloc.dart';
import 'package:toolkit/blocs/dateFormat/date_format_events.dart';
import 'package:toolkit/blocs/dateFormat/date_format_states.dart';
import 'package:toolkit/configs/app_color.dart';
import 'package:toolkit/screens/onboarding/login/emailAddress/login_screen.dart';
import 'package:toolkit/screens/onboarding/widgets/custom_card.dart';
import 'package:toolkit/widgets/primary_button.dart';
import '../../../configs/app_dimensions.dart';
import '../../../configs/app_spacing.dart';
import '../../../data/enums/date_enum.dart';
import '../../../utils/constants/string_constants.dart';
import '../../../widgets/generic_app_bar.dart';

class SelectDateFormatScreen extends StatelessWidget {
  static const routeName = 'SelectDateFormatScreen';

  const SelectDateFormatScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const GenericAppBar(title: StringConstants.kSelectDateFormat),
        // This will be changed after QM gets merged into dev.
        body: BlocBuilder<DateFormatBloc, DateFormatStates>(
          builder: (context, state) {
            if (state is DateFormatSelected) {
              return SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Padding(
                      padding: const EdgeInsets.only(
                          left: leftRightMargin,
                          right: leftRightMargin,
                          top: topBottomPadding),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CustomCard(
                                elevation: kZeroElevation,
                                child: ListView.separated(
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    padding: const EdgeInsets.only(
                                        bottom: xxTinierSpacing),
                                    shrinkWrap: true,
                                    itemCount: CustomDateFormat.values.length,
                                    itemBuilder: (context, index) {
                                      return SizedBox(
                                          height: xxxMediumSpacing,
                                          child: RadioListTile(
                                              dense: true,
                                              activeColor: AppColor.deepBlue,
                                              title: Text(CustomDateFormat
                                                  .values
                                                  .elementAt(index)
                                                  .dateFormat),
                                              controlAffinity:
                                                  ListTileControlAffinity
                                                      .trailing,
                                              value: CustomDateFormat.values
                                                  .elementAt(index)
                                                  .dateFormat,
                                              groupValue:
                                                  state.dateFormatString,
                                              onChanged: (value) {
                                                value = CustomDateFormat.values
                                                    .elementAt(index)
                                                    .dateFormat;
                                                context
                                                    .read<DateFormatBloc>()
                                                    .add(SetDateFormat(
                                                        saveDateFormatValue:
                                                            CustomDateFormat
                                                                .values
                                                                .elementAt(
                                                                    index)
                                                                .value,
                                                        saveDateFormatString:
                                                            value));
                                              }));
                                    },
                                    separatorBuilder: (context, index) {
                                      return const Divider(
                                          thickness: kDividerThickness,
                                          height: kDividerHeight);
                                    })),
                            const SizedBox(height: xxxSmallerSpacing),
                            PrimaryButton(
                                onPressed: () {
                                  Navigator.pushNamed(
                                      context, LoginScreen.routeName);
                                },
                                textValue: StringConstants.kSave)
                          ])));
            } else {
              return const SizedBox();
            }
          },
        ));
  }
}
