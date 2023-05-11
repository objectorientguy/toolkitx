import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/blocs/selectDateFormat/select_date_format_events.dart';
import 'package:toolkit/blocs/selectDateFormat/select_date_format_states.dart';
import 'package:toolkit/data/cache/cache_keys.dart';
import 'package:toolkit/data/cache/customer_cache.dart';
import 'package:toolkit/di/app_module.dart';
import 'package:toolkit/utils/constants/string_constants.dart';

class DateFormatBloc extends Bloc<DateFormatEvents, DateFormatStates> {
  final CustomerCache _customerCache = getIt<CustomerCache>();

  DateFormatStates get initialState => DateFormatInitial();

  DateFormatBloc() : super(DateFormatInitial()) {
    on<SelectDateFormat>(_dateFormat);
    on<ValidateDateFormat>(_dateFormatValidate);
  }

  _dateFormat(SelectDateFormat event, Emitter<DateFormatStates> emit) async {
    emit(DateFormatLoading());
    try {
      _customerCache.setCustomerDateFormatString(
          CacheKeys.dateFormatKey, event.dateFormat);
      String dateFormat = _customerCache
          .getCustomerDateFormat(CacheKeys.dateFormatKey)
          .toString();
      if (event.dateFormat.trim() == "null" || event.dateFormat.isEmpty) {
        add(ValidateDateFormat(message: StringConstants.kDateFormatValidate));
      } else {
        emit(DateFormatLoaded(dateFormat: dateFormat));
      }
    } catch (e) {
      emit(DateFormatError(message: e.toString()));
    }
  }

  _dateFormatValidate(
      ValidateDateFormat event, Emitter<DateFormatStates> emit) {
    emit(DateFormatValidation(message: event.message));
  }
}
