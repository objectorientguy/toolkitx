import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/blocs/checklist/systemUser/rejectPopUp/sys_user_reject_pop_up_events.dart';
import 'package:toolkit/blocs/checklist/systemUser/rejectPopUp/sys_user_reject_pop_up_states.dart';
import '../../../../data/cache/cache_keys.dart';
import '../../../../data/cache/customer_cache.dart';
import '../../../../data/models/checklist/systemUser/sys_user_reject_model.dart';
import '../../../../di/app_module.dart';
import '../../../../repositories/checklist/systemUser/sys_user_checklist_repository.dart';

class RejectBloc extends Bloc<RejectEvent, RejectStates> {
  final SysUserCheckListRepository _sysUserCheckListRepository =
      getIt<SysUserCheckListRepository>();
  final CustomerCache _customerCache = getIt<CustomerCache>();

  RejectStates get initialState => RejectCheckListInitial();

  RejectBloc() : super(RejectCheckListInitial()) {
    on<RejectCheckList>(_checklistReject);
  }

  FutureOr<void> _checklistReject(
      RejectCheckList event, Emitter<RejectStates> emit) async {
    emit(RejectingCheckList());
    try {
      String hashCode = (await _customerCache.getHashCode(CacheKeys.hashcode))!;
      if (event.responseIdList.isEmpty || event.responseIdList == []) {
        emit(CheckListNotRejected(
            errorMessage: 'Please select atleast one record to continue!'));
      } else if (event.rejectMap["comment"] == null ||
          event.rejectMap["comment"].toString().trim().isEmpty) {
        emit(CheckListNotRejected(errorMessage: 'Please add comment!'));
      } else {
        List responseId = [];
        for (int i = 0; i < event.responseIdList.length; i++) {
          responseId.add({"id": event.responseIdList[i]});
        }
        final Map postRejectDataMap = {
          "hashcode": hashCode,
          "responseids": responseId,
          "comments": event.rejectMap["comment"]
        };
        ChecklistRejectModel checklistRejectModel =
            await _sysUserCheckListRepository
                .checklistReject(postRejectDataMap);
        emit(CheckListRejected(checklistRejectModel: checklistRejectModel));
      }
    } catch (e) {
      emit(CheckListNotRejected(errorMessage: e.toString()));
    }
  }
}
