import '../../../../data/models/checklist/systemUser/sys_user_change_category_model.dart';

abstract class SysUserFetchCheckList {}

class FetchList extends SysUserFetchCheckList {}

class FetchCategory extends SysUserFetchCheckList {}

class ChangeCategory extends SysUserFetchCheckList {
  final List<GetFilterCategoryData> getFilterCategoryData;
  final String categoryName;
  final String categoryId;

  ChangeCategory(
      {required this.categoryId,
      required this.getFilterCategoryData,
      required this.categoryName});
}

class FilterChecklist extends SysUserFetchCheckList {
  final Map filterChecklistMap;

  FilterChecklist({required this.filterChecklistMap});
}

class ClearSystemUserCheckListFilter extends SysUserFetchCheckList {}
