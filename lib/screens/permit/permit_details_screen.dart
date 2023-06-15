import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/configs/app_color.dart';
import 'package:toolkit/configs/app_dimensions.dart';
import 'package:toolkit/utils/permit_util.dart';
import 'package:toolkit/widgets/custom_tabbar_view.dart';
import 'package:toolkit/widgets/generic_app_bar.dart';
import 'package:toolkit/screens/permit/widgets/permit_additional_info.dart';
import 'package:toolkit/screens/permit/widgets/permit_details.dart';
import 'package:toolkit/screens/permit/widgets/permit_group.dart';
import 'package:toolkit/screens/permit/widgets/permit_attachments.dart';
import 'package:toolkit/screens/permit/widgets/permit_timeline.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../../blocs/permit/permit_bloc.dart';
import '../../blocs/permit/permit_events.dart';
import '../../blocs/permit/permit_states.dart';
import '../../configs/app_spacing.dart';
import '../../data/models/status_tag_model.dart';
import 'widgets/ptw_action_menu.dart';
import '../../widgets/status_tag.dart';

class PermitDetailsScreen extends StatelessWidget {
  static const routeName = 'PermitDetailsScreen';

  const PermitDetailsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    context.read<PermitBloc>().add(const GetPermitDetails());
    return Scaffold(
      appBar: const GenericAppBar(
        actions: [PTWActionMenu()],
      ),
      body: BlocConsumer<PermitBloc, PermitStates>(listener: (context, state) {
        if (state is PDFGenerated) {
          context.read<PermitBloc>().add(const GetPermitDetails());
          launchUrlString(
              'https://www.toolkitx.com/location360.aspx?q=Belgium+-+WTG2+%2f+EW',
              mode: LaunchMode.inAppWebView);
        } else if (state is PDFGenerationFailed) {
          context.read<PermitBloc>().add(const GetPermitDetails());
        }
      }, builder: (context, state) {
        if (state is FetchingPermitDetails || state is GeneratingPDF) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is PermitDetailsFetched) {
          return Padding(
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
                          Text(state.permitDetailsModel.data.tab1.permit),
                          StatusTag(tags: [
                            StatusTagModel(
                                title:
                                    state.permitDetailsModel.data.tab1.status,
                                bgColor: AppColor.deepBlue),
                          ]),
                        ],
                      ),
                    ),
                    subtitle: StatusTag(tags: [
                      StatusTagModel(
                          title: (state.permitDetailsModel.data.tab1.expired ==
                                  '2')
                              ? 'Expired'
                              : '',
                          bgColor: AppColor.errorRed),
                    ]),
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
                  tabBarViewWidgets: [
                    PermitDetails(permitDetailsModel: state.permitDetailsModel),
                    PermitAdditionalInfo(
                        permitDetailsModel: state.permitDetailsModel),
                    PermitGroup(permitDetailsModel: state.permitDetailsModel),
                    CustomTimeline(
                        permitDetailsModel: state.permitDetailsModel),
                    PermitAttachments(
                        permitDetailsModel: state.permitDetailsModel),
                    const SizedBox(),
                  ],
                )
              ],
            ),
          );
        } else {
          return const SizedBox();
        }
      }),
    );
  }
}
