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
  Map reportNewIncidentMap = {};
  String selectSiteName = '';

  ReportNewIncidentStates get initialState => ReportNewIncidentInitial();

  ReportNewIncidentBloc() : super(ReportNewIncidentInitial()) {
    on<FetchIncidentMaster>(_fetchIncidentCategory);
    on<SelectIncidentCategory>(_selectIncidentCategory);
    on<ReportNewIncidentAnonymousExpansionChange>(_reportIncidentAnonymously);
    on<ReportNewIncidentContractorListChange>(_reportIncidentContractor);
    on<ReportIncidentSiteListChange>(_reportIncidentSite);
    on<ReportNewIncidentLocationChange>(_reportIncidentLocation);
    on<ReportNewIncidentAuthorityExpansionChange>(_reportIncidentAuthority);
    on<ReportNewIncidentDateTimeDescriptionValidation>(_dateTimeDescValidation);
    on<ReportNewIncidentSiteLocationValidation>(_siteLocationValidation);
    on<ReportNewIncidentCustomInfoFieldFetch>(_reportIncidentCustomInfoFetch);
    on<ReportNewIncidentCustomInfoFiledExpansionChange>(
        _reportIncidentCustomInfo);
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
    reportNewIncidentMap = event.addNewIncidentMap;
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
        addNewIncidentMap: reportNewIncidentMap));
  }

  _reportIncidentAnonymously(ReportNewIncidentAnonymousExpansionChange event,
      Emitter<ReportNewIncidentStates> emit) {
    Map reportAnonymousMap = {
      "1": DatabaseUtil.getText('Yes'),
      "2": DatabaseUtil.getText('No'),
    };
    emit(ReportNewIncidentAnonymousSelected(
        reportAnonymousId: event.reportIncidentAnonymousId,
        reportAnonymousMap: reportAnonymousMap));
  }

  _reportIncidentContractor(ReportNewIncidentContractorListChange event,
      Emitter<ReportNewIncidentStates> emit) {
    emit(ReportNewIncidentContractorSelected(
        fetchIncidentMasterModel: fetchIncidentMasterModel,
        selectContractorId: event.selectContractorId,
        selectContractorName: event.selectContractorName));
  }

  _reportIncidentSite(ReportIncidentSiteListChange event,
      Emitter<ReportNewIncidentStates> emit) {
    selectSiteName = event.selectSiteName;
    emit(ReportNewIncidentSiteSelected(
        fetchIncidentMasterModel: fetchIncidentMasterModel,
        selectSiteName: event.selectSiteName));
  }

  _reportIncidentLocation(ReportNewIncidentLocationChange event,
      Emitter<ReportNewIncidentStates> emit) {
    emit(ReportNewIncidentLocationSelected(
        fetchIncidentMasterModel: fetchIncidentMasterModel,
        selectLocationName: event.selectLocationName));
  }

  _reportIncidentAuthority(ReportNewIncidentAuthorityExpansionChange event,
      Emitter<ReportNewIncidentStates> emit) {
    Map reportAuthorityMap = {
      "1": DatabaseUtil.getText('Yes'),
      "2": DatabaseUtil.getText('No'),
    };
    emit(ReportNewIncidentAuthoritySelected(
        reportIncidentAuthorityId: event.reportIncidentAuthorityId,
        reportIncidentAuthorityMap: reportAuthorityMap));
  }

  _dateTimeDescValidation(ReportNewIncidentDateTimeDescriptionValidation event,
      Emitter<ReportNewIncidentStates> emit) {
    reportNewIncidentMap = event.reportNewIncidentMap;
    if (reportNewIncidentMap['eventdatetime'] == null &&
        reportNewIncidentMap['description'] == null) {
      emit(ReportNewIncidentDateTimeDescValidated(
          dateTimeDescValidationMessage:
              DatabaseUtil.getText('DateTimeNoEmpty')));
    } else {
      emit(ReportNewIncidentDateTimeDescValidationComplete());
    }
  }

  _siteLocationValidation(ReportNewIncidentSiteLocationValidation event,
      Emitter<ReportNewIncidentStates> emit) {
    reportNewIncidentMap = event.reportNewIncidentMap;
    if (reportNewIncidentMap['site_name'] == '' &&
        reportNewIncidentMap['location_name'] == '') {
      emit(ReportNewIncidentSiteLocationValidated(
          siteLocationValidationMessage:
              DatabaseUtil.getText('SiteLocationCompulsory')));
    } else {
      emit(ReportNewIncidentSiteLocationValidationComplete());
    }
  }

  _reportIncidentCustomInfoFetch(ReportNewIncidentCustomInfoFieldFetch event,
      Emitter<ReportNewIncidentStates> emit) {
    emit(ReportNewIncidentCustomFieldFetched(
        fetchIncidentMasterModel: fetchIncidentMasterModel));
  }

  _reportIncidentCustomInfo(
      ReportNewIncidentCustomInfoFiledExpansionChange event,
      Emitter<ReportNewIncidentStates> emit) {
    emit(ReportNewIncidentCustomFieldSelected(
        fetchIncidentMasterModel: fetchIncidentMasterModel,
        reportIncidentCustomInfoOptionId:
            event.reportIncidentCustomInfoOptionId));
  }
}
