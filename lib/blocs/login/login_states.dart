import 'package:equatable/equatable.dart';
import 'package:toolkit/data/models/login/generate_opt_login.dart';
import 'package:toolkit/data/models/login/login_model.dart';

import '../../data/models/login/validate_email.dart';

abstract class LoginStates extends Equatable {}

class LoginInitial extends LoginStates {
  @override
  List<Object?> get props => throw UnimplementedError();
}

class UserTypeDropDownLoaded extends LoginStates {
  final String typeUser;
  final String typeValue;

  UserTypeDropDownLoaded({required this.typeUser, required this.typeValue});

  @override
  List<Object?> get props => [typeUser];
}

class ValidateEmailLoading extends LoginStates {
  @override
  List<Object?> get props => throw UnimplementedError();
}

class ValidateEmailLoaded extends LoginStates {
  final ValidateEmailModel validateEmailModel;

  ValidateEmailLoaded({required this.validateEmailModel});

  @override
  List<Object?> get props => throw UnimplementedError();
}

class ValidateEmailError extends LoginStates {
  final String message;

  ValidateEmailError({required this.message});

  @override
  List<Object?> get props => throw UnimplementedError();
}

class GenerateOtpLoginLoading extends LoginStates {
  @override
  List<Object?> get props => throw UnimplementedError();
}

class GenerateOtpLoginLoaded extends LoginStates {
  final GenerateOtpLoginModel generateOtpLoginModel;

  GenerateOtpLoginLoaded({required this.generateOtpLoginModel});

  @override
  List<Object?> get props => throw UnimplementedError();
}

class GenerateOtpLoginError extends LoginStates {
  final String message;

  GenerateOtpLoginError({required this.message});

  @override
  List<Object?> get props => throw UnimplementedError();
}

class LoginLoading extends LoginStates {
  @override
  List<Object?> get props => throw UnimplementedError();
}

class LoginLoaded extends LoginStates {
  final LoginModel loginModel;

  LoginLoaded({required this.loginModel});

  @override
  List<Object?> get props => throw UnimplementedError();
}

class LoginError extends LoginStates {
  final String message;

  LoginError({required this.message});

  @override
  List<Object?> get props => throw UnimplementedError();
}
