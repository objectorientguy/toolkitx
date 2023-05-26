import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../data/models/systemUser/checklist/details_model.dart';
import '../../../data/models/systemUser/checklist/list_model.dart';
import '../../../data/models/systemUser/checklist/status_model.dart';
import '../../../di/app_module.dart';
import '../../../repositories/systemUser/checklist/repository.dart';
import 'checklist_events.dart';
import 'checklist_states.dart';

class ChecklistBloc extends Bloc<ChecklistEvents, ChecklistStates> {
  final ChecklistRepository _checklistRepository = getIt<ChecklistRepository>();

  ChecklistStates get initialState => ChecklistInitial();

  ChecklistBloc() : super(ChecklistInitial()) {
    on<FetchChecklist>(_fetchChecklist);
    on<FetchChecklistDetails>(_fetchChecklistDetails);
    on<CheckResponse>(_checkResponse);
    on<FetchChecklistStatus>(_fetchChecklistStatus);
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
      FetchChecklistDetails event, Emitter<ChecklistStates> emit) async {
    emit(ChecklistDetailsFetching());
    try {
      GetChecklistDetailsModel getChecklistDetailsModel =
          await _checklistRepository.fetchChecklistDetails(event.checklistId);
      emit(ChecklistDetailsFetched(
          getChecklistDetailsModel: getChecklistDetailsModel));
    } catch (e) {
      emit(ChecklistDetailsError());
    }
  }

  _checkResponse(CheckResponse event, Emitter<ChecklistStates> emit) {
    event.getChecklistDetailsData.responsecount != 0
        ? add(FetchChecklistStatus(scheduleId: event.scheduleId))
        : emit(ResponseChecked());
  }

  FutureOr<void> _fetchChecklistStatus(
      FetchChecklistStatus event, Emitter<ChecklistStates> emit) async {
    emit(ChecklistStatusFetching());
    try {
      GetChecklistStatusModel getChecklistStatusModel =
          await _checklistRepository.fetchChecklistStatus(event.scheduleId);
      emit(ChecklistStatusFetched(
          getChecklistStatusModel: getChecklistStatusModel));
    } catch (e) {
      emit(ChecklistStatusError());
    }
  }
}
