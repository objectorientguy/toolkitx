import 'package:equatable/equatable.dart';

abstract class DateFormatEvents extends Equatable {}

class SelectDateFormat extends DateFormatEvents {
  final String dateFormat;

  SelectDateFormat({required this.dateFormat});

  @override
  List<Object?> get props => [dateFormat];
}

class ValidateDateFormat extends DateFormatEvents {
  final String message;

  ValidateDateFormat({required this.message});

  @override
  List<Object?> get props => [];
}
