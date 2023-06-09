import 'package:equatable/equatable.dart';
import '../../../../data/models/checklist/systemUser/system_user_list_model.dart';

abstract class CheckListStates extends Equatable {}

class CheckListInitial extends CheckListStates {
  @override
  List<Object?> get props => throw UnimplementedError();
}

class FetchingCheckList extends CheckListStates {
  @override
  List<Object?> get props => throw UnimplementedError();
}

class CheckListFetched extends CheckListStates {
  final ChecklistListModel getChecklistModel;

  CheckListFetched({required this.getChecklistModel});

  @override
  List<Object?> get props => [getChecklistModel];
}

class CheckListError extends CheckListStates {
  final String errorMessage;

  CheckListError({required this.errorMessage});

  @override
  List<Object?> get props => [errorMessage];
}
