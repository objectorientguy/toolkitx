import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/screens/home/home_screen.dart';
import 'package:toolkit/screens/profile/profile_screen.dart';

import '../../blocs/wifiConnectivity/wifi_connectivity_bloc.dart';
import '../../blocs/wifiConnectivity/wifi_connectivity_states.dart';
import '../../configs/app_color.dart';
import '../../configs/app_spacing.dart';

class RootScreen extends StatefulWidget {
  static const routeName = 'RootScreen';

  const RootScreen({super.key});

  @override
  State<RootScreen> createState() => _RootScreenState();
}

class _RootScreenState extends State<RootScreen> {
  final HomeScreen homeScreen = const HomeScreen();
  final ProfileScreen profileScreen = const ProfileScreen();
  static int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  static final List<Widget> _widgetOptions = <Widget>[
    const HomeScreen(),
    const Text(
      'Index 1: Location',
    ),
    const Text(
      'Index 2: Notification',
    ),
    const Text(
      'Index 3: Chat',
    ),
    const ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar:
          BlocBuilder<WifConnectivityBloc, WifiConnectivityState>(
        builder: (context, state) {
          if (state is NoNetwork) {
            return _bottomNavigationBar(true);
          } else {
            return _bottomNavigationBar(false);
          }
        },
      ),
    );
  }

  BottomNavigationBar _bottomNavigationBar(bool isDisabled) {
    return BottomNavigationBar(
      enableFeedback: true,
      type: BottomNavigationBarType.fixed,
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Padding(
            padding: EdgeInsets.only(top: tiniestSpacing),
            child: Icon(Icons.home),
          ),
          label: '',
        ),
        BottomNavigationBarItem(
          icon: Padding(
            padding: EdgeInsets.only(top: tiniestSpacing),
            child: Icon(Icons.location_on),
          ),
          label: '',
        ),
        BottomNavigationBarItem(
          icon: Padding(
            padding: EdgeInsets.only(top: tiniestSpacing),
            child: Icon(Icons.notifications_sharp),
          ),
          label: '',
        ),
        BottomNavigationBarItem(
          icon: Padding(
            padding: EdgeInsets.only(top: tiniestSpacing),
            child: Icon(Icons.message),
          ),
          label: '',
        ),
        BottomNavigationBarItem(
          icon: Padding(
            padding: EdgeInsets.only(top: tiniestSpacing),
            child: Icon(Icons.person),
          ),
          label: '',
        ),
      ],
      currentIndex: _selectedIndex,
      selectedItemColor: Colors.blue,
      unselectedItemColor: (isDisabled) ? AppColor.lightestGrey : AppColor.grey,
      onTap: (isDisabled) ? null : _onItemTapped,
    );
  }
}
