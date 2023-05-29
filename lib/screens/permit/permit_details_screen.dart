import 'package:flutter/material.dart';
import 'package:toolkit/configs/app_color.dart';
import 'package:toolkit/configs/app_dimensions.dart';
import 'package:toolkit/widgets/custom_tabbar_view.dart';
import 'package:toolkit/widgets/generic_app_bar.dart';
import 'package:toolkit/screens/permit/widgets/permit_additional_info.dart';
import 'package:toolkit/screens/permit/widgets/permit_details.dart';
import 'package:toolkit/screens/permit/widgets/permit_group.dart';
import 'package:toolkit/screens/permit/widgets/permit_attachments.dart';
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
            top: midTiniestSpacing),
        child: Column(
          children: [
            Card(
              color: AppColor.white,
              elevation: 1,
              child: ListTile(
                title: Padding(
                  padding: const EdgeInsets.only(top: midTiniestSpacing),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('WP - 00197 (!)'),
                      Container(
                        width: MediaQuery.of(context).size.width * 0.25,
                        height: MediaQuery.of(context).size.width * 0.050,
                        decoration: BoxDecoration(
                          color: Colors.lightBlue,
                          borderRadius: BorderRadius.circular(5),
                        ),
                        alignment: Alignment.center,
                        child: const Text(
                          'REQUESTED',
                          style: TextStyle(color: Colors.white),
                          textAlign: TextAlign.center,
                        ),
                      )
                    ],
                  ),
                ),
                subtitle: Padding(
                  padding: const EdgeInsets.only(top: midTiniestSpacing),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.redAccent,
                          borderRadius: BorderRadius.circular(5),
                        ),
                        margin: const EdgeInsets.only(right: 5, bottom: 5),
                        alignment: Alignment.center,
                        child: const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text(
                            'Expired',
                            style: TextStyle(color: Colors.white),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.amberAccent,
                          borderRadius: BorderRadius.circular(5),
                        ),
                        alignment: Alignment.center,
                        margin: const EdgeInsets.only(right: 5, bottom: 5),
                        child: const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text(
                            'NPI',
                            style: TextStyle(color: Colors.white),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.amberAccent,
                          borderRadius: BorderRadius.circular(5),
                        ),
                        alignment: Alignment.center,
                        margin: const EdgeInsets.only(right: 5, bottom: 5),
                        child: const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text(
                            'NPW',
                            style: TextStyle(color: Colors.white),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: midTiniestSpacing),
            const Divider(
              height: kDividerHeight,
              thickness: 1,
            ),
            const SizedBox(height: midTiniestSpacing),
            const CustomTabBarView(
              lengthOfTabs: 6,
              tabBarViewIcons: [
                Tab(
                    icon: Icon(
                  Icons.shelves,
                  color: AppColor.grey,
                )),
                Tab(
                    icon: Icon(
                  Icons.info,
                  color: AppColor.grey,
                )),
                Tab(
                    icon: Icon(
                  Icons.group,
                  color: AppColor.grey,
                )),
                Tab(
                    icon: Icon(
                  Icons.timeline,
                  color: AppColor.grey,
                )),
                Tab(
                    icon: Icon(
                  Icons.file_copy_sharp,
                  color: AppColor.grey,
                )),
                Tab(
                    icon: Icon(
                  Icons.chat,
                  color: AppColor.grey,
                )),
              ],
              tabBarViewWidgets: [
                PermitDetails(),
                PermitAdditionalInfo(),
                PermitGroup(),
                SizedBox(),
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
