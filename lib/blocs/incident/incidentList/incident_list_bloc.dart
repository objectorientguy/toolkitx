import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/utils/database_utils.dart';
import '../../../../../data/cache/customer_cache.dart';
import '../../../../di/app_module.dart';
import '../../../data/cache/cache_keys.dart';
import '../../../data/models/incident/fetch_incidents_list_model.dart';
import '../../../repositories/incident/incident_repository.dart';
import 'incident_list_event.dart';
import 'incident_list_state.dart';

class IncidentListBloc
    extends Bloc<FetchIncidentListEvent, IncidentListStates> {
  final IncidentRepository _incidentRepository = getIt<IncidentRepository>();
  final CustomerCache _customerCache = getIt<CustomerCache>();

  IncidentListStates get initialState => FetchIncidentInitial();

  IncidentListBloc() : super(FetchIncidentInitial()) {
    on<FetchIncidentListEvent>(_fetchIncidents);
  }

  FutureOr<void> _fetchIncidents(
      FetchIncidentListEvent event, Emitter<IncidentListStates> emit) async {
    emit(FetchingIncidents());
    try {
      String userId = (await _customerCache.getUserId(CacheKeys.userId))!;
      String hashCode = (await _customerCache.getHashCode(CacheKeys.hashcode))!;
      FetchIncidentsListModel fetchIncidentsListModel =
          await _incidentRepository.fetchIncidents(userId, hashCode);
      emit(IncidentsFetched(fetchIncidentsListModel: fetchIncidentsListModel));
    } catch (e) {
      emit(IncidentsNotFetched(
          noIncidentsMessage: DatabaseUtil.getText('something_went_wrong')));
    }
  }
}
