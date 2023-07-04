import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/blocs/incident/reportNewIncident/report_new_incident_events.dart';
import 'package:toolkit/blocs/incident/reportNewIncident/report_new_incident_states.dart';
import 'package:toolkit/utils/database_utils.dart';
import '../../../../../data/cache/customer_cache.dart';
import '../../../../di/app_module.dart';
import '../../../data/cache/cache_keys.dart';
import '../../../data/models/incident/fetch_incident_master_model.dart';
import '../../../repositories/incident/incident_repository.dart';

class ReportNewIncidentBloc
    extends Bloc<ReportNewIncidentEvent, ReportNewIncidentStates> {
  final IncidentRepository _incidentRepository = getIt<IncidentRepository>();
  final CustomerCache _customerCache = getIt<CustomerCache>();
  FetchIncidentMasterModel fetchIncidentMasterModel =
      FetchIncidentMasterModel();
  Map addNewIncidentMap = {};
  String selectSiteName = '';

  ReportNewIncidentStates get initialState => ReportNewIncidentInitial();

  ReportNewIncidentBloc() : super(ReportNewIncidentInitial()) {
    on<FetchIncidentMaster>(_fetchIncidentCategory);
    on<SelectIncidentCategory>(_selectIncidentCategory);
    on<ReportIncidentAnonymousExpansionChange>(_reportIncidentAnonymously);
    on<ReportIncidentContractorListChange>(_reportIncidentContractor);
    on<ReportIncidentSiteListChange>(_reportIncidentSite);
    on<ReportIncidentLocationChange>(_reportIncidentLocation);
    on<ReportIncidentAuthorityExpansionChange>(_reportIncidentAuthority);
    on<ReportIncidentDateTimeDescriptionValidation>(_dateTimeDescValidation);
    on<ReportIncidentSiteLocationValidation>(_siteLocationValidation);
  }

  FutureOr<void> _fetchIncidentCategory(
      FetchIncidentMaster event, Emitter<ReportNewIncidentStates> emit) async {
    emit(FetchingIncidentMaster());
    try {
      String hashCode = (await _customerCache.getHashCode(CacheKeys.hashcode))!;
      fetchIncidentMasterModel =
          await _incidentRepository.fetchIncidentMaster(hashCode, event.role);
      fetchIncidentMasterModel.incidentMasterDatum![0].add(
          IncidentMasterDatum.fromJson(
              {"name": DatabaseUtil.getText('Other')}));
      fetchIncidentMasterModel.incidentMasterDatum![1].add(
          IncidentMasterDatum.fromJson(
              {"location": DatabaseUtil.getText('Other')}));
      add(SelectIncidentCategory(
          index: 0,
          itemIndex: 0,
          isSelected: false,
          multiSelectList: [],
          addNewIncidentMap: {}));
    } catch (e) {
      emit(IncidentMasterNotFetched());
    }
  }

  _selectIncidentCategory(
      SelectIncidentCategory event, Emitter<ReportNewIncidentStates> emit) {
    addNewIncidentMap = event.addNewIncidentMap;
    List showCategory = [];
    showCategory = [
      {
        'title': fetchIncidentMasterModel.incidentMasterDatum![2][0].typename,
        'items': [
          for (int i = 0;
              i < fetchIncidentMasterModel.incidentMasterDatum![2].length;
              i++)
            fetchIncidentMasterModel.incidentMasterDatum![2][i]
        ]
      },
      {
        'title': fetchIncidentMasterModel.incidentMasterDatum![3][0].typename,
        'items': [
          for (int i = 0;
              i < fetchIncidentMasterModel.incidentMasterDatum![3].length;
              i++)
            fetchIncidentMasterModel.incidentMasterDatum![3][i]
        ]
      },
      {
        'title': fetchIncidentMasterModel.incidentMasterDatum![4][0].typename,
        'items': [
          for (int i = 0;
              i < fetchIncidentMasterModel.incidentMasterDatum![4].length;
              i++)
            fetchIncidentMasterModel.incidentMasterDatum![4][i]
        ]
      },
      {
        'title': fetchIncidentMasterModel.incidentMasterDatum![5][0].typename,
        'items': [
          for (int i = 0;
              i < fetchIncidentMasterModel.incidentMasterDatum![5].length;
              i++)
            fetchIncidentMasterModel.incidentMasterDatum![5][i]
        ]
      },
      {
        'title': fetchIncidentMasterModel.incidentMasterDatum![6][0].typename,
        'items': [
          for (int i = 0;
              i < fetchIncidentMasterModel.incidentMasterDatum![6].length;
              i++)
            fetchIncidentMasterModel.incidentMasterDatum![6][i]
        ]
      }
    ];
    List selectedCategory = [];
    if (event.isSelected) {
      selectedCategory
          .add(showCategory[event.index]['items'][event.itemIndex].id);
    } else {
      event.multiSelectList
          .remove(showCategory[event.index]['items'][event.itemIndex].id);
    }
    emit(IncidentMasterFetched(
        fetchIncidentMasterModel: fetchIncidentMasterModel,
        categoryList: showCategory,
        categorySelectedList: selectedCategory,
        addNewIncidentMap: addNewIncidentMap));
  }

  _reportIncidentAnonymously(ReportIncidentAnonymousExpansionChange event,
      Emitter<ReportNewIncidentStates> emit) {
    Map reportAnonymousMap = {
      "1": DatabaseUtil.getText('Yes'),
      "2": DatabaseUtil.getText('No'),
    };
    emit(IncidentReportAnonymousSelected(
        reportAnonymousId: event.reportAnonymousId,
        reportAnonymousMap: reportAnonymousMap));
  }

  _reportIncidentContractor(ReportIncidentContractorListChange event,
      Emitter<ReportNewIncidentStates> emit) {
    emit(ReportIncidentContractorSelected(
        fetchIncidentMasterModel: fetchIncidentMasterModel,
        selectContractorId: event.selectContractorId,
        selectContractorName: event.selectContractorName));
  }

  _reportIncidentSite(ReportIncidentSiteListChange event,
      Emitter<ReportNewIncidentStates> emit) {
    selectSiteName = event.selectSiteName;
    emit(ReportIncidentSiteSelected(
        fetchIncidentMasterModel: fetchIncidentMasterModel,
        selectSiteName: event.selectSiteName));
  }

  _reportIncidentLocation(ReportIncidentLocationChange event,
      Emitter<ReportNewIncidentStates> emit) {
    emit(ReportIncidentLocationSelected(
        fetchIncidentMasterModel: fetchIncidentMasterModel,
        selectLocationName: event.locationName));
  }

  _reportIncidentAuthority(ReportIncidentAuthorityExpansionChange event,
      Emitter<ReportNewIncidentStates> emit) {
    Map reportAuthorityMap = {
      "1": DatabaseUtil.getText('Yes'),
      "2": DatabaseUtil.getText('No'),
    };
    emit(IncidentReportAuthoritySelected(
        reportAuthorityId: event.reportAuthorityId,
        reportAuthorityMap: reportAuthorityMap));
  }

  _dateTimeDescValidation(ReportIncidentDateTimeDescriptionValidation event,
      Emitter<ReportNewIncidentStates> emit) {
    addNewIncidentMap = event.addIncidentMap;
    if (addNewIncidentMap['eventdatetime'] == null &&
        addNewIncidentMap['description'] == null) {
      emit(ReportIncidentDateTimeDescValidated(
          dateTimeDescValidationMessage:
              DatabaseUtil.getText('DateTimeNoEmpty')));
    } else {
      emit(ReportIncidentDateTimeDescValidationComplete());
    }
  }

  _siteLocationValidation(ReportIncidentSiteLocationValidation event,
      Emitter<ReportNewIncidentStates> emit) {
    addNewIncidentMap = event.addIncidentMap;
    if (addNewIncidentMap['site_name'] == '' ||
        addNewIncidentMap['location_name'] == '') {
      emit(ReportIncidentSiteLocationValidated(
          siteLocationValidationMessage:
              DatabaseUtil.getText('SiteLocationCompulsory')));
    } else {
      emit(ReportIncidentSiteLocationValidationComplete());
    }
  }
}
