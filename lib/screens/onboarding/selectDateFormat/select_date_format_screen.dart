import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/blocs/dateFormat/date_format_bloc.dart';
import 'package:toolkit/blocs/dateFormat/date_format_events.dart';
import 'package:toolkit/blocs/dateFormat/date_format_states.dart';
import 'package:toolkit/screens/onboarding/login/login_screen.dart';
import 'package:toolkit/screens/onboarding/widgets/select_date_format_body.dart';
import 'package:toolkit/widgets/primary_button.dart';
import '../../../configs/app_spacing.dart';
import '../../../utils/constants/string_constants.dart';
import '../../../widgets/generic_app_bar.dart';

class SelectDateFormatScreen extends StatelessWidget {
  static const routeName = 'SelectDateFormatScreen';
  final bool isFromProfile;

  const SelectDateFormatScreen({Key? key, this.isFromProfile = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    context
        .read<DateFormatBloc>()
        .add(SetDateFormat(isFromProfile: isFromProfile));
    return Scaffold(
      appBar: const GenericAppBar(title: StringConstants.kSelectDateFormat),
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
                        SelectDateFormatBody(
                          dateFormatString: state.dateFormatString,
                          isFromProfile: isFromProfile,
                        ),
                        const SizedBox(height: xxxSmallerSpacing),
                        PrimaryButton(
                            onPressed: () {
                              if (isFromProfile == true) {
                                Navigator.pop(context);
                              } else {
                                Navigator.pushNamed(
                                    context, LoginScreen.routeName);
                              }
                            },
                            textValue: StringConstants.kSave)
                      ])));
        } else {
          return const SizedBox();
        }
      }),
    );
  }
}
