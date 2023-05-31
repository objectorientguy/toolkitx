import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/blocs/onboarding/onboarding_events.dart';
import 'package:toolkit/blocs/onboarding/onboarding_states.dart';
import 'package:toolkit/data/cache/cache_keys.dart';

import '../../data/cache/customer_cache.dart';
import '../../di/app_module.dart';

class OnBoardingBloc extends Bloc<OnBoardingEvent, OnBoardingStates> {
  final CustomerCache _customerCache = getIt<CustomerCache>();

  OnBoardingStates get initialState => OnBoardingInitial();

  OnBoardingBloc() : super(OnBoardingInitial()) {
    on<OnBoardingEvent>(_onBoardingEvent);
  }

  FutureOr<void> _onBoardingEvent(
      OnBoardingEvent event, Emitter<OnBoardingStates> emit) async {
    bool isLoggedIn =
        (await _customerCache.getIsLoggedIn(CacheKeys.isLoggedIn))!;
    bool isLanguageSelected =
        (await _customerCache.getIsLoggedIn(CacheKeys.isLanguageSelected))!;
    bool isTimeZoneSelected =
        (await _customerCache.getIsLoggedIn(CacheKeys.isTimeZoneSelected))!;
    bool isDateFormatSelected =
        (await _customerCache.getIsLoggedIn(CacheKeys.isDateFormatSelected))!;
    if (isLoggedIn == true) {
      emit(LoggedIn());
    } else if (isLanguageSelected == true) {
      emit(LanguageSelected());
    } else if (isTimeZoneSelected == true) {
      emit(TimeZoneSelected());
    } else if (isDateFormatSelected == true) {
      emit(DateFormatSelected());
    }
  }
}
