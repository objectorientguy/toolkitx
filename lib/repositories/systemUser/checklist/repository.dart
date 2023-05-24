import '../../../data/models/systemUser/checklist/list_model.dart';

abstract class ChecklistRepository {
  Future<GetChecklistModel> fetchChecklist();
}
