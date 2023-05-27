import 'package:toolkit/data/models/timeZones/time_zone_model.dart';

abstract class TimeZoneStates {}

class TimeZoneInitial extends TimeZoneStates {}

class TimeZoneLoading extends TimeZoneStates {}

class TimeZoneLoaded extends TimeZoneStates {
  final GetTimeZoneModel getTimeZoneModel;

  TimeZoneLoaded({required this.getTimeZoneModel});
}

class TimeZoneError extends TimeZoneStates {
  final String message;

  TimeZoneError({required this.message});
}

class SelectTimeZoneLoaded extends TimeZoneStates {}
