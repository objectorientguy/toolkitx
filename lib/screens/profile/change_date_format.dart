import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/blocs/dateFormat/date_format_bloc.dart';
import 'package:toolkit/blocs/dateFormat/date_format_states.dart';
import 'package:toolkit/screens/onboarding/widgets/select_date_format_body.dart';
import 'package:toolkit/widgets/primary_button.dart';
import '../../../configs/app_spacing.dart';
import '../../../utils/constants/string_constants.dart';
import '../../../widgets/generic_app_bar.dart';

class ChangeDateFormatScreen extends StatelessWidget {
  static const routeName = 'ChangeDateFormatScreen';

  const ChangeDateFormatScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const GenericAppBar(title: StringConstants.kSelectDateFormat),
      body: BlocBuilder<DateFormatBloc, DateFormatStates>(
          buildWhen: (previousState, currentState) =>
              currentState is DateFormatSelected,
          builder: (context, state) {
            if (state is DateFormatSelected) {
              return SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Padding(
                      padding: const EdgeInsets.only(
                          left: leftRightMargin,
                          right: leftRightMargin,
                          top: topBottomSpacing),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SelectDateFormatBody(
                                dateFormatString: state.dateFormatString,
                                isFromProfile: true),
                            const SizedBox(height: mediumSpacing),
                            PrimaryButton(
                                onPressed: () {
                                  Navigator.pop(context);
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
