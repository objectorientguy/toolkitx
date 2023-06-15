import 'package:equatable/equatable.dart';

import '../../../../data/models/checklist/systemUser/sys_user_approve_model.dart';

abstract class ApproveStates extends Equatable {
  @override
  List<Object?> get props => throw UnimplementedError();
}

class ApproveCheckListInitial extends ApproveStates {}

class ApprovingCheckList extends ApproveStates {}

class CheckListApproved extends ApproveStates {
  final ChecklistApproveModel checklistApproveModel;

  CheckListApproved({required this.checklistApproveModel});

  @override
  List<Object?> get props => [checklistApproveModel];
}

class CheckListNotApproved extends ApproveStates {
  final String errorMessage;

  CheckListNotApproved({required this.errorMessage});

  @override
  List<Object?> get props => [errorMessage];
}
