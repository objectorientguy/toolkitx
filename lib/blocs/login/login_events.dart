abstract class LoginEvents {}

class ChangeUserType extends LoginEvents {
  final String typeUser;
  final String typeValue;

  ChangeUserType({required this.typeValue, required this.typeUser});
}

class ValidateEmail extends LoginEvents {
  final String? email;

  ValidateEmail({required this.email});
}

class GenerateOtpLogin extends LoginEvents {}

class LoginEvent extends LoginEvents {
  final Map loginMap;

  LoginEvent({required this.loginMap});
}
