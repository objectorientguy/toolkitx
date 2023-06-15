import 'package:equatable/equatable.dart';
import 'package:toolkit/data/models/checklist/systemUser/sys_user_reject_model.dart';

abstract class RejectStates extends Equatable {
  @override
  List<Object?> get props => throw UnimplementedError();
}

class RejectCheckListInitial extends RejectStates {}

class RejectingCheckList extends RejectStates {}

class CheckListRejected extends RejectStates {
  final ChecklistRejectModel checklistRejectModel;

  CheckListRejected({required this.checklistRejectModel});

  @override
  List<Object?> get props => [checklistRejectModel];
}

class CheckListNotRejected extends RejectStates {
  final String errorMessage;

  CheckListNotRejected({required this.errorMessage});

  @override
  List<Object?> get props => [errorMessage];
}
