import 'package:flutter/material.dart';
import '../configs/app_dimensions.dart';
import '../configs/app_spacing.dart';

class CustomTabBarView extends StatelessWidget {
  final List<Tab> tabBarViewIcons;
  final List<Widget> tabBarViewWidgets;
  final int lengthOfTabs;

  const CustomTabBarView(
      {super.key,
      required this.tabBarViewIcons,
      required this.tabBarViewWidgets,
      required this.lengthOfTabs});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: DefaultTabController(
        length: lengthOfTabs, // Set the number of tabs
        child: Column(
          children: [
            TabBar(
                isScrollable: false,
                indicatorWeight: kDividerThickness,
                tabs: tabBarViewIcons),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(xxTinierSpacing),
                child: TabBarView(children: tabBarViewWidgets),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
