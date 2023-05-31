import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/blocs/dateFormat/date_format_events.dart';
import 'package:toolkit/blocs/dateFormat/date_format_states.dart';
import 'package:toolkit/data/cache/customer_cache.dart';

import '../../data/cache/cache_keys.dart';
import '../../di/app_module.dart';

class DateFormatBloc extends Bloc<SetDateFormat, DateFormatStates> {
  final CustomerCache _customerCache = getIt<CustomerCache>();

  DateFormatBloc() : super(DateFormatSelected(dateFormatString: '')) {
    on<SetDateFormat>(_saveDateFormat);
  }

  FutureOr<void> _saveDateFormat(
      SetDateFormat event, Emitter<DateFormatStates> emit) async {
    _customerCache.setCustomerDateFormatString(
        CacheKeys.dateFormatKey, event.saveDateFormatValue);
    _customerCache.setIsDateFormatSelected(
        CacheKeys.isDateFormatSelected, true);
    if (event.isFromProfile == true) {
      String timeZoneCode =
          (await _customerCache.getTimeZoneCode(CacheKeys.timeZoneCode))!;
      String userType = (await _customerCache.getUserType(CacheKeys.userType))!;
      String apiKey = (await _customerCache.getApiKey(CacheKeys.apiKey))!;
      String hashKey = (await _customerCache.getClientId(CacheKeys.clientId))!;
      String dateTimeValue = (await _customerCache
          .getCustomerDateFormat(CacheKeys.dateFormatKey))!;
      String hashCode =
          '$apiKey|$hashKey|$userType|$dateTimeValue|$timeZoneCode';
      _customerCache.setHashCode(CacheKeys.hashcode, hashCode);
    } else {
      null;
    }

    emit(DateFormatSelected(
        dateFormatValue: event.saveDateFormatValue,
        dateFormatString: event.saveDateFormatString));
  }
}
