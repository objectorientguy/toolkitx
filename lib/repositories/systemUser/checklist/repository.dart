import 'package:toolkit/data/models/systemUser/checklist/details_model.dart';

import '../../../data/models/systemUser/checklist/list_model.dart';
import '../../../data/models/systemUser/checklist/pdf_model.dart';
import '../../../data/models/systemUser/checklist/status_model.dart';

abstract class ChecklistRepository {
  Future<GetChecklistModel> fetchChecklist();

  Future<GetChecklistDetailsModel> fetchChecklistDetails(String checklistId);

  Future<GetChecklistStatusModel> fetchChecklistStatus(String scheduleId);

  Future<GetPdfModel> fetchPdf(String responseId);
}
