import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../blocs/home/home_bloc.dart';
import '../../../blocs/home/home_states.dart';
import '../../../utils/date_util.dart';

class DateAndTimeSection extends StatelessWidget {
  const DateAndTimeSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeStates>(builder: (context, state) {
      if (state is DateAndTimeLoaded) {
        return Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/icons/calendar.png', height: 20, width: 20),
            const SizedBox(width: 5),
            Text(DateUtil.formatDate(state.dateTime)),
            const SizedBox(width: 20),
            Image.asset('assets/icons/clock.png', height: 20, width: 20),
            const SizedBox(width: 5),
            Text(DateUtil.formatTime(state.dateTime)),
            const SizedBox(width: 20),
            Image.asset('assets/icons/time_zone.png', height: 20, width: 20),
            const SizedBox(width: 5),
            Text(state.dateTime.timeZoneName.toString()),
          ],
        );
      } else {
        return const SizedBox();
      }
    });
  }
}
