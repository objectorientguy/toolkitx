import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/data/cache/cache_keys.dart';
import 'package:toolkit/data/models/encrypt_class.dart';
import 'package:toolkit/data/models/login/login_model.dart';
import 'package:toolkit/data/models/login/validate_email.dart';

import '../../data/cache/customer_cache.dart';
import '../../data/models/login/generate_opt_login.dart';
import '../../di/app_module.dart';
import '../../repositories/login/login_repository.dart';
import 'login_events.dart';
import 'login_states.dart';

class LoginBloc extends Bloc<LoginEvents, LoginStates> {
  final LoginRepository _loginRepository = getIt<LoginRepository>();
  final CustomerCache _customerCache = getIt<CustomerCache>();

  LoginStates get initialState => LoginInitial();

  LoginBloc() : super(LoginInitial()) {
    on<UserTypeDropDown>(_userTypeValueChanged);
    on<ValidateEmail>(_validateEmail);
    on<GenerateOtpLogin>(_generateOtpLogin);
    on<LoginEvent>(_loginEvent);
  }

  FutureOr<void> _userTypeValueChanged(
      UserTypeDropDown event, Emitter<LoginStates> emit) async {
    _customerCache.setUserType(CacheKeys.userType, event.typeValue);
    emit(UserTypeDropDownLoaded(
        typeUser: event.typeUser, typeValue: event.typeValue));
  }

  FutureOr<void> _validateEmail(
      ValidateEmail event, Emitter<LoginStates> emit) async {
    emit(ValidateEmailLoading());
    try {
      String encryptedEmail = await EncryptData.encryptAES(event.email);
      _customerCache.setEncryptedEmail(
          CacheKeys.encryptedEmail, encryptedEmail);
      Map validateEmailMap = {'emailaddress': encryptedEmail};
      ValidateEmailModel validateEmailModel =
          await _loginRepository.validateEmail(validateEmailMap);
      if (validateEmailModel.message == '1,2') {
        add(UserTypeDropDown(typeUser: 'null', typeValue: ''));
      } else {
        _customerCache.setUserType(
            CacheKeys.userType, validateEmailModel.message);
      }
      emit(ValidateEmailLoaded(validateEmailModel: validateEmailModel));
    } catch (e) {
      emit(ValidateEmailError(message: e.toString()));
    }
  }

  FutureOr<void> _generateOtpLogin(
      GenerateOtpLogin event, Emitter<LoginStates> emit) async {
    emit(GenerateOtpLoginLoading());
    try {
      String? email =
          await _customerCache.getEncryptedEmail(CacheKeys.encryptedEmail);
      Map generateOtpMap = {'emailaddress': email};
      GenerateOtpLoginModel generateOtpLoginModel =
          await _loginRepository.getOptLogin(generateOtpMap);
      emit(
          GenerateOtpLoginLoaded(generateOtpLoginModel: generateOtpLoginModel));
    } catch (e) {
      emit(GenerateOtpLoginError(message: e.toString()));
    }
  }

  FutureOr<void> _loginEvent(
      LoginEvent event, Emitter<LoginStates> emit) async {
    emit(LoginLoading());
    try {
      String? email =
          await _customerCache.getEncryptedEmail(CacheKeys.encryptedEmail);
      String? type = await _customerCache.getUserType(CacheKeys.userType);
      String password =
          await EncryptData.encryptAES(event.loginMap['password']);
      Map loginMap = {"username": email, "password": password, "type": type};
      LoginModel loginModel = await _loginRepository.postLogin(loginMap);
      if (loginModel.status == 200) {
        emit(LoginLoaded(loginModel: loginModel));
      } else {
        emit(LoginError(message: loginModel.message!));
      }
    } catch (e) {
      emit(LoginError(message: e.toString()));
    }
  }
}
