import 'dart:async';
import 'dart:convert';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/blocs/checklist/systemUser/checkList/sys_user_checklist_event.dart';
import 'package:toolkit/blocs/checklist/systemUser/checkList/sys_user_checklist_state.dart';
import '../../../../../data/cache/cache_keys.dart';
import '../../../../../data/cache/customer_cache.dart';
import '../../../../data/models/checklist/systemUser/sys_user_change_category_model.dart';
import '../../../../data/models/checklist/systemUser/sys_user_checklist_model.dart';
import '../../../../di/app_module.dart';
import '../../../../repositories/checklist/systemUser/sys_user_checklist_repository.dart';

class SysUserCheckListBloc
    extends Bloc<SysUserFetchCheckList, SysUserCheckListStates> {
  final SysUserCheckListRepository _sysUserCheckListRepository =
      getIt<SysUserCheckListRepository>();
  final CustomerCache _customerCache = getIt<CustomerCache>();
  int page = 0;
  bool isFetching = false;
  String checklistId = '';
  String categoryId = '';
  String filterData = '{}';

  SysUserCheckListStates get initialState => CheckListInitial();

  SysUserCheckListBloc() : super(CheckListInitial()) {
    on<FetchList>(_fetchList);
    on<FetchCategory>(_fetchCategory);
    on<ChangeCategory>(_changeCategory);
    on<FilterChecklist>(_filterChecklist);
    on<ClearSystemUserCheckListFilter>(_clearFilter);
  }

  _filterChecklist(
      FilterChecklist event, Emitter<SysUserCheckListStates> emit) {
    emit(SavingFilterData());
    try {
      filterData = jsonEncode(event.filterChecklistMap);
      emit(SavedFilterData(saveFilterData: event.filterChecklistMap));
    } catch (e) {
      emit(FilterDataNotSave(errorMessage: e.toString()));
    }
  }

  FutureOr<void> _fetchList(
      FetchList event, Emitter<SysUserCheckListStates> emit) async {
    emit(FetchingCheckList());
    try {
      String hashCode = (await _customerCache.getHashCode(CacheKeys.hashcode))!;
      ChecklistListModel getChecklistModel = await _sysUserCheckListRepository
          .fetchChecklist(page, hashCode, filterData);
      if (getChecklistModel.status == 200) {
        emit(CheckListFetched(getChecklistModel: getChecklistModel));
        page++;
      } else if (getChecklistModel.status == 204) {
        emit(CheckListFetched(getChecklistModel: getChecklistModel));
      } else {
        emit(CheckListError(errorMessage: 'Oops! Something went wrong'));
      }
    } catch (e) {
      emit(CheckListError(
          errorMessage: 'Oops! Something went wrong. Please try again.'));
    }
  }

  FutureOr<void> _fetchCategory(
      FetchCategory event, Emitter<SysUserCheckListStates> emit) async {
    emit(FetchingCategory());
    try {
      String hashCode = (await _customerCache.getHashCode(CacheKeys.hashcode))!;
      String userId = (await _customerCache.getUserId(CacheKeys.userId))!;
      GetFilterCategoryModel getFilterCategoryModel =
          await _sysUserCheckListRepository.fetchCategory(hashCode, userId);
      if (getFilterCategoryModel.status == 200 &&
          getFilterCategoryModel.data!.isNotEmpty) {
        add(ChangeCategory(
            getFilterCategoryData: getFilterCategoryModel.data![0],
            categoryName: '',
            categoryId: ''));
      } else {
        emit(CategoryNotFetched());
      }
    } catch (e) {
      emit(CategoryNotFetched());
    }
  }

  FutureOr<void> _changeCategory(
      ChangeCategory event, Emitter<SysUserCheckListStates> emit) async {
    categoryId = event.categoryId;
    emit(CategoryFetched(
        categoryName: event.categoryName,
        getFilterCategoryData: event.getFilterCategoryData,
        categoryId: event.categoryId));
  }

  _clearFilter(ClearSystemUserCheckListFilter event,
      Emitter<SysUserCheckListStates> emit) async {
    filterData = '{}';
  }
}
