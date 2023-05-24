import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../data/models/systemUser/checklist/list_model.dart';
import '../../../di/app_module.dart';
import '../../../repositories/systemUser/checklist/repository.dart';
import 'checklist_events.dart';
import 'checklist_states.dart';

class ChecklistBloc extends Bloc<ChecklistEvents, ChecklistStates> {
  final ChecklistRepository _checklistRepository = getIt<ChecklistRepository>();

  ChecklistStates get initialState => ChecklistInitial();

  ChecklistBloc() : super(ChecklistInitial()) {
    on<FetchChecklist>(_fetchChecklist);
  }

  FutureOr<void> _fetchChecklist(
      FetchChecklist event, Emitter<ChecklistStates> emit) async {
    emit(ChecklistFetching());
    try {
      GetChecklistModel getChecklistModel =
          await _checklistRepository.fetchChecklist();
      emit(ChecklistFetched(getChecklistModel: getChecklistModel));
    } catch (e) {
      emit(ChecklistError(errorMessage: e.toString()));
    }
  }
}
