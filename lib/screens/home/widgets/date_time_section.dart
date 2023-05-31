import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/configs/app_spacing.dart';

import '../../../blocs/home/home_bloc.dart';
import '../../../blocs/home/home_states.dart';
import '../../../configs/app_dimensions.dart';
import '../../../utils/date_util.dart';

class DateAndTimeSection extends StatelessWidget {
  final String dateTimeOffset;
  const DateAndTimeSection({Key? key, required this.dateTimeOffset})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeStates>(builder: (context, state) {
      if (state is DateAndTimeLoaded) {
        return Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
          Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset('assets/icons/calendar.png',
                    height: kImageHeight, width: kImageWidth),
                const SizedBox(width: tiniestSpacing),
                Text(DateUtil.formatDate(state.dateTime)),
                const SizedBox(width: smallSpacing),
                Image.asset('assets/icons/clock.png',
                    height: kImageHeight, width: kImageWidth),
                const SizedBox(width: tiniestSpacing),
                Text(DateUtil.formatTime(state.dateTime))
              ]),
          const SizedBox(height: smallSpacing),
          Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: smallSpacing),
                Image.asset('assets/icons/time_zone.png',
                    height: kImageHeight, width: kImageWidth),
                const SizedBox(width: tiniestSpacing),
                Text(state.timeZoneName)
              ])
        ]);
      } else {
        return const SizedBox();
      }
    });
  }
}
