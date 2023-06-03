import 'dart:async';
import 'dart:developer';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/utils/constants/string_constants.dart';
import '../../../../di/app_module.dart';
import '../../../data/models/checklist/systemUser/approve_model.dart';
import '../../../data/models/checklist/systemUser/category_model.dart';
import '../../../data/models/checklist/systemUser/change_role_model.dart';
import '../../../data/models/checklist/systemUser/details_model.dart';
import '../../../data/models/checklist/systemUser/get_edit_header_model.dart';
import '../../../data/models/checklist/systemUser/list_model.dart';
import '../../../data/models/checklist/systemUser/pdf_model.dart';
import '../../../data/models/checklist/systemUser/reject_model.dart';
import '../../../data/models/checklist/systemUser/status_model.dart';
import '../../../data/models/checklist/systemUser/submit_header_model.dart';
import '../../../repositories/checklist/systemUser/repository.dart';
import 'checklist_events.dart';
import 'checklist_states.dart';

class ChecklistBloc extends Bloc<ChecklistEvents, ChecklistStates> {
  final ChecklistRepository _checklistRepository = getIt<ChecklistRepository>();
  String roleIdKey = '';
  String roleNameKey = '';

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
  }

  FutureOr<void> _fetchChecklist(
      FetchChecklist event, Emitter<ChecklistStates> emit) async {
    emit(ChecklistFetching());
    try {
      GetChecklistModel getChecklistModel =
          await _checklistRepository.fetchChecklist();
      emit(ChecklistFetched(getChecklistModel: getChecklistModel));
    } catch (e) {
      emit(ChecklistError());
    }
  }

  FutureOr<void> _fetchChecklistDetails(
      FetchChecklistScheduleDates event, Emitter<ChecklistStates> emit) async {
    emit(FetchingChecklistScheduleDates());
    try {
      GetChecklistDetailsModel getChecklistDetailsModel =
          await _checklistRepository.fetchChecklistDetails(event.checklistId);
      emit(ChecklistDatesScheduled(
          getChecklistDetailsModel: getChecklistDetailsModel));
    } catch (e) {
      emit(ChecklistScheduleDatesError());
    }
  }

  _checkResponse(CheckResponse event, Emitter<ChecklistStates> emit) {
    event.getChecklistDetailsData.responsecount != 0
        ? add(FetchChecklistWorkforceList(
            scheduleId: event.scheduleId, role: roleIdKey))
        : emit(ResponseChecked());
  }

  FutureOr<void> _fetchChecklistStatus(
      FetchChecklistWorkforceList event, Emitter<ChecklistStates> emit) async {
    emit(FetchingChecklistWorkforceList());
    try {
      GetChecklistStatusModel getChecklistStatusModel =
          await _checklistRepository.fetchChecklistStatus(
              event.scheduleId, event.role);
      add(StatusCheckBoxCheck(
          statusId: '',
          getChecklistStatusModel: getChecklistStatusModel,
          selectedStatus: []));
    } catch (e) {
      emit(ChecklistWorkforceListError());
    }
  }

  FutureOr<void> _fetchPdf(
      FetchPdf event, Emitter<ChecklistStates> emit) async {
    emit(FetchingPdf());
    try {
      GetPdfModel getPdfModel =
          await _checklistRepository.fetchPdf(event.responseId);
      emit(PdfFetched(getPdfModel: getPdfModel));
    } catch (e) {
      emit(FetchPdfError());
    }
  }

  FutureOr<void> _fetchRoles(
      FetchRoles event, Emitter<ChecklistStates> emit) async {
    emit(FetchingRoles());
    try {
      CheckListRolesModel checkListRolesModel =
          await _checklistRepository.fetchRoles(event.userId);
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
      GetFilterCategoryModel getFilterCategoryModel =
          await _checklistRepository.fetchCategory(event.userId);
      if (getFilterCategoryModel.status == 200 &&
          getFilterCategoryModel.data!.isNotEmpty) {
        add(ChangeCategory(
            getFilterCategoryData: getFilterCategoryModel.data![0],
            categoryName: ''));
      } else {
        emit(CategoryError());
      }
    } catch (e) {
      emit(CategoryError());
    }
  }

  FutureOr<void> _changeCategory(
      ChangeCategory event, Emitter<ChecklistStates> emit) async {
    emit(CategoryFetched(
        categoryName: event.categoryName,
        getFilterCategoryData: event.getFilterCategoryData));
  }

  FutureOr<void> _fetchEditHeader(
      FetchEditHeader event, Emitter<ChecklistStates> emit) async {
    emit(FetchingEditHeader(scheduleId: event.scheduleId));
    try {
      GetCheckListEditHeaderModel getCheckListEditHeaderModel =
          await _checklistRepository.fetchEditHeader(event.scheduleId);
      emit(EditHeaderFetched(
          getCheckListEditHeaderModel: getCheckListEditHeaderModel));
    } catch (e) {
      emit(EditHeaderError());
    }
  }

  _statusCheckboxCheck(
      StatusCheckBoxCheck event, Emitter<ChecklistStates> emit) {
    List listChanged = List.from(event.selectedStatus);
    if (event.statusId != '') {
      if (event.selectedStatus.contains(event.statusId) != true) {
        listChanged.add(event.statusId);
        event.popUpBuilder = true;
      } else {
        listChanged.remove(event.statusId);
        event.popUpBuilder = false;
      }
    }
    emit(ChecklistWorkforceListFetched(
        getChecklistStatusModel: event.getChecklistStatusModel,
        selectedStatusList: listChanged,
        popUpMenuBuilder: event.popUpBuilder));
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
    log("poop items========>$popUpMenuItems");
    emit(PopUpMenuItemsFetched(popUpMenuItems: popUpMenuItems));
  }

  FutureOr<void> _checklistApprove(
      ChecklistApprove event, Emitter<ChecklistStates> emit) async {
    emit(ChecklistApprovingData());
    try {
      if (event.approveMap["comment"] == null) {
        emit(ChecklistApproveError(message: StringConstants.kAddComment));
      }
      List scheduleId = [];
      for (int i = 0; i < event.approveMap["id"].length; i++) {
        scheduleId.add({"id": event.approveMap["id"][i]});
      }
      final Map postApproveDataMap = {
        "hashcode":
            "SvwH32gnWK1slqvskIsSg9duoVfgOQLWitcfZGr+n2KX1yltKm2T+EbsIhBm0E6B|3|1|1|azot_91",
        "responseids": scheduleId,
        "comments": event.approveMap["comment"]
      };
      log("postttt=====>$postApproveDataMap");
      PostChecklistApproveModel postChecklistApproveModel =
          await _checklistRepository.checklistApprove(postApproveDataMap);
      emit(ChecklistDataApproved(
          postChecklistApproveModel: postChecklistApproveModel));
    } catch (e) {
      emit(ChecklistApproveError(message: e.toString()));
    }
  }

  FutureOr<void> _checklistReject(
      ChecklistReject event, Emitter<ChecklistStates> emit) async {
    emit(ChecklistRejectingData());
    try {
      if (event.rejectMap["comment"] == null) {
        emit(ChecklistApproveError(message: StringConstants.kAddComment));
      }
      List scheduleId = [];
      for (int i = 0; i < event.rejectMap["id"].length; i++) {
        scheduleId.add({"id": event.rejectMap["id"][i]});
      }
      final Map postRejectDataMap = {
        "hashcode":
            "SvwH32gnWK1slqvskIsSg9duoVfgOQLWitcfZGr+n2KX1yltKm2T+EbsIhBm0E6B|3|1|1|azot_91",
        "responseids": scheduleId,
        "comments": event.rejectMap["comment"]
      };
      PostChecklistRejectModel postChecklistRejectModel =
          await _checklistRepository.checklistReject(postRejectDataMap);
      emit(ChecklistRejected(
          postChecklistRejectModel: postChecklistRejectModel));
    } catch (e) {
      emit(ChecklistRejectError(message: e.toString()));
    }
  }

  FutureOr<void> _submitHeader(
      SubmitHeader event, Emitter<ChecklistStates> emit) async {
    emit(SubmittingHeader());
    try {
      if (event.submitHeaderList[0]["value"].toString() == "null" ||
          event.submitHeaderList[0]["value"].toString().trim() == '') {
        emit(SubmitHeaderError(
            message: StringConstants.kAnswerQuestionValidation));
      } else {
        Map postEditHeaderMap = {
          "hashcode":
              "SvwH32gnWK1slqvskIsSg9duoVfgOQLWitcfZGr+n2KX1yltKm2T+EbsIhBm0E6B|3|1|1|azot_91",
          "answers": event.submitHeaderList,
          "scheduleid": event.submitHeaderMap["scheduleId"]
        };
        PostChecklistSubmitHeaderModel postChecklistSubmitHeaderModel =
            await _checklistRepository.submitHeader(postEditHeaderMap);
        emit(HeaderSubmitted(
            postChecklistSubmitHeaderModel: postChecklistSubmitHeaderModel));
      }
    } catch (e) {
      emit(SubmitHeaderError(message: e.toString()));
    }
  }
}
