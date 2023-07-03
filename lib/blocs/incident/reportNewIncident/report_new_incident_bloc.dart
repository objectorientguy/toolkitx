import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/blocs/incident/reportNewIncident/report_new_incident_events.dart';
import 'package:toolkit/blocs/incident/reportNewIncident/report_new_incident_states.dart';
import '../../../../../data/cache/customer_cache.dart';
import '../../../../di/app_module.dart';
import '../../../data/cache/cache_keys.dart';
import '../../../data/models/incident/fetch_incident_master_model.dart';
import '../../../repositories/incident/incident_repository.dart';

class ReportNewIncidentBloc
    extends Bloc<ReportNewIncidentEvent, ReportNewIncidentStates> {
  final IncidentRepository _incidentRepository = getIt<IncidentRepository>();
  final CustomerCache _customerCache = getIt<CustomerCache>();

  ReportNewIncidentStates get initialState => ReportNewIncidentInitial();

  ReportNewIncidentBloc() : super(ReportNewIncidentInitial()) {
    on<FetchIncidentCategory>(_fetchIncidentCategory);
  }

  FutureOr<void> _fetchIncidentCategory(FetchIncidentCategory event,
      Emitter<ReportNewIncidentStates> emit) async {
    emit(FetchingIncidentCategory());
    // try {
    String hashCode = (await _customerCache.getHashCode(CacheKeys.hashcode))!;
    FetchIncidentMasterModel fetchIncidentMasterModel =
        await _incidentRepository.fetchIncidentMaster(hashCode, event.role);
    emit(IncidentCategoryFetched(
        fetchIncidentMasterModel: fetchIncidentMasterModel));
    // } catch (e) {
    //   emit(IncidentCategoryNotFetched());
    // }
  }
}
