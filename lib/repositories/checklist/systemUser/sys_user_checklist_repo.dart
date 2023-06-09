import '../../../data/models/checklist/systemUser/system_user_cheklist_by_dates_model.dart';
import '../../../data/models/checklist/systemUser/system_user_list_model.dart';

abstract class CheckListRepository {
  Future<ChecklistListModel> fetchChecklist(
      int pageNo, String hashCode, String filter);

  Future<ChecklistScheduledByDatesModel> fetchScheduleDates(
      String checklistId, String hashCode);
}
