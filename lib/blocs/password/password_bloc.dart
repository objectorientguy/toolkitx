import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'password_events.dart';
import 'password_states.dart';

class PasswordBloc extends Bloc<PasswordEvents, PasswordSates> {
  PasswordSates get initialState => PasswordInitial();

  PasswordBloc() : super(PasswordInitial()) {
    on<UserTypeDropDown>(_userTypeValueChanged);
  }

  FutureOr<void> _userTypeValueChanged(
      UserTypeDropDown event, Emitter<PasswordSates> emit) async {
    emit(UserTypeDropDownLoaded(typeValue: event.typeValue));
  }
}
