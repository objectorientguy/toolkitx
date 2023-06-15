import 'package:equatable/equatable.dart';

import '../../../../data/models/checklist/systemUser/sys_user_edit_header_details_model.dart';
import '../../../../data/models/checklist/systemUser/sys_user_submit_header_model.dart';

abstract class HeaderStates extends Equatable {
  @override
  List<Object?> get props => throw UnimplementedError();
}

class HeaderInitial extends HeaderStates {}

class FetchingEditHeader extends HeaderStates {
  final String scheduleId;

  FetchingEditHeader({required this.scheduleId});

  @override
  List<Object?> get props => [scheduleId];
}

class EditHeaderFetched extends HeaderStates {
  final CheckListEditHeaderDetailsModel getCheckListEditHeaderModel;

  EditHeaderFetched({required this.getCheckListEditHeaderModel});

  @override
  List<Object?> get props => [getCheckListEditHeaderModel];
}

class EditHeaderError extends HeaderStates {}

class SubmittingHeader extends HeaderStates {}

class HeaderSubmitted extends HeaderStates {
  final ChecklistSubmitHeaderModel checklistSubmitHeaderModel;
  final String headerMessage;

  HeaderSubmitted(
      {required this.headerMessage, required this.checklistSubmitHeaderModel});

  @override
  List<Object?> get props => [checklistSubmitHeaderModel];
}

class HeaderNotSubmitted extends HeaderStates {
  final String message;

  HeaderNotSubmitted({required this.message});

  @override
  List<Object?> get props => [message];
}
