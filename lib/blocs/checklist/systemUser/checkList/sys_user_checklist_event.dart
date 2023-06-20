import '../../../../data/models/checklist/systemUser/sys_user_change_category_model.dart';

abstract class SysUserFetchCheckList {}

class FetchCheckList extends SysUserFetchCheckList {}

class FetchCheckListMaster extends SysUserFetchCheckList {}

class ChangeCheckListCategory extends SysUserFetchCheckList {
  final List<GetFilterCategoryData> getFilterCategoryData;
  final String categoryName;
  final String categoryId;

  ChangeCheckListCategory(
      {required this.categoryId,
      required this.getFilterCategoryData,
      required this.categoryName});
}

class FilterChecklist extends SysUserFetchCheckList {
  final Map filterChecklistMap;

  FilterChecklist({required this.filterChecklistMap});
}

class ClearCheckListFilter extends SysUserFetchCheckList {}
