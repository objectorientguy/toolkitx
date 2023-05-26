import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/blocs/dateFormat/date_format_events.dart';
import 'package:toolkit/blocs/dateFormat/date_format_states.dart';
import 'package:toolkit/data/cache/customer_cache.dart';

import '../../data/cache/cache_keys.dart';
import '../../di/app_module.dart';

class DateFormatBloc extends Bloc<SetDateFormat, DateFormatStates> {
  final CustomerCache _customerCache = getIt<CustomerCache>();

  DateFormatBloc() : super(DateFormatLoading()) {
    on<SetDateFormat>(_saveDateFormat);
  }

  FutureOr<void> _saveDateFormat(
      SetDateFormat event, Emitter<DateFormatStates> emit) async {
    _customerCache.setCustomerDateFormatString(
        CacheKeys.dateFormatKey, event.saveDateFormatValue);
    emit(DateFormatSelected(
        dateFormatValue: event.saveDateFormatValue,
        dateFormatString: event.saveDateFormatString));
  }
}
