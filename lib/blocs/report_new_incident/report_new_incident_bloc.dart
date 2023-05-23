import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/blocs/report_new_incident/report_new_incident_events.dart';
import 'package:toolkit/blocs/report_new_incident/report_new_incident_states.dart';

class ReportIncidentBloc
    extends Bloc<ReportIncidentEvents, ReportIncidentStates> {
  ReportIncidentStates get initialState => ReportIncidentInitial();

  ReportIncidentBloc() : super(ReportIncidentInitial()) {
    on<LocationScreenExpansionChange>(_locationScreenExpansionChange);
    on<HealthData>(_healthData);
    on<SelectCategory>(_selectCategory);
    on<ReportIncidentScreenExpansionChange>(
        _reportIncidentScreenExpansionChange);
    on<SelectInjuryMultiSelect>(_selectInjuryMultiSelect);
  }

  _locationScreenExpansionChange(LocationScreenExpansionChange event,
      Emitter<ReportIncidentStates> emit) async {
    emit(ReportIncidentLocationScreenLoaded(
        site: event.otherSite,
        location: event.otherLocation,
        reportToAuthorities: event.reportToAuthorities));
  }

  _healthData(HealthData event, Emitter<ReportIncidentStates> emit) {
    emit(ReportIncidentHealthScreenLoaded(healthData: event.healthData));
  }

  _selectCategory(SelectCategory event, Emitter<ReportIncidentStates> emit) {
    List changeData = List.from(event.selectedCategory);
    final List category = [
      {
        'title': 'Assets',
        'items': ['spill/leak', 'Dispose']
      },
      {
        'title': 'Environment',
        'items': [
          'Restricted work',
          'fatality',
          'Adverse weather',
          'Air pollution',
          'Air pollution & emission'
        ]
      },
      {
        'title': 'Other',
        'items': ['Information', 'Process']
      },
      {
        'title': 'People',
        'items': ['Medical treatment']
      },
      {
        'title': 'Reputation',
        'items': ['Assets']
      }
    ]; // List will be removed while integrating API;

    if (event.listIndex != null) {
      if (event.selectedCategory
              .contains(category[event.listIndex!]['items'][event.itemIndex]) !=
          true) {
        changeData.add(category[event.listIndex!]['items'][event.itemIndex]);
      } else {
        changeData.remove(category[event.listIndex!]['items'][event.itemIndex]);
      }
    }
    emit(
        SelectCategoryLoaded(selectedCategory: changeData, category: category));
  }

  _reportIncidentScreenExpansionChange(
      ReportIncidentScreenExpansionChange event,
      Emitter<ReportIncidentStates> emit) {
    emit(ReportIncidentScreenLoaded(
        reportAnonymously: event.reportAnonymously,
        contractor: event.contractor,
        categoryData: event.categoryData));
  }

  _selectInjuryMultiSelect(
      SelectInjuryMultiSelect event, Emitter<ReportIncidentStates> emit) {
    List changeNature = List.from(event.selectedInjuryNature);
    List changeArea = List.from(event.selectedInjuredArea);
    final List injuriesNature = [
      "injuriesNature1",
      "injuriesNature2",
      "injuriesNature3",
      "injuriesNature4",
      "injuriesNature5"
    ]; // List will be removed while integrating API;
    List injuriesList = [
      '01',
      '02',
      '03',
      '04',
      '05',
      '06',
      '07',
      '08',
      '09',
      '10',
      '11',
      '12',
      '13',
      '14',
      '15',
      '16',
      '17',
      '18',
      '19',
      '20',
      '21',
      '22',
      '23',
      '24',
      '25',
      '26',
      '27',
      '28',
      '29',
      '30',
      '31',
      '32',
      '33',
      '34',
      '35',
      '36',
      '37'
    ];
    if (event.natureIndex != null) {
      if (event.selectedInjuryNature
              .contains(injuriesNature[event.natureIndex!]) !=
          true) {
        changeNature.add(injuriesNature[event.natureIndex!]);
      } else {
        changeNature.remove(injuriesNature[event.natureIndex!]);
      }
    } else if (event.areaIndex != null) {
      if (event.selectedInjuredArea.contains(injuriesList[event.areaIndex!]) !=
          true) {
        changeArea.add(injuriesList[event.areaIndex!]);
      } else {
        changeArea.remove(injuriesList[event.areaIndex!]);
      }
    }
    emit(InjuriesScreenMultiselectLoaded(
        selectedInjuryNature: changeNature,
        selectedInjuredArea: changeArea,
        injuryNature: injuriesNature,
        injuredArea: injuriesList));
  }
}
