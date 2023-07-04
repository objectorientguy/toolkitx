import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/repositories/incident/incident_repository.dart';
import '../../../../data/cache/cache_keys.dart';
import '../../../../data/cache/customer_cache.dart';
import '../../../../di/app_module.dart';
import '../../../data/models/incident/incident_details_model.dart';
import 'incident_details_event.dart';
import 'incident_details_states.dart';

class IncidentDetailsBloc
    extends Bloc<FetchIncidentDetailsEvent, IncidentDetailsStates> {
  final IncidentRepository _incidentRepository = getIt<IncidentRepository>();
  final CustomerCache _customerCache = getIt<CustomerCache>();
  int incidentTabIndex = 0;

  IncidentDetailsStates get initialState => IncidentDetailsInitial();

  IncidentDetailsBloc() : super(IncidentDetailsInitial()) {
    on<FetchIncidentDetailsEvent>(_fetchDetails);
  }

  FutureOr<void> _fetchDetails(FetchIncidentDetailsEvent event,
      Emitter<IncidentDetailsStates> emit) async {
    emit(FetchingIncidentDetails());
    try {
      String? hashCode = await _customerCache.getHashCode(CacheKeys.hashcode);
      String? userId = await _customerCache.getUserId(CacheKeys.userId);
      String? hashKey = await _customerCache.getClientId(CacheKeys.clientId);
      incidentTabIndex = event.initialIndex;
      IncidentDetailsModel incidentDetailsModel =
          await _incidentRepository.fetchIncidentDetails(
              event.incidentId, hashCode!, userId!, event.role);
      emit(IncidentDetailsFetched(
          incidentDetailsModel: incidentDetailsModel, clientId: hashKey!));
    } catch (e) {
      emit(IncidentDetailsNotFetched());
    }
  }
}
