import 'dart:async';
import 'dart:developer';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../data/cache/cache_keys.dart';
import '../../../../data/cache/customer_cache.dart';
import '../../../../di/app_module.dart';
import '../../../data/models/incident/incident_details_model.dart';
import '../../../utils/database_utils.dart';
import '../../../repositories/incident/incident_repository.dart';
import 'incident_details_event.dart';
import 'incident_details_states.dart';

class IncidentDetailsBloc
    extends Bloc<IncidentDetailsEvent, IncidentDetailsStates> {
  final IncidentRepository _incidentRepository = getIt<IncidentRepository>();
  final CustomerCache _customerCache = getIt<CustomerCache>();
  int incidentTabIndex = 0;
  bool addInjuredPerson = false;

  IncidentDetailsStates get initialState => IncidentDetailsInitial();

  IncidentDetailsBloc() : super(IncidentDetailsInitial()) {
    on<FetchIncidentDetailsEvent>(_fetchDetails);
    on<IncidentDetailsFetchPopUpMenuItems>(_fetchPopUpMenuItems);
  }

  FutureOr<void> _fetchDetails(FetchIncidentDetailsEvent event,
      Emitter<IncidentDetailsStates> emit) async {
    emit(FetchingIncidentDetails());
    try {
      List customFieldList = [];
      List injuredPersonList = [];
      String? hashCode = await _customerCache.getHashCode(CacheKeys.hashcode);
      String? userId = await _customerCache.getUserId(CacheKeys.userId);
      String? hashKey = await _customerCache.getClientId(CacheKeys.clientId);
      incidentTabIndex = event.initialIndex;
      IncidentDetailsModel incidentDetailsModel =
          await _incidentRepository.fetchIncidentDetails(
              event.incidentId, hashCode!, userId!, event.role);
      if (incidentDetailsModel.status == 200) {
        for (int i = 0;
            i < incidentDetailsModel.data!.customfields!.length;
            i++) {
          customFieldList.add({
            "id": incidentDetailsModel.data!.customfields![i].fieldid,
            "value": incidentDetailsModel.data!.customfields![i].fieldvalue
          });
        }
        for (int j = 0;
            j < incidentDetailsModel.data!.injuredpersonlist!.length;
            j++) {
          injuredPersonList.add({
            "name": incidentDetailsModel.data!.injuredpersonlist![j].name,
            "company": "",
            "injury": "",
            "bodypart": ""
          });
        }
        Map editIncidentDetailsMap = {
          "eventdatetime": incidentDetailsModel.data!.eventdatetime,
          "description": incidentDetailsModel.data!.description,
          "responsible_person": incidentDetailsModel.data!.responsiblePerson,
          "site_name": incidentDetailsModel.data!.sitename,
          "location_name": incidentDetailsModel.data!.locationname,
          "reporteddatetime": incidentDetailsModel.data!.reporteddatetime,
          "category": incidentDetailsModel.data!.category,
          "createduserby": incidentDetailsModel.data!.createduserby,
          "createdworkforceby": incidentDetailsModel.data!.createdworkforceby,
          "hashcode": hashCode,
          "role": event.role,
          "identity": '',
          "companyid": incidentDetailsModel.data!.companyid,
          "persons": injuredPersonList,
          "customfields": customFieldList
        };
        log("edit map bloc======>$editIncidentDetailsMap");
        emit(IncidentDetailsFetched(
            incidentDetailsModel: incidentDetailsModel,
            clientId: hashKey!,
            editIncidentDetailsMap: editIncidentDetailsMap));
      }
    } catch (e) {
      emit(IncidentDetailsNotFetched());
    }
  }

  _fetchPopUpMenuItems(IncidentDetailsFetchPopUpMenuItems event,
      Emitter<IncidentDetailsStates> emit) {
    List popUpMenuItems = [
      DatabaseUtil.getText('AddComments'),
      DatabaseUtil.getText('EditIncident'),
      DatabaseUtil.getText('Report'),
      DatabaseUtil.getText('Markasresolved'),
      DatabaseUtil.getText('GenerateReport')
    ];
    emit(IncidentDetailsPopUpMenuItemsFetched(popUpMenuItems: popUpMenuItems));
  }
}
