import 'dart:async';
import 'dart:developer';
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
  Map addNewIncidentMap = {};

  ReportNewIncidentStates get initialState => ReportNewIncidentInitial();

  ReportNewIncidentBloc() : super(ReportNewIncidentInitial()) {
    on<FetchIncidentMaster>(_fetchIncidentCategory);
    on<SelectIncidentCategory>(_selectIncidentCategory);
    on<ReportIncidentExpansionChange>(_reportIncidentAnonymously);
  }

  FutureOr<void> _fetchIncidentCategory(
      FetchIncidentMaster event, Emitter<ReportNewIncidentStates> emit) async {
    emit(FetchingIncidentMaster());
    try {
      String hashCode = (await _customerCache.getHashCode(CacheKeys.hashcode))!;
      FetchIncidentMasterModel fetchIncidentMasterModel =
          await _incidentRepository.fetchIncidentMaster(hashCode, event.role);
      add(SelectIncidentCategory(
          fetchIncidentMasterModel: fetchIncidentMasterModel,
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
        'title':
            event.fetchIncidentMasterModel.incidentMasterDatum[2][0].typename,
        'items': [
          for (int i = 0;
              i < event.fetchIncidentMasterModel.incidentMasterDatum[2].length;
              i++)
            event.fetchIncidentMasterModel.incidentMasterDatum[2][i].name
        ]
      },
      {
        'title':
            event.fetchIncidentMasterModel.incidentMasterDatum[3][0].typename,
        'items': [
          for (int i = 0;
              i < event.fetchIncidentMasterModel.incidentMasterDatum[3].length;
              i++)
            event.fetchIncidentMasterModel.incidentMasterDatum[3][i].name
        ]
      },
      {
        'title':
            event.fetchIncidentMasterModel.incidentMasterDatum[4][0].typename,
        'items': [
          for (int i = 0;
              i < event.fetchIncidentMasterModel.incidentMasterDatum[4].length;
              i++)
            event.fetchIncidentMasterModel.incidentMasterDatum[4][i].name
        ]
      },
      {
        'title':
            event.fetchIncidentMasterModel.incidentMasterDatum[5][0].typename,
        'items': [
          for (int i = 0;
              i < event.fetchIncidentMasterModel.incidentMasterDatum[5].length;
              i++)
            event.fetchIncidentMasterModel.incidentMasterDatum[5][i].name
        ]
      },
      {
        'title':
            event.fetchIncidentMasterModel.incidentMasterDatum[6][0].typename,
        'items': [
          for (int i = 0;
              i < event.fetchIncidentMasterModel.incidentMasterDatum[6].length;
              i++)
            event.fetchIncidentMasterModel.incidentMasterDatum[6][i].name
        ]
      }
    ];
    List selectedCategory = [];
    if (event.isSelected) {
      selectedCategory.add(showCategory[event.index]['items'][event.itemIndex]);
    } else {
      event.multiSelectList
          .remove(showCategory[event.index]['items'][event.itemIndex]);
    }
    emit(IncidentMasterFetched(
        fetchIncidentMasterModel: event.fetchIncidentMasterModel,
        categoryList: showCategory,
        categorySelectedList: selectedCategory,
        addNewIncidentMap: addNewIncidentMap));
  }

  _reportIncidentAnonymously(ReportIncidentExpansionChange event,
      Emitter<ReportNewIncidentStates> emit) {
    log("bloc=====>${event.selectContractorId}");
    List reportAnonymousList = [
      DatabaseUtil.getText('Yes'),
      DatabaseUtil.getText('No'),
    ];
    emit(ReportNewIncidentFetched(
        reportAnonymousList: reportAnonymousList,
        reportAnonymous: event.reportAnonymously,
        addNewIncidentMap: addNewIncidentMap,
        selectContractorId: event.selectContractorId,
        selectContractorName: event.selectContractorName));
  }
}
