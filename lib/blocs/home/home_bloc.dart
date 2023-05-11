import 'dart:async';

import 'package:toolkit/blocs/home/home_events.dart';
import 'package:toolkit/blocs/home/home_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeBloc extends Bloc<HomeEvents, HomeStates> {
  HomeBloc() : super(const HomeInitial()) {
    startTimeCounter();
    on<SetDateAndTime>(_setDateAndTime);
  }

  void startTimeCounter() async {
    Stream.periodic(const Duration(seconds: 1), (count) => count)
        .listen((count) => add(const SetDateAndTime()));
  }

  FutureOr<void> _setDateAndTime(
      SetDateAndTime event, Emitter<HomeStates> emit) {
    emit(DateAndTimeLoaded(dateTime: DateTime.now()));
  }
}
