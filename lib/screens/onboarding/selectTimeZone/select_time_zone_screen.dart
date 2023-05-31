import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/screens/onboarding/language/select_language_screen.dart';
import 'package:toolkit/screens/onboarding/widgets/time_zone_body.dart';
import '../../../blocs/timeZone/time_zone_bloc.dart';
import '../../../blocs/timeZone/time_zone_events.dart';
import '../../../blocs/timeZone/time_zone_states.dart';
import '../../../configs/app_spacing.dart';
import '../../../utils/constants/string_constants.dart';
import '../selectDateFormat/select_date_format_screen.dart';
import '../../../widgets/generic_app_bar.dart';
import '../../../widgets/error_section.dart';

class SelectTimeZoneScreen extends StatelessWidget {
  static const routeName = 'SelectTimeZoneScreen';

  const SelectTimeZoneScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    context.read<TimeZoneBloc>().add(FetchTimeZone());
    return WillPopScope(
      onWillPop: () async {
        Navigator.pushNamed(context, SelectLanguageScreen.routeName);
        return true;
      },
      child: Scaffold(
          appBar: GenericAppBar(
              title: StringConstants.kSelectTimeZone,
              onPressed: () =>
                  Navigator.pushNamed(context, SelectLanguageScreen.routeName)),
          body: Padding(
            padding: const EdgeInsets.only(
                left: leftRightMargin,
                right: leftRightMargin,
                top: topBottomSpacing),
            child: BlocConsumer<TimeZoneBloc, TimeZoneStates>(
                buildWhen: (previousState, currentState) =>
                    currentState is TimeZoneFetching ||
                    currentState is TimeZoneFetched,
                listener: (context, state) {
                  if (state is TimeZoneSelected) {
                    Navigator.pushNamed(
                        context, SelectDateFormatScreen.routeName);
                  }
                },
                builder: (context, state) {
                  if (state is TimeZoneFetching) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state is TimeZoneFetched) {
                    return TimeZoneBody(
                        timeZoneData: state.getTimeZoneModel.data!);
                  } else if (state is FetchTimeZoneError) {
                    return Center(
                        child: GenericReloadButton(
                            onPressed: () {
                              context.read<TimeZoneBloc>().add(FetchTimeZone());
                            },
                            textValue: StringConstants.kReload));
                  } else {
                    return const SizedBox();
                  }
                }),
          )),
    );
  }
}
