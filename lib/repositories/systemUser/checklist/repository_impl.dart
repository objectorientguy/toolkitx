import 'package:toolkit/utils/constants/api_constants.dart';

import '../../../data/models/systemUser/checklist/list_model.dart';
import '../../../utils/dio_client.dart';
import 'repository.dart';

class ChecklistRepositoryImpl extends ChecklistRepository {
  @override
  Future<GetChecklistModel> fetchChecklist() async {
    final response = await DioClient().get(
        "${ApiConstants.baseUrl}/api/checklist/getallchecklists?pageno=1&hashcode=vbdvrj9aN/gnmG9HRZBOV137+VBlDH1innvdsfSI8lOHTShvQP8iAcfeuRbflSG0|3|1|1|cet_3&filter={}");
    return GetChecklistModel.fromJson(response);
  }
}
