import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/blocs/client/client_events.dart';
import 'package:toolkit/blocs/client/client_states.dart';
import 'package:toolkit/data/cache/cache_keys.dart';
import 'package:toolkit/data/models/client/client_list_model.dart';
import 'package:toolkit/data/models/client/home_screen_model.dart';
import 'package:toolkit/repositories/client/client_repository.dart';

import '../../data/cache/customer_cache.dart';
import '../../di/app_module.dart';
import '../../utils/modules_util.dart';

class ClientBloc extends Bloc<ClientEvents, ClientStates> {
  final ClientRepository _clientRepository = getIt<ClientRepository>();
  final CustomerCache _customerCache = getIt<CustomerCache>();

  ClientStates get initialState => ClientInitial();

  ClientBloc() : super(ClientInitial()) {
    on<FetchClientList>(_fetchClientList);
    on<FetchHomeScreenData>(_fetchHomeScreenData);
  }

  FutureOr<void> _fetchClientList(
      FetchClientList event, Emitter<ClientStates> emit) async {
    emit(ClientListFetching());
    try {
      String clientDataKey =
          (await _customerCache.getClientDataKey(CacheKeys.clientDataKey))!;
      String userType = (await _customerCache.getUserType(CacheKeys.userType))!;
      ClientListModel clientListModel =
          await _clientRepository.fetchClientList(clientDataKey, userType);
      if (clientListModel.data!.length == 1) {
        add(FetchHomeScreenData(
            hashKey: clientListModel.data![0].hashkey.toString(),
            apiKey: clientListModel.data![0].apikey,
            image: clientListModel.data![0].hashimg));
      }
      emit(ClientListFetched(clientListModel: clientListModel));
    } catch (e) {
      emit(FetchClientListError());
    }
  }

  FutureOr<void> _fetchHomeScreenData(
      FetchHomeScreenData event, Emitter<ClientStates> emit) async {
    emit(HomeScreenFetching());
    try {
      List permissionsList = [];
      String timeZoneCode =
          (await _customerCache.getTimeZoneCode(CacheKeys.timeZoneCode))!;
      String userType = (await _customerCache.getUserType(CacheKeys.userType))!;
      String dateTimeValue = (await _customerCache
          .getCustomerDateFormat(CacheKeys.dateFormatKey))!;
      String hashCode =
          '${event.apiKey}|${event.hashKey}|$userType|$dateTimeValue|$timeZoneCode';
      _customerCache.setApiKey(CacheKeys.apiKey, event.apiKey);
      _customerCache.setClientId(CacheKeys.clientId, event.hashKey);
      _customerCache.setHashCode(CacheKeys.hashcode, hashCode);
      _customerCache.setClientImage(CacheKeys.clientImage, event.image);
      Map fetchHomeScreenMap = {
        "hashkey": event.hashKey,
        "apikey": event.apiKey,
        "type": userType,
        "timezonecode": timeZoneCode
      };
      HomeScreenModel homeScreenModel =
          await _clientRepository.fetchHomeScreen(fetchHomeScreenMap);
      if (homeScreenModel.status == 200) {
        _customerCache.setUserId(
            CacheKeys.userId, homeScreenModel.data!.userid);
        _customerCache.setUserId2(
            CacheKeys.userId2, homeScreenModel.data!.userid2);
        permissionsList =
            homeScreenModel.data!.permission.replaceAll(' ', '').split(',');
        List availableModules = [];
        for (int i = 0; i < permissionsList.length; i++) {
          if (permissionsList.contains(ModulesUtil.listModulesMode[i].key) ==
              true) {
            availableModules.add(ModulesUtil.listModulesMode[i]);
          }
        }
        emit(HomeScreenFetched(
            processClientModel: homeScreenModel,
            image: event.image,
            availableModules: availableModules));
      } else {
        emit(FetchHomeScreenError());
      }
    } catch (e) {
      emit(FetchHomeScreenError());
    }
  }
}
