import '../../data/models/login/generate_opt_login.dart';
import '../../data/models/login/login_model.dart';
import '../../data/models/login/validate_email.dart';
import '../../utils/constants/api_constants.dart';
import '../../utils/dio_client.dart';
import 'login_repository.dart';

class LoginRepositoryImpl extends LoginRepository {
  @override
  Future<ValidateEmailModel> validateEmail(Map validateEmailMap) async {
    final response = await DioClient().post(
        "${ApiConstants.baseUrl}/api/common/validateemail", validateEmailMap);
    return ValidateEmailModel.fromJson(response);
  }

  @override
  Future<GenerateOtpLoginModel> getOptLogin(Map getOptLoginMap) async {
    final response = await DioClient()
        .post("${ApiConstants.baseUrl}api/common/generateotp", getOptLoginMap);
    return GenerateOtpLoginModel.fromJson(response);
  }

  @override
  Future<LoginModel> postLogin(Map postLogin) async {
    final response = await DioClient()
        .post("${ApiConstants.baseUrl}/api/common/login", postLogin);
    return LoginModel.fromJson(response);
  }
}
