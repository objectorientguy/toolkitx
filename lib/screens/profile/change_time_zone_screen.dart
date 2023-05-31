import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../blocs/timeZone/time_zone_bloc.dart';
import '../../blocs/timeZone/time_zone_events.dart';
import '../../blocs/timeZone/time_zone_states.dart';
import '../../configs/app_spacing.dart';
import '../../utils/constants/string_constants.dart';
import '../../widgets/error_section.dart';
import '../../widgets/generic_app_bar.dart';
import '../onboarding/widgets/time_zone_body.dart';

class ChangeTimeZoneScreen extends StatelessWidget {
  static const routeName = 'ChangeTimeZoneScreen';
  const ChangeTimeZoneScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    context.read<TimeZoneBloc>().add(FetchTimeZone());
    return Scaffold(
        appBar: const GenericAppBar(title: StringConstants.kSelectTimeZone),
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
                  Navigator.pop(context);
                }
              },
              builder: (context, state) {
                if (state is TimeZoneFetching) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is TimeZoneFetched) {
                  return TimeZoneBody(
                    timeZoneData: state.getTimeZoneModel.data!,
                    isFromProfile: true,
                  );
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
        ));
  }
}
