import 'package:equatable/equatable.dart';

abstract class PasswordSates extends Equatable {}

class PasswordInitial extends PasswordSates {
  @override
  List<Object?> get props => throw UnimplementedError();
}

class UserTypeDropDownLoaded extends PasswordSates {
  final String typeValue;

  UserTypeDropDownLoaded({required this.typeValue});

  @override
  List<Object?> get props => [typeValue];
}
