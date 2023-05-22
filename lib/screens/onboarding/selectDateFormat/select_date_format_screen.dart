import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/blocs/dateFormat/save_date_format_bloc.dart';
import 'package:toolkit/blocs/dateFormat/save_date_format_event.dart';
import 'package:toolkit/blocs/dateFormat/save_date_format_state.dart';
import 'package:toolkit/configs/app_color.dart';
import 'package:toolkit/configs/app_theme.dart';
import 'package:toolkit/screens/onboarding/login/emailAddress/login_screen.dart';
import 'package:toolkit/screens/onboarding/widgets/custom_card.dart';
import 'package:toolkit/widgets/primary_button.dart';
import '../../../configs/app_dimensions.dart';
import '../../../configs/app_spacing.dart';
import '../../../data/enums/date_enum.dart';
import '../../../utils/constants/string_constants.dart';
import '../../../widgets/generic_app_bar.dart';

class SelectDateFormatScreen extends StatefulWidget {
  static const routeName = 'SelectDateFormatScreen';

  const SelectDateFormatScreen({Key? key}) : super(key: key);

  @override
  State<SelectDateFormatScreen> createState() => _SelectDateFormatScreenState();
}

class _SelectDateFormatScreenState extends State<SelectDateFormatScreen> {
  String dateFormatValues = CustomDateFormat.values.elementAt(0).dateFormat;
  String values = CustomDateFormat.values.elementAt(0).value;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: GenericAppBar(
            title: Text(StringConstants.kSelectDateFormat,
                style: Theme.of(context).textTheme.medium)),
        // This will be changed after QM gets merged into dev.
        body: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Padding(
                padding: const EdgeInsets.only(
                    left: leftRightMargin,
                    right: leftRightMargin,
                    top: topBottomSpacing),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomCard(
                          elevation: kZeroElevation,
                          child: ListView.separated(
                              physics: const NeverScrollableScrollPhysics(),
                              padding: const EdgeInsets.only(
                                  bottom: midTiniestSpacing),
                              shrinkWrap: true,
                              itemCount: CustomDateFormat.values.length,
                              itemBuilder: (context, index) {
                                return SizedBox(
                                    height: largeSpacing,
                                    child: RadioListTile(
                                        dense: true,
                                        activeColor: AppColor.deepBlue,
                                        title: Text(CustomDateFormat.values
                                            .elementAt(index)
                                            .dateFormat),
                                        controlAffinity:
                                            ListTileControlAffinity.trailing,
                                        value: CustomDateFormat.values
                                            .elementAt(index)
                                            .dateFormat,
                                        groupValue: dateFormatValues,
                                        onChanged: (value) {
                                          setState(() {
                                            value = CustomDateFormat.values
                                                .elementAt(index)
                                                .dateFormat;
                                            dateFormatValues = value!;
                                            values = CustomDateFormat.values
                                                .elementAt(index)
                                                .value;
                                          });
                                        }));
                              },
                              separatorBuilder: (context, index) {
                                return const Divider(
                                    thickness: kDividerThickness,
                                    height: kDividerHeight);
                              })),
                      const SizedBox(height: mediumSpacing),
                      BlocListener<SaveDateFormatBloc, DateFormatSaved>(
                          listener: (context, state) {
                            Navigator.pushNamed(context, LoginScreen.routeName);
                          },
                          child: PrimaryButton(
                              onPressed: () {
                                context.read<SaveDateFormatBloc>().add(
                                    SaveDateFormatEvent(
                                        saveDateFormatValue: values));
                              },
                              textValue: StringConstants.kSave))
                    ]))));
  }
}
