import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../blocs/timeZone/time_zone_bloc.dart';
import '../../../blocs/timeZone/time_zone_events.dart';
import '../../../configs/app_dimensions.dart';
import '../../../configs/app_spacing.dart';
import '../../../data/models/timeZones/time_zone_model.dart';
import '../selectDateFormat/select_date_format_screen.dart';
import 'custom_card.dart';

class TimeZoneBody extends StatelessWidget {
  final List<TimeZoneData> timeZoneData;
  final bool isFromProfile;

  const TimeZoneBody(
      {Key? key, required this.timeZoneData, this.isFromProfile = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        padding: EdgeInsets.zero,
        physics: const BouncingScrollPhysics(),
        shrinkWrap: true,
        itemCount: timeZoneData.length,
        itemBuilder: (context, index) {
          return CustomCard(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(kCardRadius)),
              child: ListTile(
                  onTap: () {
                    context.read<TimeZoneBloc>().add(SelectTimeZone(
                        timeZoneCode: timeZoneData[index].code,
                        isFromProfile: isFromProfile,
                        timeZoneName: timeZoneData[index].name));
                    if (isFromProfile == true) {
                      Navigator.pop(context);
                    } else {
                      Navigator.pushNamed(
                          context, SelectDateFormatScreen.routeName,
                          arguments: false);
                    }
                  },
                  leading: const Icon(Icons.public, size: kIconSize),
                  title: Padding(
                      padding: const EdgeInsets.only(bottom: xxTiniestSpacing),
                      child: Text(timeZoneData[index].offset)),
                  subtitle: Text(timeZoneData[index].name)));
        },
        separatorBuilder: (BuildContext context, int index) {
          return const SizedBox(height: xxTinierSpacing);
        });
  }
}
