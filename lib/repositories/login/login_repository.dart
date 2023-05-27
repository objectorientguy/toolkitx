import '../../data/models/login/generate_opt_login.dart';
import '../../data/models/login/login_model.dart';
import '../../data/models/login/validate_email.dart';

abstract class LoginRepository {
  Future<ValidateEmailModel> validateEmail(Map validateEmailMap);

  Future<GenerateOtpLoginModel> getOptLogin(Map getOptLoginMap);

  Future<LoginModel> postLogin(Map postLogin);
}
