import 'dart:async';
import 'dart:developer';

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
    String timeZoneName = '';
    try {
      timeZoneName =
          (await _customerCache.getTimeZoneName(CacheKeys.timeZoneName))!;
    } catch (e) {
      timeZoneName = DateTime.now().timeZoneName;
    }
    DateTime dateTime = DateTime.now();
    String? image = await _customerCache.getClientImage(CacheKeys.clientImage);
    String? timeZoneOffset =
        await _customerCache.getTimeZoneOffset(CacheKeys.timeZoneOffset);
    if (timeZoneOffset != null) {
      List offset =
          timeZoneOffset.replaceAll('+', '').replaceAll('-', '').split(':');
      log('Datetime now=====>$dateTime');
      if (timeZoneOffset.contains('+')) {
        dateTime = DateTime.now().toUtc().add(Duration(
            hours: int.parse(offset[0]), minutes: int.parse(offset[1].trim())));
        log('Add Datetime====>$dateTime');
      } else {
        dateTime = DateTime.now().toUtc().subtract(Duration(
            hours: int.parse(offset[0]), minutes: int.parse(offset[1].trim())));
        log('Sub Datetime====>$dateTime');
      }
    }
    emit(DateAndTimeLoaded(
        dateTime: dateTime, timeZoneName: timeZoneName, image: image!));
  }
}
