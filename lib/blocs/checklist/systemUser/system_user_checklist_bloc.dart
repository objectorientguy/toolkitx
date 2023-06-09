import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/utils/constants/string_constants.dart';
import '../../../../di/app_module.dart';
import '../../../data/cache/cache_keys.dart';
import '../../../data/cache/customer_cache.dart';
import '../../../data/models/checklist/systemUser/system_user_approve_model.dart';
import '../../../data/models/checklist/systemUser/system_user_category_model.dart';
import '../../../data/models/checklist/systemUser/system_user_change_role_model.dart';
import '../../../data/models/checklist/systemUser/system_user_cheklist_by_dates_model.dart';
import '../../../data/models/checklist/systemUser/system_user_edit_header_details_model.dart';
import '../../../data/models/checklist/systemUser/system_user_list_model.dart';
import '../../../data/models/checklist/systemUser/system_user_pdf_model.dart';
import '../../../data/models/checklist/systemUser/system_user_reject_model.dart';
import '../../../data/models/checklist/systemUser/sys_user_save_third_party_approval_model.dart';
import '../../../data/models/checklist/systemUser/system_user_workfoce_list_model.dart';
import '../../../data/models/checklist/systemUser/system_user_submit_header_model.dart';
import '../../../repositories/checklist/systemUser/system_user_repository.dart';
import 'system_user_checklist_events.dart';
import 'system_user_checklist_states.dart';

class ChecklistBloc extends Bloc<ChecklistEvents, ChecklistStates> {
  final ChecklistRepository _checklistRepository = getIt<ChecklistRepository>();
  final CustomerCache _customerCache = getIt<CustomerCache>();
  String roleIdKey = '';
  String roleNameKey = '';
  List responseIdList = [];
  Map allChecklistDataMap = {};
  int page = 0;
  bool isFetching = false;
  String filterData = '';

  ChecklistStates get initialState => ChecklistInitial();

  ChecklistBloc() : super(ChecklistInitial()) {
    on<FetchChecklist>(_fetchChecklist);
    on<FetchChecklistScheduleDates>(_fetchChecklistDetails);
    on<CheckResponse>(_checkResponse);
    on<FetchChecklistWorkforceList>(_fetchChecklistStatus);
    on<FetchPdf>(_fetchPdf);
    on<FetchRoles>(_fetchRoles);
    on<ChangeRoles>(_changeRole);
    on<FetchCategory>(_fetchCategory);
    on<ChangeCategory>(_changeCategory);
    on<FetchEditHeader>(_fetchEditHeader);
    on<StatusCheckBoxCheck>(_statusCheckboxCheck);
    on<FetchPopUpMenu>(_fetchPopUpMenuItems);
    on<ChecklistApprove>(_checklistApprove);
    on<ChecklistReject>(_checklistReject);
    on<SubmitHeader>(_submitHeader);
    on<ThirdPartyApprove>(_thirdPartyApprove);
    on<FilterChecklist>(_filterChecklist);
  }

  FutureOr<void> _fetchChecklist(
      FetchChecklist event, Emitter<ChecklistStates> emit) async {
    emit(ChecklistFetching());
    // try {
    String hashCode = (await _customerCache.getHashCode(CacheKeys.hashcode))!;
    ChecklistListModel getChecklistModel = await _checklistRepository
        .fetchChecklist(page, hashCode, filterData.toString());
    if (getChecklistModel.status == 200) {
      emit(ChecklistFetched(getChecklistModel: getChecklistModel));
      page++;
      log("pageee=====>$page");
    } else {
      emit(ChecklistError(errorMessage: ''));
    }
    // } catch (e) {
    //   emit(ChecklistError(errorMessage: ''));
    // }
  }

  FutureOr<void> _fetchChecklistDetails(
      FetchChecklistScheduleDates event, Emitter<ChecklistStates> emit) async {
    emit(FetchingChecklistScheduleDates());
    try {
      String hashCode = (await _customerCache.getHashCode(CacheKeys.hashcode))!;
      ChecklistScheduledByDatesModel getChecklistDetailsModel =
          await _checklistRepository.fetchChecklistDetails(
              event.checklistId, hashCode);
      emit(ChecklistDatesScheduled(
          getChecklistDetailsModel: getChecklistDetailsModel,
          allChecklistDataMap: allChecklistDataMap));
    } catch (e) {
      emit(ChecklistScheduleDatesError());
    }
  }

  _checkResponse(CheckResponse event, Emitter<ChecklistStates> emit) {
    allChecklistDataMap["scheduleId"] = event.scheduleId;
    event.getChecklistDetailsData.responsecount != 0
        ? add(FetchChecklistWorkforceList(
            scheduleId: event.scheduleId, role: roleIdKey, responseIds: []))
        : emit(ResponseChecked());
  }

  FutureOr<void> _fetchChecklistStatus(
      FetchChecklistWorkforceList event, Emitter<ChecklistStates> emit) async {
    emit(FetchingChecklistWorkforceList());
    try {
      String hashCode = (await _customerCache.getHashCode(CacheKeys.hashcode))!;
      ChecklistWorkforceListModel getChecklistStatusModel =
          await _checklistRepository.fetchChecklistStatus(
              event.scheduleId, hashCode, event.role);
      add(StatusCheckBoxCheck(
          responseId: '',
          getChecklistStatusModel: getChecklistStatusModel,
          selectedResponseIds: []));
    } catch (e) {
      emit(ChecklistWorkforceListError());
    }
  }

  FutureOr<void> _fetchPdf(
      FetchPdf event, Emitter<ChecklistStates> emit) async {
    emit(FetchingPdf());
    try {
      String hashCode = (await _customerCache.getHashCode(CacheKeys.hashcode))!;
      GetPdfModel getPdfModel =
          await _checklistRepository.fetchPdf(event.responseId, hashCode);
      emit(PdfFetched(getPdfModel: getPdfModel));
    } catch (e) {
      emit(FetchPdfError());
    }
  }

  FutureOr<void> _fetchRoles(
      FetchRoles event, Emitter<ChecklistStates> emit) async {
    emit(FetchingRoles());
    try {
      String hashCode = (await _customerCache.getHashCode(CacheKeys.hashcode))!;
      String userId = (await _customerCache.getUserId(CacheKeys.userId))!;
      CheckListRolesModel checkListRolesModel =
          await _checklistRepository.fetchRoles(hashCode, userId);
      if (checkListRolesModel.status == 200 &&
          checkListRolesModel.data!.isNotEmpty) {
        add(ChangeRoles(
            roleId: roleIdKey,
            roleName: roleNameKey,
            checkListRolesModel: checkListRolesModel));
      } else {
        emit(FetchRolesError());
      }
    } catch (e) {
      emit(FetchRolesError());
    }
  }

  FutureOr<void> _changeRole(
      ChangeRoles event, Emitter<ChecklistStates> emit) async {
    roleIdKey = event.roleId;
    roleNameKey = event.roleName;
    emit(RolesFetched(
        roleId: event.roleId,
        roleName: event.roleName,
        checkListRolesModel: event.checkListRolesModel,
        isChanged: event.isChanged));
  }

  FutureOr<void> _fetchCategory(
      FetchCategory event, Emitter<ChecklistStates> emit) async {
    emit(CategoryFetching());
    try {
      String hashCode = (await _customerCache.getHashCode(CacheKeys.hashcode))!;
      String userId = (await _customerCache.getUserId(CacheKeys.userId))!;
      GetFilterCategoryModel getFilterCategoryModel =
          await _checklistRepository.fetchCategory(hashCode, userId);
      if (getFilterCategoryModel.status == 200 &&
          getFilterCategoryModel.data!.isNotEmpty) {
        add(ChangeCategory(
            getFilterCategoryData: getFilterCategoryModel.data![0],
            categoryName: '',
            categoryId: ''));
      } else {
        emit(CategoryError());
      }
    } catch (e) {
      emit(CategoryError());
    }
  }

  FutureOr<void> _changeCategory(
      ChangeCategory event, Emitter<ChecklistStates> emit) async {
    allChecklistDataMap["category"] = event.categoryId;
    emit(CategoryFetched(
        categoryName: event.categoryName,
        getFilterCategoryData: event.getFilterCategoryData,
        categoryId: event.categoryId));
  }

  FutureOr<void> _fetchEditHeader(
      FetchEditHeader event, Emitter<ChecklistStates> emit) async {
    emit(FetchingEditHeader(scheduleId: event.scheduleId));
    try {
      String hashCode = (await _customerCache.getHashCode(CacheKeys.hashcode))!;
      CheckListEditHeaderDetailsModel getCheckListEditHeaderModel =
          await _checklistRepository.fetchEditHeader(
              event.scheduleId, hashCode);
      emit(EditHeaderFetched(
          getCheckListEditHeaderModel: getCheckListEditHeaderModel,
          allChecklistDataMap: allChecklistDataMap));
    } catch (e) {
      emit(EditHeaderError());
    }
  }

  _statusCheckboxCheck(
      StatusCheckBoxCheck event, Emitter<ChecklistStates> emit) {
    List responseIdsList = List.from(event.selectedResponseIds);
    if (event.responseId != '') {
      if (event.selectedResponseIds.contains(event.responseId) != true) {
        responseIdsList.add(event.responseId);
        event.popUpBuilder = true;
      } else {
        responseIdsList.remove(event.responseId);
        event.popUpBuilder = false;
      }
    }
    responseIdList = List.from(responseIdsList);
    emit(ChecklistWorkforceListFetched(
        getChecklistStatusModel: event.getChecklistStatusModel,
        selectedIdsList: responseIdsList,
        popUpMenuBuilder: event.popUpBuilder,
        allChecklistDataMap: allChecklistDataMap));
  }

  _fetchPopUpMenuItems(FetchPopUpMenu event, Emitter<ChecklistStates> emit) {
    List popUpMenuItems = [
      'Approve',
      'Reject',
      'Third Party Approve',
      'Edit Header'
    ];
    if (event.popUpMenuBuilder == false) {
      popUpMenuItems.removeAt(1);
      popUpMenuItems.removeAt(0);
    }
    emit(PopUpMenuItemsFetched(popUpMenuItems: popUpMenuItems));
  }

  FutureOr<void> _checklistApprove(
      ChecklistApprove event, Emitter<ChecklistStates> emit) async {
    emit(ChecklistApprovingData());
    try {
      String hashCode = (await _customerCache.getHashCode(CacheKeys.hashcode))!;
      if (event.approveMap["comment"] == null ||
          event.approveMap["comment"].toString().trim().isEmpty) {
        emit(ChecklistApproveError(message: StringConstants.kAddComment));
      }
      List responseId = [];
      for (int i = 0; i < responseIdList.length; i++) {
        responseId.add({"id": responseIdList[i]});
      }
      final Map postApproveDataMap = {
        "hashcode": hashCode,
        "responseids": responseId,
        "comments": event.approveMap["comment"]
      };
      ChecklistApproveModel postChecklistApproveModel =
      await _checklistRepository.checklistApprove(postApproveDataMap);
      emit(ChecklistDataApproved(
          postChecklistApproveModel: postChecklistApproveModel));
    } catch (e) {
      emit(ChecklistApproveError(message: e.toString()));
    }
  }

  FutureOr<void> _checklistReject(
      ChecklistReject event, Emitter<ChecklistStates> emit) async {
    emit(RejectingChecklist());
    try {
      String hashCode = (await _customerCache.getHashCode(CacheKeys.hashcode))!;
      if (event.rejectMap["comment"] == null ||
          event.rejectMap["comment"].toString().trim().isEmpty) {
        emit(ChecklistNotRejected(message: StringConstants.kAddComment));
      }
      List scheduleId = [];
      for (int i = 0; i < responseIdList.length; i++) {
        scheduleId.add({"id": responseIdList[i]});
      }
      final Map postRejectDataMap = {
        "hashcode": hashCode,
        "responseids": scheduleId,
        "comments": event.rejectMap["comment"]
      };
      ChecklistRejectModel postChecklistRejectModel =
      await _checklistRepository.checklistReject(postRejectDataMap);
      emit(ChecklistRejected(
          postChecklistRejectModel: postChecklistRejectModel));
    } catch (e) {
      emit(ChecklistNotRejected(message: e.toString()));
    }
  }

  FutureOr<void> _submitHeader(
      SubmitHeader event, Emitter<ChecklistStates> emit) async {
    emit(SubmittingHeader());
    try {
      String hashCode = (await _customerCache.getHashCode(CacheKeys.hashcode))!;
      if (event.submitHeaderList[0]["value"].toString() == "null" ||
          event.submitHeaderList[0]["value"].toString().trim().isEmpty) {
        emit(SubmitHeaderError(
            message: StringConstants.kAnswerQuestionValidation));
      } else {
        Map postEditHeaderMap = {
          "hashcode": hashCode,
          "answers": event.submitHeaderList,
          "scheduleid": event.submitHeaderMap["scheduleId"]
        };
        ChecklistSubmitHeaderModel postChecklistSubmitHeaderModel =
        await _checklistRepository.submitHeader(postEditHeaderMap);
        emit(HeaderSubmitted(
            postChecklistSubmitHeaderModel: postChecklistSubmitHeaderModel));
      }
    } catch (e) {
      emit(SubmitHeaderError(message: e.toString()));
    }
  }

  FutureOr<void> _thirdPartyApprove(
      ThirdPartyApprove event, Emitter<ChecklistStates> emit) async {
    emit(ApprovingThirdParty());
    try {
      String hashCode = (await _customerCache.getHashCode(CacheKeys.hashcode))!;
      if (event.thirdPartyApprove["name"].toString() == "null" ||
          event.thirdPartyApprove["name"].toString().trim().isEmpty) {
        emit(ThirdPartyDisapprove(message: 'Please enter name'));
      } else {
        List responseId = [];
        for (int i = 0; i < responseIdList.length; i++) {
          responseId.add({"id": responseIdList[i]});
        }
        Map saveThirdPartyApprovalMap = {
          "hashcode": hashCode,
          "responseids": responseId,
          "name": event.thirdPartyApprove["name"],
          "sign_text": event.thirdPartyApprove["sign_text"]
        };
        log("mappppp 1======>$saveThirdPartyApprovalMap");
        SaveThirdPartyApproval saveThirdPartyApproval =
            await _checklistRepository
                .saveThirdPartyApproval(saveThirdPartyApprovalMap);
        emit(ThirdPartyApproved(
            saveThirdPartyApproval: saveThirdPartyApproval,
            thirdPartyApproveMap: event.thirdPartyApprove));
        log("mappppp======>$saveThirdPartyApprovalMap");
      }
    } catch (e) {
      emit(ThirdPartyDisapprove(message: e.toString()));
    }
  }

  _filterChecklist(FilterChecklist event, Emitter<ChecklistStates> emit) async {
    emit(SavingFilterData());
    try {
      event.filterChecklistMap["category"] = allChecklistDataMap["category"];
      log("event.filter=======>${event.filterChecklistMap}");
      filterData = jsonEncode(event.filterChecklistMap);
      log("filterrrr=======>$filterData");
      emit(SavedFilterData(saveFilterData: event.filterChecklistMap));
    } catch (e) {
      emit(FilterDataNotSave(errorMessage: e.toString()));
    }
  }
}
