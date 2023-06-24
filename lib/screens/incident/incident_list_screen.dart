import 'package:flutter/material.dart';
import 'package:toolkit/configs/app_spacing.dart';
import 'package:toolkit/configs/app_theme.dart';
import 'package:toolkit/utils/database_utils.dart';

import '../../configs/app_color.dart';
import '../../widgets/custom_icon_button_row.dart';
import '../../widgets/generic_app_bar.dart';
import '../../widgets/custom_card.dart';
import 'category_screen.dart';
import 'change_role_screen.dart';
import 'filter_screen.dart';

class IncidentListScreen extends StatelessWidget {
  static const routeName = 'IncidentListScreen';

  const IncidentListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: GenericAppBar(title: DatabaseUtil.getText('ReportanIncident')),
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.pushNamed(context, CategoryScreen.routeName);
          },
          child: const Icon(Icons.add)),
      body: Padding(
        padding: const EdgeInsets.only(
            left: leftRightMargin,
            right: leftRightMargin,
            top: xxTinierSpacing),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          CustomIconButtonRow(
              primaryOnPress: () {
                Navigator.pushNamed(context, IncidentFilterScreen.routeName);
              },
              secondaryOnPress: () {
                Navigator.pushNamed(
                    context, IncidentChangeRoleScreen.routeName);
              },
              isEnabled: true,
              clearOnPress: () {}),
          const SizedBox(height: xxTinierSpacing),
          Expanded(
              child: ListView.separated(
                  physics: const BouncingScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: 15,
                  itemBuilder: (context, index) {
                    return CustomCard(
                        child: ListTile(
                            contentPadding:
                                const EdgeInsets.all(xxTinierSpacing),
                            title: Padding(
                                padding: const EdgeInsets.only(
                                    bottom: xxTinierSpacing),
                                child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text('#RI0148',
                                          style: Theme.of(context)
                                              .textTheme
                                              .small
                                              .copyWith(
                                                  color: AppColor.black,
                                                  fontWeight: FontWeight.w600)),
                                      Text('ACKNOWLEDGED',
                                          style: Theme.of(context)
                                              .textTheme
                                              .xxSmall
                                              .copyWith(
                                                  color: AppColor.deepBlue))
                                    ])),
                            subtitle: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('Testing',
                                      style:
                                          Theme.of(context).textTheme.xSmall),
                                  const SizedBox(height: xxTinierSpacing),
                                  Text('11.05.2023 17.190',
                                      style: Theme.of(context)
                                          .textTheme
                                          .xSmall
                                          .copyWith(color: AppColor.grey)),
                                  const SizedBox(height: xxTinierSpacing),
                                  Text('Berlin Office-Belgium - WTG2',
                                      style: Theme.of(context)
                                          .textTheme
                                          .xSmall
                                          .copyWith(color: AppColor.grey))
                                ])));
                  },
                  separatorBuilder: (context, index) {
                    return const SizedBox(height: xxTinySpacing);
                  })),
          const SizedBox(height: xxTinySpacing)
        ]),
      ),
    );
  }
}
