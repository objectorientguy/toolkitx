import 'package:flutter/material.dart';
import 'package:toolkit/configs/app_theme.dart';
import 'package:toolkit/widgets/generic_app_bar.dart';

import '../../configs/app_color.dart';
import '../../configs/app_dimensions.dart';
import '../../configs/app_spacing.dart';
import '../../data/models/status_tag_model.dart';
import '../../utils/incident_util.dart';
import '../../widgets/custom_tabbar_view.dart';
import '../../widgets/status_tag.dart';

class ToDoDetailsScreen extends StatelessWidget {
  static const routeName = 'ToDoDetailsScreen';

  const ToDoDetailsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const GenericAppBar(),
      body: Padding(
          padding: const EdgeInsets.only(
              left: leftRightMargin,
              right: leftRightMargin,
              top: xxTinierSpacing),
          child: Column(children: [
            Card(
                color: AppColor.white,
                elevation: kCardElevation,
                child: ListTile(
                    title: Padding(
                        padding: const EdgeInsets.only(top: xxTinierSpacing),
                        child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("incidentListDatum.refno",
                                  style: Theme.of(context).textTheme.medium),
                              StatusTag(tags: [
                                StatusTagModel(
                                    title:
                                        "incidentDetailsModel.data!.statusText",
                                    bgColor: AppColor.deepBlue)
                              ])
                            ])))),
            const SizedBox(height: xxTinierSpacing),
            const Divider(height: kDividerHeight, thickness: kDividerWidth),
            CustomTabBarView(
                lengthOfTabs: 2,
                tabBarViewIcons: IncidentUtil().tabBarViewIcons,
                initialIndex: 0,
                tabBarViewWidgets: const [])
          ])),
    );
  }
}
