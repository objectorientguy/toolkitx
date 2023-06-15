import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/blocs/checklist/systemUser/submitHeader/header_events.dart';
import 'package:toolkit/blocs/checklist/systemUser/submitHeader/header_states.dart';
import '../../../../data/cache/cache_keys.dart';
import '../../../../data/cache/customer_cache.dart';
import '../../../../data/models/checklist/systemUser/sys_user_edit_header_details_model.dart';
import '../../../../data/models/checklist/systemUser/sys_user_submit_header_model.dart';
import '../../../../di/app_module.dart';
import '../../../../repositories/checklist/systemUser/sys_user_checklist_repository.dart';

class HeaderBloc extends Bloc<HeaderEvent, HeaderStates> {
  final SysUserCheckListRepository _sysUserCheckListRepository =
      getIt<SysUserCheckListRepository>();
  final CustomerCache _customerCache = getIt<CustomerCache>();

  HeaderStates get initialState => HeaderInitial();

  HeaderBloc() : super(HeaderInitial()) {
    on<FetchEditHeader>(_fetchEditHeader);
    on<SubmitHeader>(_submitHeader);
  }

  FutureOr<void> _fetchEditHeader(
      FetchEditHeader event, Emitter<HeaderStates> emit) async {
    emit(FetchingEditHeader(scheduleId: event.scheduleId));
    try {
      String hashCode = (await _customerCache.getHashCode(CacheKeys.hashcode))!;
      CheckListEditHeaderDetailsModel checkListEditHeaderDetailsModel =
          await _sysUserCheckListRepository.fetchEditHeader(
              event.scheduleId, hashCode);
      emit(EditHeaderFetched(
          getCheckListEditHeaderModel: checkListEditHeaderDetailsModel));
    } catch (e) {
      emit(EditHeaderError());
    }
  }

  FutureOr<void> _submitHeader(
      SubmitHeader event, Emitter<HeaderStates> emit) async {
    emit(SubmittingHeader());
    try {
      String hashCode = (await _customerCache.getHashCode(CacheKeys.hashcode))!;
      if (event.submitHeaderList[0]["value"].toString() == "null" &&
          event.submitHeaderList[0]["value"].toString().trim().isEmpty &&
          event.submitHeaderList[0]["ismandatory"] == 1) {
        emit(HeaderNotSubmitted(
            message: 'Please answer the mandatory question!'));
      } else {
        Map postEditHeaderMap = {
          "hashcode": hashCode,
          "answers": event.submitHeaderList,
          "scheduleid": event.scheduleId
        };
        ChecklistSubmitHeaderModel checklistSubmitHeaderModel =
            await _sysUserCheckListRepository.submitHeader(postEditHeaderMap);
        emit(HeaderSubmitted(
            checklistSubmitHeaderModel: checklistSubmitHeaderModel,
            headerMessage: 'The data has been saved successfully!'));
      }
    } catch (e) {
      emit(HeaderNotSubmitted(message: e.toString()));
    }
  }
}
