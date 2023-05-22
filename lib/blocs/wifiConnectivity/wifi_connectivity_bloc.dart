import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/blocs/wifiConnectivity/wifi_connectivity_events.dart';
import 'package:toolkit/blocs/wifiConnectivity/wifi_connectivity_states.dart';

import '../../utils/connectivity_util.dart';

class WifConnectivityBloc
    extends Bloc<WifiConnectivityEvent, WifiConnectivityState> {
  WifConnectivityBloc._() : super(EstablishingNetwork()) {
    on<ObserveNetwork>(_observeNetwork);
    on<NotifyNetworkStatus>(_notifyNetworkStatus);
  }

  static final WifConnectivityBloc _instance = WifConnectivityBloc._();

  factory WifConnectivityBloc() => _instance;

  void _observeNetwork(event, emit) {
    ConnectivityUtil.observeNetwork();
  }

  void _notifyNetworkStatus(NotifyNetworkStatus event, emit) {
    event.isConnected ? emit(EstablishedNetwork()) : emit(NoNetwork());
  }
}
