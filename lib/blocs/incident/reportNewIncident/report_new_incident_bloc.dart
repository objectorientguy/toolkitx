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
  Map addNewIncidentMap = {};

  ReportNewIncidentStates get initialState => ReportNewIncidentInitial();

  ReportNewIncidentBloc() : super(ReportNewIncidentInitial()) {
    on<FetchIncidentCategory>(_fetchIncidentCategory);
    on<SelectIncidentCategory>(_selectIncidentCategory);
  }

  FutureOr<void> _fetchIncidentCategory(FetchIncidentCategory event,
      Emitter<ReportNewIncidentStates> emit) async {
    emit(FetchingIncidentCategory());
    try {
      String hashCode = (await _customerCache.getHashCode(CacheKeys.hashcode))!;
      FetchIncidentMasterModel fetchIncidentMasterModel =
          await _incidentRepository.fetchIncidentMaster(hashCode, event.role);
      add(SelectIncidentCategory(
          fetchIncidentMasterModel: fetchIncidentMasterModel,
          index: 0,
          itemIndex: 0,
          isSelected: false,
          multiSelectList: []));
    } catch (e) {
      emit(IncidentCategoryNotFetched());
    }
  }

  _selectIncidentCategory(
      SelectIncidentCategory event, Emitter<ReportNewIncidentStates> emit) {
    List showCategory = [];
    showCategory = [
      {
        'title': event.fetchIncidentMasterModel.data[2][0].typename,
        'items': [
          for (int i = 0;
              i < event.fetchIncidentMasterModel.data[2].length;
              i++)
            event.fetchIncidentMasterModel.data[2][i].name
        ]
      },
      {
        'title': event.fetchIncidentMasterModel.data[3][0].typename,
        'items': [
          for (int i = 0;
              i < event.fetchIncidentMasterModel.data[3].length;
              i++)
            event.fetchIncidentMasterModel.data[3][i].name
        ]
      },
      {
        'title': event.fetchIncidentMasterModel.data[4][0].typename,
        'items': [
          for (int i = 0;
              i < event.fetchIncidentMasterModel.data[4].length;
              i++)
            event.fetchIncidentMasterModel.data[4][i].name
        ]
      },
      {
        'title': event.fetchIncidentMasterModel.data[5][0].typename,
        'items': [
          for (int i = 0;
              i < event.fetchIncidentMasterModel.data[5].length;
              i++)
            event.fetchIncidentMasterModel.data[5][i].name
        ]
      },
      {
        'title': event.fetchIncidentMasterModel.data[6][0].typename,
        'items': [
          for (int i = 0;
              i < event.fetchIncidentMasterModel.data[6].length;
              i++)
            event.fetchIncidentMasterModel.data[6][i].name
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
    emit(IncidentCategoryFetched(
        fetchIncidentMasterModel: event.fetchIncidentMasterModel,
        categoryList: showCategory,
        categorySelectedList: selectedCategory,
        addNewIncidentMap: addNewIncidentMap));
  }
}
