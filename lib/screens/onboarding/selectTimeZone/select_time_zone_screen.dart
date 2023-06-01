import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/screens/onboarding/widgets/time_zone_body.dart';
import '../../../blocs/timeZone/time_zone_bloc.dart';
import '../../../blocs/timeZone/time_zone_events.dart';
import '../../../blocs/timeZone/time_zone_states.dart';
import '../../../configs/app_spacing.dart';
import '../../../utils/constants/string_constants.dart';
import '../../../widgets/generic_app_bar.dart';
import '../../../widgets/error_section.dart';

class SelectTimeZoneScreen extends StatelessWidget {
  static const routeName = 'SelectTimeZoneScreen';
  final bool isFromProfile;

  const SelectTimeZoneScreen({Key? key, this.isFromProfile = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    context.read<TimeZoneBloc>().add(FetchTimeZone());
    return Scaffold(
        appBar: const GenericAppBar(
          title: StringConstants.kSelectTimeZone,
        ),
        body: Padding(
          padding: const EdgeInsets.only(
              left: leftRightMargin,
              right: leftRightMargin,
              top: topBottomSpacing),
          child: BlocBuilder<TimeZoneBloc, TimeZoneStates>(
              builder: (context, state) {
            if (state is TimeZoneFetching) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is TimeZoneFetched) {
              return TimeZoneBody(
                  timeZoneData: state.getTimeZoneModel.data!,
                  isFromProfile: isFromProfile);
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
