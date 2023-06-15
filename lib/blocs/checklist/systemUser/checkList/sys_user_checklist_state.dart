import 'package:equatable/equatable.dart';

import '../../../../data/models/checklist/systemUser/sys_user_change_category_model.dart';
import '../../../../data/models/checklist/systemUser/sys_user_checklist_model.dart';

abstract class SysUserCheckListStates extends Equatable {}

class CheckListInitial extends SysUserCheckListStates {
  @override
  List<Object?> get props => [];
}

class FetchingCheckList extends SysUserCheckListStates {
  @override
  List<Object?> get props => [];
}

class CheckListFetched extends SysUserCheckListStates {
  final ChecklistListModel getChecklistModel;

  CheckListFetched({required this.getChecklistModel});

  @override
  List<Object?> get props => [];
}

class CheckListError extends SysUserCheckListStates {
  final String errorMessage;

  CheckListError({required this.errorMessage});

  @override
  List<Object?> get props => [errorMessage];
}

class FetchingCategory extends SysUserCheckListStates {
  @override
  List<Object?> get props => [];
}

class CategoryFetched extends SysUserCheckListStates {
  final List<GetFilterCategoryData> getFilterCategoryData;
  final String categoryName;
  final String categoryId;

  CategoryFetched(
      {required this.categoryId,
      required this.categoryName,
      required this.getFilterCategoryData});

  @override
  List<Object?> get props => [getFilterCategoryData, categoryName, categoryId];
}

class CategoryNotFetched extends SysUserCheckListStates {
  @override
  List<Object?> get props => [];
}

class SavingFilterData extends SysUserCheckListStates {
  @override
  List<Object?> get props => [];
}

class SavedFilterData extends SysUserCheckListStates {
  final Map saveFilterData;

  SavedFilterData({required this.saveFilterData});

  @override
  List<Object?> get props => [saveFilterData];
}

class FilterDataNotSave extends SysUserCheckListStates {
  final String errorMessage;

  FilterDataNotSave({required this.errorMessage});

  @override
  List<Object?> get props => [errorMessage];
}
