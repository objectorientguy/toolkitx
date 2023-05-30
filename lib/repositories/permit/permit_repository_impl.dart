import 'package:toolkit/utils/constants/api_constants.dart';
import '../../data/models/permit/all_permits_model.dart';
import '../../utils/dio_client.dart';
import 'permit_repository.dart';

class PermitRepositoryImpl extends PermitRepository {
  @override
  Future<AllPermitModel> getAllPermits() async {
    final response = await DioClient().get(
        "${ApiConstants.baseUrl}permit/get?pageno=1&hashcode=vbdvrj9aN/gnmG9HRZBOV137+VBlDH1innvdsfSI8lOHTShvQP8iAcfeuRbflSG0|3|1|1|cet_3&filter=&role=XyXKlqi+qAnXdhxREzo0SQ==");
    return AllPermitModel.fromJson(response);
  }
}
