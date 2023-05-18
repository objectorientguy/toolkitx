import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/blocs/selectDateFormat/select_date_format_bloc.dart';
import 'package:toolkit/blocs/selectDateFormat/select_date_format_states.dart';
import 'package:toolkit/configs/app_color.dart';
import 'package:toolkit/configs/app_theme.dart';
import 'package:toolkit/screens/onboarding/widgets/custom_card.dart';
import 'package:toolkit/widgets/custom_snackbar.dart';
import 'package:toolkit/widgets/primary_button.dart';
import '../../../blocs/selectDateFormat/select_date_format_events.dart';
import '../../../configs/app_dimensions.dart';
import '../../../configs/app_spacing.dart';
import '../../../data/enums/date_enum.dart';
import '../../../utils/constants/string_constants.dart';
import '../login/emailAddress/login_screen.dart';
import '../../../widgets/generic_app_bar.dart';

class SelectDateFormatScreen extends StatefulWidget {
  static const routeName = 'SelectDateFormatScreen';

  const SelectDateFormatScreen({Key? key}) : super(key: key);

  @override
  State<SelectDateFormatScreen> createState() => _SelectDateFormatScreenState();
}

class _SelectDateFormatScreenState extends State<SelectDateFormatScreen> {
  String? dateFormatValues;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const GenericAppBar(),
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
                    Text(StringConstants.kSelectDateFormat,
                        style: Theme.of(context).textTheme.medium),
                    const SizedBox(height: tinySpacing),
                    CustomCard(
                        elevation: 0,
                        child: ListView.separated(
                            physics: const NeverScrollableScrollPhysics(),
                            padding: EdgeInsets.only(
                                bottom:
                                    MediaQuery.of(context).size.width * 0.03),
                            shrinkWrap: true,
                            itemCount: CustomDateFormat.values.length,
                            itemBuilder: (context, index) {
                              return SizedBox(
                                  height:
                                      MediaQuery.of(context).size.width * 0.1,
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
                                          dateFormatValues = value;
                                        });
                                      }));
                            },
                            separatorBuilder: (context, index) {
                              return Divider(
                                  thickness: kDividerThickness,
                                  height: MediaQuery.of(context).size.width *
                                      0.062);
                            })),
                    const SizedBox(height: mediumSpacing),
                    BlocListener<DateFormatBloc, DateFormatStates>(
                        listener: (context, state) {
                          if (state is DateFormatLoading) {
                            const CircularProgressIndicator();
                          } else if (state is DateFormatLoaded) {
                            Navigator.pushNamed(context, LoginScreen.routeName);
                          } else if (state is DateFormatValidation) {
                            showCustomSnackBar(
                                context, state.message, StringConstants.kOk);
                          }
                        },
                        child: PrimaryButton(
                            onPressed: () {
                              context.read<DateFormatBloc>().add(
                                  SelectDateFormat(
                                      dateFormat: dateFormatValues.toString()));
                            },
                            textValue: StringConstants.kSave))
                  ])),
        ));
  }
}
