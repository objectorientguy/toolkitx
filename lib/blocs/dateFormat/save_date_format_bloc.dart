import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/blocs/dateFormat/save_date_format_event.dart';
import 'package:toolkit/blocs/dateFormat/save_date_format_state.dart';
import 'package:toolkit/data/cache/customer_cache.dart';

import '../../data/cache/cache_keys.dart';
import '../../di/app_module.dart';

class SaveDateFormatBloc extends Bloc<SaveDateFormatEvent, DateFormatSaved> {
  final CustomerCache _customerCache = getIt<CustomerCache>();

  SaveDateFormatBloc() : super(DateFormatSaved()) {
    on<SaveDateFormatEvent>(_saveDateFormatValue);
  }

  FutureOr<void> _saveDateFormatValue(
      SaveDateFormatEvent event, Emitter<DateFormatSaved> emit) async {
    try {
      _customerCache.setCustomerDateFormatString(
          CacheKeys.dateFormatKey, event.saveDateFormatValue);
      emit(DateFormatSaved());
    } catch (e) {
      e.toString();
    }
  }
}
