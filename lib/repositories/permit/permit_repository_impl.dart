import 'package:toolkit/utils/constants/api_constants.dart';
import '../../data/models/pdf_generation_model.dart';
import '../../data/models/permit/all_permits_model.dart';
import '../../data/models/permit/permit_details_model.dart';
import '../../data/models/permit/permit_roles_model.dart';
import '../../utils/dio_client.dart';
import 'permit_repository.dart';

class PermitRepositoryImpl extends PermitRepository {
  @override
  Future<AllPermitModel> getAllPermits() async {
    final response = await DioClient().get(
        "${ApiConstants.baseUrl}permit/get?pageno=1&hashcode=vbdvrj9aN/gnmG9HRZBOV137+VBlDH1innvdsfSI8lOHTShvQP8iAcfeuRbflSG0|3|1|1|cet_3&filter=&role=XyXKlqi+qAnXdhxREzo0SQ==");
    return AllPermitModel.fromJson(response);
  }

  @override
  Future<PermitRolesModel> fetchPermitRoles() async {
    final response = await DioClient().get(
        "${ApiConstants.baseUrl}permit/getroles?hashcode=vbdvrj9aN/gnmG9HRZBOV137+VBlDH1innvdsfSI8lOHTShvQP8iAcfeuRbflSG0|3|1|1|cet_3&userid=2ATY8mLx8MjkcnrmiRLvrA==");
    return PermitRolesModel.fromJson(response);
  }

  @override
  Future<PermitDetailsModel> fetchPermitDetails() async {
    final response = await DioClient().get(
        "${ApiConstants.baseUrl}permit/GetPermitAllDetails?permitid=L1rdKdH2Z2w06XVMdH78Qw==&hashcode=vbdvrj9aN/gnmG9HRZBOV137+VBlDH1innvdsfSI8lOHTShvQP8iAcfeuRbflSG0|3|1|1|cet_3&role=fGLj9XEzYUQ+1lz4/JymXw==");
    return PermitDetailsModel.fromJson(response);
  }

  @override
  Future<PdfGenerationModel> generatePdf() async {
    final response = await DioClient().get(
        "${ApiConstants.baseUrl}permit/getpdf?permitid=L1rdKdH2Z2w06XVMdH78Qw==&hashcode=vbdvrj9aN/gnmG9HRZBOV137+VBlDH1innvdsfSI8lOHTShvQP8iAcfeuRbflSG0|3|1|1|cet_3");
    return PdfGenerationModel.fromJson(response);
  }
}
