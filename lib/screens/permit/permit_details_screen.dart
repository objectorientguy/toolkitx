import 'package:flutter/material.dart';
import 'package:toolkit/configs/app_color.dart';
import 'package:toolkit/configs/app_dimensions.dart';
import 'package:toolkit/screens/permit/widgets/tags.dart';
import 'package:toolkit/utils/permit_util.dart';
import 'package:toolkit/widgets/custom_tabbar_view.dart';
import 'package:toolkit/widgets/generic_app_bar.dart';
import 'package:toolkit/screens/permit/widgets/permit_additional_info.dart';
import 'package:toolkit/screens/permit/widgets/permit_details.dart';
import 'package:toolkit/screens/permit/widgets/permit_group.dart';
import 'package:toolkit/screens/permit/widgets/permit_attachments.dart';
import 'package:toolkit/screens/permit/widgets/permit_timeline.dart';

import '../../configs/app_spacing.dart';

class PermitDetailsScreen extends StatelessWidget {
  static const routeName = 'PermitDetailsScreen';

  const PermitDetailsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: GenericAppBar(
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.more_vert))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.only(
            left: leftRightMargin,
            right: leftRightMargin,
            top: xxTinierSpacing),
        child: Column(
          children: [
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
                      const Text('WP - 00197 (!)'),
                      Container(
                        width: MediaQuery.of(context).size.width * 0.25,
                        height: MediaQuery.of(context).size.width * 0.050,
                        decoration: BoxDecoration(
                          color: AppColor.deepBlue,
                          borderRadius: BorderRadius.circular(kCardRadius),
                        ),
                        alignment: Alignment.center,
                        child: const Text(
                          'REQUESTED',
                          style: TextStyle(color: AppColor.white),
                          textAlign: TextAlign.center,
                        ),
                      )
                    ],
                  ),
                ),
                subtitle: const Padding(
                  padding: EdgeInsets.only(top: xxTinierSpacing),
                  child: Tags(),
                ),
              ),
            ),
            const SizedBox(height: xxTinierSpacing),
            const Divider(
              height: kDividerHeight,
              thickness: kDividerWidth,
            ),
            const SizedBox(height: xxTinierSpacing),
            CustomTabBarView(
              lengthOfTabs: 6,
              tabBarViewIcons: PermitUtil().tabBarViewIcons,
              tabBarViewWidgets: const [
                PermitDetails(),
                PermitAdditionalInfo(),
                PermitGroup(),
                CustomTimeline(),
                PermitAttachments(),
                SizedBox(),
              ],
            )
          ],
        ),
      ),
    );
  }
}
