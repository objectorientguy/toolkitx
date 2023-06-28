import 'package:flutter/material.dart';
import 'package:toolkit/configs/app_theme.dart';
import 'package:toolkit/data/models/incident/incident_details_model.dart';
import 'package:toolkit/screens/incident/widgets/view_incident_details_network_image.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../../../configs/app_color.dart';
import '../../../configs/app_spacing.dart';
import '../../../utils/constants/api_constants.dart';
import '../../../widgets/custom_card.dart';

class PermitDetailsComment extends StatelessWidget {
  final IncidentDetailsModel incidentDetailsModel;
  final List fileNames;
  final String fileRandomValue;

  const PermitDetailsComment(
      {Key? key,
      required this.incidentDetailsModel,
      required this.fileNames,
      required this.fileRandomValue})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      physics: const BouncingScrollPhysics(),
      padding: EdgeInsets.zero,
      shrinkWrap: true,
      itemCount: incidentDetailsModel.data!.commentslist!.length,
      itemBuilder: (context, index) {
        return CustomCard(
          child: ListTile(
            trailing:
                Text(incidentDetailsModel.data!.commentslist![index].created),
            title: Text(
                incidentDetailsModel.data!.commentslist![index].ownername,
                style: Theme.of(context).textTheme.small.copyWith(
                    fontWeight: FontWeight.w700, color: AppColor.mediumBlack)),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(incidentDetailsModel.data!.commentslist![index].comments,
                    style: Theme.of(context).textTheme.xxSmall),
                const SizedBox(height: xxTinierSpacing),
                Visibility(
                  visible:
                      incidentDetailsModel.data!.commentslist![index].files !=
                          null,
                  child: ViewIncidentDetailsNetworkImage(
                    onTap: () {
                      launchUrlString(
                          '${ApiConstants.viewDocBaseUrl}${fileNames[index]}&code=$fileRandomValue',
                          mode: LaunchMode.inAppWebView);
                    },
                    imageUrl:
                        '${ApiConstants.viewDocBaseUrl}${fileNames[index]}&code=$fileRandomValue',
                    itemCount: fileNames.length,
                  ),
                ),
              ],
            ),
          ),
        );
      },
      separatorBuilder: (context, index) {
        return const SizedBox(height: xxTinierSpacing);
      },
    );
  }
}
