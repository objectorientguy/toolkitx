import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../data/cache/cache_keys.dart';
import '../../../../data/cache/customer_cache.dart';
import '../../../../di/app_module.dart';
import '../../../data/models/incident/fetch_permit_to_link_model.dart';
import '../../../data/models/incident/incident_details_model.dart';
import '../../../data/models/incident/saved_linked_permit_model.dart';
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
  List savedList = [];

  IncidentDetailsStates get initialState => IncidentDetailsInitial();

  IncidentDetailsBloc() : super(IncidentDetailsInitial()) {
    on<FetchIncidentDetailsEvent>(_fetchDetails);
    on<IncidentDetailsFetchPopUpMenuItems>(_fetchPopUpMenuItems);
    on<FetchPermitToLinkList>(_fetchPermitToLink);
    on<SaveLikedPermits>(_saveLinkedPermits);
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

  FutureOr<void> _fetchPermitToLink(
      FetchPermitToLinkList event, Emitter<IncidentDetailsStates> emit) async {
    emit(FetchingPermitToLink());
    try {
      String? hashCode = await _customerCache.getHashCode(CacheKeys.hashcode);
      String? filter = "";
      FetchPermitToLinkModel permitToLinkModel = await _incidentRepository
          .fetchPermitToLink(event.pageNo, hashCode!, filter, event.incidentId);
      emit(FetchedPermitToLink(fetchPermitToLinkModel: permitToLinkModel));
    } catch (e) {
      emit(FetchPermitToLinkError());
    }
  }

  FutureOr<void> _saveLinkedPermits(
      SaveLikedPermits event, Emitter<IncidentDetailsStates> emit) async {
    emit(SavingLinkedPermits());
    try {
      String? hashCode = await _customerCache.getHashCode(CacheKeys.hashcode);
      String? userid = await _customerCache.getUserId(CacheKeys.userId);

      Map linkedPermitMap = {
        "userid": userid,
        "incidentid": event.incidentId,
        "hashcode": hashCode,
        "permitid": event.savedPermitList
      };
      SaveLinkedPermitModel savedPermitModel =
          await _incidentRepository.saveLinkedPermit(linkedPermitMap);
      if (savedPermitModel.status == 200) {
        emit(SavedLinkedPermits(saveLinkedPermitModel: savedPermitModel));
      } else {
        emit(LinkedPermitsNotSaved(
            permitNotSavedMessage:
                DatabaseUtil.getText('some_unknown_error_please_try_again')));
      }
    } catch (e) {
      emit(FetchPermitToLinkError());
    }
  }
}
