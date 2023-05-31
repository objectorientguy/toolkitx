import 'dart:async';

import 'package:toolkit/blocs/home/home_events.dart';
import 'package:toolkit/blocs/home/home_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/cache/cache_keys.dart';
import '../../data/cache/customer_cache.dart';
import '../../di/app_module.dart';

class HomeBloc extends Bloc<HomeEvents, HomeStates> {
  final CustomerCache _customerCache = getIt<CustomerCache>();

  HomeBloc() : super(const HomeInitial()) {
    on<SetDateAndTime>(_setDateAndTime);
    on<StartTimer>(_startTimer);
  }

  FutureOr<void> _startTimer(StartTimer event, Emitter<HomeStates> emit) {
    Stream.periodic(const Duration(seconds: 1), (count) => count)
        .listen((count) => add(const SetDateAndTime()));
  }

  FutureOr<void> _setDateAndTime(
      SetDateAndTime event, Emitter<HomeStates> emit) async {
    String timeZoneName =
        (await _customerCache.getTimeZoneName(CacheKeys.timeZoneName))!;
    emit(DateAndTimeLoaded(
        dateTime: DateTime.now(), timeZoneName: timeZoneName));
  }
}
