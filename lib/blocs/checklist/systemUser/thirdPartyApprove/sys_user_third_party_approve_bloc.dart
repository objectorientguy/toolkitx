import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/blocs/checklist/systemUser/thirdPartyApprove/sys_user_third_party_approve_events.dart';
import 'package:toolkit/blocs/checklist/systemUser/thirdPartyApprove/sys_user_third_party_approve_states.dart';
import 'package:toolkit/data/models/checklist/systemUser/sys_user_third_party_approval_model.dart';
import '../../../../data/cache/cache_keys.dart';
import '../../../../data/cache/customer_cache.dart';
import '../../../../di/app_module.dart';
import '../../../../repositories/checklist/systemUser/sys_user_checklist_repository.dart';

class ThirdPartyApproveBloc
    extends Bloc<ThirdPartyApproveEvent, ThirdPartyApproveStates> {
  final SysUserCheckListRepository _sysUserCheckListRepository =
      getIt<SysUserCheckListRepository>();
  final CustomerCache _customerCache = getIt<CustomerCache>();

  ThirdPartyApproveStates get initialState => ThirdPartyApproveInitial();

  ThirdPartyApproveBloc() : super(ThirdPartyApproveInitial()) {
    on<ThirdPartyApproveCheckList>(_thirdPartyApproveChecklist);
  }

  FutureOr<void> _thirdPartyApproveChecklist(ThirdPartyApproveCheckList event,
      Emitter<ThirdPartyApproveStates> emit) async {
    emit(ThirdPartyApproving());
    try {
      String hashCode = (await _customerCache.getHashCode(CacheKeys.hashcode))!;
      if (event.thirdPartyApproveMap["name"] == null ||
          event.thirdPartyApproveMap["name"].toString().trim().isEmpty) {
        emit(ThirdPartyNotApproved(errorMessage: 'Please enter name'));
      } else {
        List responseId = [];
        for (int i = 0; i < event.responseIdList.length; i++) {
          responseId.add({"id": event.responseIdList[i]});
        }
        final Map postthirdPartApprovalDataMap = {
          "hashcode": hashCode,
          "responseids": responseId,
          "name": event.thirdPartyApproveMap["name"],
          "sign_text": event.thirdPartyApproveMap["sign_text"]
        };
        SaveThirdPartyApproval saveThirdPartyApproval =
            await _sysUserCheckListRepository
                .checklistThirdPartyApproval(postthirdPartApprovalDataMap);
        emit(
            ThirdPartyApproved(saveThirdPartyApproval: saveThirdPartyApproval));
      }
    } catch (e) {
      emit(ThirdPartyNotApproved(errorMessage: e.toString()));
    }
  }
}
