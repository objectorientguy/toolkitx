import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/screens/home/widgets/offline_modules.dart';

import '../../../blocs/wifiConnectivity/wifi_connectivity_bloc.dart';
import '../../../blocs/wifiConnectivity/wifi_connectivity_states.dart';
import 'online_modules.dart';

class ModulesGridLayout extends StatelessWidget {
  final List availableModules;

  const ModulesGridLayout({Key? key, required this.availableModules})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MediaQuery.removePadding(
      context: context,
      removeTop: true,
      child: BlocBuilder<WifiConnectivityBloc, WifiConnectivityState>(
          builder: (context, state) {
        if (state is NoNetwork) {
          return const OffLineModules();
        } else {
          return OnLineModules(availableModules: availableModules);
        }
      }),
    );
  }
}
