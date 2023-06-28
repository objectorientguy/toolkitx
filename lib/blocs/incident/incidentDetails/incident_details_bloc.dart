import 'dart:async';
import 'dart:convert';
import 'dart:math';
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

  IncidentDetailsStates get initialState => IncidentDetailsInitial();

  IncidentDetailsBloc() : super(IncidentDetailsInitial()) {
    on<FetchIncidentDetailsEvent>(_fetchDetails);
  }

  FutureOr<void> _fetchDetails(FetchIncidentDetailsEvent event,
      Emitter<IncidentDetailsStates> emit) async {
    emit(FetchingIncidentDetails());
    try {
      List files = [];
      String hashCode = (await _customerCache.getHashCode(CacheKeys.hashcode))!;
      String userId = (await _customerCache.getUserId(CacheKeys.userId))!;
      String hashKey = (await _customerCache.getClientId(CacheKeys.clientId))!;
      IncidentDetailsModel incidentDetailsModel = await _incidentRepository
          .fetchIncidentDetails(event.incidentId, hashCode, userId, event.role);
      String fileNames = incidentDetailsModel.data!.files;
      files = jsonDecode(jsonEncode(fileNames.split(',')));
      const chars =
          'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
      Random rnd = Random();
      String getRandomString(int length) =>
          String.fromCharCodes(Iterable.generate(
              length, (_) => chars.codeUnitAt(rnd.nextInt(chars.length))));
      String randomValue = getRandomString(16);
      String filesRandomValue = randomValue + hashKey;
      emit(IncidentDetailsFetched(
          incidentDetailsModel: incidentDetailsModel,
          files: files,
          randomValue: filesRandomValue));
    } catch (e) {
      emit(IncidentDetailsNotFetched());
    }
  }
}
