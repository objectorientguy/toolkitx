import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/blocs/checklist/systemUser/approvePopUp/sys_user_approve_pop_up_events.dart';
import 'package:toolkit/blocs/checklist/systemUser/approvePopUp/sys_user_approve_pop_up_states.dart';
import '../../../../data/cache/cache_keys.dart';
import '../../../../data/cache/customer_cache.dart';
import '../../../../data/models/checklist/systemUser/sys_user_approve_model.dart';
import '../../../../di/app_module.dart';
import '../../../../repositories/checklist/systemUser/sys_user_checklist_repository.dart';

class ApproveBloc extends Bloc<ApproveEvent, ApproveStates> {
  final SysUserCheckListRepository _sysUserCheckListRepository =
      getIt<SysUserCheckListRepository>();
  final CustomerCache _customerCache = getIt<CustomerCache>();

  ApproveStates get initialState => ApproveCheckListInitial();

  ApproveBloc() : super(ApproveCheckListInitial()) {
    on<ApproveCheckList>(_checklistApprove);
  }

  FutureOr<void> _checklistApprove(
      ApproveCheckList event, Emitter<ApproveStates> emit) async {
    emit(ApprovingCheckList());
    try {
      String hashCode = (await _customerCache.getHashCode(CacheKeys.hashcode))!;
      if (event.responseIdList.isEmpty || event.responseIdList == []) {
        emit(CheckListNotApproved(
            errorMessage: 'Please select atleast one record to continue!'));
      } else if (event.approveMap["comment"] == null ||
          event.approveMap["comment"].toString().trim().isEmpty) {
        emit(CheckListNotApproved(errorMessage: 'Please add comment!'));
      } else {
        List responseId = [];
        for (int i = 0; i < event.responseIdList.length; i++) {
          responseId.add({"id": event.responseIdList[i]});
        }
        final Map postApproveDataMap = {
          "hashcode": hashCode,
          "responseids": responseId,
          "comments": event.approveMap["comment"]
        };
        ChecklistApproveModel checklistApproveModel =
            await _sysUserCheckListRepository
                .checklistApprove(postApproveDataMap);
        emit(CheckListApproved(checklistApproveModel: checklistApproveModel));
      }
    } catch (e) {
      emit(CheckListNotApproved(errorMessage: e.toString()));
    }
  }
}
